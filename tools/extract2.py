#!/usr/bin/env python2

"""
BASICODE audio modulator/demodulator

(c) 2015, 2016 Rob Hagemans
This file is released under the GNU GPL version 3 or later.
"""

import wave
import struct
import array
import logging
import operator
from collections import deque


class WaveReader(object):
    """Read pulse-code modulated audio from WAV file."""

    type_codes = {
        1: 'B',
        2: 'h',
        4: 'l',
    }

    def __init__(self, name, buffer_length=1024, channel=0):
        """Open a WAV file."""
        self._wave_reader = wave.open(name, 'r')
        self._nchannels = self._wave_reader.getnchannels()
        self._sample_width = self._wave_reader.getsampwidth()
        # frame rate in frames per second
        self.framerate = self._wave_reader.getframerate()
        self._amplitude = 256**self._sample_width/2
        if self._sample_width == 1:
            self._zero = 128
        else:
            self._zero = 0
        self._channel = channel
        self.buffer_length = buffer_length

    def __iter__(self):
        """Define iterator."""
        return self

    def next(self):
        """Get next list of frames."""
        frames = self._wave_reader.readframes(self.buffer_length)
        if not frames:
            raise StopIteration()
        # convert to list of numbers
        # other version took just the MSB - i.e. squeeze everything into a 1-byte value
        # which has the advantage of also working for 3-byte depths, if such a thing exists.
        samples = array.array(self.type_codes[self._sample_width], frames).tolist()
        # get single channel
        # other version would sum channels
        samples = samples[self._channel::self._nchannels]
        # subtract bias
        samples = [s - self._zero for s in samples]
        return samples

    __next__ = next


class PulseReader(object):
    """Read pulse lengths from PCM."""

    def __init__(self, pcm_reader):
        """Initialise pulse reader."""
        self._pcm_reader = pcm_reader
        self._frame_buffer = []
        self._buffer_pos = 0
        self._sign = 0
        self._frame_duration = 1000000. / self._pcm_reader.framerate

    def __iter__(self):
        """Define iterator."""
        return self

    def next(self):
        """Get next pulse length in microseconds."""
        length = 0
        while True:
            try:
                sample = self._frame_buffer[self._buffer_pos]
                self._buffer_pos += 1
            except IndexError:
                self._frame_buffer = next(self._pcm_reader)
                self._buffer_pos = 0
                continue
            self._sign, prev_sign = (sample > 0) - (sample < 0), self._sign
            if (not self._sign) or self._sign == prev_sign:
                length += 1
            else:
                return length * self._frame_duration


    __next__ = next


class BasicodeReader(object):
    """Read bits and bytes from pulses."""

    sync_bytes = {
        0x02: 'A',
        0x01: 'D'
    }

    def __init__(self, pulse_reader):
        """Initialise."""
        self._pulse_reader = pulse_reader
        # 1200 Hz cycle takes 833 us; 2400 Hz cycle takes 417 us
        # cycles longer than 626 microseconds are long cycles
        self._length_cut = 626
        # official length is 5s at 2400 Hz, ie 24000 pulses. accept 1s.
        self._leader_length = 4800

    def read_leader(self):
        """Read the pilot wave and return the sync byte."""
        while True:
            # skip non-leader pulses
            while True:
                l = next(self._pulse_reader)
                if l <= self._length_cut/2:
                    break
                pass
            # we've got a leader pulse, count them
            counter = 0
            while next(self._pulse_reader) <= self._length_cut/2:
                counter += 1
            # if not enough for a leader, look again
            if counter < self._leader_length:
                continue
            # got a complete leader; check for full cycle
            if next(self._pulse_reader) > self._length_cut/2:
                return 0

    def read_trailer(self):
        """Read the trailing wave."""
        while next(self._pulse_reader) <= self._length_cut/2:
            pass

    def read_bit(self):
        """Read the next bit, raise StopIteration at end of tape."""
        cycle = next(self._pulse_reader), next(self._pulse_reader)
        # one = two pulses of 417 us; zero = one pulse of 833 us
        if sum(cycle) < self._length_cut:
            cycle = next(self._pulse_reader), next(self._pulse_reader)
            if sum(cycle) < self._length_cut:
                return 1
            else:
                return None
        else:
            return 0

    # should we simply read short pulses after 8 bits until a long pulse is found, then read that (pilot-style)?
    # would avoid special treatment of first byte (skip_start)
    # and perhaps be more resilient to framing error -> could drop bits until correct 'minipilot' (110) is read, then resume
    # e.g. could have a read_frame() method, so read_byte would become 8* read_bit, then read_frame

    def read_byte(self, skip_start=False):
        """Read a byte from the tape."""
        if skip_start:
            start = 0
        else:
            start = self.read_bit()
        byte = 0
        bits = [self.read_bit() for _ in xrange(8)]
        stop0 = self.read_bit()
        stop1 = self.read_bit()
        if None in bits:
            logging.error('Pulse length error: %s', bits)
            # replace unreadable bits with zeros
            bits = [b if b else 0 for b in bits]
        if start == 1 or stop0 == 0 or stop1 == 0:
            logging.error('Byte not framed: %s ', ([start] + bits + [stop0, stop1]))
            # flip MSB as error sign
            bits[-1] = 0
        # bits are in inverse order
        byte = int(''.join(str(b) for b in reversed(bits)), 2)
        #byte = sum(bit << i for i, bit in enumerate(bits))
        # flip bit 7
        byte ^= 0x80
        return byte


