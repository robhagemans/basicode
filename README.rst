BASICODE
========

The purpose of BASICODE was to enable radio-transmission of software to owners of numerous
mutually incompatible 8-bit platforms. It was developed in 1980 by Dutch broadcaster *NOS* for its
hobby-electronics radio programme Hobbyscoop.

BASICODE consists of the following elements:

- A subset of classic Microsoft BASIC common to the BASIC dialects of the target platforms
- A standard set of subroutines to provide functionality for which no common BASIC syntax exists
- An audio modulation format intended to be readable by data cassette players

.. image:: http://robhagemans.github.io/basicode/zwart1.jpg

BASICODE users would tape record the modulated program from the radio. They would need a native *translation program*
for their platform, which would decode the common audio format and supplement the BASICODE program with the platform
implementation of the standard subroutines. If everything went well, they would then be able to run and use the program.

*NOS* started BASICODE transmissions in 1982 on medium wave Dutch radio. Other broadcasters followed suit:
Dutch broadcasters *NOS* and *TROS*, the British *BBC*, the West German *WDR* and
the East German *Radio DDR* all at one time or another performed regular BASICODE transmissions.
In re-unified Germany, *Deutschlandsender Kultur* continued to transmit BASICODE until around 1992.

BASICODE programs were also distributed on collection recordings: mostly these were cassette tapes, but there were audio CDs and
gramophone records as well, as well as diskette sets. Many of these sources additionally contained translation programs for one
or more platforms.

While the authors and broadcasters retained copyrights on the programs, they encouraged them to be shared widely
for non-commercial purposes.

This repository contains BASICODE programs from a number of sources. I have decoded them from
the original audio recordings, where available, and corrected transmission failures using context,
alternative sources and checksums. I have concentrated on the portable BASICODE sources and have
omitted platform-specific code such as translation programs. The following titles are included:

==================================  ==========  ===== ==================  ==================
Title                               Medium      Year  Standard            Language
==================================  ==========  ===== ==================  ==================
`Chip Shop BASICODE 2`_             Tape        1984  BASICODE-2          English
`Wiegand & Fillinger - Basicode`_   Tape        1984  BASICODE-2          German
`BASICODE-2A`_                      Tape        1985  BASICODE-2          English and Dutch
`SIG/M volume 235: BASICODE`_       Diskette    1985  BASICODE-2          English and Dutch
`The Best of BASICODE 1`_           Tape        1985  BASICODE-2          Dutch
`The Best of BASICODE 2`_           Tape        1985  BASICODE-2          Dutch
`The Best of BASICODE 3`_           Tape        1986  BASICODE-2          Dutch
`The Best of BASICODE 4`_           Tape        1987  BASICODE-2          Dutch
`The Best of BASICODE 5`_           CD          1988  BASICODE-2          Dutch
`The Best of BASICODE 6`_           Diskette    1991  BASICODE-2          Dutch
`The Best of BASICODE 7`_           Diskette    1992  Text only           Dutch
`BASICODE-3`_                       Tape        1986  BASICODE-3          Dutch
`BASICODE-3 Verzamelcassette 1`_    Tape        1987  BASICODE-3          Dutch
`BASICODE-3 Verzamelcassette 2`_    Tape        1987  BASICODE-3          Dutch
`BASICODE-3 Verzamelcassette 3`_    Tape        1988  BASICODE-3          Dutch
`BASICODE-3 Verzamelcassette 4`_    Tape        1988  BASICODE-3          Dutch
`BASICODE-3 Verzamelcassette 5`_    Tape        1989  BASICODE-3          Dutch
`BASICODE-3 Verzamelcassette 6`_    Tape        1989  BASICODE-3          Dutch
`BASICODE-3 Verzamelcassette 7`_    Tape        1990  BASICODE-3          Dutch and German
`BASICODE-3 Verzamelcassette 8`_    Tape        1990  BASICODE-3          Dutch and German
`BASICODE-3 Verzamelcassette 9`_    Tape        1990  BASICODE-3          Dutch and German
`BasiCode Sammelsurium`_            Diskette    1998  BASICODE-2, 3, 3C   German
==================================  ==========  ===== ==================  ==================

.. _BASICODE-2A: Basicode-2a/
.. _Chip Shop BASICODE 2: Chip_Shop_Basicode_2/
.. _Wiegand & Fillinger - Basicode: Wiegand_Fillinger_Basicode_2/
.. _`SIG/M volume 235: BASICODE`: SIGM-235/
.. _The Best of BASICODE 1: Best_of_Basicode_1/
.. _The Best of BASICODE 2: Best_of_Basicode_2/
.. _The Best of BASICODE 3: Best_of_Basicode_3/
.. _The Best of BASICODE 4: Best_of_Basicode_4/
.. _The Best of BASICODE 5: Best_of_Basicode_5/
.. _The Best of BASICODE 6: Best_of_Basicode_6/
.. _The Best of BASICODE 7: Best_of_Basicode_7/
.. _BASICODE-3: Basicode-3/
.. _BASICODE-3 Verzamelcassette 1: Verzamelcassette_1/
.. _BASICODE-3 Verzamelcassette 2: Verzamelcassette_2/
.. _BASICODE-3 Verzamelcassette 3: Verzamelcassette_3/
.. _BASICODE-3 Verzamelcassette 4: Verzamelcassette_4/
.. _BASICODE-3 Verzamelcassette 5: Verzamelcassette_5/
.. _BASICODE-3 Verzamelcassette 6: Verzamelcassette_6/
.. _BASICODE-3 Verzamelcassette 7: Verzamelcassette_7/
.. _BASICODE-3 Verzamelcassette 8: Verzamelcassette_8/
.. _BASICODE-3 Verzamelcassette 9: Verzamelcassette_9/
.. _`BasiCode Sammelsurium`: Sammelsurium/



Acknowledgements
----------------

A big thank you to **Janny Looyenga**, **Jan Bredenbeek**, **André van der Leeden**, **Thomas Rademacher** and many others for history, BASICODE recordings and background information!


Books
-----

- *BASICODE Hobbyscoop 2*, Nederlandse Omroep Stichting, 1984.
- *Het BASICODE-3 Boek*, Kluwer Technische Boeken, Deventer, 1986.
- Michael Wiegand, Heike u. Manfred Fillinger, *BASICODE. Mit Programmkassette*, Ravensburger Buchverlag, Ravensburg, 1986.

Online resources
----------------

- Janny Looyenga, `BASICODE`_.
- Prof. Dr. Horst Völz, `Datenaustausch mit BASICODE`_, *Radio Fernsehen Elektronik* **1** 1990.
- Victor Reijs, `Overview of BASICODE-3`_.
- Lennart Benschop, `BASICODE: an example of Dutch computer folklore`_.
- Thomas Rademacher, `BasiCode – Software für alle`_.
- Jan Bredenbeek, `BASICODE wiki`_.

.. _BASICODE: http://www.nostalgia8.nl/basicode.htm
.. _`Datenaustausch mit BASICODE`: http://www.kc85emu.de/scans/rfe0190/Basicode.htm
.. _`BASICODE: an example of Dutch computer folklore`: https://lennartb.home.xs4all.nl/basicode.html
.. _`Overview of BASICODE-3`: http://www.iol.ie/~geniet/eng/BASICODE3sub.htm
.. _`BasiCode – Software für alle`: http://www.joyce.de/basicode/
.. _`BASICODE wiki`: https://github.com/janbredenbeek/Basicode/wiki
