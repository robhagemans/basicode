"""
BASICODE audio modulator/demodulator

(c) 2015, 2016 Rob Hagemans
This file is released under the GNU GPL version 3 or later.
"""

import os
import numpy as np
import math
import struct
import logging
import string
from chunk import Chunk
import io
import itertools
import sys


#################################################################################
# Exceptions

class CassetteIOError(IOError): pass
class EndOfTape(CassetteIOError): pass
class PulseError(CassetteIOError): pass
class FramingError(CassetteIOError): pass
class OperationNotImplemented(CassetteIOError): pass


#################################################################################
# Streams

class BasicodeStream(object):
    """BASICODE-format byte stream."""

    def __init__(self, bitstream):
        """Initialise file on tape."""
        self.bitstream = bitstream
        # is a file open on this stream?
        self.is_open = False
        # keep track of last seg, offs, length to reproduce GW-BASIC oddity
        self.last = 0, 0, 0
        self.buffer_complete = False
        self.length = 0
        self.filetype = ''
        self.rwmode = ''

    def close(self):
        """Finalise the track on the tape stream."""
        if self.is_open:
            self._close_record_buffer()
            self.is_open = False
            self.rwmode = ''

    def flush(self):
        """Flush buffers (dummy)."""
        pass

    def close_tape(self):
        """Eject the tape."""
        try:
            self.close()
            self.bitstream.close()
        except EnvironmentError:
            pass

    def counter(self):
        """Position on tape in seconds."""
        return self.bitstream.counter()

    def wind(self, loc):
        self.bitstream.wind(loc)

    def write(self, c):
        """Write a string to a file on tape."""
        self.record_stream.write(c)
        self._flush_record_buffer()

    def read(self, nbytes=-1):
        """Read bytes from a file on tape."""
        c = ''
        try:
            while True:
                if nbytes > -1:
                    c += self.record_stream.read(nbytes-len(c))
                    if len(c) >= nbytes:
                        return c
                else:
                    c += self.record_stream.read()
                if self.buffer_complete:
                    return c
                self._fill_record_buffer()
        except EndOfTape:
            return c

    def open_read(self):
        """Play until a file record is found."""
        if not self.bitstream.read_leader():
            # reached end-of-tape without finding appropriate file
            raise EndOfTape()
        self.filetype = 'A'
        self.record_num = 0
        self.record_stream = io.BytesIO()
        self.buffer_complete = False
        return ' '*8, 'A', 0, 0, 0

    def open_write(self, name, filetype, seg, offs, length):
        # writing BASICODE not implemented
        raise OperationNotImplemented()

    def _fill_record_buffer(self):
        """Read a file from tape."""
        if self.record_num > 0:
            return False
        self.record_num += 1
        self.record_stream = io.BytesIO()
        # xor sum includes STX byte
        checksum = 0x02
        while True:
            try:
                byte = self.bitstream.read_byte()
            except (PulseError, FramingError) as e:
                logging.warning("%s Cassette I/O error during read: %s",
                                timestamp(self.bitstream.counter()), e)
                # insert a zero byte as a marker for the error
                byte = 0
            except EndOfTape as e:
                logging.warning("%s Cassette I/O error during read: %s",
                                timestamp(self.bitstream.counter()), e)
                break
            checksum ^= byte
            if byte == 0x03:
                break
            c = chr(byte)
            self.record_stream.write(c)
            # CR -> CRLF
            if byte == 0x0d:
                self.record_stream.write('\n')
        # read one-byte checksum and report errors
        try:
            checksum_byte = self.bitstream.read_byte()
        except (PulseError, FramingError, EndOfTape) as e:
            logging.warning("%s, Could not read checksum: %s",
                            timestamp(self.bitstream.counter()), e)
        else:
            # checksum shld be 0 for even # bytes, 128 for odd
            if checksum_byte is None or checksum^checksum_byte not in (0,128):
                logging.warning("%s Checksum failed, required: %02x realised: %02x",
                                timestamp(self.bitstream.counter()),
                                checksum_byte, checksum)
        self.record_stream.seek(0)
        self.bitstream.read_trailer()
        self.buffer_complete = True
        return True

    def _flush_record_buffer(self):
        """Write the tape buffer to tape."""
        pass

    def _close_record_buffer(self):
        """Write the tape buffer to tape and finalise."""
        pass


