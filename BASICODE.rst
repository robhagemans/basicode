
BASICODE specification
######################


Programs
========

Programs consist of lines of ASCII text, separated by carriage returns.
All program text except string literals and comments is uppercase.
Each line is no more than 60 characters long and
consists of a line number, followed by a space and a compound statement.

Line numbers are whole numbers in the range ``1000``-``32767``, inclusive.

A compound statement consists of one or more statements, separated by colons ``:``.

Programs must include a first line ``1000`` of the following form::

    1000 A = value: GOTO 20: REM program name

In Basicode-3 and -3C, programs should be explicitly terminated with ``GOTO 950``.


Variables
=========

There are two types of scalar variables: numerical and string.

Numerical variable names consist of a letter and optionally another letter or a number.
String variable names consist of a letter and optionally another letter or a number,
terminated by a dollar sign ``$``.

The following two-letter words are reserved words and must not be used as variable names:

- All words starting with ``O``.
- ``AS``, ``AT``, ``FN``, ``GR``, ``IF``, ``PI``, ``ST``, ``TI``, ``TI$``, ``TO``  (in BASICODE-2, -3 and -3C)
- ``LN`` (in BASICODE-3 and -3C)

The following variable names have a special meaning for use with BASICODE subroutines:

- ``A``, ``CN``, ``CT``, ``FR``, ``HO``, ``IN$``, ``RV``, ``SR``, ``SR$``, and ``VE`` (in BASICODE-2, -3 and -3C)
- ``HG``,  ``IN``, ``NF``, ``NF$``, ``SD``, ``SP``, ``SV``, and ``VG`` (in BASICODE-3 and -3C)
- ``CC`` (in BASICODE-3C)

Arrays are lists of values of the same type. Array names are variable names;
the same name must not be used for a scalar and an array in the same program.
Arrays are indexed by a whole number enclosed in parentheses ``()``. The first index is ``0``.

Strings must be no longer than 255 characters.


Literals
========

Numerical literals consist of an optional sign ``-`` or ``+``, followed by digits, optionally followed by a decimal point ``.``,
optionally followed by more digits.

String literals consist of a double quote ``"``, followed by the characters of the string,
followed by a double quote ``"``.


Statements
==========

``DATA literal [, literal] ...`` declares data which can be read with ``READ``.

``DEF FNa(variable) = expression`` defines the user-defined function ``a`` with parameter ``variable``.
``expression`` is a numeric expression that may refer to ``variable``. It must not recursively
call the newly defined function. BASICODE-3 and -3C only.

``DIM variable(max_index)`` allocates an array to be of length ``max_index+1``.

``END`` terminates the program. BASICODE-2 only.

``FOR variable = start TO stop [STEP step]`` initiates a loop. ``variable`` must be numeric. Statements between
this statement and the matching ``NEXT`` statement will be executed at least once
and may be executed multiple times. In the first iteration, ``variable`` will have the value ``start``.
Every next iteration it is incremented by ``step`` or by one if the ``STEP`` clause is omitted.
If ``variable`` is greater than or equal to ``stop``, the loop exits at the ``NEXT`` statement and
program execution continues from the statement after ``NEXT``.

``GOSUB line_number`` jumps to a subroutine. If a subsequent ``RETURN`` statement is encountered,
program execution continues at the statement after ``GOSUB``.

``GOTO line_number`` jumps to a line number in the program.
``GOTO 20`` and ``GOTO 950`` (BASICODE-3 and -3C) have a special meaning which is
discussed under `Subroutines`_.

``IF condition THEN {line_number | compound_statement}`` executes ``compound_statement`` or jumps to ``line_number``
if ``condition`` evaluates to true. ``condition`` must be a Boolean expression. There is no ``ELSE`` clause.

``INPUT variable`` waits for user input and assigns the value provided by the user to ``variable``.

``[LET] variable = expression`` evaluates ``expression`` and assigns its value to ``variable``.
The keyword ``LET`` may be omitted.

``NEXT variable`` iterates a loop. Loops may be nested but ``variable`` must match the initiating ``FOR``
statement (and must not be omitted).

