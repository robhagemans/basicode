BASICODE interpreter
====================

This is a BASICODE interpreter in Javascript, compatible with BASICODE versions 2, 3 and 3C.


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

- If the element contains any content, the script will attempt to execute it as BASICODE.
- If the element is empty, it will show a splash screen.

In either case, you can drag and drop local text files containing BASICODE onto the canvas to execute them. Enjoy!