##############################################################################


class TapeBitStream(object):
    """Cassette tape bitstream interface."""

    # sync byte for IBM PC tapes
    sync_byte = 0x16
    # intro text
    intro = 'PC-BASIC tape\x1a'

    def __init__(self, mode='r'):
        """Initialise tape interface."""
        pass

    def __enter__(self):
        """Context guard."""
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        """Context guard."""
        self.close()

    def counter(self):
        """Position on tape in seconds."""
        return 0

    def wind(self, loc):
        """Set position of tape in seconds."""
        pass

    def read_intro(self):
        """Try to read intro; ensure image not empty."""
        for b in bytearray(self.intro):
            c = self.read_byte()
            if c == '':
                # empty or short file
                return False
            if c != b:
                break
        else:
            for _ in range(7):
                self.read_bit()
        return True

    def write_intro(self):
        """Write some noise to give the reader something to get started."""
        # We just need some bits here
        # however on a new CAS file this works like a magic-sequence...
        for b in bytearray(self.intro):
            self.write_byte(b)
        # Write seven bits, so that we are byte-aligned after the sync bit
        # (after the 256-byte pilot). Makes CAS-files easier to read in hex.
        for _ in range(7):
            self.write_bit(0)
        self.write_pause(100)

    def read_leader(self):
        """Read the leader / pilot wave."""
        try:
            while True:
                while self.read_bit() != 1:
                    pass
                counter = 0
                while True:
                    b = self.read_bit()
                    if b != 1:
                        break
                    counter += 1
                # sync bit 0 has been read, check sync byte 0x16
                # at least 64*8 bits
                if b is not None and counter >= 512:
                    sync = self.read_byte(skip_start=True)
                    if sync == self.sync_byte:
                        return True
        except EndOfTape:
            return False

    def write_leader(self):
        """Write the leader / pilot tone."""
        for _ in range(256):
            self.write_byte(0xff)
        self.write_bit(0)
        self.write_byte(0x16)

    def read_byte(self, skip_start=False):
        """Read a byte from the tape."""
        # NOTE: skip_start is ignored
        byte = 0
        for i in xrange(8):
            bit = self.read_bit()
            if bit is None:
                raise PulseError()
            byte += bit * 128 >> i
        return byte

    def write_byte(self, byte):
        """Write a byte to tape image."""
        bits = [ 1 if (byte & (128 >> i) != 0) else 0 for i in range(8) ]
        for bit in bits:
            self.write_bit(bit)

    def close(self):
        """Eject tape."""
        pass

    def switch_mode(self, new_mode):
        """Switch tape to reading or writing mode."""
        pass

    def flush(self):
        """Write remaining bits to tape (stub)."""
        pass

    def read_bit(self):
        """Read the next bit (stub)."""
        return 0

    def write_bit(self, bit):
        """Write the next bit (stub)."""
        pass

    def write_pause(self, milliseconds):
        """Write pause to tape image (stub)."""
        pass

    def read_trailer(self):
        """Read the trailing wave """
        try:
            while self.read_bit() == 1:
                pass
        except EndOfTape:
            pass

    def write_trailer(self):
        """Write trailing wave."""
        # closing sequence is 30 1-bits followed by a zero bit (based on PCE output).
        # Not 32 1-bits as per http://fileformats.archiveteam.org/wiki/IBM_PC_data_
        for _ in range(30):
            self.write_bit(1)
        self.write_bit(0)

##############################################################################
# Wave file reader/writer
# note that the wave module opens for read or write exclusively


# http://www.topherlee.com/software/pcm-tut-wavformat.html
# The header of a WAV (RIFF) file is 44 bytes long and has the following format:

#    Positions	Sample Value	Description
#    1 - 4	"RIFF"	Marks the file as a riff file. Characters are each 1 byte long.
#    5 - 8	File size (integer)	Size of the overall file - 8 bytes, in bytes (32-bit integer). Typically, you'd fill this in after creation.
#    9 -12	"WAVE"	File Type Header. For our purposes, it always equals "WAVE".
#    13-16	"fmt "	Format chunk marker. Includes trailing null
#    17-20	16	Length of format data as listed above
#    21-22	1	Type of format (1 is PCM) - 2 byte integer
#    23-24	2	Number of Channels - 2 byte integer
#    25-28	44100	Sample Rate - 32 byte integer. Common values are 44100 (CD), 48000 (DAT). Sample Rate = Number of Samples per second, or Hertz.
#    29-32	176400	(Sample Rate * BitsPerSample * Channels) / 8.
#    33-34	4	(BitsPerSample * Channels) / 8.1 - 8 bit mono2 - 8 bit stereo/16 bit mono4 - 16 bit stereo
#    35-36	16	Bits per sample
#    37-40	"data"	"data" chunk header. Marks the beginning of the data section.
#    41-44	File size (data)	Size of the data section.
#    Sample values are given above for a 16-bit stereo source.

# data section consists of little-endian PCM audio data
# each sample consists of nchannels*samplewidth bytes



