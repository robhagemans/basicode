#!/usr/bin/env python2
import sys

# include the start and end byte
checksum = 0x83 ^ 0x82

with open(sys.argv[1], 'rb') as f:
    # basicode has CR line endings
    for char in f.read().replace('\r\n', '\r').replace('\n', '\r'):
        checksum ^= ord(char) ^ 0x80

print '%02x' % checksum