``ON expression {GOTO| GOSUB} line_number [, line_number] ...`` evaluates ``expression`` and uses its
value to choose from a list of jumps. ``expression`` is a numeric expression that must evaluate to a whole number. If the value is ``1``,
the statement jumps to the first ``line_number``, etc. If the value is less than ``1`` or greater than the number of line numbers in the list,
no jump is performed.

``PRINT {expression | TAB(n)} [{ ; | , } {expression | TAB(n)}] ... ``
outputs the values of ``expression``s to the screen.
If ``;`` is used, values are separated by a space.
If ``,`` is used, values are aligned to tabulation stops (of undefined length).
The pseudo-function ``TAB(n)`` may be used to move the next expression to position ``n``,
where the first position is ``1`` or ``0`` and implementation-dependent. ``n`` must be greater than ``0``.
Use of ``TAB`` and ``,`` is not recommended.

``READ variable`` reads the next ``DATA`` literal into ``variable`` and increments the data pointer.
The types of the literal and the variable must match.

``REM comment`` is a comment and ignored.
``REM`` must be the last statement on the line.
``comment`` must not contain the colon character ``:``.

``RESTORE`` resets the data pointer to the start.

``RETURN`` exits a subroutine; execution continues at the statement following the
``GOSUB`` that called the subroutine.

``RUN`` clears all variables and restarts the program. BASICODE-2 only.

``STOP`` terminates the program. BASICODE-2 only.


Functions
=========

Note that the arguments to the functions below are expressions whose return value is numeric, unless
the argument is denoted with a dollar sign.


``ABS(x)`` returns the absolute value of its argument.

``ASC(x$)`` returns the ordinal value of the first character of its argument.
Use with care as not all target platforms use ASCII.

``ATN(x)`` returns the arctangent of its argument, in radians.

``CHR$(x)`` returns the character with the ordinal value provided by its argument.
Use with care as not all target platforms use ASCII.

``COS(x)`` returns the cosine of its argument, which is interpreted as radians.

``EXP(x)`` returns the exponential of its argument.

``FNa(x)`` returns the value of the user-defined function ``a`` with argument ``x``. BASICODE-3 and -3C only.

``INT(x)`` returns its argument as a whole number truncated towards negative infinity.

``LEFT$(x$, n)`` returns the ``n`` leftmost characters of the string ``x$``.
``n`` must be in the range ``1``-``255``.

``LEN(x$)`` returns the length of its argument.

``LOG(x)`` returns the natural logarithm of its argument. ``x`` must be greater than ``0``.

``MID$(x$, s, n)`` returns ``n`` consecutive characters characters, starting with
position ``s``, where the first position is ``1``. ``s`` and ``n`` must be in the
range ``1``-``255``.

``RIGHT$(x$, n)`` returns the ``n`` leftmost characters of the string ``x$``.
``n`` must be in the range ``1``-``255``.

``SGN(x)`` returns the sign of its argument: ``1`` for positive,
``-1`` for negative, ``0`` for zero.

``SIN(x)`` returns the sine of its argument, which is interpreted as radians.

``SQR(x)`` returns the square root of its argument. ``x`` must be greater than or equal to ``0``.

``TAN(x)`` returns the tangent of its argument, which is interpreted as radians.

``VAL(x$)`` returns the numerical value of the string representation of a number
given as its argument. ``x$`` must be string representing a valid numerical literal.


Boolean Operators
=================

``x AND y`` returns the logical conjunction of its operands.

``NOT x`` returns the logical negation of its operand.

``x OR y`` returns the logical disjunction of its operands.

``x = y`` returns the equality of its operands.

``x < y`` returns ``x`` less than ``y``.

``x > y`` returns ``x`` greater than ``y``.

``x <> y`` returns the inequality of its operands.

``x <= y`` returns ``x`` less than or equal to ``y``.

``x >= y`` returns ``x`` greater than or equal to ``y``.

Boolean expressions may only be used in an ``IF`` statement and must
not be assigned to a variable. The numerical value of Boolean values is undefined.

The order of precedence of Boolean operators is undefined and must be indicated with parentheses.


String Operators
================

