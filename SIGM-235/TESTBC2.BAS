1000 A=100:GOTO 20:REM RESERVEER STRINGRUIMTE
1010 GOSUB 100
1020 PRINT TAB(8);"BASICODE-2 TESTPROGRAMMA"
1030 PRINT TAB(8);"------------------------"
1040 PRINT:PRINT"Met dit programma willen we het nieuwe"
1050 PRINT:PRINT"Basicode-2 protocol en Uw subroutine's"
1060 PRINT:PRINT"testen. We beginnen maar meteen..."
1070 HO=15:VE=15
1080 HO=HO+1:HM=HO:GOSUB 110:GOSUB 120:IF HM=HO THEN 1080
1090 HM=HM-1:HO=0
1100 VE=VE+1:VM=VE:GOSUB 110:GOSUB 120:IF VM=VE THEN 1100
1110 VM=VM-1:HO=0:VE=8:GOSUB 110
1120 PRINT:PRINT"Als het goed is, meet Uw scherm"
1130 PRINT:PRINT HM+1;" bij ";VM+1;" karakters. Klopt dat?"
1140 PRINT:PRINT"Aan het eind van elke pagina wordt U"
1150 PRINT:PRINT"gevraagd op een toets te drukken. Druk"
1160 PRINT:PRINT"op de P als er iets niet klopt, druk"
1170 PRINT:PRINT"anders een willekeurige toets in."
1180 GOSUB 9000
1190 IF IN$="P"OR IN$="p"THEN 10000
1200 PRINT"We gaan nu de cursor besturen op het"
1210 PRINT:PRINT"scherm. Druk daartoe op de toetsen"
1220 PRINT:PRINT"I, J, K en M voor resp naar boven,"
1230 PRINT:PRINT"links, rechts en naar beneden."
1240 PRINT:PRINT"Het drukken op S stopt dit deel van het"
1250 PRINT:PRINT"programma."
1260 GOSUB 9000
1270 IF IN$="P"OR IN$="p"THEN 10000
1280 HO=INT(HM/2):VE=INT(VM/2):IN$="*"
1290 GOSUB 110:PRINT IN$;:GOSUB 110:GOSUB 120
1300 GOSUB 210
1310 IF IN$="I"THEN IF VE>0 THEN VE=VE-1
1320 IF IN$="K"THEN IF HO<HM THEN HO=HO+1
1330 IF IN$="J"THEN IF HO>0 THEN HO=HO-1
1340 IF IN$="M"THEN IF VE<VM THEN VE=VE+1
1350 IF IN$="S"THEN 1380
1360 IF VE=VM AND HO=HM THEN 1300
1370 GOTO 1290
1380 GOSUB 100:PRINT"Om te voorkomen dat het scherm scrollt"
1390 PRINT:PRINT"wordt de positie uiterst rechtsonder"
1400 PRINT:PRINT"niet geprint!"
1410 GOSUB 9000
1420 IF IN$="P"OR IN$="p"THEN 10000
1430 PRINT"We maken nu een tabel met getallen :"
1440 VE=3:HO=0:GOSUB 110
1450 PRINT"!    x   ! sin(x) !   x^2  !"
1460 PRINT"----------------------------"
1470 CT=6:CN=3
1480 FOR VE=5 TO VM-7
1490 GOSUB 110
1500 GOSUB 260:RV=(1-2*RV)*3
1510 SR=RV:GOSUB 310:PRINT"! ";SR$;" !";
1520 SR=SIN(RV):GOSUB 310:PRINT" ";SR$;" !";
1530 SR=RV^2:GOSUB 310:PRINT" ";SR$;" !"
1540 NEXT VE
1550 PRINT:PRINT"De getallen moeten netjes onder elkaar"
1560 PRINT:PRINT"in kolommen staan!"
1570 GOSUB 9000
1580 IF IN$="P"OR IN$="p"THEN 10000
1590 PRINT"Als er een getal niet past in het veld"
1600 PRINT:PRINT"als opgegeven (hier CN=3:CT=6), moeten"
1610 PRINT:PRINT"er bv sterretjes geprint worden:"
1620 SR=1E+23:GOSUB 300
1630 PRINT:PRINT"Als voorbeeld nemen we het getal ";SR$
1640 GOSUB 310:PRINT:PRINT"Dat wordt: ";SR$
1650 PRINT:PRINT"Als het te klein is, wordt er afgerond"
1660 PRINT:PRINT"en wordt het dus nul."
1670 SR=-3.45E-06:GOSUB 300
1680 PRINT:PRINT"Het getal ";SR$;" wordt dus ";
1690 GOSUB 310:PRINT SR$
1700 PRINT:PRINT"Voor het getal 0.000 schrijft U toch"
1710 PRINT:PRINT"geen min-teken, he?"
1720 GOSUB 9000
1730 IF IN$="P"OR IN$="p"THEN 10000
1740 PRINT"Nu testen we de routine op regel 200 en"
1750 PRINT:PRINT"de pieproutine. Als U op een toets"
1760 PRINT:PRINT"drukt piept de computer indien dat kan"
1770 PRINT:PRINT"en print een boodschap op het scherm."
1780 PRINT:PRINT"Het tikken van de S stopt de routine."
1790 K=0
1800 HO=0:VE=12:GOSUB 110
1810 K=NOT(K):IF K THEN PRINT"Druk op een toets..":GOTO 1830
1820 PRINT"                        "
1830 FOR I=0 TO 20:GOSUB 200:IF IN$="S"THEN I=101
1840 IF IN$=""THEN 1860
1850 VE=12:GOSUB 110:PRINT"PIEP!               ":GOSUB 250
1860 NEXT I
1870 IF IN$<>"S"THEN 1800
1880 GOSUB 9000
1890 IF IN$="P"OR IN$="p"THEN 10000
1900 PRINT"Volgens opgave van Uw subroutine is nog"
1910 GOSUB 270:SR=FR:GOSUB 300
1920 PRINT:PRINT SR$;" bytes aan geheugenruimte over."
1930 PRINT:PRINT"Als laatste kunnen we nu nog de printer"
1940 PRINT:PRINT"subroutine's testen. Is dat mogelijk?";
1950 GOSUB 210:IF IN$="N"OR IN$="n"THEN 2020
1960 PRINT:PRINT"Ok daar gaan we dan..."
1970 SR$="Hallo dit is een stukje tekst voor op":GOSUB 350
1980 SR$=" de printer.":GOSUB 350:GOSUB 360
1990 SR$="We zijn benieuwd of dat ook heeft gewerkt."
2000 GOSUB 350:GOSUB 360
2010 PRINT:PRINT"Zo, dat was dat."
2020 GOSUB 9000
2030 IF IN$="P"OR IN$="p"THEN 10000
2040 PRINT"Deze test is nu afgelopen. Op dit"
2050 PRINT:PRINT"bandje vindt U verder nog enkele"
2060 PRINT:PRINT"programma's om mee te testen. We zijn"
2070 PRINT:PRINT"zeer benieuwd naar de resultaten die U"
2080 PRINT:PRINT"behaald met deze programma's!"
2090 PRINT:PRINT"Laat U dat eens weten? Het adres en"
2100 PRINT:PRINT"telefoonnummer:"
2110 GOTO 10090
9000 HO=0:VE=VM:GOSUB 110
9010 PRINT"Probleem? druk op P..";:GOSUB 210:GOSUB 100:RETURN
10000 GOSUB 100:PRINT"Dan is er dus iets mis!!"
10010 PRINT"------------------------"
10020 PRINT:PRINT"Probeer uit te vinden wat precies en"
10030 PRINT"pas dan zonodig de subroutine's aan."
10040 PRINT"Maar er kan natuurlijk ook een fout in"
10050 PRINT"het protocol of dit programma zitten."
10060 PRINT"Probeert U eerst nog even de rest van"
10070 PRINT"dit programma te laten lopen?"
10080 PRINT"Neem dan svp kontakt op met:"
10090 PRINT:PRINT:PRINT"      J. Herrmann"
10100 PRINT:PRINT"      Musschenbroekstr. 17"
10110 PRINT:PRINT"      5621 EA Eindhoven"
10120 PRINT:PRINT"      Tel 040-438505"
10130 END
T"      Musschenbroekstr. 17"