class BasicodeStream(object):
    """Stream interface over tape file."""

    def __init__(self, tape, file_type):
        """Stream over tape file."""
        self._tape = tape
        self.mode = 'r'
        self.file_type = file_type

    def __enter__(self):
        """Context guard."""
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        """Context guard."""
        self.close()

    def read(self, n=-1):
        """Read n bytes from the stream."""
        if n >= 0:
            return ''.join(chr(next(self._tape)) for _ in xrange(n))
        else:
            return ''.join(chr(b) for b in self._tape)

    def close(self):
        """Close file."""
        # read to end of file
        list(self._tape)


class BasicodeTape(object):
    """Open a recording of a BASICODE tape as a file container."""

    def __init__(self, file_name):
        """Open a tape recording."""
        self._pcm_reader = WaveReader(file_name)
        self._pulse_reader = PulseReader(self._pcm_reader)
        self._reader = BasicodeReader(self._pulse_reader)
        self._end_of_tape = False
        self._buffer = None
        self._next_block_nr = 0
        self._finished = False
        self._file_type = None

    def open(self, mode='r'):
        """Search next file and return contents."""
        self._next_block_nr = 0
        self._file_type = None
        self._finished = False
        self._fill_buffer()
        if not self._end_of_tape:
            return BasicodeStream(self, self._file_type)
        else:
            raise IOError('End of tape')

    def _fill_buffer(self):
        """Fill the buffer, if necessary."""
        if not self._buffer and not self._finished:
            try:
                self._read_block()
            except StopIteration:
                self._end_of_tape = True

    def _read_block(self):
        """Read a block into the buffer."""
        self._reader.read_leader()
        sync = self._reader.read_byte(skip_start=True)
        try:
            file_type = self._reader.sync_bytes[sync]
        except KeyError:
            logging.error('Invalid sync byte %02x', sync)
            file_type = 'A'
        if not self._file_type:
            self._file_type = file_type
        elif self._file_type != file_type:
            logging.error('Unexpected block of type %s', file_type)
        checksum_observed = sync
        if self._file_type == 'D':
            block_nr = self._reader.read_byte()
            checksum_observed ^= block_nr
            if block_nr != self._next_block_nr:
                logging.error('Invalid block number: expected %02x observed %02x', self._next_block_nr, block_nr)
            self._next_block_nr = block_nr + 1
        self._buffer = deque()
        self._finished = False
        while True:
            c = self._reader.read_byte()
            checksum_observed ^= c ^ 0x80
            if c == 0x03:
                break
            elif (self._file_type == 'D') and (c == 0x04):
                self._finished = True
            if not self._finished:
                self._buffer.append(c)
        if self._file_type == 'A':
            self._finished = True
        checksum_expected = self._reader.read_byte()
        if checksum_expected != checksum_observed:
            logging.error('Checksum failed: expected %02x observed %02x', checksum_expected, checksum_observed)
        self._reader.read_trailer()

    def __iter__(self):
        """Define iterator."""
        return self

    def next(self):
        """Read next byte from current file, or StopIteration."""
        self._fill_buffer()
        try:
            return self._buffer.popleft()
        except IndexError:
            raise StopIteration()

    __next__ = next


###############################################################################

import sys
import os

def main():
    """Extract all files from a tape."""
    wav_file = sys.argv[1]
    tapestream = BasicodeTape(wav_file)
    trunk = os.path.basename(wav_file).replace('.wav', '')
    track = 0
    while True:
        track += 1
        try:
            with tapestream.open() as inp:
                print 'Found file of type %s in track %d' % (inp.file_type, track)
                ext = 'bc' if inp.file_type == 'A' else 'dat'
                with open('%s_%02d.%s' % (trunk, track, ext), 'wb') as out:
                    out.write(inp.read())
        except IOError:
            break


if __name__ == '__main__':
    main()
