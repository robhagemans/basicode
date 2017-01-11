BASICODE interpreter
====================

This is a BASICODE interpreter in Javascript, compatible with BASICODE versions 2, 3 and 3C.
There is `a live demo <http://robhagemans.github.io/basicode/>`_.

Deployment
----------

Summary::

    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="utf-8">
        <script src="basicode.js"></script>
    </head>
    <body>
        <script type="text/basicode">
            1000 GOTO 20
            1010 PRINT "Hello, world!"
        </script>
    </body>
    </html>


The package consists of a single Javascript file. To embed one or more interpreters in an HTML document, link the script in the header.
It will scan the HTML for any ``<script type="text/basicode">`` elements and replace them with newly created canvases.

- If the element contains any content or has a ``src=`` property pointing to a text file, the script will attempt to execute it as BASICODE.
- If the element is empty, it will show a splash screen.

In either case, you can drag and drop local text files containing BASICODE onto the canvas to execute them. Enjoy!


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