``x$ + y$`` returns the concatenation of its operands.


Numerical Operators
===================

``+ x`` returns its operand.

``- x`` returns the negative of its operand.

``x + y`` returns the sum of its operands.

``x - y`` returns the difference of its operands.

``x * y`` returns the product of its operands.

``x / y`` returns the quotient of its operands.

``x ^ y`` returns ``x`` raised to the power of ``y``.


Subroutines
===========

``GOTO 20``

Initialises the program. The variable ``A`` should contain the
maximum total number of characters for all strings required by the program.
After initialisation, program execution continues in line ``1010``.

Additionally, in BASICODE-3 and -3C:

- sets the variable ``HO`` to the highest column index and ``VE`` to the highest row index on the text screen.
- sets the variable ``HG`` to the number or horizontal pixels and ``VG`` to the number of vertical pixels on the graphical screen.
- if called from elsewhere in the program, ``GOTO 20`` clears all variables and restarts.


``GOSUB 100``

Clears the screen and places the cursor in the top left corner.


``GOSUB 110``

Places the cursor on the row given in ``VE`` and the column given in ``HO``.
The top left cell has position ``HO=0`` and ``VE=0``. ``HO`` and ``VE`` should be greater than or equal to zero.

In BASICODE-2, additionally, ``HO`` should be less than ``40`` and ``VE`` should be less than ``24``.


``GOSUB 120``

Returns the current cursor position in the variables ``HO``, ``VE``.


``GOSUB 150``

Basicode-3 and -3C only. Prints the contents of variable ``SR$`` in an emphasised way, for example in reverse video.
Three spaces are printed before and three spaces are printed after the string.


``GOSUB 200``

Polls the keyboard; if a key was pressed, returns this in ``IN$``. If no key was pressed, returns the empty string in ``IN$``.

Additionally, in BASICODE-3 and -3C, returns in ``IN`` the ordinal value of the main character on the key pressed, ignoring the shift state. For letter keys,
the main value is the ordinal value of the uppercase character; for number keys, it is the ordinal value of the digit character. The value returned is always in the range ``32``-``95``.
If no key is pressed, returns ``0`` in ``IN``.

The following codes are returned for special keys:

=======  ============  =========
Key      ``IN$``       ``IN``
-------  ------------  ---------
Return   ``CHR$(13)``  13
Delete   undefined     127
Left     undefined     28
Right    undefined     29
Down     undefined     30
Up       undefined     31
=======  ============  =========

Additionally, in BASICODE-3C only, function keys return negative values: F1 returns -1, F2 returns -2, etc.


``GOSUB 210``

Waits for a keypress and returns it in ``IN$``. See ``GOSUB 200`` for the values returned in ``IN$`` and, in BASICODE-3 and -3C, in ``IN``.


``GOSUB 220``

Basicode-3 and -3C only.
Sets ``IN`` to the ordinal value of the character shown on the screen
at the position given by ``HO``, ``VE``. As in ``GOSUB 200``, this returns the main/uppercase character. The value returned is in the range ``32``-``95``.
If the position in those variables is outside the text screen, sets ``IN`` to ``0``.
``IN$`` is unaffected by this subroutine.

In BASICODE-3C only, an offset value is returned in ``CN`` such that ``CHR$(IN+CN)`` reproduces the character case sensitively.


``GOSUB 250``

Sound a beep. Pitch, volume and duration are implementation-dependent.


``GOSUB 260``

