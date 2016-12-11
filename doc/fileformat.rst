BASICODE file format
====================

Modulation
----------

Files on BASICODE cassettes are stored as frequency-modulated sound.
BASICODE bits all have the same duration of 1/1200 s.

-  A 1-bit is represented by two wave periods at 2400 Hz.
-  A 0-bit is represented by a single wave period at 1200 Hz.

Byte format
-----------

+--------+---------+------------------------------------------------------------------------+
| Bits   | Value   | Function                                                               |
+========+=========+========================================================================+
| 1      | 0       | Start bit                                                              |
+--------+---------+------------------------------------------------------------------------+
| 7      |         | ASCII payload, least significant bit first.                            |
+--------+---------+------------------------------------------------------------------------+
| 1      | 1       | Inverted most-significant bit of payload (for 7-bit ASCII, always 1)   |
+--------+---------+------------------------------------------------------------------------+
| 2      | 1       | Stop bits                                                              |
+--------+---------+------------------------------------------------------------------------+


Program file format
-------------------

+---------+----------------+--------------------------------------------------------------------+
| Bytes   | Format         | Meaning                                                            |
+=========+================+====================================================================+
|         | 5s at 2400Hz   | Leader wave                                                        |
+---------+----------------+--------------------------------------------------------------------+
| 1       | ``02``         | ``STX``                                                            |
+---------+----------------+--------------------------------------------------------------------+
|         |                | BASICODE payload: ASCII with ``CR`` line separators.               |
+---------+----------------+--------------------------------------------------------------------+
| 1       | ``03``         | ``ETX``                                                            |
+---------+----------------+--------------------------------------------------------------------+
| 1       |                | Checksum: bitwise ``XOR`` of ``STX``, payload and ``ETX`` bytes.   |
+---------+----------------+--------------------------------------------------------------------+
|         | 5s at 2400Hz   | Trailer wave                                                       |
+---------+----------------+--------------------------------------------------------------------+


Data file format
----------------

Data files are split into blocks of 1024 bytes each. The stated reason for this
is to avoid needing a sentinel value to indicate the end of the block; however,
the header information does not include the number of blocks nor the length of
the last block.

Therefore, the end of the file needs to be indicated with an ``ETH`` (``04``) byte.
According to Dr. Völz's description, all further bytes in the block should be
``ETH``; however, the BASICODE-3 book leaves these bytes unspecified and states they could
be anything. In practice, they often are values other than ``ETH``.

This means that, despite the 1024-byte block structure of the files, this protocol
is not suited to transfer binary files, since it is not possible to transmit a ``04``
without indicating the end of the file. In practice, all files in BASICODE-3 format
are ASCII files, so this problem does not arise.

+---------+----------------+----------------------------------------------------------------------------------+
| Bytes   | Format         | Meaning                                                                          |
+=========+================+==================================================================================+
|         | 5s at 2400Hz   | Leader wave                                                                      |
+---------+----------------+----------------------------------------------------------------------------------+
| 1       | ``01``         | ``STH``                                                                          |
+---------+----------------+----------------------------------------------------------------------------------+
| 1       |                | Block sequential number; first block is 0.                                       |
+---------+----------------+----------------------------------------------------------------------------------+
| 1024    |                | Data payload.                                                                    |
+---------+----------------+----------------------------------------------------------------------------------+
| 1       | ``03``         | ``ETX``                                                                          |
+---------+----------------+----------------------------------------------------------------------------------+
| 1       |                | Checksum: bitwise ``XOR`` of ``STH``, block number, payload and ``ETX`` bytes.   |
+---------+----------------+----------------------------------------------------------------------------------+
|         | 5s at 2400Hz   | Trailer wave                                                                     |
+---------+----------------+----------------------------------------------------------------------------------+


The last block will have 0 – 1023 payload bytes; the rest of the block
is filled with ``ETH`` (``04``) bytes. These bytes are included in that
block's checksum but otherwise ignored.


--------------