class WAVBitStream(TapeBitStream):
    """WAV-file cassette image bit stream."""

    def __init__(self, filename, mode):
        """Initialise WAV-file."""
        TapeBitStream.__init__(self)
        self.filename = filename
        if not os.path.exists(filename):
            # create/overwrite file
            self.framerate = 22050
            self.sampwidth = 1
            self.nchannels = 1
            self.wav = open(self.filename, 'wb')
            self._write_wav_header()
            self.operating_mode = 'w'
        else:
            # open file for reading and find wave parameters
            try:
                self.wav = open(self.filename, 'r+b')
            except EnvironmentError:
                self.wav = open(self.filename, 'rb')
            if not self._read_wav_header():
                raise EndOfTape()
            self.operating_mode = 'r'
        self.wav_pos = 0
        self.buf_len = 1024
        # convert 8-bit and 16-bit values to ints
        if self.sampwidth == 1:
            self.sub_threshold = 0
            self.subtractor = 128*self.nchannels
        else:
            self.sub_threshold = 256*self.nchannels/2
            self.subtractor =  256*self.nchannels
        # volume above/below zero that is interpreted as zero
        self.zero_threshold = self.nchannels
        # 1000 us for 1, 500 us for 0; threshold for half-pulse (500 us, 250 us)
        self.halflength = [250*self.framerate/1000000, 500*self.framerate/1000000]
        self.halflength_cut = 375*self.framerate/1000000
        self.halflength_max = 2*self.halflength_cut
        self.halflength_min = self.halflength_cut / 2
        self.length_cut = 2*self.halflength_cut
        # 2048 halves = 1024 pulses = 512 1-bits = 64 bytes of leader
        self.min_leader_halves = 2048
        # initialise generators
        self.filter = passthrough()
        self.filter.send(None)
        self.read_half = self._gen_read_halfpulse()
        # write fluff at start if this is a new file
        if self.operating_mode == 'w':
            self.write_intro()
        self.switch_mode(mode)

    def __getstate__(self):
        """Get pickling dict for stream."""
        return { 'filename': self.filename,
                 'mode': self.operating_mode,
                 'counter': self.counter() }

    def __setstate__(self, st):
        """Initialise stream from pickling dict."""
        # open for reading to avoid writing intro
        self.__init__(st['filename'], 'r')
        self.wind(st['counter'])
        self.switch_mode(st['mode'])

    def switch_mode(self, mode):
        """Switch tape to reading or writing mode."""
        self.operating_mode = mode

    def counter(self):
        """Time stamp in seconds."""
        return self.wav_pos/(1.*self.framerate)

    def wind(self, loc):
        """Set position of tape in seconds."""
        self.wav_pos = int(loc * self.framerate)
        self.wav.seek(self.wav_pos)

    def close(self):
        """Close WAV-file."""
        TapeBitStream.close(self)
        # write file length fields
        self.wav.seek(0, 2)
        end_pos = self.wav.tell()
        self.wav.seek(self.riff_pos, 0)
        self.wav.write(struct.pack('<4sL', 'RIFF', end_pos-self.riff_pos-8))
        self.wav.seek(self.data_pos, 0)
        self.wav.write(struct.pack('<4sL', 'data', end_pos-self.start))
        self.wav.close()

    def _fill_buffer(self):
        """Fill buffer with frames and pre-process."""
        frame_buf = []
        frames = self.wav.read(self.buf_len*self.nchannels*self.sampwidth)
        if not frames:
            raise EndOfTape
        # convert MSBs to int (data stored little endian)
        # note that we simply throw away all the less significant bytes
        frames = map(ord, frames[self.sampwidth-1::self.sampwidth])
        # sum frames over channels
        frames = map(sum, zip(*[iter(frames)]*self.nchannels))
        frames = [ x-self.subtractor if x >= self.sub_threshold else x for x in frames ]
        return self.filter.send(frames)

    def _gen_read_halfpulse(self):
        """Generator to read a half-pulse and yield its length."""
        length = 0
        frame = 1
        prezero = 1
        pos_in_frame = 0
        frame_buf = []
        while True:
            try:
                sample = frame_buf[pos_in_frame]
                pos_in_frame += 1
            except IndexError:
                frame_buf = self._fill_buffer()
                pos_in_frame = 0
                continue
            length += 1
            last, frame = frame, (sample > self.zero_threshold) + (sample >= -self.zero_threshold) - 1
            if last != frame and (last != 0 or frame == prezero):
                if frame == 0 and last != 0:
                    prezero = last
                self.wav_pos += length
                yield length
                length = 0

    def write_pause(self, milliseconds):
        """Write a pause of given length to the tape."""
        length = (milliseconds * self.framerate / 1000)
        zero = { 1: '\x7f', 2: '\x00\x00'}
        self.wav.write(zero[self.sampwidth] * self.nchannels * length)
        self.wav_pos += length

    def _read_wav_header(self):
        """Read RIFF WAV header."""
        try:
            ch = Chunk(self.wav, bigendian=0)
        except (EOFError):
            logging.debug('WAV file is corrupted.')
            return False
        if ch.getname() != 'RIFF' or ch.read(4) != 'WAVE':
            logging.debug('Not a WAV file.')
            return False
        # this would normally be 0
        self.riff_pos = self.wav.tell() - 12
        riff_size = ch.getsize()
        self.sampwidth, self.nchannels, self.framerate = 0, 0, 0
        while True:
            try:
                chunk = Chunk(ch, bigendian=0)
            except EOFError:
                logging.debug('No data chunk found in WAV file.')
                return False
            chunkname = chunk.getname()
            if chunkname == 'fmt ':
                format_tag, self.nchannels, self.framerate, _, _ = struct.unpack('<HHLLH', chunk.read(14))
                if format_tag == 1:
                    sampwidth = struct.unpack('<H', chunk.read(2))[0]
                    self.sampwidth = (sampwidth + 7) // 8
                else:
                    logging.debug('WAV file not in uncompressed PCM format.')
                    return False
            elif chunkname == 'data':
                if not self.sampwidth:
                    logging.debug('Format chunk not found.')
                    return False
                self.data_pos = self.wav.tell() - 4
                #self.wav.read(4)
                self.start = self.wav.tell()
                return True
            chunk.skip()

    def _write_wav_header(self):
        """Write RIFF WAV header."""
        # "RIFF" chunk header
        self.riff_pos = self.wav.tell()
        # length is corrected at close
        self.wav.write(struct.pack('<4sL4s', 'RIFF', 36, 'WAVE'))
        # "fmt " subchunk
        self.wav.write(struct.pack('<4sLHHLLHH', 'fmt ', 16,
            1, self.nchannels, self.framerate,
            self.nchannels * self.framerate * self.sampwidth,
            self.nchannels * self.sampwidth,
            self.sampwidth * 8))
        # "data" subchunk header
        self.data_pos = self.wav.tell()
        # length is corrected at close
        self.wav.write(struct.pack('<4sL', 'data', 0))
        self.start = self.wav.tell()

    def read_leader(self):
        """Read the leader / pilot wave."""
        try:
            while True:
                while self.read_bit() != 1:
                    pass
                counter = 0
                pulse = (0,0)
                while True:
                    last = pulse
                    half = next(self.read_half)
                    if not self._is_leader_halfpulse(half):
                        if counter > self.min_leader_halves:
                            #  zero bit; try to sync
                            half = next(self.read_half)
                        break
                    counter += 1
                # sync bit 0 has been read, check sync byte
                if counter >= self.min_leader_halves:
                    # read rest of first byte
                    try:
                        self.last_error_bit = None
                        self.dropbit = None
                        sync = self.read_byte(skip_start=True)
                        if sync == self.sync_byte:
                            return True
                        else:
                            logging.debug("%s Incorrect sync byte after %d pulses: %02x",
                                          timestamp(self.counter()), counter, sync)
                    except (PulseError, FramingError) as e:
                        logging.debug("%s Error in sync byte after %d pulses: %s",
                                      timestamp(self.counter()), counter, e)
        except (EndOfTape, StopIteration):
            self.read_half = self._gen_read_halfpulse()
            return False

