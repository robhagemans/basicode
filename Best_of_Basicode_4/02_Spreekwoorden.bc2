1000 A=500:GOTO 20
1010 REM  SPREEKWOORDEN
1020 REM 
1030 REM  ******************
1040 REM  * HOOFDPROGRAMMA *
1050 REM  ******************
1060 REM 
1070 GOSUB 4680:REM DIMENSIONEREN
1080 GOSUB 4610:REM INITIALISEREN
1090 GOSUB 4410:REM TITELBEELD
1100 GOSUB 3990:REM UITLEG
1110 GOSUB 3410:REM INTRO1
1120 GOSUB 3740:REM INTRO2
1130 GOSUB 3080:REM KADER TEKENEN
1140 GOSUB 3030:REM WILLEKEURIG BEGIN
1150 FOR N=1 TO AB
1160 FOR SP=1 TO 2
1170 GOSUB 1600:REM ZIN PRINTEN
1180 GOSUB 1830:REM INVULLEN
1190 IF A$<>Z$ THEN GOSUB 2280:REM FOUT
1200 IF A$=Z$ THEN GOSUB 2540:REM GOED
1210 NEXT SP:NEXT N
1220 GOSUB 2660:REM EINDSTAND
1230 ON IN GOTO 1120,1080,1240
1240 GOSUB 2940:REM EINDE
1250 END
1260 REM 
1270 REM ***************
1280 REM * SUBROUTINES *
1290 REM ***************
1300 REM 
1310 REM WIS1
1320 HO=2:FOR VE=7 TO 14
1330 IF (VE=9) OR(VE=11) THEN 1350
1340 GOSUB 110:PRINT SP$
1350 NEXT VE:RETURN
1360 REM WIS2
1370 HO=2:FOR VE=16 TO 22
1380 GOSUB 110:PRINT SP$
1390 NEXT VE:RETURN
1400 REM INLEZEN
1410 Z$=""
1420 READ W$:Z$=Z$+W$
1430 IF W$="*" THEN RESTORE :GOTO 1410
1440 IF RIGHT$(W$,1)<>"." THEN 1420
1450 RETURN
1460 REM SPATIEBALK
1470 HO=2:VE=22:GOSUB 110
1480 PRINT "Druk op de spatiebalk...";
1490 GOSUB 210:IF IN$<>" " THEN 1490
1500 RETURN
1510 REM ROEP SPELER
1520 IF SP=1 THEN N$=N1$:TS=S1
1530 IF SP=2 THEN N$=N2$:TS=S2
1540 HO=2:VE=17:GOSUB 110
1550 PRINT N$;" is nu aan de beurt."
1560 VE=19:GOSUB 110
1570 PRINT "Klaar voor de start?"
1580 RETURN
1590 REM ZIN INLEZEN+PRINTEN
1600 GOSUB 1320:GOSUB 1370:GOSUB 1410
1610 HO=LEN(TH$)+8:VE=11
1620 GOSUB 110:PRINT N
1630 GOSUB 1520
1640 Z=LEN(Z$)-1:CD=INT(TS*Z)+30
1650 Z$=LEFT$(Z$,Z):V$=""
1660 FOR I=1 TO Z
1670 L$=MID$(Z$,I,2)
1680 IF (L$="IJ") OR(L$="ij") THEN I=I+1:GOTO 1770
1690 L$=MID$(Z$,I,1)
1700 IF (L$="A") OR(L$="a") THEN 1770
1710 IF (L$="E") OR(L$="e") THEN 1770
1720 IF (L$="I") OR(L$="i") THEN 1770
1730 IF (L$="O") OR(L$="o") THEN 1770
1740 IF (L$="U") OR(L$="u") THEN 1770
1750 IF (L$="Y") OR(L$="y") THEN 1770
1760 V$=V$+L$
1770 NEXT I:GOSUB 270
1780 GOSUB 1470:GOSUB 1370
1785 HO=2:VE=13:GOSUB 110:PRINT "?";
1790 HO=INT((39-LEN(V$))/2):VE=7
1800 GOSUB 110:PRINT V$
1810 RETURN
1820 REM INVULLEN
1830 A$="":PH=2:PV=13
1840 FOR I=CD TO 0 STEP -1
1850 HO=34:VE=3:GOSUB 110:PRINT "   "
1860 SR=I:GOSUB 300:GOSUB 110:PRINT SR$
1870 FOR J=1 TO 10:GOSUB 20100
1880 HO=PH:VE=PV:GOSUB 110
1890 GOSUB 200
1900 IF IN$="" THEN 1990
1910 IF IN$=BS$ THEN GOSUB 2070:GOTO 1990
1920 IF IN$=CHR$(13) THEN J=10:GOTO 1990
1930 PRINT IN$;
1940 A$=A$+IN$
1950 GOSUB 20100
1960 GOSUB 120:PRINT "?";:PH=HO:PV=VE
1970 GOSUB 20000
1980 IF HO=38 THEN GOSUB 2170:REM WRAPAROUND
1990 NEXT J:GOSUB 20000
2000 SC=I
2010 IF IN$=CHR$(13) THEN I=0:GOSUB 110:PRINT " ";
2020 NEXT I:GOSUB 270
2030 HO=34:VE=3
2040 GOSUB 110:PRINT "   "
2050 RETURN
2060 REM CORRECTIE
2070 HO=HO-1
2080 IF (HO<2) AND(VE=13) THEN RETURN
2090 IF (HO<2) AND(VE=14) THEN HO=HE-1:VE=13
2100 GOSUB 110:PRINT "  ";:GOSUB 110:PRINT "?";
2110 PH=HO:PV=VE
2120 A=LEN(A$)
2130 IF A=1 THEN A$="":RETURN
2140 A$=LEFT$(A$,A-1)
2150 RETURN
2160 REM WRAPAROUND
2170 A=LEN(A$):B=A
2180 IF MID$(A$,B,1)<>" " THEN B=B-1:GOTO 2180
2190 HO=HO-(A-B):GOSUB 110:HE=HO
2200 FOR K=1 TO A-B+1:PRINT " ";:NEXT K
2210 HO=2:VE=14:GOSUB 110
2220 IF (B=A) THEN 2250
2230 PRINT RIGHT$(A$,A-B);
2240 GOSUB 120
2250 PH=HO:PV=VE:PRINT "?";
2260 RETURN
2270 REM FOUT
2280 IF SC<1 THEN 2410
2290 V$="":W$=""
2300 FOR I=1 TO Z
2310 L$=MID$(Z$,I,1)
2320 IF (L$=" ") OR(L$=",") THEN 2340
2330 V$=V$+L$
2340 NEXT I
2350 FOR I=1 TO LEN(A$)
2360 L$=MID$(A$,I,1)
2370 IF (L$=" ") OR(L$=",") THEN 2390
2380 W$=W$+L$
2390 NEXT I
2400 IF V$=W$ THEN Z$=V$:A$=W$:RETURN
2410 HO=2:VE=17:GOSUB 110
2420 IF SC<1 THEN PRINT "Je tijd is voorbij. Het was:"
2430 IF SC>0 THEN PRINT "Helaas niet goed. Het was:"
2440 VE=19:GOSUB 110
2450 IF Z<36 THEN PRINT Z$:GOTO 2510
2460 B=36
2470 IF MID$(Z$,B,1)<>" " THEN B=B-1:GOTO 2470
2480 PRINT LEFT$(Z$,B)
2490 VE=20:GOSUB 110
2500 PRINT RIGHT$(Z$,Z-B)
2510 GOSUB 1470
2520 RETURN
2530 REM GOED
2540 HO=2:VE=17:GOSUB 110
2550 GOSUB 260:I=INT(RV*10)
2560 PRINT G$(I)
2570 VE=19:GOSUB 110
2580 PRINT "Score in deze ronde: ";SC
2590 IF SP=1 THEN SA=SA+SC:VE=1:SC=SA
2600 IF SP=2 THEN SB=SB+SC:VE=3:SC=SB
2610 HO=LI+3:GOSUB 110
2620 SR=SC:GOSUB 310:PRINT SR$
2630 GOSUB 1470
2640 RETURN
2650 REM EINDSTAND
2660 GOSUB 1320:GOSUB 1370
2670 HO=2:VE=11:GOSUB 110
2680 PRINT SP$
2690 GOSUB 110:PRINT "EINDE VAN DIT SPEL."
2700 HO=2:VE=17:GOSUB 110
2710 IF SA>SB THEN PRINT "Proficiat, ";N1$
2720 IF (SB>SA) THEN PRINT "Proficiat, ";N2$
2730 IF SA<>SB THEN VE=19:GOSUB 110
2740 IF SA<>SB THEN PRINT "Je hebt gewonnen!"
2750 IF SA=SB THEN PRINT "Ongelooflijk. Een gelijkspel!"
2760 GOSUB 1470:GOSUB 1370
2770 HO=0:FOR VE=0 TO 11
2780 IF (VE>4) AND(VE<10) THEN 2800
2790 GOSUB 110:PRINT "   ";SP$;
2800 NEXT VE
2810 HO=2:VE=17:GOSUB 110
2820 PRINT "1. Dezelfde spelers nog 'n keer."
2830 VE=19:GOSUB 110
2840 PRINT "2. Nieuwe spelers in aantocht."
2850 VE=21:GOSUB 110
2860 PRINT "3. Stoppen."
2870 VE=7:GOSUB 110
2880 PRINT "WAT KIES JE? ";
2890 GOSUB 210:IN=VAL(IN$)
2900 IF (IN<1) OR(IN>3) THEN 2890
2910 IF IN=1 THEN GOSUB 4610
2920 RETURN
2930 REM EINDE
2940 GOSUB 1320:HO=0:FOR VE=0 TO 23
2950 IF (VE>4) AND(VE<10) THEN 2970
2960 GOSUB 110:PRINT "   ";SP$;
2970 NEXT VE:Z$="EIND GOED AL GOED"
2980 VE=7:HO=INT((39-LEN(Z$))/2)
2990 GOSUB 110:PRINT Z$
3000 VE=10:GOSUB 110
3010 RETURN
3020 REM WILLEKEURIG BEGIN
3030 FOR I=1 TO LEN(N2$)
3040 GOSUB 1410
3050 NEXT I
3060 RETURN
3070 REM KADER TEKENEN
3080 GOSUB 100
3090 HO=2:VE=1:GOSUB 110
3100 PRINT N1$;
3110 HO=LI+2:GOSUB 110
3120 PRINT ":   0 pt"
3130 HO=32:GOSUB 110:PRINT "TIJD:"
3140 HO=2:VE=3:GOSUB 110
3150 PRINT N2$
3160 HO=LI+2:GOSUB 110
3170 PRINT ":   0 pt"
3180 HO=0:VE=5:GOSUB 110
3190 PRINT "***************************************"
3200 FOR VE=6 TO 8:GOSUB 110
3210 PRINT "*                                     *"
3220 NEXT VE
3230 VE=9:GOSUB 110
3240 PRINT "***************************************"
3250 HO=2:VE=11:GOSUB 110
3260 PRINT TH$;" - NR. "
3270 HO=0:VE=15:GOSUB 110
3280 PRINT "+-------------------------------------+"
3290 FOR VE=16 TO 22:GOSUB 110
3300 PRINT "!                                     !"
3310 NEXT VE
3320 VE=23:GOSUB 110
3330 PRINT "+-------------------------------------+";
3340 RETURN
3350 REM KOP
3360 GOSUB 100:PRINT L1$
3370 HO=INT((39-LEN(TH$))/2):VE=1:GOSUB 110
3380 PRINT TH$:PRINT L1$
3390 RETURN
3400 REM INTRO1
3410 GOSUB 3360
3420 GOSUB 20100
3430 PRINT :GOSUB 120:PRINT "Voornaam speler 1";
3440 INPUT N1$
3450 IF N1$="" THEN N1$="Speler 1"
3460 GOSUB 110:PRINT SP$;"  "
3470 GOSUB 110:PRINT "Hallo ";N1$;","
3480 GOSUB 3900
3490 GOSUB 210:S1=VAL(IN$)
3500 IF (S1<1) OR(S1>3) THEN 3490
3510 IF S1=2 THEN S1=1.5
3520 IF S1=3 THEN S1=2
3530 GOSUB 110:PRINT IN$
3540 GOSUB 3360
3550 PRINT :GOSUB 120:PRINT "Voornaam speler 2";
3560 INPUT N2$
3570 IF N2$="" THEN N2$="Speler 2"
3580 IF N1$=N2$ THEN N1$=N1$+" 1":N2$=N2$+" 2"
3590 I=LEN(N1$)
3600 IF I>15 THEN N1$=LEFT$(N1$,15):GOTO 3600
3610 J=LEN(N2$)
3620 IF J>15 THEN N2$=LEFT$(N2$,15):GOTO 3620
3630 LI=I:IF J>I THEN LI=J
3640 GOSUB 110:PRINT SP$;"  "
3650 GOSUB 110:PRINT "Hallo ";N2$;","
3660 GOSUB 3900
3670 GOSUB 210:S2=VAL(IN$)
3680 IF (S2<1) OR(S2>3) THEN 3670
3690 IF S2=2 THEN S2=1.5
3700 IF S2=3 THEN S2=2
3710 GOSUB 110:PRINT IN$
3720 RETURN
3730 REM INTRO2
3740 GOSUB 3360
3750 PRINT :PRINT 
3760 PRINT :PRINT "Hoeveel ";TH$
3770 PRINT :PRINT "wil elk van jullie raden?"
3780 PRINT :PRINT "(Minstens 5; hoogstens 45)"
3790 PRINT :PRINT "Aantal: ";:GOSUB 120:VE=VE-1
3800 INPUT IN$:IN=VAL(IN$)
3810 IF (IN<5) OR(IN>45) THEN GOSUB 110:GOTO 3790
3820 AB=IN:GOSUB 20000
3830 HO=0:VE=22:GOSUB 110
3840 PRINT "Nog iets verbeteren (J/N) ?";
3850 GOSUB 210
3860 IF (IN$="J") OR(IN$="j") THEN GOSUB 3410:GOTO 3740
3870 IF (IN$<>"N") AND(IN$<>"n") THEN 3850
3880 RETURN
3890 REM INTROTEKST
3900 PRINT :PRINT "Om beide spelers gelijke kansen te"
3910 PRINT :PRINT "geven, moeten we rekening houden met"
3920 PRINT :PRINT "je typvaardigheid, dus de snelheid"
3930 PRINT :PRINT "waarmee je op 't toetsenbord ratelt."
3940 PRINT :PRINT "Kies EERLIJK uit de 3 mogelijkheden."
3950 PRINT :PRINT "(1 = vlug  2 = gemiddeld  3 = langzaam)"
3960 PRINT :PRINT "Jouw typsnelheid is: ";
3970 RETURN
3980 REM UITLEG
3990 GOSUB 100
4000 HO=9:VE=11:GOSUB 110
4010 PRINT "Wil je uitleg (J/N) ?";
4020 GOSUB 210
4030 IF (IN$="N") OR(IN$="n") THEN RETURN
4040 IF (IN$<>"J") AND(IN$<>"j") THEN 4020
4050 GOSUB 3360
4060 PRINT :PRINT "Dit spel is bedoeld voor twee personen."
4070 PRINT :PRINT "(In noodgevallen mag je natuurlijk ook"
4080 PRINT :PRINT "tegen jezelf spelen.)"
4090 PRINT :PRINT "Je ziet zo dadelijk een stukje tekst"
4100 PRINT :PRINT "over 't thema: ";TH$;"."
4110 PRINT :PRINT "Uit de tekst zijn alle klinkers (a-e-i-"
4120 PRINT :PRINT "o-u-y) weggelaten, zodat je heel gekke"
4130 PRINT :PRINT "'woorden' krijgt."
4140 PRINT :PRINT L1$
4150 GOSUB 1470
4160 GOSUB 3360
4170 PRINT :PRINT "Elke speler probeert de tekst zo snel"
4180 PRINT :PRINT "mogelijk te raden en in te tikken."
4190 PRINT :PRINT "Hoe langer de tekst is, hoe meer tijd"
4200 PRINT :PRINT "je krijgt."
4210 PRINT :PRINT "Je kunt verbeteren met de <-- toets."
4220 PRINT :PRINT "Controleer je antwoord en druk daarna,"
4230 PRINT :PRINT "maar NIET EERDER op de invoertoets."
4240 PRINT :PRINT "(RETURN, ENTER of iets dergelijks.)"
4250 PRINT :PRINT L1$:GOSUB 1470
4260 GOSUB 3360
4270 PRINT :PRINT "De eerste letter van het antwoord en"
4280 PRINT :PRINT "eigennamen schrijf je met een hoofd-"
4290 PRINT :PRINT "letter, de rest met kleine letters."
4300 PRINT :PRINT L1$
4310 PRINT :PRINT 
4320 PRINT :PRINT "     1. Uitleg nog eens lezen."
4330 PRINT :PRINT "     2. Ga verder met 't spel."
4340 PRINT :PRINT 
4350 PRINT :PRINT "     WAT KIES JE: ";
4360 GOSUB 210:IN=VAL(IN$)
4370 IF (IN<1) OR(IN>2) THEN 4360
4380 IF IN=1 THEN 4050
4390 RETURN
4400 REM TITELBEELD
4410 GOSUB 100
4420 HO=0:VE=7:GOSUB 110
4430 PRINT "    +-----------------------------+"
4440 PRINT "    !                             !"
4450 PRINT "    !  S P R E E K W O O R D E N  !"
4460 PRINT "    !                             !"
4470 PRINT "    !      Een programma van      !"
4480 PRINT "    !                             !"
4490 PRINT "    !         Harry Engel         !"
4500 PRINT "    !                             !"
4510 PRINT "    +-----------------------------+"
4520 HO=36:VE=21:GOSUB 110
4530 PRINT "=>";
4540 FOR W=1 TO 100:NEXT W
4550 GOSUB 110:PRINT "  ";
4560 FOR W=1 TO 100:NEXT W
4570 GOSUB 200
4580 IF IN$="" THEN 4520
4590 RETURN
4600 REM INITIALISEREN
4610 TH$="SPREEKWOORDEN"
4620 SP$="                                    "
4630 L1$="======================================="
4640 SA=0:SB=0
4650 CT=4:CN=0
4660 RETURN
4670 REM DIMENSIONEREN
4680 DIM G$(9)
4690 GOSUB 20200:GOSUB 20000
4700 G$(0)="NIET TE GELOVEN!":G$(1)="BEREGOED!"
4710 G$(2)="GEWELDIG!":G$(3)="EENZAME KLASSE!"
4720 G$(4)="WOW!":G$(5)="TE GEK, HOOR!"
4730 G$(6)="SUPER!":G$(7)="WAT BEN JIJ GOED!"
4740 G$(8)="FANTASTISCH!":G$(9)="KAN NIET BETER!"
4750 RETURN
19980 REM CURSOR UIT
19990 REM VOOR COMPUTERS MET IRRITANTE CURSOR
20000 PRINT CHR$(2);:REM P2000T
20010 RETURN
20090 REM CURSOR AAN
20100 PRINT CHR$(1);:REM P2000T
20110 RETURN
20190 REM ASCII-WAARDE VOOR <-- TOETS
20200 BS$=CHR$(16):REM P2000T
20210 RETURN
25000 DATA "Oost west thuis best."
25010 DATA "Wie een kuil graaft voor een"
25020 DATA " ander valt er zelf in."
25030 DATA "De aanhouder wint."
25040 DATA "Aken en Keulen zijn niet"
25050 DATA " op een dag gebouwd."
25060 DATA "Twaalf ambachten, dertien ongelukken."
25070 DATA "De appel valt niet ver van de boom."
25080 DATA "Na gedane arbeid is het goed rusten."
25090 DATA "Als het tij verloopt,"
25100 DATA " verzet men de bakens."
25110 DATA "Wie kaatst moet de bal verwachten."
25120 DATA "Het zijn sterke benen, die"
25130 DATA " de weelde kunnen dragen."
25140 DATA "Een goed begin is het halve werk."
25150 DATA "Belofte maakt schuld."
25160 DATA "Beter benijd dan beklaagd."
25170 DATA "Nieuwe bezems vegen schoon."
25180 DATA "Bitter in de mond maakt"
25190 DATA " het hart gezond."
25200 DATA "Beter hard geblazen dan de mond verbrand."
25210 DATA "In het land der blinden is eenoog koning."
25220 DATA "Het bloed kruipt waar het niet gaan kan."
25230 DATA "Hoge bomen vangen veel wind."
25240 DATA "Boontje komt om zijn loontje."
25250 DATA "Wie boter op zijn hoofd heeft,"
25260 DATA " moet uit de zon blijven."
25270 DATA "Wiens brood men eet, diens"
25280 DATA " woord men spreekt."
25290 DATA "Beter een goede buur dan een verre vriend."
25300 DATA "Al te goed is buurmans gek."
25310 DATA "De een zijn dood is de ander zijn brood."
25320 DATA "Een ezel stoot zich niet tweemaal"
25330 DATA " aan dezelfde steen."
25340 DATA "Het eerste gewin is kattegespin."
25350 DATA "Wie in een glazen huis woont,"
25360 DATA " moet niet met stenen gooien."
25370 DATA "Gestolen goed gedijt niet."
25380 DATA "Goedkoop is duurkoop."
25390 DATA "Het is niet al goud wat er blinkt."
25400 DATA "Eigen haard is goud waard."
25410 DATA "Beter ten halve gekeerd,"
25420 DATA " dan ten hele gedwaald."
25430 DATA "Vele handen maken licht werk."
25440 DATA "Waar het hart vol van is,"
25450 DATA " loopt de mond van over."
25460 DATA "Zachte heelmeesters maken"
25470 DATA " stinkende wonden."
25480 DATA "Met grote heren is het kwaad"
25490 DATA " kersen eten."
25500 DATA "Het hemd is nader dan de rok."
25510 DATA "Blaffende honden bijten niet."
25520 DATA "Men moet geen slapende honden"
25530 DATA " wakker maken."
25540 DATA "Met onwillige honden is het"
25550 DATA " kwaad hazen vangen."
25560 DATA "Wie een hond wil slaan,"
25570 DATA " vindt licht een stok."
25580 DATA "Honger maakt rauwe bonen zoet."
25590 DATA "Zoveel hoofden, zoveel zinnen."
25600 DATA "Hoogmoed komt voor de val."
25610 DATA "Van dik hout zaagt men planken."
25620 DATA "Men moet het ijzer smeden als het heet is."
25630 DATA "Als het kalf verdronken is,"
25640 DATA " dempt men de put."
25650 DATA "Als de katten muizen,"
25660 DATA " dan mauwen ze niet."
25670 DATA "Wie het kleine niet eert,"
25680 DATA " is het grote niet weerd."
25690 DATA "Men noemt geen koe bont,"
25700 DATA " of er is een vlekje aan."
25710 DATA "Het zijn niet allen koks,"
25720 DATA " die lange messen dragen."
25730 DATA "Veel koks bederven de brij."
25740 DATA "Krakende wagens lopen het langst."
25750 DATA "De kruik gaat zo lang te water"
25760 DATA " tot ze barst."
25770 DATA "Wie het laatst lacht, lacht het best."
25780 DATA "Ledigheid is des duivels oorkussen."
25790 DATA "Lekker is maar een vinger lang."
25800 DATA "Al is de leugen nog zo snel,"
25810 DATA " de waarheid achterhaalt haar wel."
25820 DATA "De laatste loodjes wegen het zwaarst."
25830 DATA "Bij het scheiden van de markt"
25840 DATA " leert men de kooplui kennen."
25850 DATA "De morgenstond heeft goud in de mond."
25860 DATA "Wie zijn neus schendt,"
25870 DATA " schendt zijn aangezicht."
25880 DATA "Als niet komt tot iet,"
25890 DATA " kent iet zich zelven niet."
25900 DATA "Het oog van de meester"
25910 DATA " maakt het paard vet."
25920 DATA "Zoals de ouden zongen, piepen de jongen."
25930 DATA "Een gegeven paard moet men niet"
25940 DATA " in de bek zien."
25950 DATA "Wie met pek omgaat, wordt ermee besmet."
25960 DATA "De pot verwijt de ketel"
25970 DATA " dat hij zwart ziet."
25980 DATA "Na regen komt zonneschijn."
25990 DATA "Het is goed riemen snijden"
26000 DATA " uit andermans leer."
26010 DATA "Als een schaap over de dam is,"
26020 DATA " volgen er spoedig meer."
26030 DATA "Wie de schoen past, trekke hem aan."
26040 DATA "De soep wordt niet zo heet gegeten,"
26050 DATA " als ze wordt opgediend."
26060 DATA "Haastige spoed is zelden goed."
26070 DATA "De beste stuurlui staan aan wal."
26080 DATA "Veel varkens maken de spoeling dun."
26090 DATA "Wat in het vat is, verzuurt niet."
26100 DATA "Holle vaten klinken het hardst."
26110 DATA "Beter een vogel in de hand"
26120 DATA " dan tien in de lucht."
26130 DATA "Voorzichtigheid is de moeder"
26140 DATA " van de porceleinkast."
26150 DATA "Een vos verliest wel zijn haren,"
26160 DATA " maar niet zijn streken."
26170 DATA "Als de vos de passie preekt,"
26180 DATA " boer pas op je kippen."
26190 DATA "Die niet waagt, die niet wint."
26200 DATA "Zoals de waard is, vertrouwt hij"
26210 DATA " zijn gasten."
26220 DATA "Stille waters hebben diepe gronden."
26230 DATA "Goede wijn behoeft geen krans."
26240 DATA "Wie wind zaait, zal storm oogsten."
26250 DATA "Gedane zaken nemen geen keer."
26260 DATA "Een zwaluw maakt nog geen zomer."
26270 DATA "*"
30000 REM Het thema van dit spel kan eenvoudig
30010 REM veranderd worden door de dataregels
30020 REM vanaf 25000 aan het nieuwe onderwerp
30030 REM aan te passen.
30040 REM Geef TH$ in regel 4610 de naam van 
30050 REM het nieuwe thema en pas ook het
30060 REM titelbeeld in regel 4450 aan. 
30070 REM Dat is alles!
30080 REM Voorbeelden van mogelijke thema's:
30090 REM Bekende Nederlanders, Sportsterren,
30100 REM hoofdsteden, landen, klasgenoten,
30110 REM popsterren, enz, enz.
30120 REM 
30130 REM **********************
30140 REM *    Harry Engel     *
30150 REM *   Sg. Eysenhegge   *
30160 REM *  VSO - LOM School  *
30170 REM *    Valkstraat 4    *
30180 REM *  6135 GC  Sittard  *
30190 REM * Tel. 04490 - 22088 * 
30200 REM *    januari 1987    *
30210 REM **********************
30220 REM 
30230 REM Verander zonodig regels 20000,
30240 REM 20100 en 20200
30250 REM 
30260 REM COPYRIGHT (C) NOS HILVERSUM
