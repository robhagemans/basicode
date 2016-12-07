1000 A=500:GOTO 20
1010 REM WOORDBENOEMING
1020 REM 
1030 REM HOOFDPROGRAMMA
1040 REM 
1050 GOSUB 10250:REM DIMENSIONEREN
1060 GOSUB 10010:REM INITIALISEREN
1070 GOSUB 9610:REM TITELBEELD
1080 GOSUB 8370:REM HOOFDMENU
1090 IF NV=0 THEN GOSUB 8600
1100 GOSUB 9250:REM WILLEKEURIG BEGIN
1110 GOSUB 6350:REM KADER TEKENEN
1120 GOSUB 6430:REM ZIN INLEZEN
1130 GOSUB 6530:REM ZIN OP SCHERM
1140 FOR N=1 TO AW
1150 C1=VAL(LEFT$(WC$(N),1))
1160 IF WS$(C1)="" THEN 1320
1170 C2=VAL(MID$(WC$(N),2,1))
1180 C3=VAL(RIGHT$(WC$(N),1))
1190 ON NV GOSUB 1450,1530,270
1200 IF C1=0 THEN 1320
1210 GOSUB 1940
1220 IF S=1 THEN 1320
1230 GOSUB 1890:REM WISSEN
1240 IF C2=0 THEN 1320
1250 ON C1 GOSUB 2420,2510,2600,2690,2790,3070,2980
1260 IF S=1 THEN 1320
1270 GOSUB 1890
1280 IF C3=0 THEN 1320
1290 ON C1-2 GOSUB 3180,3280,3390
1300 IF S=1 THEN 1320
1310 GOSUB 1890
1320 NEXT N
1330 IF S=1 THEN GOSUB 6700:GOSUB 10110:GOTO 1080
1340 GOTO 1110
1350 REM 
1360 REM SUBROUTINES
1370 REM 
1380 REM VERHOOG INVOER
1390 FOR I=1 TO B
1400 IF WS$(I)="" THEN IN=IN+1
1410 IF IN=I THEN I=B
1420 NEXT I
1430 RETURN
1440 REM NIVEAU 1
1450 IF C1=1 THEN C2=0
1460 IF C1=3 THEN C2=0
1470 IF C1=4 THEN C2=0
1480 IF (C1=5) AND(C2>3) THEN C1=0
1490 IF (C1=5) AND(C2<>1) THEN C3=0
1500 IF C1=7 THEN C2=0
1510 RETURN
1520 REM NIVEAU 2
1530 IF C1=4 THEN C3=0
1540 IF (C1=5) AND(C2>5) THEN C1=0
1550 IF (C1=5) AND(C2<>1) THEN C3=0
1560 IF C1=7 THEN C2=0
1570 RETURN
1580 REM GOED ANTWOORD
1590 F=0:GOSUB 260
1600 I=INT(RV*10)
1610 HO=0:VE=22:GOSUB 110
1620 PRINT L0$:HO=INT((39-LEN(G$(I)))/2)
1630 GOSUB 110:PRINT G$(I);
1640 FOR W=1 TO 1000:NEXT W
1650 RETURN
1660 REM INVOER
1670 HO=0:VE=22:GOSUB 110
1680 PRINT "WAT KIES JE ? ";
1690 GOSUB 200:IN=VAL(IN$)
1700 IF (IN$="S") OR(IN$="s") THEN S=1:N=AW:RETURN
1710 IF (IN$="T") OR(IN$="t") THEN S=2:RETURN
1720 HO=WH(N):VE=WV(N):GOSUB 110
1730 WL=LEN(WO$)
1740 PRINT LEFT$(WO$(0),WL);
1750 FOR W=1 TO 100:NEXT W
1760 GOSUB 110:PRINT WO$;
1770 FOR W=1 TO 100:NEXT W
1780 IF IN$="" THEN 1690
1790 RETURN
1800 REM DRUK SPATIEBALK
1810 HO=0:VE=20:GOSUB 110
1820 PRINT L2$
1830 VE=22:GOSUB 110
1840 PRINT L0$
1850 GOSUB 110:PRINT "Druk op de spatiebalk... ";
1860 GOSUB 210:IF IN$<>" " THEN 1860
1870 RETURN
1880 REM MKV WISSEN
1890 HO=0:FOR VE=8 TO 22
1900 IF VE=20 THEN 1920
1910 GOSUB 110:PRINT L0$
1920 NEXT VE:RETURN
1930 REM KEUZE 1
1940 HO=0:VE=8:GOSUB 110
1950 WO$=WO$(N):WL=LEN(WO$)
1960 IF ASC(RIGHT$(WO$,1))<65 THEN WO$=LEFT$(WO$,WL-1)
1970 PRINT "WAT IS: '";WO$;"' ?"
1980 CT=1:CN=0:S=0
1990 HO=0:VE=10:J=1
2000 FOR I=1 TO B
2010 IF WS$(I)="" THEN 2060
2020 SR=J:GOSUB 310:GOSUB 110
2030 PRINT SR$;") ";WS$(I)
2040 J=J+1:VE=VE+2
2050 IF (J=INT((B-A)/2+.5)+1) AND(J>3) THEN HO=19:VE=10
2060 NEXT I
2070 GOSUB 1670
2080 IF S=1 THEN RETURN
2090 IF S=2 THEN GOSUB 6650:GOTO 1940
2100 IF (A=0) OR(IN=0) THEN 2140
2110 FOR I=1 TO C1
2120 IF WS$(I)="" THEN IN=IN+1
2130 NEXT I
2140 IF (IN<1) OR(IN>B) THEN 2070
2150 AV=AV+1:V(C1,0)=V(C1,0)+1
2160 IF IN=C1 THEN GOSUB 1590:RETURN
2170 F=F+1:IF NV>1 THEN F=2
2180 IF F=2 THEN GOSUB 2270:RETURN
2190 GOSUB 2210:GOTO 2070
2200 REM FOUT
2210 HO=0:VE=22:GOSUB 110
2220 PRINT "Niet goed. Je krijgt nog een kans.";
2230 FOR W=1 TO 2000:NEXT W
2240 GOSUB 110:PRINT L0$
2250 AV=AV-1:V(C1,0)=V(C1,0)-1:RETURN
2260 REM WEER FOUT
2270 GOSUB 1890
2280 HO=0:VE=8:GOSUB 110
2290 PRINT "Je antwoord was helaas niet goed."
2300 F(C1,0)=F(C1,0)+1:FT=FT+1:F=0
2310 ON C1 GOSUB 3670,3740,3810,3880,3950,4020,4100,4190,4290
2320 GOSUB 1810:RETURN
2330 REM KEUZEHULP
2340 HO=0:VE=8:GOSUB 110
2350 PRINT "'";WO$;"' is een:"
2360 S=0:RETURN
2370 REM KEUZEHULP
2380 AV=AV+1:V(C1,C2)=V(C1,C2)+1
2390 IF IN=C2 THEN GOSUB 1590:RETURN
2400 GOSUB 3070:RETURN
2410 REM KEUZE 2.1
2420 GOSUB 2340
2430 PRINT :PRINT "1) Bepaald lidwoord"
2440 PRINT :PRINT "2) Onbepaald lidwoord"
2450 GOSUB 1670
2460 IF S=1 THEN RETURN
2470 IF S=2 THEN GOSUB 6650:GOTO 2420
2480 IF (IN<1) OR(IN>2) THEN 2450
2490 GOSUB 2380:RETURN
2500 REM KEUZE 2.2
2510 GOSUB 2340
2520 PRINT :PRINT "1) Zelfstandig naamwoord"
2530 PRINT :PRINT "2) Bijvoeglijk naamwoord"
2540 GOSUB 1670
2550 IF S=1 THEN RETURN
2560 IF S=2 THEN GOSUB 6650:GOTO 2510
2570 IF (IN<1) OR(IN>2) THEN 2540
2580 GOSUB 2380:RETURN
2590 REM KEUZE 2.3
2600 GOSUB 2340
2610 PRINT :PRINT "1) Hoofdtelwoord"
2620 PRINT :PRINT "2) Rangtelwoord"
2630 GOSUB 1670
2640 IF S=1 THEN RETURN
2650 IF S=2 THEN GOSUB 6650:GOTO 2600
2660 IF (IN<1) OR(IN>2) THEN 2630
2670 GOSUB 2380:RETURN
2680 REM KEUZE 2.4
2690 GOSUB 2340
2700 PRINT :PRINT "1) Koppelwerkwoord"
2710 PRINT :PRINT "2) Hulpwerkwoord"
2720 PRINT :PRINT "3) Zelfstandig werkwoord"
2730 GOSUB 1670
2740 IF S=1 THEN RETURN
2750 IF S=2 THEN GOSUB 6650:GOTO 2690
2760 IF (IN<1) OR(IN>3) THEN 2730
2770 GOSUB 2380:RETURN
2780 REM KEUZE 2.5
2790 HO=0:VE=8:GOSUB 110:S=0
2800 PRINT "Het voornaamwoord: '";WO$;"' is:"
2810 CT=1:CN=0
2820 HO=0:VE=11:J=1
2830 FOR I=1 TO 8
2840 IF W5$(I)="" THEN 2900
2850 SR=J:GOSUB 310:GOSUB 110
2860 PRINT SR$;") ";W5$(I)
2870 J=J+1:VE=VE+2
2880 IF (NV=2) AND(J=4) THEN HO=19:VE=11
2890 IF (NV=3) AND(J=5) THEN HO=19:VE=11
2900 NEXT I
2910 GOSUB 1670
2920 IF S=1 THEN RETURN
2930 IF S=2 THEN GOSUB 6650:GOTO 2790
2940 IF (IN<1) OR(IN>8) THEN 2910
2950 IF W5$(IN)="" THEN 2910
2960 GOSUB 2380:RETURN
2970 REM KEUZE 2.7
2980 GOSUB 2340
2990 PRINT :PRINT "1) Nevenschikkend voegwoord"
3000 PRINT :PRINT "2) Onderschikkend voegwoord"
3010 GOSUB 1670
3020 IF S=1 THEN RETURN
3030 IF S=2 THEN GOSUB 6650:GOTO 2980
3040 IF (IN<1) OR(IN>2) THEN 3010
3050 GOSUB 2380:RETURN
3060 REM KEUZE 2 FOUT
3070 GOSUB 1890
3080 HO=0:VE=8:GOSUB 110
3090 PRINT "Je antwoord is helaas niet goed.":PRINT 
3100 F(C1,C2)=F(C1,C2)+1:FT=FT+1
3110 ON C1 GOSUB 4370,4470,4630,4810,5010,270,5570
3120 GOSUB 1810:RETURN
3130 REM KEUZEHULP
3140 AV=AV+1:V(0,C1)=V(0,C1)+1
3150 IF IN=C3 THEN GOSUB 1590:RETURN
3160 GOSUB 3600:RETURN
3170 REM KEUZE 3.3
3180 HO=0:VE=8:GOSUB 110:S=0
3190 PRINT "Het telwoord '";WO$;"' is:"
3200 PRINT :PRINT "1) Bepaald"
3210 PRINT :PRINT "2) Onbepaald"
3220 GOSUB 1670
3230 IF S=1 THEN RETURN
3240 IF S=2 THEN GOSUB 6650:GOTO 3180
3250 IF (IN<1) OR(IN>2) THEN 3220
3260 GOSUB 3140:RETURN
3270 REM KEUZE 3.4
3280 HO=0:VE=8:GOSUB 110:S=0
3290 PRINT "In welke vorm staat '";WO$;"'?"
3300 PRINT :PRINT "1) Infinitief"
3310 PRINT :PRINT "2) Persoonsvorm"
3320 PRINT :PRINT "3) Deelwoordvorm"
3330 GOSUB 1670
3340 IF S=1 THEN RETURN
3350 IF S=2 THEN GOSUB 6650:GOTO 3280
3360 IF (IN<1) OR(IN>3) THEN 3330
3370 GOSUB 3140:RETURN
3380 REM KEUZE 3.5
3390 HO=0:VE=8:GOSUB 110:S=0
3400 IF C2>1 THEN 3510
3410 PRINT "'";WO$;"' is:"
3420 PRINT :PRINT "   ENKELVOUD = ev      MEERVOUD = mv"
3430 PRINT :PRINT "1) 1e persoon ev.   4) 1e persoon mv."
3440 PRINT :PRINT "2) 2e persoon ev.   5) 2e persoon mv."
3450 PRINT :PRINT "3) 3e persoon ev.   6) 3e persoon mv."
3460 GOSUB 1670
3470 IF S=1 THEN RETURN
3480 IF S=2 THEN GOSUB 6650:GOTO 3390
3490 IF (IN<1) OR(IN>6) THEN 3460
3500 GOSUB 3140:RETURN
3510 PRINT "'";WO$;"' wordt hier:"
3520 PRINT :PRINT "1) bijvoeglijk gebruikt"
3530 PRINT :PRINT "2) zelfstandig gebruikt"
3540 GOSUB 1670
3550 IF S=1 THEN RETURN
3560 IF S=2 THEN GOSUB 6650:GOTO 3390
3570 IF (IN<1) OR(IN>2) THEN 3540
3580 GOSUB 3140:RETURN
3590 REM KEUZE 3 FOUT
3600 GOSUB 1890
3610 HO=0:VE=8:GOSUB 110
3620 PRINT "Je antwoord is helaas fout.":PRINT 
3630 F(0,C1)=F(0,C1)+1:FT=FT+1
3640 ON C1-2 GOSUB 5710,5890,6110
3650 GOSUB 1810:RETURN
3660 REM UITLEG 1
3670 PRINT :PRINT "'";WO$;"' is een lidwoord."
3680 PRINT :PRINT "Een lidwoord komt alleen voor in"
3690 PRINT :PRINT "combinatie met een zelfst. naamwoord."
3700 PRINT :PRINT "Als lidwoorden gebruiken we:"
3710 PRINT :PRINT "DE, HET en EEN."
3720 RETURN
3730 REM UITLEG 2
3740 PRINT :PRINT "'";WO$;"' is een naamwoord."
3750 PRINT :PRINT "We onderscheiden:"
3760 PRINT :PRINT "zelfstandige naamwoorden"
3770 PRINT :PRINT "en"
3780 PRINT :PRINT "bijvoeglijke naamwoorden."
3790 RETURN
3800 REM UITLEG 3
3810 PRINT :PRINT "'";WO$;"' is een telwoord."
3820 PRINT :PRINT "We onderscheiden:"
3830 PRINT :PRINT "hoofdtelwoorden"
3840 PRINT :PRINT "en"
3850 PRINT :PRINT "rangtelwoorden."
3860 RETURN
3870 REM UITLEG 4
3880 PRINT :PRINT "'";WO$;"' is een werkwoord."
3890 PRINT :PRINT "We onderscheiden:"
3900 PRINT :PRINT "1. koppelwerkwoorden."
3910 PRINT :PRINT "2. hulpwerkwoorden."
3920 PRINT :PRINT "3. zelfstandige werkwoorden."
3930 RETURN
3940 REM UITLEG 5
3950 PRINT :PRINT "'";WO$;"' is een voornaamwoord."
3960 PRINT :PRINT "Een voornaamwoord staat in de plaats"
3970 PRINT :PRINT "van een zelfstandig naamwoord."
3980 PRINT :PRINT "Bv: De les is moeilijk."
3990 PRINT :PRINT "    Dit    is moeilijk."
4000 RETURN
4010 REM UITLEG 6
4020 PRINT :PRINT "'";WO$;"' is een voorzetsel."
4030 PRINT :PRINT "De meeste voorzetsels kun je plaatsen"
4040 PRINT :PRINT "op de puntjes in: .. het hok (bv. op)."
4050 PRINT :PRINT "'Vaste' voorzetsels hebben een sterke"
4060 PRINT :PRINT "binding met 'n werkwoord: houden van."
4070 PRINT "                                 ---"
4080 RETURN
4090 REM UITLEG 7
4100 PRINT :PRINT "'";WO$;"' is een voegwoord."
4110 PRINT :PRINT "Voegwoorden voegen woorden of zinnen"
4120 PRINT :PRINT "aan elkaar. Voorbeelden:"
4130 PRINT :PRINT "Jan en Piet zijn broers."
4140 PRINT "   ---"
4150 PRINT "Ik ging naar bed, omdat ik moe was."
4160 PRINT "                  -----"
4170 RETURN
4180 REM UITLEG 8
4190 PRINT :PRINT "'";WO$;"' is een bijwoord."
4200 PRINT :PRINT "Het geeft vaak 'n bijzonderheid van een"
4210 PRINT :PRINT "werkwoord      : ik lees snel."
4220 PRINT "                         ----"
4230 PRINT "bijv. naamwoord: hij is zeer dapper."
4240 PRINT "                        ----"
4250 PRINT "ander bijwoord : ik lees heel snel."
4260 PRINT "                         ----"
4270 RETURN
4280 REM UITLEG 9
4290 PRINT :PRINT "'";WO$;"' is 'n tussenwerpsel."
4300 PRINT :PRINT "Een tussenwerpsel is een uitroep van:"
4310 PRINT :PRINT "pijn, schrik, afkeer, spijt, enz."
4320 PRINT :PRINT "Voorbeelden:(au, hu, bah, sorry, enz.)"
4330 PRINT :PRINT "Klanknabootsing: 'Zoef', weg was hij."
4340 PRINT "                  ----"
4350 RETURN
4360 REM UITLEG 2.1
4370 IF C2=2 THEN 4420
4380 PRINT "'";WO$;"' is een bepaald lidwoord."
4390 PRINT :PRINT "De bepaalde lidwoorden zijn:"
4400 PRINT :PRINT "DE en HET."
4410 RETURN
4420 PRINT "'";WO$;"' is 't onbepaalde lidwoord."
4430 PRINT :PRINT "Andere onbepaalde lidwoorden"
4440 PRINT :PRINT "hebben we niet."
4450 RETURN
4460 REM UITLEG2.2
4470 IF C2=2 THEN 4540
4480 PRINT "'";WO$;"' is 'n zelfst. naamw."
4490 PRINT :PRINT "Zelfstandige naamwoorden zijn de namen"
4500 PRINT :PRINT "van mensen, dieren en dingen."
4510 PRINT :PRINT "Ook van 'onzichtbare dingen'."
4520 PRINT :PRINT "Bv. jongen, kat, hout, verstand."
4530 RETURN
4540 PRINT "'";WO$;"'is 'n bijv. naamw."
4550 PRINT :PRINT "Bijvoeglijke naamwoorden noemen"
4560 PRINT :PRINT "'n bijzonderheid van 'n zelfst. naamw."
4570 PRINT :PRINT "Bv. Een dure computer."
4580 PRINT "        ----"
4590 PRINT "    De computer is duur."
4600 PRINT "                   ----"
4610 RETURN
4620 REM UITLEG 2.3
4630 IF C2=2 THEN 4720
4640 PRINT "'";WO$;"' is 'n hoofdtelwoord."
4650 PRINT :PRINT "Hoofdtelwoorden noemen het aantal,"
4660 PRINT :PRINT "dat je van iets hebt."
4670 PRINT :PRINT "Bv. Ik heb drie balpennen."
4680 PRINT "           ----"
4690 PRINT "    Ik heb weinig geld."
4700 PRINT "           ------"
4710 RETURN
4720 PRINT "'";WO$;"'is een rangtelwoord."
4730 PRINT :PRINT "Rangtelwoorden geven de plaats van iets"
4740 PRINT :PRINT "of iemand in een reeks aan."
4750 PRINT :PRINT "Bv. De tweede dag van de week."
4760 PRINT "       ------"
4770 PRINT "    Dat is de zoveelste keer."
4780 PRINT "              ---------"
4790 RETURN
4800 REM UITLEG 2.4
4810 ON C2 GOTO 4820,4880,4940
4820 PRINT "'";WO$;"' is 'n koppelwerkwoord."
4830 PRINT :PRINT "De koppelwerkwoorden zijn:"
4840 PRINT :PRINT "zijn, worden, blijven, blijken,"
4850 PRINT :PRINT "lijken, schijnen, heten, dunken"
4860 PRINT :PRINT "en voorkomen."
4870 RETURN
4880 PRINT "'";WO$;"' is 'n hulpwerkwoord."
4890 PRINT :PRINT "Als in 'n zin meer dan 1 werkwoord zit,"
4900 PRINT :PRINT "dan is de persoonsvorm altijd een"
4910 PRINT :PRINT "hulpwerkwoord. In een zin kunnen"
4920 PRINT :PRINT "wel meerdere hulpwerkwoorden zitten."
4930 RETURN
4940 PRINT "'";WO$;"' is 'n zelfst. werkw."
4950 PRINT :PRINT "Een werkwoord dat in zijn eentje"
4960 PRINT :PRINT "een werkwoordelijk gezegde kan"
4970 PRINT :PRINT "vormen heet 'n zelfst. werkwoord."
4980 PRINT :PRINT "Het heeft duidelijk 'n betekenis."
4990 RETURN
5000 REM UITLEG 2.5
5010 ON C2 GOTO 5020,5080,5130,5190,5280,5340,5420,5500
5020 PRINT "'";WO$;"' is 'n persoonlijk voornw."
5030 PRINT :PRINT "In de onderwerpsvorm kennen we o.a."
5040 PRINT :PRINT "Ik, jij, hij, zij, het, wij, jullie, U."
5050 PRINT :PRINT "In de voorwerpsvorm kennen we o.a."
5060 PRINT :PRINT "Me, jou, hem, haar, ons, jullie, U, hen"
5070 RETURN
5080 PRINT "'";WO$;"' is 'n bezittelijk voornw."
5090 PRINT :PRINT "Het geeft aan van wie iets is."
5100 PRINT :PRINT "Voorbeelden: mijn, jouw, zijn, haar,"
5110 PRINT :PRINT "ons, jullie, uw en hun."
5120 RETURN
5130 PRINT "'";WO$;"'is 'n aanwijzend voornw."
5140 PRINT :PRINT "De meest voorkomende zijn:"
5150 PRINT :PRINT "die, dit, dat en deze."
5160 PRINT :PRINT "Andere voorbeelden: zo'n, zulke,"
5170 PRINT :PRINT "dergelijke, dezelfde, degene, enz."
5180 RETURN
5190 PRINT "'";WO$;"' is 'n vragend voornw."
5200 PRINT :PRINT "Het vraagt naar 'n zelfst. naamwoord."
5210 PRINT :PRINT "Bv. Wat zie ik?      (Een auto)"
5220 PRINT "    ---"
5230 PRINT "    Wie loopt daar?  (Vader)"
5240 PRINT "    ---"
5250 PRINT "Pas op voor vragende bijwoorden!!"
5260 PRINT "                     ----------"
5270 RETURN
5280 PRINT "'";WO$;"' is 'n onbepaald voornw."
5290 PRINT :PRINT "Het zelfst. naamw. waarvoor het in"
5300 PRINT :PRINT "de plaats staat blijft vaag."
5310 PRINT :PRINT "Bv. Men, (n)iemand, (n)iets, alles,"
5320 PRINT :PRINT "wat, ieder(een), menig(een), ene, enz."
5330 RETURN
5340 PRINT "'";WO$;"' is 'n betrekkelijk voornw."
5350 PRINT :PRINT "Het heeft betrekking op iets dat al"
5360 PRINT :PRINT "eerder genoemd is. Voorbeeld:"
5370 PRINT :PRINT "De jas die daar hangt, is van mij."
5380 PRINT "       ---"
5390 PRINT "'die' heeft betrekking op 'de jas'."
5400 PRINT " ---"
5410 RETURN
5420 PRINT "'";WO$;"' is 'n wederkerend voornw."
5430 PRINT :PRINT "Advies: Zet de zin in de derde persoon."
5440 PRINT :PRINT "Het wederkerend vnw. wordt dan 'zich'."
5450 PRINT :PRINT "Bv. Ik schaam me."
5460 PRINT "              --"
5470 PRINT "    Hij schaamt zich."
5480 PRINT "                ----"
5490 RETURN
5500 PRINT "'";WO$;"' is 'n wederkerig voornw."
5510 PRINT :PRINT "Het enige wederkerige voornaamw. is:"
5520 PRINT :PRINT "ELKAAR."
5530 PRINT :PRINT "Andere vormen hiervan zijn:"
5540 PRINT :PRINT "MEKAAR en ELKANDER."
5550 RETURN
5560 REM UITLEG 2.7
5570 IF C2=2 THEN 5640
5580 PRINT "'";WO$;"' is 'n nevenschikkend voegwoord."
5590 PRINT :PRINT "Het verbindt twee gelijksoortige zinnen"
5600 PRINT :PRINT "(twee hoofdzinnen of twee bijzinnen)"
5610 PRINT :PRINT "met elkaar. De meest voorkomende zijn:"
5620 PRINT :PRINT "EN, MAAR, OF, WANT."
5630 RETURN
5640 PRINT "'";WO$;"' is 'n onderschikkend voegw."
5650 PRINT :PRINT "Het verbindt twee ongelijksoortige"
5660 PRINT :PRINT "zinnen (hoofd- en bijzin) met elkaar."
5670 PRINT :PRINT "De volgende komen veel voor: OMDAT,"
5680 PRINT :PRINT "OPDAT, VOORDAT, ZODAT, NADAT, DAT."
5690 RETURN
5700 REM UITLEG 3.3
5710 IF C3=2 THEN 5800
5720 PRINT "Het telwoord '";WO$;"' is bepaald,"
5730 PRINT :PRINT "want het aantal of de plaats"
5740 PRINT :PRINT "in de reeks is precies bekend."
5750 PRINT :PRINT "Bv. Ik koop twee appels."
5760 PRINT "            ----"
5770 PRINT "    De eerste de beste."
5780 PRINT "       ------"
5790 RETURN
5800 PRINT "Het telwoord '";WO$;"' is onbepaald,"
5810 PRINT :PRINT "want je weet het aantal of de plaats"
5820 PRINT :PRINT "in de reeks niet precies."
5830 PRINT :PRINT "Bv. Ik eet veel snoep."
5840 PRINT "           ----"
5850 PRINT "    De middelste jongen ken ik."
5860 PRINT "       ---------"
5870 RETURN
5880 REM UITLEG 3.4
5890 ON C3 GOTO 5900,5970,6030
5900 PRINT "'";WO$;"' staat in de infinitief."
5910 PRINT :PRINT "Bij de infinitief staat altijd 'n werkw"
5920 PRINT "                        ------"
5930 PRINT "in de persoonsvorm. De infinitief"
5940 PRINT :PRINT "noemen we ook wel de onbepaalde wijs"
5950 PRINT :PRINT "of het hele werkwoord."
5960 RETURN
5970 PRINT "'";WO$;"' staat in de persoonsvorm,"
5980 PRINT :PRINT "want aan '";WO$;"' kun je zien"
5990 PRINT :PRINT "of de zin in de tegenwoordige of in"
6000 PRINT :PRINT "de verleden tijd staat."
6010 PRINT :PRINT "Zie ook het programma 'Ontleden'."
6020 RETURN
6030 PRINT "'";WO$;"' is 'n deelwoordvorm."
6040 PRINT :PRINT "Bij voltooide deelwoorden staat altijd"
6050 PRINT "                                ------"
6060 PRINT "'n vorm van 'hebben, zijn of worden'."
6070 PRINT :PRINT "Onvoltooide deelwoorden vorm je door"
6080 PRINT :PRINT "achter de infinitief 'd(e)' te zetten."
6090 RETURN
6100 REM UITLEG 3.5
6110 IF C2>1 THEN 6190
6120 SR=C3:IF C3>3 THEN SR=C3-3
6130 GOSUB 310
6140 PRINT "Het persoonlijk voornaamwoord '";WO$;"'"
6150 PRINT :PRINT "is ";SR$;"e persoon ";
6160 IF C3<4 THEN PRINT "enkelvoud."
6170 IF C3>3 THEN PRINT "meervoud."
6180 RETURN
6190 PRINT "Het voornaamwoord '";WO$;"'"
6200 IF C3=2 THEN 6300
6210 PRINT :PRINT "is hier bijvoeglijk gebruikt, want"
6220 PRINT :PRINT "het staat voor het zelfstandig"
6230 PRINT :PRINT "naamwoord: ";
6240 FOR I=N TO AW
6250 W$=WO$(I)
6260 IF ASC(RIGHT$(W$,1))<65 THEN W$=LEFT$(W$,LEN(W$)-1)
6270 IF WC$(I)="210" THEN PRINT W$;".":I=AW
6280 NEXT I
6290 RETURN
6300 PRINT :PRINT "is hier zelfstandig gebruikt, want"
6310 PRINT :PRINT "het staat NIET voor een zelfstandig"
6320 PRINT :PRINT "naamwoord."
6330 RETURN
6340 REM KADER TEKENEN
6350 GOSUB 100
6360 PRINT "=============== ZIN    ================"
6370 HO=0:VE=6:GOSUB 110
6380 PRINT L2$
6390 VE=20:GOSUB 110
6400 PRINT L2$
6410 RETURN
6420 REM ZIN INLEZEN
6430 GOSUB 270
6440 READ AW:REM AANTAL WOORDEN
6450 IF AW=0 THEN RESTORE :GOTO 6440
6460 FOR I=1 TO AW:READ WO$
6470 WL=LEN(WO$)
6480 WO$(I)=LEFT$(WO$,WL-3)
6490 WC$(I)=RIGHT$(WO$,3)
6500 NEXT I:NR=NR+1
6510 RETURN
6520 REM ZIN OP SCHERM
6530 VE=0:HO=20:GOSUB 110
6540 SR=NR:CT=2:CN=0
6550 GOSUB 310:PRINT SR$
6560 VE=2:HO=0:GOSUB 110
6570 FOR I=1 TO AW:GOSUB 20100:GOSUB 120
6580 GOSUB 20000
6590 WL=LEN(WO$(I))
6600 IF HO+WL>=39 THEN VE=4:HO=0
6610 WH(I)=HO:WV(I)=VE
6620 GOSUB 110:PRINT WO$(I);" ";
6630 NEXT I:RETURN
6640 REM TUSSENSTAND
6650 GOSUB 6700
6660 GOSUB 6350
6670 GOSUB 6530
6680 RETURN
6690 REM FOUTENOVERZICHT
6700 GOSUB 100
6710 PRINT "     F O U T E N O V E R Z I C H T"
6720 PRINT L1$
6730 PRINT :PRINT "Aantal vragen: ";
6740 CT=3:CN=0
6750 SR=AV:GOSUB 310:PRINT SR$
6760 IF AV=0 THEN GOSUB 1810:RETURN
6770 PRINT "Niveau       : ";
6780 SR=NV:GOSUB 310:PRINT SR$;
6790 PRINT "         Cijfer: ";
6800 CT=4:CN=1
6810 SR=INT((AV-FT)/AV*100)/10:GOSUB 310
6820 PRINT SR$:PRINT 
6830 PRINT L2$
6840 PRINT 
6850 CT=3:CN=0
6860 FOR I=1 TO 9
6870 IF WS$(I)="" THEN 6970
6880 PRINT "      ";WS$(I);
6890 GOSUB 20100:GOSUB 120:GOSUB 20000
6900 HO=19:GOSUB 110:PRINT ": ";
6910 SR=F(0,I)
6920 FOR J=0 TO 8
6930 SR=SR+F(I,J)
6940 NEXT J
6950 GOSUB 310
6960 PRINT SR$;" x FOUT."
6970 NEXT I
6980 HO=0:VE=20:GOSUB 110
6990 PRINT L2$
7000 PRINT :PRINT "PER WOORDSOORT APART BEKIJKEN (J/N) ? ";
7010 GOSUB 210
7020 IF (IN$<>"J") AND(IN$<>"j") THEN RETURN
7030 GOSUB 100
7040 PRINT "F O U T E N  P E R  W O O R D S O O R T"
7050 PRINT L1$
7060 CT=1:CN=0
7070 HO=1:VE=6:J=0
7080 FOR I=0 TO B
7090 IF WS$(I)="" THEN 7140
7100 SR=J:GOSUB 310:GOSUB 110
7110 PRINT SR$;") ";WS$(I)
7120 J=J+1:VE=VE+2
7130 IF J=INT((B-A)/2+1) THEN HO=20:VE=6
7140 NEXT I
7150 HO=0:VE=20:GOSUB 110:PRINT L1$
7160 VE=22:GOSUB 110
7170 PRINT "WAT KIES JE ? ";
7180 GOSUB 210:IN=VAL(IN$)
7190 IF IN$="0" THEN RETURN
7200 IF A>0 THEN GOSUB 1390
7210 IF (IN<1) OR(IN>B) THEN 7180
7220 IF WS$(IN)="" THEN 7180
7230 GOSUB 100
7240 HO=INT((22-LEN(WS$(IN)))/2):VE=0:GOSUB 110
7250 PRINT "FOUTENOVERZICHT: ";WS$(IN)
7260 PRINT L1$
7270 ON IN GOSUB 7430,7530,7620,7740,7890,8120,8170,8270,8320
7280 GOSUB 1810:GOTO 7030
7290 REM HULP
7300 SR=F(I,J)
7310 CT=2:GOSUB 310
7320 PRINT SR$;"x Ft = ";
7330 IF V(I,J)=0 THEN SR=0:GOTO 7350
7340 SR=INT(F(I,J)*100/V(I,J)+.5)
7350 CT=3:GOSUB 310
7360 PRINT SR$;"% => ";
7370 IF SR>49 THEN PRINT "Slecht";
7380 IF (SR>34) AND(SR<50) THEN PRINT "Matig";
7390 IF (SR>19) AND(SR<35) THEN PRINT "Kan beter";
7400 IF (SR<20) AND(V(I,J)>0) THEN PRINT "Goed";
7410 PRINT "":PRINT :RETURN
7420 REM LIDWOORD
7430 HO=0:VE=8:GOSUB 110
7440 PRINT WS$(1);" : ";
7450 I=1:J=0:GOSUB 7300
7460 IF NV=1 THEN 7510
7470 PRINT "Bepaald  : ";
7480 J=1:GOSUB 7300
7490 PRINT "Onbepaald: ";
7500 J=2:GOSUB 7300
7510 RETURN
7520 REM NAAMWOORD
7530 HO=0:VE=8:GOSUB 110
7540 PRINT WS$(2);"  : ";
7550 I=2:J=0:GOSUB 7300
7560 PRINT "Zelfstandig: ";
7570 J=1:GOSUB 7300
7580 PRINT "Bijvoeglijk: ";
7590 J=2:GOSUB 7300
7600 RETURN
7610 REM TELWOORD
7620 HO=0:VE=6:GOSUB 110
7630 PRINT WS$(3);"   : ";
7640 I=3:J=0:GOSUB 7300
7650 IF NV=1 THEN 7720
7660 PRINT "Hoofdtelw  : ";
7670 J=1:GOSUB 7300
7680 PRINT "Rangtelw   : ";
7690 J=2:GOSUB 7300
7700 PRINT "(On)bepaald: ";
7710 I=0:J=3:GOSUB 7300
7720 RETURN
7730 REM WERKWOORD
7740 HO=0:VE=5:GOSUB 110
7750 PRINT WS$(4);" : ";
7760 I=4:J=0:GOSUB 7300
7770 IF NV=1 THEN 7870
7780 PRINT "Koppelww  : ";
7790 J=1:GOSUB 7300
7800 PRINT "Hulpwerkw : ";
7810 J=2:GOSUB 7300
7820 PRINT "Zelfst. ww: ";
7830 J=3:GOSUB 7300
7840 IF NV=2 THEN 7870
7850 PRINT "Vorm      : ";
7860 I=0:J=4:GOSUB 7300
7870 RETURN
7880 REM VOORNAAMW
7890 HO=0:VE=3:GOSUB 110
7900 PRINT "Voornaamw   :";
7910 I=5:J=0:GOSUB 7300
7920 PRINT "Persoonlijk :";
7930 J=1:GOSUB 7300
7940 PRINT "Bezittelijk :";
7950 J=2:GOSUB 7300
7960 PRINT "Aanwijzend  :";
7970 J=3:GOSUB 7300
7980 IF NV=1 THEN RETURN
7990 PRINT "Vragend     :";
8000 J=4:GOSUB 7300
8010 PRINT "Onbepaald   :";
8020 J=5:GOSUB 7300
8030 IF NV=2 THEN RETURN
8040 PRINT "Betrekkelijk:";
8050 J=6:GOSUB 7300
8060 PRINT "Wederkerend :";
8070 J=7:GOSUB 7300
8080 PRINT "Wederkerig  :";
8090 J=8:GOSUB 7300
8100 RETURN
8110 REM VOORZETSEL 
8120 HO=0:VE=9:GOSUB 110
8130 PRINT WS$(6);": ";
8140 I=6:J=0:GOSUB 7300
8150 RETURN
8160 REM VOEGWOORD
8170 HO=0:VE=8:GOSUB 110
8180 PRINT WS$(7);": ";
8190 I=7:J=0:GOSUB 7300
8200 IF NV<3 THEN 8250
8210 PRINT "Nevensch.: ";
8220 J=1:GOSUB 7300
8230 PRINT "Ondersch.: ";
8240 J=2:GOSUB 7300
8250 RETURN
8260 REM BIJWOORD 
8270 HO=0:VE=9:GOSUB 110
8280 PRINT WS$(8);": ";
8290 I=8:J=0:GOSUB 7300
8300 RETURN
8310 REM TUSSENW 
8320 HO=0:VE=9:GOSUB 110
8330 PRINT "Tussenw: ";
8340 I=9:J=0:GOSUB 7300
8350 RETURN
8360 REM HOOFDMENU
8370 IF S=0 THEN GOSUB 8600
8380 GOSUB 100
8390 PRINT "           H O O F D M E N U"
8400 PRINT L1$
8410 HO=0:VE=6:GOSUB 110
8420 PRINT "   1) Nuttige tips."
8430 PRINT 
8440 PRINT :PRINT "   2) Alle woordsoorten oefenen."
8450 PRINT 
8460 PRINT :PRINT "   3) Keuze maken uit de woordsoorten."
8470 PRINT 
8480 PRINT :PRINT "   4) Stoppen."
8490 VE=20:GOSUB 110
8500 PRINT L1$
8510 HO=0:VE=22:GOSUB 110
8520 PRINT "WAT KIES JE ? ";
8530 GOSUB 210:KE=VAL(IN$)
8540 IF (KE<1) OR(KE>4) THEN 8530
8550 IF KE=4 THEN GOSUB 100:END
8560 IF KE=3 THEN GOSUB 8910
8570 IF KE=1 THEN GOSUB 9370:GOTO 8380
8580 RETURN
8590 REM KIES NIVEAU
8600 GOSUB 100
8610 PRINT "         K I E S   N I V E A U"
8620 PRINT L1$
8630 HO=0:VE=7:GOSUB 110
8640 PRINT "   1) Groep 8 basisschool"
8650 PRINT 
8660 PRINT :PRINT "   2) Brugklas voortgezet onderwijs"
8670 PRINT 
8680 PRINT :PRINT "   3) Overige leerjaren v.o."
8690 VE=20:GOSUB 110
8700 PRINT L1$
8710 HO=0:VE=22:GOSUB 110
8720 PRINT "WAT KIES JE ? ";
8730 GOSUB 210:NV=VAL(IN$)
8740 IF (NV<1) OR(NV>3) THEN 8730
8750 A=0:B=9
8760 IF NV=2 THEN B=8
8770 IF NV=1 THEN B=7
8780 ON NV GOSUB 8810,8870,270
8790 RETURN
8800 REM NV=1
8810 W5$(4)="":W5$(5)=""
8820 W5$(6)="":W5$(7)=""
8830 W5$(8)=""
8840 WS$(8)="":WS$(9)=""
8850 RETURN
8860 REM NV=2
8870 WS$(9)="":W5$(6)=""
8880 W5$(7)="":W5$(8)=""
8890 RETURN
8900 REM WOORDSOORTEN KIEZEN
8910 IF NV=0 THEN GOSUB 8600
8920 GOSUB 100
8930 PRINT "   K I E S   W O O R D S O O R T E N"
8940 PRINT L1$
8950 PRINT :PRINT "Welke woordsoorten wil je NIET oefenen?"
8960 PRINT "                          ----"
8970 PRINT "Laat minstens 3 woordsoorten staan."
8980 PRINT :PRINT L1$
8990 CT=1:CN=0
9000 HO=0:VE=10:J=0
9010 FOR I=0 TO B
9020 IF WS$(I)="" THEN 9070
9030 SR=J:GOSUB 310:GOSUB 110
9040 PRINT SR$;") ";WS$(I)
9050 J=J+1:VE=VE+2
9060 IF J=INT((B-A)/2+1) THEN HO=19:VE=10
9070 NEXT I
9080 HO=0:VE=20:GOSUB 110:PRINT L1$
9090 IF B-A=3 THEN 9190
9100 HO=0:VE=22:GOSUB 110
9110 PRINT "WAT KIES JE ?  ";
9120 GOSUB 210:IN=VAL(IN$)
9130 IF IN$="0" THEN 9190
9140 IF A>0 THEN GOSUB 1390
9150 IF (IN<1) OR(IN>B) THEN 9120
9160 IF WS$(IN)="" THEN 9120
9170 WS$(IN)="":A=A+1
9180 GOSUB 1890:GOTO 8990
9190 HO=0:VE=22:GOSUB 110:PRINT "GOED ZO (J/N) ?";
9200 GOSUB 210
9210 IF (IN$="N") OR(IN$="n") THEN GOSUB 10010:GOTO 8920
9220 IF (IN$<>"J") AND(IN$<>"j") THEN 9200
9230 RETURN
9240 REM WILLEKEURIG BEGIN
9250 GOSUB 100
9260 HO=12:VE=11:GOSUB 110
9270 PRINT "Even geduld ....."
9280 GOSUB 260:I=INT(RV*AZ)
9290 FOR J=1 TO I
9300 READ AW
9310 IF AW=0 THEN RESTORE :GOTO 9280
9320 FOR K=1 TO AW
9330 READ WO$(K)
9340 NEXT K:NEXT J
9350 RETURN
9360 REM TIPS
9370 GOSUB 100
9380 PRINT "        N U T T I G E   T I P S"
9390 PRINT L1$
9400 PRINT :PRINT "Bij een meerkeuzevraag kun je met de"
9410 PRINT :PRINT "toets 'S' de oefening stoppen en weer"
9420 PRINT :PRINT "terugkeren naar het hoofdmenu."
9430 PRINT 
9440 PRINT :PRINT "Met toets 'T' daarentegen krijg je"
9450 PRINT :PRINT "de tussenstand op het scherm. Daarna"
9460 PRINT :PRINT "gaat het programma gewoon verder met"
9470 PRINT :PRINT "de zin waarbij je gebleven was."
9480 PRINT :PRINT "Dus: 'S' = Stoppen   'T' = Tussenstand."
9490 GOSUB 1810:GOSUB 100
9500 PRINT :PRINT "Raadpleeg altijd je schoolboek(en) voor"
9510 PRINT :PRINT "een gedegen uitleg, wanneer je iets"
9520 PRINT :PRINT "niet begrijpt."
9530 PRINT :PRINT "Dit programma geeft wel enige uitleg"
9540 PRINT :PRINT "als je een fout maakt, maar het"
9550 PRINT :PRINT "beperkt zich tot hoofdzaken."
9560 PRINT :PRINT "In je schoolboek(en) vind je veel meer"
9570 PRINT :PRINT "voorbeelden die bijdragen tot een beter"
9580 PRINT :PRINT "begrip van een bepaald woordsoort."
9590 GOSUB 1810:RETURN
9600 REM TITELBEELD
9610 GOSUB 100
9620 GOSUB 20000
9630 FOR I=0 TO 38:PRINT "*";
9640 FOR W=1 TO 20:NEXT W:NEXT I
9650 HO=39:FOR VE=0 TO 22:GOSUB 110
9660 PRINT "*";:NEXT VE
9670 VE=22:FOR HO=38 TO 1 STEP -1
9680 GOSUB 110:PRINT "*";:NEXT HO
9690 HO=0:FOR VE=22 TO 1 STEP -1
9700 GOSUB 110:PRINT "*";:NEXT VE
9710 FOR J=1 TO 9
9720 GOSUB 260
9730 X=INT(RV*16+2)
9740 GOSUB 260
9750 Y=INT(RV*19+2)
9760 HO=X:VE=Y:GOSUB 110
9770 PRINT "??? ";WS$(J);" ???"
9780 FOR W=1 TO 750:NEXT W
9790 GOSUB 110
9800 PRINT "                     ":REM 21 SPATIES
9810 NEXT J
9820 HO=0:VE=7:GOSUB 110
9830 PRINT "*   +-----------------------------+"
9840 PRINT "*   !                             !"
9850 PRINT "*   ! W O O R D B E N O E M I N G !"
9860 PRINT "*   !                             !"
9870 PRINT "*   !      Een programma van      !"
9880 PRINT "*   !                             !"
9890 PRINT "*   !         Harry Engel         !"
9900 PRINT "*   !                             !"
9910 PRINT "*   +-----------------------------+"
9920 HO=36:VE=21:GOSUB 110
9930 PRINT "=>";
9940 FOR W=1 TO 100:NEXT W
9950 GOSUB 110:PRINT "  ";
9960 FOR W=1 TO 100:NEXT W
9970 GOSUB 200
9980 IF IN$="" THEN 9920
9990 RETURN
10000 REM INITIALISEREN
10010 L0$="                                       "
10020 L1$="======================================="
10030 L2$="---------------------------------------"
10040 WO$(0)="                    "
10050 G$(0)="NIET TE GELOVEN!":G$(1)="BEREGOED!"
10060 G$(2)="GEWELDIG!":G$(3)="EENZAME KLASSE!"
10070 G$(4)="WOW!":G$(5)="TE GEK, HOOR!"
10080 G$(6)="SUPER!":G$(7)="WAT BEN JIJ GOED!"
10090 G$(8)="FANTASTISCH!":G$(9)="KAN NIET BETER!"
10100 AZ=30:REM AANTAL ZINNEN
10110 FOR I=0 TO 9:FOR J=0 TO 9
10120 F(I,J)=0:V(I,J)=0:NEXT J:NEXT I
10130 F=0:FT=0:NR=0:AV=0:NV=0
10140 WS$(0)="Einde keuze":WS$(1)="Lidwoord"
10150 WS$(2)="Naamwoord":WS$(3)="Telwoord"
10160 WS$(4)="Werkwoord":WS$(5)="Voornaamwoord"
10170 WS$(6)="Voorzetsel":WS$(7)="Voegwoord"
10180 WS$(8)="Bijwoord":WS$(9)="Tussenwerpsel"
10190 W5$(1)="Persoonlijk":W5$(2)="Bezittelijk"
10200 W5$(3)="Aanwijzend":W5$(4)="Vragend"
10210 W5$(5)="Onbepaald":W5$(6)="Betrekkelijk"
10220 W5$(7)="Wederkerend":W5$(8)="Wederkerig"
10230 RETURN
10240 REM DIMENSIONEREN
10250 DIM WO$(15),WC$(15),WS$(9),W5$(8),G$(9)
10260 DIM WH(15),WV(15),F(9,9),V(9,9)
10270 RETURN
19980 REM CURSOR UIT
19990 REM VOOR COMPUTERS MET IRRITANTE CURSOR
20000 PRINT CHR$(2);:REM P2000T
20010 RETURN
20090 REM CURSOR AAN
20100 PRINT CHR$(1);:REM P2000T
20110 RETURN
25000 DATA 14,"De110","jongen210","die560","daar800","aan600"
25010 DATA "de110","overkant210","van600","deze531"
25020 DATA "straat210","loopt,432","is412"
25030 DATA "mijn521","broer.210"
25040 DATA 11,"Ik511","zal422","de110","oplossing210"
25050 DATA "van600","de110","tweede321","puzzel210"
25060 DATA "vanavond800","nog800","vinden.431"
25070 DATA 10,"Dit531","jaar210","zijn422","weinig312"
25080 DATA "leerlingen210","tijdens600","hun521"
25090 DATA "vakantie210","ziek220","geweest.413"
25100 DATA 8,"Paarden210","die560","de110","haver210"
25110 DATA "verdienen,432","krijgen432","die532","niet.800"
25120 DATA 5,"Wanneer800","zullen422","we514"
25130 DATA "elkaar580","ontmoeten?431"
25140 DATA 7,"Voor600","ons521","huis210","staat432"
25150 DATA "een120","mooie220","kastanjeboom.210"
25160 DATA 10,"Vijf311","minuten210","na600","het110"
25170 DATA "ongeluk210","was412","de110","politie210"
25180 DATA "al800","aanwezig.220"
25190 DATA 9,"Ik511","ga422","vaak800","met600"
25200 DATA "mijn521","vrienden210","de110"
25210 DATA "stad210","bezoeken.431"
25220 DATA 8,"Welke541","grote220","stad210","ligt432"
25230 DATA "tussen600","deze531","twee311","dorpen?210"
25240 DATA 8,"Elke551","zondag210","wandelen432","we514"
25250 DATA "hier800","langs600","het110","strand.210"
25260 DATA 7,"De110","fietsen210","zullen422","per600"
25270 DATA "trein210","worden421","vervoerd.433"
25280 DATA 8,"Zij513","had422","verwacht433","dat720"
25290 DATA "jij512","later800","zou422","komen.431"
25300 DATA 6,"Scheren432","jullie515","je570"
25310 DATA "echt800","iedere551","morgen?210"
25320 DATA 5,"Bah,900","dat532","is412"
25330 DATA "niet800","lekker!220"
25340 DATA 8,"We514","wandelen432","en710"
25350 DATA "fietsen432","veel800","in600"
25360 DATA "de110","vakantie.210"
25370 DATA 5,"Dat532","vertel432","ik511"
25380 DATA "jou512","niet.800"
25390 DATA 9,"We514","hebben422","ons570","laten421"
25400 DATA "vertellen431","dat720","het552"
25410 DATA "waar220","was.412"
25420 DATA 9,"Waarom800","zeg432","je512","me511"
25430 DATA "niet,800","wie542","elkaar580"
25440 DATA "uitgescholden433","hebben?422"
25450 DATA 6,"Het552","sneeuwde432","die531"
25460 DATA "nacht210","enkele312","uren.210"
25470 DATA 7,"Dat532","kan422","zij513","van600"
25480 DATA "jullie515","wel800","verdragen.431"
25490 DATA 7,"Toen800","leek412","je512","nog800"
25500 DATA "jong220","en710","gelukkig.220"
25510 DATA 12,"Toen720","zijn521","auto210"
25520 DATA "stuk220","was,412","ging432","hij513"
25530 DATA "te600","voet210","naar600","het110","werk.210"
25540 DATA 5,"Ik511","zou422","maar800"
25550 DATA "opletten,431","hoor!900"
25560 DATA 11,"U512","zei432","dat720","we514","stil220"
25570 DATA "moesten422","zijn,411","omdat720","u512"
25580 DATA "wilde422","studeren.431"
25590 DATA 9,"Ik511","ben412","geslaagd,220"
25600 DATA "dus800","betalen432","mijn521"
25610 DATA "ouders210","een120","feestje.210"
25620 DATA 4,"Wat voor een541","auto210"
25630 DATA "stond432","daar?800"
25640 DATA 4,"Waar800","blijf432","je512","toch?800"
25650 DATA 10,"De110","bekende220","artiest210","die560"
25660 DATA "in600","de110","show210","optrad,432"
25670 DATA "werd422","uitgefloten.433"
25680 DATA 8,"Wat541","komen422","jullie515","op600"
25690 DATA "dit531","tijdstip210","hier800","doen?431"
25700 DATA 9,"Op600","zondag210","en710"
25710 DATA "woensdag210","kan422","iedereen551"
25720 DATA "naar600","Hobbyscoop210","luisteren.431"
25730 DATA 0
30000 REM **********************
30010 REM *    Harry Engel     *
30020 REM *   Sg. Eysenhegge   *
30030 REM *  VSO - LOM School  *
30040 REM *    Valkstraat 4    *
30050 REM *  6135 GC  Sittard  *
30060 REM * Tel. 04490 - 22088 * 
30070 REM *   november 1986    *
30080 REM **********************
30090 REM Verander zonodig regels 20000 en 20100
30100 REM 
30110 REM COPYRIGHT (C) NOS HILVERSUM