##############################################################################

# Prof. Dr. rer. nat. habil. HORST VOELZ, Datenaustausch mit Basicode
# Radio Fernsehen Elektronik 1/1990
# http://www.kc85emu.de/scans/rfe0190/Basicode.htm

# BITS:
# 0 - 1 period  at 1200 Hz
# 1 - 2 periods at 2400 Hz
#
# BYTES:
# 1 start bit
# 2 stop bits
# bit 7 (most significant bit) is inverted and therefore always 1 for ASCII
# least significant bit is sent first
#
# PROGRAM FILES:
# - synchronising tone: 5s at 2400 Hz
# - start byte 0x82 (i.e., 0x02 STX because of the inverted bit 7)
# - ASCII text; only 0x20 -- 0x7e inclusive with lines separated by 0x0D
# - stop byte 0x83 (i.e, 0x03 ETX)
# - checksum byte; XOR of all previous bytes including STX and ETX
# - 1s at 2400 Hz
#
# DATA FILES:
# All code points 0x00 - 0xFF allowed
# sent in blocks of 1024 bytes
# each block:
# - synch tone: 5s of 2400 Hz
# - start byte 0x81 (i.e., 0x01 STH)
# - block number; first is 0x80 (i.e., 0x00) incremented by 1 for each consecutive block
# - 1024 data bytes with inverted bit 7
# - stop byte 0x83 (i.e., 0x02, ETX)
# - checksum byte: XOR of previous 1027 bytes
# - 1s at 2400 Hz
# if the final block is shorter than 1024 bytes, then the unused space is filled
# with 0x84 (i.e., 0x04 EOT). These bytes are included in the checksum.
# the checksum of a data file always has a 1 in bit 7 due to its structure


