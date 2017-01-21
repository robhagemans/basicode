BASICODE interpreter
====================

This is a BASICODE interpreter in Javascript, compatible with BASICODE versions 2, 3 and 3C.
There is `a live demo <http://robhagemans.github.io/basicode/>`_.

Quick start
-----------
::

    <!DOCTYPE html>
    <html>
    <head>
        <script src="basicode.js"></script>
    </head>
    <body>
        <script type="text/basicode">
            1010 PRINT "Hello, world!"
        </script>
    </body>
    </html>


Deployment
----------

The package consists of a single Javascript file. To embed one or more interpreters in an HTML5 document, link the script in the header.
It will scan the HTML for any ``<script type="text/basicode">`` elements and replace them with newly created canvases.

- If the element contains any content or has a ``src=`` property pointing to a text file, the script will attempt to execute it as BASICODE.
- If the element is empty, it will show a splash screen.

In either case, you can drag and drop local text files containing BASICODE onto the canvas to execute them. Enjoy!


Settings
--------

A number of options can be set through the dataset attribute of the ``script`` element:

===================== ============================================================
Attribute             Setting
===================== ============================================================
``data-columns``      Number of text columns
``data-rows``         Number of text rows
``data-speed``        Number of cycles per second in ``FOR`` loops (roughly)
``data-font``         Font to use for text. See below.
``data-canvas``       Target ``canvas`` id for screen / keyboard
``data-floppy-1``     Target ``div`` id for visualisation of first floppy drive
``data-floppy-2``     Target ``div`` id for visualisation of second floppy drive
``data-floppy-3``     Target ``div`` id for visualisation of third floppy drive
``data-printer``      Target ``iframe`` id for printer output
``data-listing``      Target ``textarea`` for editable program listing
===================== ============================================================


Fonts
-----

The following fonts are available:

============ ====================================
Font         Description
============ ====================================
``smooth``   Browser's native monospace font
``spectrum`` 8x8 ZX Spectrum font
``c64``      8x8 Commodore 64 font
``cga``      8x8 IBM CGA font
``thin``     8x8 IBM CGA thin stroke font
``pcjr``     8x8 IBM PCjr font
``tandy``    8x8 Tandy 1000 font
``tandy2``   8x8 Tandy 1000 font, later version
``ega``      8x14 IBM EGA font
``mda``      9x14 Hercules and IBM MDPA font
``olivetti`` 8x16 Olivetti M24 and AT&T 6300 font
``vga``      9x16 IBM VGA font
============ ====================================


Compatibility
-------------

The interpreter should work on reasonably recent, standards-compliant browsers.
You need a keyboard, so it will be difficult to use on mobile.
I've superficially tested it on Chrome, Firefox, Safari, and Opera.
It probably works fine on Edge, but I haven't tried. It mostly works on Internet Explorer 11 (except sound) but not at all on older versions.


Copyright and Licence
---------------------

(For the avoidance of doubt, this licence only applies to the present directory; not to the whole repository.)

**BASICODE interpreter in Javascript. Copyright © 2016—2017 Rob Hagemans.**

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program; if not, write to the Free Software Foundation, Inc., 51 Franklin
Street, Fifth Floor, Boston, MA 02110-1301 USA.
