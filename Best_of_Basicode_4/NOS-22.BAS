1000 A=1000:GOTO 20
1010 REM Stelsels
1020 DIM H$(15),L$(15),QA$(8),QB$(8)
1030 GOSUB 22240:REM inlezen data
1040 GOSUB 100
1050 HO=13:VE=6:GOSUB 110
1060 PRINT ;"* DECIMAAL *"
1070 HO=11:VE=9:GOSUB 110
1080 PRINT ;"* HEXADECIMAAL *"
1090 HO=14:VE=12:GOSUB 110
1100 PRINT ;"* BINAIR *"
1110 FOR T=1 TO VT*75:NEXT T
1120 :
1130 REM DEEL 1 UITLEG
1140 F=0:GOSUB 100
1150 HO=0:VE=5:GOSUB 110
1160 PRINT ;"Dit programma bestaat uit twee delen."
1170 PRINT :PRINT :PRINT 
1180 PRINT "  Het eerste deel is bedoeld om U"
1190 PRINT "  inzicht te geven in het 2-tallig"
1200 PRINT "  en het 16-tallig stelsel."
1210 PRINT :PRINT 
1220 PRINT "  Het tweede gedeelte is een reken"
1230 PRINT "  programma waarmee U getallen in"
1240 PRINT "  de andere stelsels kunt omzetten."
1250 PRINT :PRINT "  Na deel 1 komt U vanzelf in 2."
1260 PRINT :PRINT 
1270 PRINT "        Uw keuze 1 of 2 ";
1280 GOSUB 21200:REM buffer leeg
1290 GOSUB 210
1300 IF IN$="1" THEN 1330
1310 IF IN$="2" THEN 4130
1320 GOTO 1280
1330 GOSUB 100
1340 PRINT :PRINT 
1350 PRINT "Wij zijn gewend in het tien-tallig of"
1360 PRINT "decimale stelsel te rekenen."
1370 PRINT 
1380 PRINT "Hiervoor hebben we de beschikking over"
1390 PRINT "de cijfers  0 t/m 9, waarmee we alle"
1400 PRINT "mogelijke getallen kunnen samenstellen."
1410 PRINT 
1420 PRINT "De computer bestaat uit vele duizenden"
1430 PRINT "electronische schakelaars."
1440 PRINT "   Zo'n  schakelaar kent 2 standen:"
1450 PRINT 
1460 PRINT "       UIT of 0     AAN of 1"
1470 PRINT 
1480 PRINT "Om de computer te laten werken moeten"
1490 PRINT "we dus een systeem gebruiken, waarmee"
1500 PRINT "we getallen opbouwen met 2 cijfers"
1510 PRINT "in plaats van de 10 die we gewend zijn."
1520 PRINT 
1530 PRINT "We moeten gaan werken met het"
1540 PRINT "twee-tallig of BINAIRE stelsel."
1550 GOSUB 20530:REM verder
1560 PRINT :PRINT 
1570 PRINT "Op de volgende pagina's wordt de opbouw"
1580 PRINT "van respectievelijk een decimaal en een"
1590 PRINT "binair getal getoond."
1600 PRINT 
1610 PRINT "Na de opbouw van de getallen ziet U de"
1620 PRINT "rekenkundige samenstelling."
1630 PRINT "Hieruit volgt voor het binaire getal"
1640 PRINT "vanzelf de omzetting naar decimaal."
1650 PRINT :PRINT 
1660 PRINT "Het binaire getal bestaat, zoals U zult"
1670 PRINT "zien uit 8 cijfers."
1680 PRINT 
1690 PRINT "We noemen dit  8 bit  of  1 byte."
1700 PRINT :PRINT 
1710 PRINT "In de opbouw schema's komt U  ^  tegen."
1720 PRINT "Dit teken betekent:  - tot de macht -"
1730 PRINT 
1740 PRINT "B.V.  10^3 = 10x10x10 = 1000"
1750 GOSUB 20530:REM verder
1760 HO=1:VE=3:GOSUB 110
1770 PRINT ;"We bekijken eerst een decimaal getal."
1780 VE=5:GOSUB 110
1790 PRINT ;"  b.v."
1800 A$="49683"
1810 QA$(1)="Tienduizendtallen"
1820 QB$(1)="x 10^4  of  4 x 10000 = 40000"
1830 QA$(2)="Duizendtallen"
1840 QB$(2)="x 10^3  of  9 x  1000 =  9000"
1850 QA$(3)="Honderdtallen"
1860 QB$(3)="x 10^2  of  6 x   100 =   600"
1870 QA$(4)="Tientallen"
1880 QB$(4)="x 10^1  of  8 x    10 =    80"
1890 QA$(5)="Eenheden"
1900 QB$(5)="x 10^0  of  3 x     1 =     3"
1910 GOSUB 20000:REM verplaats getal
1920 FOR I=1 TO VT*60:NEXT I
1930 GOSUB 20360:REM wissel tekst
1940 HO=27:VE=18:GOSUB 110
1950 PRINT ;"----- +"
1960 HO=8:VE=20:GOSUB 110
1970 FOR K=1 TO VT*30:NEXT K
1980 PRINT ;"Samen is het weer  49683"
1990 GOSUB 20530:REM verder
2000 A$="10100110"
2010 QA$(1)=" 128 tallen"
2020 QB$(1)="x 2^7  of  1 x 128 = 128"
2030 QA$(2)="  64 tallen"
2040 QB$(2)="x 2^6  of  0 x  64 =   0"
2050 QA$(3)="  32 tallen"
2060 QB$(3)="x 2^5  of  1 x  32 =  32"
2070 QA$(4)="  16 tallen"
2080 QB$(4)="x 2^4  of  0 x  16 =   0"
2090 QA$(5)="   8 tallen"
2100 QB$(5)="x 2^3  of  0 x   8 =   0"
2110 QA$(6)="   4 tallen"
2120 QB$(6)="x 2^2  of  1 x   4 =   4"
2130 QA$(7)="   2 tallen"
2140 QB$(7)="x 2^1  of  1 x   2 =   2"
2150 QA$(8)="   Eenheden"
2160 QB$(8)="x 2^0  of  0 x   1 =   0"
2170 HO=1:VE=2:GOSUB 110
2180 PRINT ;"Binair"
2190 F=3
2200 GOSUB 20000:REM verplaats getal
2210 FOR I=1 TO VT*60:NEXT I
2220 GOSUB 20360:REM wissel tekst
2230 F=0
2240 HO=24:VE=20:GOSUB 110
2250 PRINT ;"--- +"
2260 FOR K=1 TO VT*30:NEXT K
2270 PRINT "       Decimaal is dit  166"
2280 GOSUB 20530:REM verder
2290 PRINT :PRINT :PRINT 
2300 PRINT "Is het verschil U opgevallen ?"
2310 PRINT 
2320 PRINT "    Decimaal    10^3"
2330 PRINT 
2340 PRINT "    Binair       2^3"
2350 PRINT 
2360 PRINT "In de praktijk is het erg lastig om"
2370 PRINT "altijd met lange binaire getallen te"
2380 PRINT "moeten werken."
2390 PRINT 
2400 PRINT "Daarom nemen we 4 binaire cijfers bij"
2410 PRINT "elkaar en dan blijkt, dat er met deze"
2420 PRINT "vier cijfers  16  combinaties te maken"
2430 PRINT "zijn."
2440 PRINT "       Van 0000 t/m 1111."
2450 PRINT 
2460 PRINT "Met deze 16 kunnen we het 16 tallig of"
2470 PRINT "het HEXADECIMALE stelsel vormen."
2480 GOSUB 20530:REM verder
2490 PRINT :PRINT :PRINT 
2500 PRINT "Daar er maar 10 cijfers zijn 0 t/m 9"
2510 PRINT "gebruiken we voor de waarde's 10 t/m 15"
2520 PRINT "de letters  A B C D E F."
2530 PRINT :PRINT 
2540 PRINT "Op de volgende pagina kunt U zelf een"
2550 PRINT "4 bit binair getal intikken en zien"
2560 PRINT "hoe hieruit een hex. waarde ontstaat."
2570 PRINT :PRINT 
2580 PRINT "Als U een 0 of een 1 intikt, worden op"
2590 PRINT "gelijke hoogte 1 of meer schakelaars"
2600 PRINT "naar links of naar rechts getekend."
2610 PRINT 
2620 PRINT "Boven in beeld staat Uw binaire getal."
2630 PRINT 
2640 PRINT "Als U de doorgaande lijn van boven naar"
2650 PRINT "beneden volgt, komt U uit bij de hex."
2660 PRINT "waarde van Uw binaire getal."
2670 GOSUB 20530:REM verder
2680 REM Teken het schema
2690 GOSUB 100
2700 HO=9:VE=1:GOSUB 110
2710 PRINT ;"Bin.      ="
2720 RESTORE 
2730 GOSUB 22240:REM data inlezen
2740 READ HO:READ VE
2750 IF HO=50 THEN 2800
2760 HO=HO+2:VE=VE-1
2770 GOSUB 110
2780 PRINT ;"o";
2790 GOTO 2740
2800 HO=0:VE=22:GOSUB 110
2810 PRINT ;"Hex. : 0 1 2 3 4 5 6 ";
2820 PRINT ;"7 8 9 A B C D E F";
2830 W=0:FOR I=0 TO 3
2840 HO=0:VE=I+(3-I)+I*5
2850 GOSUB 110
2860 PRINT ;"S";I+1;"-";
2870 GOSUB 21200:GOSUB 210
2880 IF IN$="0" THEN GOSUB 20600:GOTO 2910
2890 IF IN$="1" THEN GOSUB 20870:GOTO 2910
2900 GOTO 2870
2910 U=8
2920 IF I=1 THEN U=4
2930 IF I=2 THEN U=2
2940 IF I=3 THEN U=1
2950 W=W+(ASC(IN$)-48)*U
2960 VE=1:HO=14+I:GOSUB 110
2970 PRINT ;IN$;
2980 NEXT I
2990 VE=21:HO=7+2*W:GOSUB 110
3000 PRINT ;"!";
3010 HO=10:VE=24:GOSUB 110
3020 PRINT ;"Nog een keer ?  J/N ";
3030 GOSUB 21200:REM buffer leeg
3040 GOSUB 210
3050 LE$=IN$
3060 IF (LE$="J") OR(LE$="j") THEN 2680
3070 IF (LE$="N") OR(LE$="n") THEN 3090
3080 GOTO 3030
3090 GOSUB 100
3100 PRINT :PRINT 
3110 PRINT "Uit het schema van de vorige pagina"
3120 PRINT "blijkt o.a."
3130 PRINT "           0101 = 5 hex."
3140 PRINT "           1010 = A hex."
3150 PRINT "           0011 = 3 hex."
3160 PRINT "           1111 = F hex."
3170 PRINT 
3180 PRINT "We kunnen de binaire getallen achter"
3190 PRINT "elkaar zetten, om een groot getal te"
3200 PRINT "vormen."
3210 PRINT 
3220 PRINT "       0101 1010  0011 1111"
3230 PRINT 
3240 PRINT "Zoals U ziet, hebben we een onhandig"
3250 PRINT "lang getal gekregen."
3260 PRINT 
3270 PRINT "Eenvoudiger wordt het, als we de hex."
3280 PRINT "waarde's achter elkaar zetten: 5A3F"
3290 PRINT 
3300 PRINT "De waarde van beide getallen is gelijk."
3310 GOSUB 20530:REM verder
3320 HO=1:VE=3:GOSUB 110
3330 PRINT ;"Laten we dit getal eens bekijken;"
3340 VE=5:GOSUB 110
3350 PRINT ;"  Hex."
3360 A$="5A3F"
3370 QA$(1)=" 4096 tallen"
3380 QB$(1)="x 16^3  of   5 x 4096 = 20480"
3390 QA$(2)="  256 tallen"
3400 QB$(2)="x 16^2  of  10 x  256 =  2560"
3410 QA$(3)="   16 tallen"
3420 QB$(3)="x 16^1  of   3 x   16 =    48"
3430 QA$(4)="   Eenheden"
3440 QB$(4)="x 16^0  of  15 x    1 =    15"
3450 GOSUB 20000:REM verplaats getal
3460 FOR I=1 TO VT*60:NEXT I
3470 GOSUB 20360:REM wissel tekst
3480 HO=27:VE=16:GOSUB 110
3490 PRINT ;"----- +"
3500 HO=6:VE=18:GOSUB 110
3510 FOR K=1 TO VT*30:NEXT K
3520 PRINT ;"Decimale waarde is:  23103"
3530 GOSUB 20530:REM verder
3540 PRINT :PRINT :PRINT 
3550 PRINT "Om hex. getallen van decimale getallen"
3560 PRINT "te kunnen onderscheiden, worden hex."
3570 PRINT "getallen aangegeven met &, &H of H."
3580 PRINT "Dit verschilt per computer."
3590 PRINT 
3600 PRINT "U heeft waarschijnlijk al ontdekt, dat"
3610 PRINT "een hex. getal van 2 cijfers overeen"
3620 PRINT "komt met een 8 bit binair getal."
3630 PRINT 
3640 PRINT "Omdat de home-computer een 8 bit micro"
3650 PRINT "processor heeft, worden binaire - en"
3660 PRINT "hex. getallen met nullen aangevuld tot"
3670 PRINT "8 bit."
3680 PRINT "       &E    wordt   &0E"
3690 PRINT "       0011  wordt   00000011"
3700 PRINT 
3710 PRINT "Wat U nu nog mist is een eenvoudige"
3720 PRINT "methode om van decimaal naar de andere"
3730 PRINT "stelsels om te rekenen."
3740 GOSUB 20530:REM verder
3750 PRINT :PRINT 
3760 PRINT "Het is een kwestie van delen."
3770 PRINT 
3780 PRINT "Als voorbeeld blijven we even in het"
3790 PRINT "10 tallige stelsel."
3800 PRINT :PRINT 
3810 PRINT "We nemen een getal  3581  en gaan"
3820 PRINT 
3830 PRINT "delen door 10  . . 3581:10=358 rest 1"
3840 PRINT 
3850 PRINT "uitkomst 358  . . . 358:10=35  rest 8"
3860 PRINT 
3870 PRINT "uitkomst 35  . . . . 35:10=3   rest 5"
3880 PRINT 
3890 PRINT "uitkomst 3  . . . . . 3:10=0   rest 3"
3900 PRINT :PRINT 
3910 PRINT "Als we nu de resten van de delingen"
3920 PRINT "van beneden naar boven opschrijven"
3930 PRINT "krijgen we 3581 terug."
3940 GOSUB 20530:REM verder
3950 PRINT :PRINT :PRINT 
3960 PRINT "Door een getal op dezelfde wijze te"
3970 PRINT "delen door 2 krijgt U als rest steeds"
3980 PRINT "een 1 of een 0."
3990 PRINT 
4000 PRINT "Als U nu weer van onder naar boven"
4010 PRINT "leest ziet U de binaire waarde van"
4020 PRINT "het decimale getal."
4030 PRINT 
4040 PRINT "Probeer het maar eens."
4050 PRINT :PRINT 
4060 PRINT "Delen door 16 geeft als resultaat een"
4070 PRINT "hexadecimaal getal."
4080 PRINT :PRINT 
4090 PRINT "Eenvoudiger is het om gebruik te maken"
4100 PRINT "van het hierna volgende programma."
4110 GOSUB 20530:REM verder
4120 :
4130 REM DEEL 2 REKEN-PROGRAMMA
4140 GOSUB 100
4150 HO=2:VE=3:GOSUB 110
4160 PRINT ;"Dit is het omreken programma,"
4170 PRINT :PRINT "  voor decimale, hexadecimale en"
4180 PRINT :PRINT "  binaire getallen."
4190 VE=11:GOSUB 110
4200 PRINT "Er zijn 3 mogelijkheden:"
4210 PRINT :PRINT "   1 - Berekening per getal."
4220 PRINT :PRINT "   2 - Alle getallen van 0 t/m 255."
4230 PRINT :PRINT "   3 - Printer uitvoer in tabelvorm."
4240 PRINT :PRINT :PRINT 
4250 PRINT "  Uw keuze ? ";
4260 GOSUB 21200:REM buffer leeg
4270 GOSUB 210
4280 IF IN$="1" THEN 4320
4290 IF IN$="2" THEN 4740
4300 IF IN$="3" THEN 4980
4310 GOTO 4260
4320 GOSUB 100
4330 HO=3:VE=2:GOSUB 110
4340 PRINT ;"Ook hier zijn 3 mogelijkheden:"
4350 PRINT 
4360 PRINT :PRINT "   D - Decimaal getal invoeren."
4370 PRINT :PRINT "   H - Hexadecimaal getal invoeren."
4380 PRINT :PRINT "   B - Binair getal invoeren."
4390 PRINT :PRINT 
4400 PRINT " Het ingevoerde getal wordt in de"
4410 PRINT " beide andere stelsels omgezet."
4420 PRINT :PRINT 
4430 PRINT " Met  M  krijgt U het menu terug."
4440 PRINT 
4450 PRINT " Met  T  gaat U terug naar het begin."
4460 PRINT 
4470 PRINT " Met  S  verlaat U het programma."
4480 PRINT :PRINT 
4490 PRINT :PRINT " Uw keuze ? ";
4500 GOSUB 21200:REM buffer leeg
4510 GOSUB 210
4520 LE$=IN$
4530 IF (LE$="D") OR(LE$="d") THEN 4600
4540 IF (LE$="H") OR(LE$="h") THEN 4640
4550 IF (LE$="B") OR(LE$="b") THEN 4680
4560 IF (LE$="M") OR(LE$="m") THEN 4130
4570 IF (LE$="T") OR(LE$="t") THEN 1130
4580 IF (LE$="S") OR(LE$="s") THEN 5320
4590 GOTO 4500
4600 GOSUB 21370:REM dec input
4610 GOSUB 22320:REM bepalen hex waarde
4620 GOSUB 22030:REM scherm-uitvoer
4630 GOTO 4710
4640 GOSUB 21500:REM hex input
4650 GOSUB 22320
4660 GOSUB 22030
4670 GOTO 4710
4680 GOSUB 21760:REM bin input
4690 GOSUB 22320
4700 GOSUB 22030
4710 HO=4:VE=20:GOSUB 110
4720 PRINT ;"Uw keuze  D  H  B  M  T  S  ? ";
4730 GOTO 4500
4740 DE=0:Y=0
4750 FOR J=1 TO 16
4760 GOSUB 100
4770 PRINT :PRINT :PRINT :PRINT 
4780 FOR K=0 TO 15
4790 DE=Y+K
4800 GOSUB 22320:REM bepalen hex waarde
4810 GOSUB 22030:REM scherm-uitvoer
4820 NEXT K
4830 Y=Y+16
4840 HO=2:VE=23:GOSUB 110
4850 IF J=16 THEN 4930
4860 PRINT ;"     V = verder     S = stop ";
4870 GOSUB 21200:REM buffer leeg
4880 GOSUB 210
4890 LE$=IN$
4900 IF (LE$="V") OR(LE$="v") THEN 4960
4910 IF (LE$="S") OR(LE$="s") THEN J=16:GOTO 4960
4920 GOTO 4870
4930 PRINT ;"Meer is er niet. Opnieuw met toets.";
4940 GOSUB 21200:REM buffer leeg
4950 GOSUB 210
4960 NEXT J
4970 GOTO 4140
4980 GOSUB 100
4990 HO=2:VE=10:GOSUB 110
5000 PRINT ;"Printer-mode:"
5010 PRINT :PRINT "  80 karakters per regel."
5020 PRINT :PRINT "  Minimaal 52 regels."
5030 HO=2:VE=20:GOSUB 110
5040 PRINT ;"Druk op een toets voor START ";
5050 GOSUB 21200:REM buffer leeg
5060 GOSUB 210
5070 GOSUB 100
5080 DE=0:N=0
5090 FOR P=0 TO 47
5100 DE=P:N=48:GOSUB 22090:REM print
5110 IF P=15 THEN GOSUB 360:GOSUB 360
5120 IF P=31 THEN GOSUB 360:GOSUB 360
5130 NEXT P
5140 GOSUB 21250:REM papier
5150 GOSUB 100
5160 FOR P=96 TO 143
5170 DE=P:N=48:GOSUB 22090:REM print
5180 IF P=111 THEN GOSUB 360:GOSUB 360
5190 IF P=127 THEN GOSUB 360:GOSUB 360
5200 NEXT P
5210 GOSUB 21250:REM papier
5220 GOSUB 100
5230 FOR P=192 TO 223
5240 DE=P:N=32:GOSUB 22090:REM print
5250 IF P=207 THEN GOSUB 360:GOSUB 360
5260 NEXT P
5270 HO=1:VE=10:GOSUB 110
5280 PRINT ;"Terug in het programma met een toets.";
5290 GOSUB 21200:REM buffer leeg
5300 GOSUB 210
5310 GOTO 4130
5320 GOSUB 100
5330 HO=5::VE=10:GOSUB 110
5340 PRINT ;"Met <RUN> kunt U opnieuw."
5350 PRINT :PRINT "Zo niet, dan tot een volgende keer."
5360 PRINT 
5370 END
5380 :
20000 REM GETAL VERPLAATSEN
20010 HO=10:VE=5-F:GOSUB 110
20020 PRINT ;A$;
20030 FOR K=1 TO VT*60:NEXT K
20040 AA=LEN(A$)
20050 HO=9+AA
20060 FOR VE=(6-F) TO (5+2*AA)-F
20070 GOSUB 110
20080 PRINT ;MID$(A$,AA,1);
20090 FOR K=1 TO VT:NEXT K
20100 NEXT VE
20110 FOR HO=HO TO 1 STEP -1
20120 GOSUB 110
20130 PRINT ;MID$(A$,AA,1);
20140 FOR K=1 TO VT:NEXT K
20150 NEXT HO
20160 HO=9+AA
20170 FOR VE=(6-F) TO (5+2*AA)-F
20180 GOSUB 110
20190 PRINT ;" ";
20200 FOR K=1 TO VT:NEXT K
20210 NEXT VE
20220 FOR HO=HO TO 2 STEP -1
20230 GOSUB 110
20240 PRINT ;" ";
20250 FOR K=1 TO VT:NEXT K
20260 NEXT HO
20270 FOR I=1 TO LEN(QA$(AA))
20280 Q$=MID$(QA$(AA),I,1)
20290 PRINT ;Q$;
20300 FOR K=1 TO VT:NEXT K
20310 NEXT I
20320 AA=AA-1
20330 IF AA>=1 THEN 20050
20340 RETURN
20350 :
20360 REM VERWISSEL TEKST
20370 AA=LEN(A$):AB=AA
20380 FOR VE=(6+AA*2)-F TO 8-F STEP -2
20390 FOR HO=LEN(QA$(AB))+3 TO 2 STEP -1
20400 GOSUB 110
20410 PRINT ;" ";
20420 FOR K=1 TO VT:NEXT K
20430 NEXT HO
20440 FOR I=1 TO LEN(QB$(AB))
20450 Q$=MID$(QB$(AB),I,1)
20460 PRINT ;Q$;
20470 FOR K=1 TO VT:NEXT K
20480 NEXT I
20490 AB=AB-1
20500 NEXT VE
20510 RETURN
20520 :
20530 REM VERVOLG
20540 HO=3:VE=24:GOSUB 110
20550 PRINT ;"Druk op een toets voor vervolg. ";
20560 GOSUB 21200:REM buffer leeg
20570 GOSUB 210:GOSUB 100
20580 RETURN
20590 :
20600 REM SCHAKELAAR 0
20610 PRINT ;IN$;
20620 IF I=1 THEN 20680
20630 IF I=2 THEN 20730
20640 IF I=3 THEN 20810
20650 HO=21:VE=3:GOSUB 21150
20660 HO=20:VE=4:GOSUB 21150
20670 RETURN
20680 HO=13:VE=8:GOSUB 21150
20690 HO=29:GOSUB 21150
20700 HO=12:VE=9:GOSUB 21150
20710 HO=28:GOSUB 21150
20720 RETURN
20730 FOR HO=9 TO 33 STEP 8
20740 GOSUB 21150
20750 NEXT HO
20760 VE=14
20770 FOR HO=8 TO 32 STEP 8
20780 GOSUB 21150
20790 NEXT HO
20800 RETURN
20810 VE=18
20820 FOR HO=7 TO 35 STEP 4
20830 GOSUB 21150
20840 NEXT HO
20850 RETURN
20860 :
20870 REM SCHAKELAAR 1
20880 PRINT ;IN$;
20890 IF I=1 THEN 20950
20900 IF I=2 THEN 21000
20910 IF I=3 THEN 21090
20920 HO=23:VE=3:GOSUB 21150
20930 HO=24:VE=4:GOSUB 21150
20940 RETURN
20950 HO=15:VE=8:GOSUB 21150
20960 HO=31:GOSUB 21150
20970 HO=16:VE=9:GOSUB 21150
20980 HO=32:GOSUB 21150
20990 RETURN
21000 VE=13
21010 FOR HO=11 TO 35 STEP 8
21020 GOSUB 21150
21030 NEXT HO
21040 VE=14
21050 FOR HO=12 TO 36 STEP 8
21060 GOSUB 21150
21070 NEXT HO
21080 RETURN
21090 VE=18
21100 FOR HO=9 TO 37 STEP 4
21110 GOSUB 21150
21120 NEXT HO
21130 RETURN
21140 :
21150 REM PRINT S
21160 GOSUB 110
21170 PRINT ;"S";
21180 RETURN
21190 :
21200 REM BUFFER LEGEN
21210 GOSUB 200
21220 IF IN$<>"" THEN 21210
21230 RETURN
21240 :
21250 REM NIEUW PAPIER
21260 GOSUB 100
21270 HO=3:VE=10:GOSUB 110
21280 PRINT ;"Nieuw vel papier in de printer,"
21290 VE=12:GOSUB 110
21300 PRINT ;"zodra hij gestopt is."
21310 VE=20:GOSUB 110
21320 PRINT ;"Verder met een toets.";
21330 GOSUB 21200:REM buffer leeg
21340 GOSUB 210
21350 RETURN
21360 :
21370 REM INPUT DECIMAAL GETAL
21380 GOSUB 100
21390 HO=6:VE=5:GOSUB 110
21400 PRINT ;"Na intikken  <RETURN>"
21410 HO=0:VE=9:GOSUB 110
21420 PRINT ;"Geef decimaal getal (0 t/m 255) ";
21430 INPUT D$
21440 DE=INT(VAL(D$)):IF D$="0" THEN 21470
21450 IF DE<=0 THEN 21380
21460 IF DE>255 THEN 21380
21470 PRINT :PRINT :PRINT 
21480 RETURN
21490 :
21500 REM INPUT HEXADECIMAAL GETAL
21510 GOSUB 100
21520 HO=6:VE=5:GOSUB 110
21530 PRINT ;"Na intikken  <RETURN>"
21540 HO=0:VE=9:GOSUB 110
21550 PRINT ;"Geef hexadec. getal (00 t/m FF) ";
21560 INPUT G$
21570 IF LEN(G$)<1 THEN 21510
21580 IF LEN(G$)>2 THEN 21510
21590 IF LEN(G$)=2 THEN 21640
21600 GB=ASC(G$)
21610 IF (GB<58) AND(GB>47) THEN DE=GB-48:GOTO 21730
21620 IF (GB<71) AND(GB>64) THEN DE=GB-55:GOTO 21730
21630 GOTO 21510
21640 GA=ASC(LEFT$(G$,1))
21650 GB=ASC(MID$(G$,2,1))
21660 IF (GA<58) AND(GA>47) THEN GA=GA-48:GOTO 21690
21670 IF (GA<71) AND(GA>64) THEN GA=GA-55:GOTO 21690
21680 GOTO 21510
21690 IF (GB<58) AND(GB>47) THEN GB=GB-48:GOTO 21720
21700 IF (GB<71) AND(GB>64) THEN GB=GB-55:GOTO 21720
21710 GOTO 21510
21720 DE=GA*16+GB
21730 PRINT :PRINT :PRINT 
21740 RETURN
21750 :
21760 REM INPUT BINAIR GETAL
21770 GOSUB 100
21780 HO=6:VE=5:GOSUB 110
21790 PRINT ;"Na intikken  <RETURN>"
21800 HO=27:VE=10:GOSUB 110
21810 PRINT ;".      ."
21820 HO=0:VE=9:GOSUB 110
21830 PRINT ;"Geef binair getal (8 bit) ";
21840 INPUT T$
21850 B=0:BO$=""
21860 FOR T=8 TO 1 STEP -1
21870 Z$=MID$(T$,T,1)
21880 IF (Z$<>"1") AND(Z$<>"0") THEN 21910
21890 BO$=BO$+Z$
21900 GOTO 21920
21910 B=B+1
21920 NEXT T
21930 IF B<>0 THEN 21770
21940 DE=0
21950 FOR F=0 TO 7
21960 E$=MID$(BO$,F+1,1)
21970 E=ASC(E$)-48
21980 DE=DE+E*2^F
21990 NEXT F
22000 PRINT :PRINT :PRINT 
22010 RETURN
22020 :
22030 REM SCHERM-UITVOER
22040 GOSUB 22410:REM Bepalen bin waarde
22050 PRINT S$;D$;" Dec. = ";H$(H);L$(L);
22060 PRINT ;" Hex. = ";BI$;" Binair"
22070 RETURN
22080 :
22090 REM PRINTER-UITVOER
22100 GOSUB 22320:REM Bep. hex.
22110 SR$="   "+S$+D$+" Dec. = "+H$(H)+L$(L)
22120 GOSUB 350
22130 GOSUB 22410:REM bep. bin. waarde
22140 SR$=" Hex. = "+BI$+" Bin.      "
22150 GOSUB 350
22160 DE=P+N:GOSUB 22320:REM Bep. hex.
22170 SR$=S$+D$+" Dec. = "+H$(H)+L$(L)
22180 GOSUB 350
22190 GOSUB 22410:REM bep. bin. waarde
22200 SR$=" Hex. = "+BI$+" Bin."
22210 GOSUB 350:GOSUB 360
22220 RETURN
22230 :
22240 REM INLEZEN DATA
22250 VT=40:REM VERTRAGING
22260 FOR I=0 TO 15
22270 READ H$(I)
22280 READ L$(I)
22290 NEXT I
22300 RETURN
22310 :
22320 REM BEPALEN HEX WAARDE
22330 SR=DE:GOSUB 300:D$=SR$
22340 S$=""
22350 IF DE<100 THEN S$=" "
22360 IF DE<10 THEN S$="  "
22370 H=INT(DE/16)
22380 L=DE-(H*16)
22390 RETURN
22400 :
22410 REM BEPALEN BINAIRE WAARDE
22420 BI$=""
22430 FOR I=7 TO 0 STEP -1
22440 B$="0"
22450 IF DE>=2^I THEN DE=DE-2^I:B$="1"
22460 BI$=BI$+B$
22470 NEXT I
22480 RETURN
22490 :
25000 DATA "0","0","1","1","2","2","3"
25010 DATA "3","4","4","5","5","6","6"
25020 DATA "7","7","8","8","9","9","A"
25030 DATA "A","B","B","C","C","D","D"
25040 DATA "E","E","F","F"
25050 DATA 20,2,20,3,12,6,13,6,14,6,15,6
25060 DATA 16,6,17,6,18,6,22,6,23,6,24,6
25070 DATA 25,6,26,6,27,6,28,6,12,7,28,7
25080 DATA 12,8,28,8,8,11,9,11,10,11,14
25090 DATA 11,15,11,16,11,24,11,25,11,26
25100 DATA 11,30,11,31,11,32,11,8,12,16
25110 DATA 12,24,12,32,12,8,13,16,13,24
25120 DATA 13,32,13,6,16,10,16,14,16,18
25130 DATA 16,22,16,26,16,30,16,34,16,6
25140 DATA 17,10,17,14,17,18,17,22,17,26
25150 DATA 17,30,17,34,17,6,18,10,18,14
25160 DATA 18,18,18,22,18,26,18,30,18,34
25170 DATA 18,5,20,7,20,9,20,11,20,13,20
25180 DATA 15,20,17,20,19,20,21,20,23,20
25190 DATA 25,20,27,20,29,20,31,20,33,20
25200 DATA 35,20,5,21,7,21,9,21,11,21,13
25210 DATA 21,15,21,17,21,19,21,21,21,23
25220 DATA 21,25,21,27,21,29,21,31,21,33
25230 DATA 21,35,21,50,0
25240 :
30000 REM 
30010 REM U kunt de snelheid in enkele
30020 REM onderdelen van het programma
30030 REM wijzigen met de waarde van
30040 REM VT in regel 22250
30050 REM 
30060 REM Programma geschreven in
30070 REM BASICODE 2  door:
30080 REM 
30090 REM L.D.R.P.Looyenga
30100 REM Stamperweg 1
30110 REM 3813 SZ Amersfoort
30120 REM 
30130 REM op een Acorn Electron
30140 REM 
30150 REM oktober 1986
30160 REM 
30170 REM Copyright NOS Hilversum
30180 REM 
