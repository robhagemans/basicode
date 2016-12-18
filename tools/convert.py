#!/usr/bin/env python2

"""
BASICODE to PC-BASIC converter

(c) 2015, 2016 Rob Hagemans
This file is released under the GNU GPL version 3 or later.
"""

import sys
import string

# get input and output filenames, use stdin if not specified
# for input file, any newline convention goes
# output files are written with CRLF so GW-BASIC/DOS can read them

# if two names specified, optionally take third argument
# which is a bascoder to prepend

try:
    file_in = open(sys.argv[1], 'rU')
except IndexError:
    file_in = sys.stdin

try:
    file_out = open(sys.argv[2], 'wb')
except IndexError:
    file_out = sys.stdout

try:
    with open(sys.argv[3], 'rU') as bc:
        bascoder = '\r\n'.join(line[:-1] for line in bc.readlines() if line not in ('\n', '\x1a', '\x1a\n'))
except IndexError:
    bascoder = ''

# basicode-3 keywords getting an extra space
keywords = {
    'PRINT', 'INPUT', 'LET', 'GOTO',
    'GOSUB', 'RETURN', 'FOR', 'TO',
    'STEP', 'NEXT', 'IF', 'THEN', 'ON',
    'DIM', 'READ', 'DATA', 'RESTORE',
    'REM', 'DEF', 'FN', 'ABS', 'SGN',
    'INT', 'SQR', 'SIN', 'COS',
    'TAN', 'ATN', 'EXP', 'LOG', 'ASC',
    'VAL', 'LEN', 'CHR', 'LEFT', 'MID',
    'RIGHT', 'AND', 'OR', 'NOT', 'TAB'
}

with file_in, file_out:
    file_out.write(bascoder)
    for line in file_in:
        word = ''
        rem, literal = False, False
        # universal newlines turns every line ending into \n
        # so by ignoring the last char we ignore any newline combination
        for c in line[:-1]:
            if c == '"':
                literal = not literal
            if word == 'REM':
                rem = True
            if (c.isalnum() or c == '.') and not literal and not rem:
                if word in keywords:
                    file_out.write(word + ' ')
                    word = ''
                word += c
            else:
                file_out.write(word + c)
                word = ''
        # write DOS-style newline
        file_out.write(word + '\r\n')