Sets ``RV`` to a pseudorandom value greater than or equal to `0`` and less than ``1``.


``GOSUB 270``

Runs a garbage-collection cycle and sets ``FR`` to the number of bytes of free memory.


``GOSUB 280``

Basicode-3 and -3C only.
If ``FR=1``, disable the Break key. If ``FR=0``, enable it.


``GOSUB 300``

Set ``SR$`` to a string representation of the number stored in ``SR``.
The representation has no leading or trailing spaces.


``GOSUB 310``

Set ``SR$`` to a string representation of the number stored in ``SR``. The representation is always fixed-point
with a total length of ``CT`` characters and ``CN`` digits after the radix point, rounding where necessary.
If the representation does not fit, a string of length ``CN`` containing repeated `*` characters is returned.


``GOSUB 330``

Basicode-3 and -3C only.
Set ``SR$`` to its value, converted to uppercase.


``GOSUB 350``

Prints the text contained in ``SR$`` on the line printer.
No newline is printed (unless it is contained in the string).


``GOSUB 360``

Prints a newline on the printer.


``GOSUB 400``

Basicode-3 and -3C only.
Plays a tone of pitch ``SP``, duration ``SD``, and volume ``SV``, where:

- ``SP`` is in the range ``0``-``127`` where ``60`` represents the middle C, 69 is standard pitch A (440 Hz).
  Every integer step represents a half-note difference so that an octave has 12 steps.

- ``SD`` is the duration in tenths of a second.

- ``SV`` is the volume, where ``0`` represents silence, ``7`` is normal volume and ``15`` represents maximum volume.


``GOSUB 450``

Basicode-3 and -3C only.
Waits at most ``SD`` tenths of a second or until a key is pressed. Returns any pressed key in the same way as ``GOSUB 200``.


``GOSUB 500``

Basicode-3 and -3C only.
Opens the file with name ``NF$`` with source and mode determined by ``NF`` as follows:

======  =======  =========================================
``NF``  Mode     Medium
------  -------  -----------------------------------------
    0   input    BASICODE tape
    1   output
------  -------  -----------------------------------------
    2   input    Native tape or disk
    3   output
------  -------  -----------------------------------------
    4   input    Native disk, second file
    5   output
------  -------  -----------------------------------------
    6   input    Native disk, third file
    7   output
======  =======  =========================================


``GOSUB 540``

Basicode-3 and -3C only.
Returns the next string from file open under ``NF`` into ``IN$``

A status code is returned in ``IN``:

======  =====================
``IN``  Status
------  ---------------------
    0   OK
    1   End of file
    -1  Error
======  =====================

If a error or end-of-file occurs, ``IN$`` is set to the empty string.


``GOSUB 560``

Basicode-3 and -3C only.
Writes the string in ``SR$`` to the file open under ``NF``.
See ``GOSUB 540`` for status codes.


``GOSUB 580``

Basicode-3 and -3C only.
Closes the file open under ``NF``.


``GOSUB 600``

Basicode-3 and -3C only.
Switch to graphics mode and clear screen.


``GOSUB 610``

Basicode-3 and -3C only.
Plot a point at coordinate ``(HO,VE)``, where ``HO`` and ``VE`` are in the interval ``[0,1[``, ``(0, 0)`` is the top left pixel and ``(1, 1)`` is just outside the bottom right screen corner.
If ``CN`` equals 0, plot in foreground color; if ``CN`` equals 1, plot in background color.


``GOSUB 630``

Basicode-3 and -3C only.
Draw a line to coordinate ``(HO,VE)``. If ``CN`` equals 0, draw in foreground color; if ``CN`` equals 1, draw in background color.


``GOSUB 650``

Draw text on the graphical screen, where  coordinate ``(HO,VE)`` is the top left of the text box.
If ``CN`` equals 0, draw in foreground color; if ``CN`` equals 1, draw in background color.


``GOTO 950``

Basicode-3 and -3C only.
End the program.



Recommended structure
=====================

It is recommended to use line number ranges as follows:

===========  ===========================================
Range        Purpose
-----------  -------------------------------------------
       1000  Initialisation line
 1010-19999  Main program
20000-24999  Machine-specific subroutines
25000-29999  ``DATA`` lines
30000-31999  Comments: program description
32000-32767  Comments: author's name and contact details
===========  ===========================================


File format
===========

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
All further bytes in the block after ``ETH`` are unspecified. 

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

Sources
=======

- Hans G. Janssen (ed.), *BASICODE Hobbyscoop 2*, Nederlandse Omroep Stichting, Hilversum, 1983.
- Jacques Haubrich (ed.), *Het BASICODE-3 Boek*, Kluwer Technische Boeken, Deventer, 1986.
- `BASICODE-3C Journal <Sammelsurium/JOURNALE/BASC3-C.ASC>`_
