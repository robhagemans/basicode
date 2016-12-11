.. rubric:: BASICODE file format
   :name: basicode-file-format

Files on BASICODE cassettes are stored as frequency-modulated sound. By
contrast to the IBM cassette format, BASICODE bits all have the same
duration of 1/1200 s.

.. rubric:: Modulation
   :name: basicode-modulation

-  A 1-bit is represented by two wave periods at 2400 Hz.
-  A 0-bit is represented by a single wave period at 1200 Hz.

.. rubric:: Byte format
   :name: basicode-byte


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


.. rubric:: Program file format
   :name: basicode-program


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


.. rubric:: Data file format
   :name: basicode-data

Data files are split into blocks of 1024 bytes each. The specification
does not indicate how to determine the length of a stored file; note
that BASICODE data files are exceedingly rare so it is not clear how
this limitation was dealt with in practice.


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