class BasicodeWAVBitStream(WAVBitStream):
    """BASICODE-standard WAV image reader."""

    def __init__(self, filename, mode):
        """Initialise BASICODE WAV-file reader."""
        WAVBitStream.__init__(self, filename, mode)
        # basicode uses STX as sync byte
        self.sync_byte = 0x02
        # fix frequencies to Basicode standards, 1200 / 2400 Hz
        # one = two pulses of 417 us; zero = one pulse of 833 us
        # value is cutoff for full pulse
        self.length_cut = 626*self.framerate/1000000
        self.length_max = 2*self.length_cut
        self.length_min = self.length_cut / 2
        # initialise generators
        self.filter = passthrough()
        #self.filter = hipass(self.framerate)
        #self.filter = butterband4(self.framerate, 1350, 3450)
        self.filter.send(None)
        # byte error correcting
        self.dropbit = None
        self.last_error_bit = None

    def read_bit(self):
        """Read the next bit."""
        try:
            pulse0 = (next(self.read_half), next(self.read_half))
            # one = two pulses of 417 us; zero = one pulse of 833 us
            if sum(pulse0) < self.length_cut:
                pulse1 = (next(self.read_half), next(self.read_half))
                if sum(pulse1) < self.length_cut:
                    return 1
                else:
                    return None
            else:
                return 0
        except StopIteration:
            self.read_half = self._gen_read_halfpulse()
            raise EndOfTape

    def write_bit(self, bit):
        """BASICODE writing not yet supported."""
        pass

    def read_byte(self, skip_start=False):
        """Read a byte from the tape."""
        if skip_start:
            start = 0
        else:
            start = self.read_bit()
        byte = 0
        bits = [ self.read_bit() for _ in xrange(8) ]
        if self.dropbit == 1 and self.last_error_bit == 0 and bits[-2:] == [1, 1]:
            # error-correcting: have we gone one too far?
            stop0, stop1 = bits[-2:]
            bits = [self.dropbit, start] + bits[:-2]
            start = self.last_error_bit
        elif self.dropbit == 0 and bits[-1] == 1:
            # error-correcting: keep dropbit
            stop0, stop1 = bits[-1], self.read_bit()
            bits = [start] + bits[:-1]
            start = self.dropbit
        else:
            # normal case, no error last time
            # or can't find a working correction
            stop0 = self.read_bit()
            stop1 = self.read_bit()
        if start == 1 or stop0 == 0 or stop1 == 0:
            self.last_error_bit = stop1
            # incorrect start/stop bit, try to recover by shifting
            self.dropbit = self.read_bit()
            raise FramingError(
                "Byte not framed: %s " % ([start] + bits + [stop0, stop1]))
        else:
            # start/stopbits correct or unreadable
            self.last_error_bit = None
            self.dropbit = None
            if None in bits:
                raise PulseError()
            # bits in inverse order
            byte = sum(bit << i for i, bit in enumerate(bits))
            # flip bit 7
            byte ^= 0x80
            return byte

    def _is_leader_halfpulse(self, half):
        """Return whether the half pulse is of pilot wave frequency."""
        return half <= self.length_cut/2


##############################################################################
# supporting functions

def hms(seconds):
    """Return elapsed cassette time at given frame."""
    m, s = divmod(seconds, 60)
    h, m = divmod(m, 60)
    return h, m, s

def timestamp(counter):
    """Time stamp."""
    return "[%d:%02d:%02d] " % hms(counter)


##############################################################################
# filters
# see e.g. http://www.exstrom.com/journal/sigproc/
# cf. src/arch/ibmpc/c (Hampa Hug) in PCE sources
# cf. http://www.exstrom.com/journal/sigproc/bwbpf.c
# see http://musicdsp.org/files/Audio-EQ-Cookbook.txt

# NOTE that it's often quicker and easier to use SOX to filter the audio


def passthrough():
    """Passthrough filter."""
    x = []
    while True:
        x = yield x

# cutoff=1260., transition=1102.5
def hipass(sample_rate, cutoff=1200, transition=2400, amplify=3):
    """High-pass filter."""
    # see https://tomroelandts.com/articles/how-to-create-a-simple-high-pass-filter
    # cutoff frequency, as a fraction of the sampling rate
    cutoff = cutoff / float(sample_rate)
    # transition band, as a fraction of the sampling rate
    transition = transition / float(sample_rate)
    # filter length
    length = int(np.ceil((4. / transition)))
    # N must be odd
    length += 1 - (length%2)
    # construct a low-pass filter.
    h = np.sinc(2 * cutoff * (np.arange(length) - (length-1)/2.))
    window = np.blackman(length)
    h *= window
    h /= np.sum(h)
    # create a high-pass filter from the low-pass filter through spectral inversion
    h = -h
    h[(length - 1) / 2] += 1
    # convolve filter with sample stream
    buf = np.zeros(length)
    output = np.array([])
    while True:
        sample = yield output.astype(np.int16)
        buf = np.concatenate((buf, sample))
        output = np.convolve(h, buf)[length:length+len(sample)] * amplify
        buf = buf[-length:]


def butterworth(sample_rate, cutoff_freq):
    """Second-order Butterworth low-pass filter."""
    # cf. src/arch/ibmpc/c (Hampa Hug) in PCE sources
    x, y = [0, 0], [0, 0]
    om = 1. / math.tan((math.pi * cutoff_freq) / sample_rate)
    rb0 = 1. / (om*om + om*math.sqrt(2.) + 1.)
    b1, b2 = 2.*(1.-om*om), (om*om-om*math.sqrt(2.)+1.)
    while True:
        inp = yield y[2:]
        x = x[-2:] + inp
        y = y[-2:] + [0]*len(inp)
        for i in range(2, len(x)):
            y[i] = (x[i] + 2*x[i-1] + x[i-2] - b1*y[i-1] - b2*y[i-2]) * rb0

def butterband4(sample_rate, lo_freq, hi_freq):
    """4th-order Butterworth band-pass filter."""
    # cf. http://www.exstrom.com/journal/sigproc/bwbpf.c
    f1 = hi_freq
    f2 = lo_freq
    s = sample_rate
    n = 1
    #
    a = math.cos(math.pi*(f1+f2)/s) / math.cos(math.pi*(f1-f2)/s)
    a2 = a*a
    b = math.tan(math.pi*(f1-f2)/s)
    b2 = b*b
    #
    r = math.sin(math.pi*(1.0)/(4.))
    s = b2 + 2.0*b*r + 1.0
    A = (b2/s)   * 2 ## *2 to gain amplitude, my addition
    d1 = 4.0*a*(1.0+b*r)/s
    d2 = 2.0*(b2-2.0*a2-1.0)/s
    d3 = 4.0*a*(1.0-b*r)/s
    d4 = -(b2 - 2.0*b*r + 1.0)/s
    w0, w1, w2, w3, w4 = 0,0,0,0,0
    out = []
    while True:
        inp = yield out
        out = [0]*len(inp)
        for i, x in enumerate(inp):
            w0 = d1*w1 + d2*w2 + d3*w3 + d4*w4 + x
            out[i] = A*(w0 - 2.0*w2 + w4)
            w4, w3, w2, w1 = w3, w2, w1, w0

def butterband_sox(sample_rate, f0, width):
    """2-pole Butterworth band-pass filter."""
    # see http://musicdsp.org/files/Audio-EQ-Cookbook.txt
    # and SOX source code
    # width is difference between -3dB cutoff points
    # it seems f0 = sqrt(f_hi f_lo), width ~ f_hi - f_lo
    w0 = 2.*math.pi*f0/sample_rate
#    alpha = sin(w0)*sinh(log(2.)/2 * width_octaves * w0/sin(w0)) (digital)
#    alpha = sin(w0)*sinh(log(2.)/2 * width_octaves) (analogue)
    # this is from SOX:
    alpha = math.sin(w0)/(2.*f0/width)
    #
    b0 =   alpha
    #b1 =   0
    b2 =  -alpha
    a0 =   1. + alpha
    a1 =  -2.*math.cos(w0)
    a2 =   1. - alpha
    b0a = b0/a0
    b2a = b2/a0
    a1a = a1/a0
    a2a = a2/a0
    x, y = [0, 0], [0, 0]
    while True:
        inp = yield y[2:]
        x = x[-2:] + inp
        y = y[-2:] + [0]*len(inp)
        for i in range(2, len(x)):
            y[i] = b0a*x[i] + b2a*x[i-2] - a1a*y[i-1] - a2a*y[i-2]


###############################################################################

wav_file = sys.argv[1]
tapestream = BasicodeStream(BasicodeWAVBitStream(wav_file, 'r'))
trunk = os.path.basename(wav_file).replace('.wav', '')

for track in itertools.count():
    tapestream.open_read()
    print 'Found track %d at %s' % (track, timestamp(tapestream.counter()))
    s = tapestream.read()
    with open('%s_%02d.bc' % (trunk, track), 'wb') as f:
        f.write(s)
