1000 A=2000:GOTO 20:REM HOOFDREKENEN
1010 REM *******************************
1020 REM **      VASTE VARIABELEN     **
1030 REM *******************************
1050 C=0:Q=0:R=0:V=0:VD=0
1060 K$="+-x:"
1070 TS$="----------------------------------------"
1080 S1$="                                        "
1090 S3$=S1$+S1$+S1$:S6$=S3$+S3$
1100 KV$="               HOOFDREKENEN             "+S1$
1110 VT$="????????????????????????????????????????"
1120 VR$=VT$+VT$+VT$+VT$+VT$+S1$
1130 KB$="Kies eerst de vorm van de uitkomst:     "+S1$
1140 BV$="1)   2)    3)    4)   5)    6)     7)   "
1150 BV$=BV$+"  x l   x l  xx l    l   x l    x l   xx"
1160 BV$=BV$+"  - l  -- l  -- l  x l  x- l  x-- l  x--"
1170 BV$=BV$+"  x l  xx l  xx l    l   x l   xx l   xx"
1180 BV$=BV$+"    l     l     l    l     l      l     "+TS$
1190 REM *******************************
1200 REM **      MENU                 **
1210 REM *******************************
1220 GOSUB 100:HO=0:VE=1:GOSUB 110
1230 PRINT "MENU:":PRINT "-----":PRINT S3$
1240 PRINT "Algemene informatie...................1 ";S3$;
1250 PRINT "Start hoofdrekenen met zakgeld........2 ";S3$;
1260 PRINT "Start hoofdrekenen zonder zakgeld.....3 ";S3$;
1270 PRINT "Stoppen...............................4 ";S3$;
1280 PRINT "                 << 1 - 4 >>";
1290 GOSUB 260:GOSUB 200:IF IN$="" THEN 1290
1295 PK=VAL(IN$):IF PK=4 THEN END
1300 IF (PK<1) OR(PK>3) THEN 1290
1310 GOSUB 100:IF PK>1 THEN 2930
1320 REM *******************************
1330 REM **      INFORMATIE           **
1340 REM *******************************
1350 PRINT "Dit programma is bedoeld voor een ieder ";
1360 PRINT "die zijn/haar (hoofd-)rekenvaardigheid  ";
1370 PRINT "wenst te toetsen of te verbeteren, maar ";
1380 PRINT "speciaal voor kinderen vanaf de hoogste ";
1390 PRINT "groepen van de basisschool.             ";S1$;
1400 PRINT "Met name voor die laatste categorie     ";
1410 PRINT "worden onder meer aanwijzingen inzake de";
1420 PRINT "rekentechnieken gegeven, daar waar de   ";
1430 PRINT "sommen fout worden uitgewerkt.          ";S1$;
1440 PRINT "Ook is voor die groep de mogelijkheid   ";
1450 PRINT "opgenomen om een aanvulling op het zak- ";
1460 PRINT "geld te verdienen, dit ter stimulering  ";
1470 PRINT "van een regelmatige training.           ";S1$;
1480 PRINT "Desgewenst kan dit laatste programma-   ";
1490 PRINT "onderdeel worden verwijderd.            ";
1500 PRINT "Zie hiervoor de programmeursinformatie  ";
1510 PRINT "in de listing v.a. regelnr. 30000.      ";
1520 GOSUB 23030
1530 PRINT "Voor elke som kunnen 5 punten worden    ";
1540 PRINT "behaald.                                ";S1$;
1550 PRINT "Een fout levert 0 punten op."
1560 PRINT "Het programma kan bovendien niet verder ";
1570 PRINT "worden afgewerkt voordat elke som goed  ";
1580 PRINT "is opgelost.                            ";S1$;
1600 PRINT "Zakgeldberekening:                      ";S1$;
1610 PRINT "98 punten of meer....fl. 1.00           ";
1620 PRINT "90-97 punten.........fl. 0.75           ";
1630 PRINT "80-89 punten.........fl. 0.50           ";
1640 PRINT "70-79 punten.........fl. 0.25           ";S1$;
1650 PRINT "Bovendien bij:                          ";S1$;
1660 PRINT "              0 fouten..........fl. 1.00";
1670 PRINT "              1 fout............fl. 0.75";
1680 PRINT "              2 fouten..........fl. 0.50";
1690 PRINT "              3 fouten..........fl. 0.25";
1700 IF PK=2 THEN RETURN
1710 GOSUB 23030
1720 PRINT "U komt de volgende sommen tegen:        ";S3$;
1730 PRINT "-optellen/aftrekken (combinatie);       ";S1$;
1740 PRINT "-vermenigvuldigen;                      ";S1$;
1750 PRINT "-delen;                                 ";S1$;
1760 PRINT "-optellen, aftrekken, vermenigvuldigen  ";
1770 PRINT " en delen van breuken;                  ";S1$;
1780 PRINT "-inhoudsberekeningen;                   ";S1$;
1790 PRINT "-renteberekeningen.                     ";S1$;
1800 GOSUB 23030
1810 PRINT "Bij de gecombineerde optel-/aftreksommen";
1820 PRINT "kan de uitkomst zowel positief als nega-";
1830 PRINT "tief zijn. Vergeet in het laatste geval ";
1840 PRINT "niet het negatief-teken.                ";
1850 PRINT "De maximale grootte van de getallen is  ";
1860 PRINT "1000. De uitkomst kan groter zijn.      ";S3$;
1870 PRINT "Bij vermenigvuldigingen zijn de deelne- ";
1880 PRINT "mende getallen niet groter dan 20.      ";S3$;
1890 PRINT "Delingen leveren als resultaat steeds   ";
1900 PRINT "een heel getal beneden 21 op.           ";S1$;
1910 GOSUB 23030
1920 PRINT "Bij breuken dient voordat het resutaat  ";
1930 PRINT "wordt ingevuld te worden aangegeven hoe ";
1940 PRINT "dat er uit komt te zien.                ";
1950 PRINT "De ingetikte cyfers van de uitkomst     ";
1960 PRINT "komen dan vanzelf op de juiste plaats te";
1970 PRINT "staan.                                  ";S1$;
1980 PRINT TS$;BV$;
1990 PRINT "   4                                   x";
2000 PRINT " 2--  komt in dat geval overeen met: x--";
2010 PRINT "  15                                  xx";S1$;
2020 PRINT "Ingevuld moet worden het cyfer 6.       ";
2030 GOSUB 23030
2040 PRINT "Inhoudsberekeningen dienen afwisselend  ";
2050 PRINT "in cm3 en dm3 te worden gemaakt.        ";
2060 PRINT "Daar waar in de opgaven centimeters en  ";
2070 PRINT "decimeters door elkaar worden gebruikt  ";
2080 PRINT "wordt de inhoud steeds in cm3 gevraagd. ";S1$;
2090 PRINT "Renteberekeningen tenslotte zijn zo     ";
2100 PRINT "samengesteld, dat de uitkomst nooit     ";
2110 PRINT "kleiner is dan hele centen (in eenheden ";
2120 PRINT "van 25).                                ";TS$;
2130 PRINT "De uitwerking van de sommen dient binnen";
2140 PRINT "ongeveer 20 seconden plaats te vinden.  ";
2150 PRINT "Wordt deze tijd overschreden, dan loopt ";
2160 PRINT "het te behalen aantal punten voor de be-";
2170 PRINT "treffende som terug.                    ";S1$;
2180 PRINT "Andere dan commodore-64 computers zullen";
2190 PRINT "mogelijk het getal .045 in regel 20130  ";
2200 PRINT "moeten aanpassen om de rekentijd op 20  ";
2210 PRINT "seconden te bepalen.                    ";S1$;
2220 PRINT "Tijd tekort: verlagen;                  ";
2230 PRINT "tijd teveel: verhogen.";
2240 GOSUB 23030:GOTO 1220
2900 REM *******************************
2910 REM **      PROGRAMMA-START      **
2920 REM *******************************
2930 GOSUB 100:HO=12:VE=10:GOSUB 110
2940 PRINT "Corrigeren alleen":VE=12:GOSUB 110
2950 PRINT "  met de letter:":VE=15:GOSUB 110
2960 PRINT "       'C'"
2970 FOR XX=0 TO 2500:NEXT XX
2980 SO=0:FO=0:PA=0:F=0
2990 GOSUB 100:PRINT KV$;VR$;:GOTO 20310
3000 REM *******************************
3010 REM **      WISSELING-SOMMEN     **
3020 REM *******************************
3030 GOSUB 260:WS=INT(RV*7)+1
3040 T=0:HP=0
3050 ON WS GOTO 3130,3330,3430,3530,3530,5030,5530
3100 REM *******************************
3110 REM **      OPTELLEN/AFTREKKEN   **
3120 REM *******************************
3130 GOSUB 260:X=INT(RV*1000)+1
3140 GOSUB 260:Y=INT(RV*1000)+1
3150 GOSUB 260:Z=INT(RV*1000)+1
3160 HO=14:VE=14:GOSUB 110
3170 PRINT X;"+";Y;"-";Z;"= ?";
3180 GOSUB 20030:IF C THEN 3180
3190 IF VAL(U$)=X+Y-Z THEN 20230
3200 GOSUB 20530:GOTO 3160
3300 REM *******************************
3310 REM **      VERMENIGVULDIGEN     **
3320 REM *******************************
3330 GOSUB 260:X=INT(RV*20)+1
3340 GOSUB 260:Y=INT(RV*20)+1
3350 HO=14:VE=14:GOSUB 110
3360 PRINT X;"*";Y;"= ?";
3370 GOSUB 20030:IF C THEN 3370
3380 IF VAL(U$)=X*Y THEN 20230
3390 GOSUB 20530:GOTO 3350
3400 REM *******************************
3410 REM **      DELEN                **
3420 REM *******************************
3430 GOSUB 260:Y=INT(RV*20)+1
3440 GOSUB 260:X=INT((RV*20)+1)*Y
3450 HO=14:VE=14:GOSUB 110
3460 PRINT X;":";Y;"= ?";
3470 GOSUB 20030:IF C THEN 3470
3480 IF VAL(U$)=X/Y THEN 20230
3490 GOSUB 20530:GOTO 3450
3500 REM *******************************
3510 REM **      BREUKEN              **
3520 REM *******************************
3530 GC=0:HP=9
3540 GOSUB 260:TA=INT(RV*4)+1
3550 GOSUB 260:NA=INT(RV*8)+1
3560 GOSUB 260:TB=INT(RV*4)+1
3570 GOSUB 260:NB=INT(RV*8)+1
3580 IF (TA>NA) THEN H=NA:NA=TA:TA=H
3590 IF (TB>NB) THEN H=NB:NB=TB:TB=H
3610 REM ********SOMKIEZER**************
3630 GOSUB 260:K=INT(RV*4)+1
3640 ON K GOTO 3680,3730,3800,3840
3660 REM ********OPTELLEN***************
3680 TC=TA*NB+TB*NA:NC=NA*NB:GOTO 4000
3710 REM ********AFTREKKEN**************
3730 IF TA/NA<TB/NB THEN H=TA:TA=TB:TB=H:H=NA:NA=NB:NB=H
3740 TC=TA*NB-TB*NA:NC=NA*NB
3750 IF TC=0 THEN 3540
3760 GOTO 4000
3780 REM ********VERMENIGVULDIGEN*******
3800 TC=TA*TB:NC=NA*NB:GOTO 4000
3820 REM ********DELEN******************
3840 TC=TA*NB:NC=NA*TB
3990 REM ********VEREENVOUDIGEN*********
4000 GC=INT(TC/NC):TC=TC-GC*NC
4010 FOR XX=1 TO 4
4020 P$=MID$("2357",XX,1):X=VAL(P$)
4030 Y=((TC/X=INT(TC/X)) AND(NC/X=INT(NC/X)))
4040 IF Y THEN TC=TC/X:NC=NC/X:GOTO 4030
4050 NEXT XX
4080 REM ********SOMOPBOUW**************
4090 H$=MID$(K$,K,1)
4100 HO=0:VE=13:GOSUB 110
4110 SR=TA:GOSUB 300:PRINT SR$;
4120 SR=TB:GOSUB 300:PRINT "   ";SR$
4130 VE=14:GOSUB 110:PRINT "- ";H$;" - =  < 1 - 7 >?"
4150 SR=NA:GOSUB 300:VE=15:GOSUB 110:PRINT SR$;
4160 SR=NB:GOSUB 300:PRINT "   ";SR$;
4200 REM ********KIEZEN BREUKVORM*******
4210 HO=0:VE=0:GOSUB 110:PRINT KB$;BV$
4220 GOSUB 20130:V=VAL(IN$)
4230 IF (V<1) OR(V>7) THEN 4220
4240 GOSUB 110:PRINT KV$;VR$;
4250 REM ********OPBOUW RESULTAAT*******
4260 X=0:Y=0:Z=0:HO=HP:VE=14:GOSUB 110
4270 PRINT "           ":GOSUB 110
4280 R=(V<>3):Q=(V<>4)
4290 IF V>3 THEN PRINT "?";:IF V=4 THEN 4360
4320 IF (V=1) OR(V=5) THEN PRINT "-":GOTO 4340
4330 PRINT "--"
4340 IF (V=1) OR(V=3) THEN VE=13:GOSUB 110:PRINT "?"
4350 IF V=2 THEN VE=13:HO=HP+1:GOSUB 110:PRINT "?"
4360 GOSUB 20040:R=(V<>7):IF C THEN 4210
4370 IF V>3 THEN X=VAL(U$):IF V=4 THEN 4600
4380 IF V<4 THEN Y=VAL(U$):GOTO 4430
4390 IF (V=5) OR(V=7) THEN HO=HP+1:VE=13:GOSUB 110:PRINT "?"
4400 IF V=6 THEN HO=HP+2:VE=13:GOSUB 110:PRINT "?"
4410 GOSUB 20040:IF C THEN 4210
4420 Y=VAL(U$)
4430 Q=0:IF V<4 THEN HO=HP:VE=15:GOSUB 110
4440 IF V>4 THEN HO=HP+1:VE=15:GOSUB 110
4450 PRINT "?":R=((V=1) OR(V=5)):GOSUB 20040:IF C THEN 4200
4470 Z=VAL(U$)
4600 REM ********VERGELIJK UITKOMST*****
4610 IF Z=0 THEN Z=1
4620 IF (GC+TC/NC=X+Y/Z) AND(Y=TC) THEN 20230
4630 IF GC+TC/NC=X+Y/Z THEN 4710
4640 GOSUB 20530:HP=9:GOTO 4100
4700 REM ********VEREENV.-OPDRACHT******
4710 IF HP=29 THEN 4640
4720 HP=29:HO=14:VE=14:GOSUB 110
4730 PRINT "vereenvoudigd: < 1 - 7 >?"
4740 GOTO 4210
5000 REM *******************************
5010 REM **      INHOUD-BEREKENEN     **
5020 REM *******************************
5030 GOSUB 260:ML=INT(RV*2)
5040 GOSUB 260:LE=INT(RV*9+1)/(10^ML)
5050 GOSUB 260:MB=INT(RV*2)
5060 GOSUB 260:BR=INT(RV*9+1)/(10^MB)
5070 GOSUB 260:MH=INT(RV*2)
5080 GOSUB 260:HG=INT(RV*9+1)/(10^MH)
5090 HO=0:VE=10:GOSUB 110
5100 PRINT "Bereken de inhoud van een blok in ";
5110 S=(ML+MB+MH=0):IF S THEN PRINT "dm3.":GOTO 5130
5120 PRINT "cm3.":PRINT 
5130 VE=11:HO=0:GOSUB 110:PRINT TS$:VE=14:GOSUB 110
5140 PRINT "lengte  ";:IF ML=0 THEN PRINT LE;" dm.":GOTO 5160
5150 PRINT LE*10;" cm."
5160 VE=15:GOSUB 110
5170 PRINT "breedte ";:IF MB=0 THEN PRINT BR;" dm.":GOTO 5190
5180 PRINT BR*10;" cm."
5190 VE=16:GOSUB 110
5200 PRINT "hoogte  ";:IF MH=0 THEN PRINT HG;" dm.":GOTO 5220
5210 PRINT HG*10;" cm."
5220 VE=17:HO=17:GOSUB 110:PRINT "INHOUD: ?";
5230 GOSUB 20030:IF C THEN 5230
5240 IF S THEN CO=LE*BR*HG:GOTO 5260
5250 CO=INT(LE*BR*HG*1000+.1)
5260 IH=VAL(U$):IF IH=CO THEN 20230
5270 GOSUB 20530:GOTO 5090
5500 REM *******************************
5510 REM **      RENTE-BEREKENEN      **
5520 REM *******************************
5530 GOSUB 260:RE=INT((RV*18)+2)*.5
5540 GOSUB 260:MN=INT(RV*2)*6
5550 GOSUB 260:JR=INT(RV*5)+1
5560 GOSUB 260:KP=INT(RV*9+1)*100
5570 HO=0:VE=11:GOSUB 110:SR=KP:GOSUB 300
5580 PRINT "Kapitaal: fl. ";SR$;".00 I"
5590 VE=12:GOSUB 110:PRINT "---------------------I"
5600 VE=13:GOSUB 110:PRINT "Rente: ";RE;" % pjr."
5610 HO=21:GOSUB 110:PRINT "I":HO=0
5620 VE=14:GOSUB 110:PRINT "---------------------I"
5630 VE=15:GOSUB 110:PRINT "Looptijd: ";JR;"jaar    I"
5650 IF MN=6 THEN HO=11:VE=16:GOSUB 110:PRINT "6 maanden.I"
5660 HO=23:VE=17:GOSUB 110:PRINT "Rente fl ?";
5670 GOSUB 20030:IF C THEN 5670
5680 IF VAL(U$)=INT(RE*KP*(MN+12*JR))/1200 THEN 20230
5690 GOSUB 20530:GOTO 5570
20000 REM ******************************
20010 REM *      UITKOMST-SUBROUTINE  **
20020 REM ******************************
20030 IF NOT(C) THEN GOSUB 120:HO=HO-1
20040 U$=""
20050 GOSUB 110:GOSUB 20130:C=((IN$="c") OR(IN$="C"))
20060 IF C THEN 21030
20070 IF (Q) AND(R) THEN U$=U$+IN$:PRINT U$:RETURN
20080 IF IN$=CHR$(13) THEN PRINT U$;" ";:RETURN
20090 R=((V<>1) AND(V<>5)):U$=U$+IN$:PRINT U$;"?";:GOTO 20050
20100 REM ******************************
20110 REM *      TIJDLUS-SUBROUTINE   **
20120 REM ******************************
20130 GOSUB 200:T=T+.045:TD=INT(T)
20140 IF IN$="" THEN 20130
20150 IF IN$="," THEN IN$="."
20160 RETURN
20200 REM ******************************
20210 REM *      GOED-ROUTINE         **
20220 REM ******************************
20230 HO=0:VE=8:GOSUB 110:PRINT S6$;S6$;
20240 SO=SO+1:PN=5:IF F THEN PN=0:F=0
20250 IF TD>20 THEN PN=PN-INT((TD-20)/4)
20260 IF PN<0 THEN PN=0
20270 PA=PA+PN:HO=14:VE=14:GOSUB 110
20280 IF SO<19 THEN PRINT "Goed, nog ";20-SO;" sommen."
20290 IF SO=19 THEN PRINT "Goed, LAATSTE SOM !"
20300 IF SO=20 THEN PRINT "Prima! We zijn klaar";
20310 HO=0:VE=20:GOSUB 110:PRINT TS$;
20320 IF SO<10 THEN PRINT "Aantal goed gemaakte sommen....";SO
20330 IF SO>9 THEN PRINT "Aantal goed gemaakte sommen...";SO
20340 IF FO<10 THEN PRINT "Aantal gemaakte fouten.........";FO
20350 IF FO>9 THEN PRINT "Aantal gemaakte fouten........";FO
20360 IF PA<10 THEN PRINT "Het puntenaantal bedraagt nu...";PA;
20370 IF PA>9 THEN PRINT "Het puntenaantal bedraagt nu..";PA;
20390 FOR XX=0 TO 999:NEXT XX:IF F THEN RETURN
20400 HO=0:VE=14:GOSUB 110:PRINT S1$;
20410 IF SO<20 THEN 3030
20420 GOSUB 23030:GOTO 22430
20500 REM ******************************
20510 REM **   FOUT-SUBROUTINE        **
20520 REM ******************************
20530 F=(1=1)
20540 HO=0:VE=8:GOSUB 110:PRINT S6$;S6$;
20550 HO=14:VE=14:GOSUB 110
20560 PRINT "Fout !";
20580 FO=FO+1
20590 GOSUB 20310
20600 HO=0:VE=14:GOSUB 110:PRINT S1$
20670 ON WS GOSUB 21140,21210,21240,21270,21270,22010,22120
20680 IF WS>3 THEN HO=0:VE=19:GOSUB 110
20690 IF WS>3 THEN PRINT "Dezelfde opgave nog 'ns:";
20700 GOSUB 23030
20720 HO=0:VE=8:GOSUB 110:PRINT S6$;S6$;:RETURN
21000 REM ******************************
21010 REM *      CORRECTIE-SUBROUTINE **
21020 REM ******************************
21030 IF (WS=4) OR(WS=5) THEN 21050
21040 GOSUB 110:PRINT "?       ";:GOSUB 110:RETURN
21050 HO=HP:VE=12
21060 FOR XX=1 TO 3:VE=VE+XX:GOSUB 110
21070 PRINT "     ":NEXT XX
21080 VE=14:GOSUB 110:PRINT "< 1 - 7 >?":RETURN
21100 REM ******************************
21110 REM *      MEDEDELINGEN         **
21120 REM ******************************
21130 REM *******FOUT +/- SOM***********
21140 U=(X+Y-Z):V=VAL(U$)
21150 HO=14:VE=14:GOSUB 110
21160 IF (U<0) AND(V=ABS(U)) THEN PRINT "- teken vergeten!";
21165 IF (U<0) AND(V=ABS(U)) THEN RETURN
21170 IF U>V THEN PRINT "Te weinig! Nog 'ns.";
21180 IF U<V THEN PRINT "Te veel! Nog 'ns.";
21190 RETURN
21200 REM *******VERMENIGVULDIGING******
21210 U=(X*Y):V=VAL(U$):GOTO 21150
21230 REM *******DELING*****************
21240 U=(X/Y):V=VAL(U$):GOTO 21150
21260 REM *******BREUKEN****************
21270 HO=0:VE=8:GOSUB 110
21280 IF HP=29 THEN 21810
21290 ON K GOTO 21300,21300,21590,21680
21300 IF NA<>NB THEN 21380
21310 PRINT "Bij optellen of aftrekken van breuken   ";
21320 PRINT "met gelijke noemers worden alleen de    ";
21330 PRINT "tellers bij elkaar opgeteld of van el-  ";
21340 PRINT "kaar afgetrokken. De noemer verandert   ";
21350 PRINT "niet. Vervolgens dient de uitkomst zo   ";
21360 PRINT "mogelijk te worden vereenvoudigd.       ";
21370 RETURN
21380 PRINT "Bij optellen of aftrekken van breuken   ";
21390 PRINT "met ongelijke noemers moeten die noemers";
21400 PRINT "eerst worden gelijkgemaakt.             ";
21410 PRINT "Op welke wijze dit het best kan geschie-";
21420 PRINT "den, is afhankelijk van de opgave.      ";
21430 PRINT "Het is in onze opgaven echter steeds    ";
21440 PRINT "mogelijk de beide tellers te vermenig-  ";
21450 PRINT "vuldigen met de noemers van de andere   ";
21460 PRINT "breuk. De teller van de uitkomst vindt  ";
21470 PRINT "men dan door de producten op te tellen  ";
21480 PRINT "of van elkaar af te trekken.            ";
21490 GOSUB 23030
21500 PRINT "De noemer van de uitkomst is dan het    ";
21510 PRINT "product van de noemers uit de opgave.   ";S1$;
21520 PRINT "           4 3  (5*4)+(6*3)  20+18   38 ";
21530 PRINT "VOORBEELD: -+- = --------- = ----- = -- ";
21540 PRINT "           6 5      6*5       30     30 ";S1$;
21550 PRINT "                         8     4        ";
21560 PRINT "Vereenvoudigd is dit:  1-- = 1--        ";
21570 PRINT "                        30    15        ";
21580 RETURN
21590 PRINT "Bij het vermenigvuldigen van breuken    ";
21600 PRINT "moeten zowel de tellers als de noemers  ";
21610 PRINT "met elkaar worden vermenigvuldigd:      ";S1$;
21620 PRINT "de teller van de uitkomst is dan het    ";
21630 PRINT "product van de tellers uit de opgave, de";
21640 PRINT "noemer van de uitkomst die van de       ";
21650 PRINT "noemers uit de opgave.                  ";S1$;
21660 PRINT "Zo mogelijk dient de uitkomst daarna nog";
21670 PRINT "te worden vereenvoudigd.":RETURN
21680 PRINT "Delen door een breuk is vermenigvuldigen";
21690 PRINT "met het omgekeerde!                     ";S1$;
21700 PRINT "Dit wil zeggen, dat de teller en de     ";
21710 PRINT "noemer van de breuk waardoor wordt      ";
21720 PRINT "gedeeld kunnen worden verwisseld waarna ";
21730 PRINT "de opgave als een vermenigvuldiging kan ";
21740 PRINT "worden uitgevoerd.":GOSUB 23030
21750 PRINT S3$;"           2   2        2   3    6      ";
21760 PRINT "VOORBEELD: - : - wordt: - * - = --      ";
21770 PRINT "           7   3        7   2   14      ";S1$;
21780 PRINT "                      3                 ";
21790 PRINT "vereenvoudigd is dit: -                 ";
21800 PRINT "                      7":RETURN
21810 PRINT "Bij het vereenvoudigen van 'n breuk be- ";
21820 PRINT "handelen we deze eerst als een gewone   ";
21830 PRINT "deling, dat wil zeggen dat we kijken of ";
21840 PRINT "de teller door de noemer kan worden ge- ";
21850 PRINT "deeld.                                  ";
21860 PRINT "We vinden dan het hele getal, dat voor  ";
21870 PRINT "de breuk komt te staan.                 ";S1$;
21880 PRINT "Als we een 'rest' overhouden, dan wordt ";
21890 PRINT "dat de nieuwe teller":GOSUB 23030
21900 PRINT "Vervolgens zoeken we naar het grootste  ";
21910 PRINT "getal waardoor zowel de teller als de   ";
21920 PRINT "noemer van de niewe breuk kan worden ge-";
21930 PRINT "deeld en voeren dit uit.                ";S1$;
21940 PRINT "           25    10 (rest)    2         ";
21950 PRINT "VOORBEELD: -- = 1--        = 1-         ";
21960 PRINT "           15    15           3         ";S1$;
21970 PRINT "(teller en noemer van de tweede breuk   ";
21980 PRINT " konden beide door 5 worden gedeeld)"
21990 RETURN
22000 REM *******INHOUD*****************
22010 HO=0:VE=10:GOSUB 110:IF IH=0 THEN IH=1
22020 QQ=0:QQ=((CO/IH=10) OR(CO/IH=100))
22025 IF QQ THEN VE=12:GOSUB 110:GOTO 22090
22030 PRINT "De inhoud van een blok vindt men door   ";
22040 PRINT "de lengte, breedte en hoogte ervan met  ";
22050 PRINT "elkaar te vermenigvuldigen.             ";S1$;
22060 PRINT "Bedenk dat een decimeter 10 maal groter ";
22070 PRINT "is dan een centimeter!                  ";
22080 RETURN
22090 PRINT "Jammer, het was bijna goed.             ";
22100 PRINT S1$;:GOTO 22060
22110 REM *******RENTEBEREENING*********
22120 HO=0:VE=8:GOSUB 110
22130 PRINT "Rente over spaargeld (kapitaal) wordt   ";
22140 PRINT "berekend in procenten (%) per jaar.     ";S1$;
22150 PRINT "1% betekent daarbij een-honderdste      ";
22160 PRINT "gedeelte.                               ";
22170 PRINT "Het kapitaal uit de opgave moet dus     ";
22180 PRINT "eerst worden gedeeld door 100 (komma 2  ";
22190 PRINT "plaatsen naar voren) en daarna worden   ";
22200 PRINT "vermenigvuldigd met het rentepercentage.";
22210 PRINT "(";RE;"% in de opgave).":GOSUB 23030
22220 PRINT "Vervolgens moet het gevonden rente-     ";
22230 PRINT "bedrag worden vermenigvuldigd met het   ";
22240 PRINT "aantal jaren dat het kapitaal uitstaat, ";
22250 PRINT "zodat de opgave alsvolgt uitziet:       ";S1$;
22260 PRINT "Kapitaal ";KP;" gulden wordt ";KP/100;
22270 PRINT " (1/100).";:VE=14:GOSUB 110
22280 PRINT "Rente ";RE;"%, dus ";RE;"*";KP/100;"= ?";
22290 VE=15:GOSUB 110
22300 PRINT "Tijd ";JR;
22310 IF MN=6 THEN PRINT " en een half ";
22320 PRINT "jaar."
22330 VE=16:GOSUB 110
22340 PRINT "De gevonden uitkomst moet dus nog worden";
22350 PRINT "vermenigvuldigd met ";JR;
22360 IF MN=6 THEN PRINT " en een half.":RETURN
22370 RETURN
22400 REM ******************************
22410 REM **     KLAAR-ROUTINES       **
22420 REM ******************************
22430 GOSUB 100
22450 PRINT VT$;VT$;
22460 FOR XX=0 TO 18
22470 PRINT "???                                  ???";
22480 NEXT XX
22490 PRINT VT$;VT$;
22500 HO=7:VE=6:GOSUB 110
22520 IF PA>94 THEN PRINT "Fantastisch gedaan!";:GOTO 22590
22530 IF PA>85 THEN PRINT "Prima gedaan.";:GOTO 22590
22540 IF PA>75 THEN PRINT "Goed gedaan.";:GOTO 22590
22550 IF PA>59 THEN PRINT "Dit was redelijk.";:GOTO 22590
22560 IF PA<60 THEN PRINT "Met wat vaker oefenen";:VE=7
22570 GOSUB 110:PRINT "wordt het resultaat";:VE=8
22580 GOSUB 110:PRINT "vast veel beter.";
22590 HO=7:VE=12:GOSUB 110
22600 PRINT "Het aantal behaalde";
22610 VE=13:GOSUB 110
22620 PRINT "punten bedraagt..........";PA;
22630 VE=18:GOSUB 110
22640 IF FO=0 THEN PRINT "De uitwerking was foutloos";
22650 IF FO=1 THEN PRINT "Er is slechts 1 fout gemaakt.";
22660 IF FO>1 THEN PRINT "Er zijn ";FO;" fouten gemaakt.";
22670 FOR XX=0 TO 2000:NEXT XX
22680 HO=13:VE=23:GOSUB 110:IN$="":GOSUB 23050
22690 IF PK=3 THEN SO=0:PA=0:FO=0:GOTO 1220
22700 GOSUB 100
22710 REM **************  AFREKENING  **
22720 PRINT "AFREKENING:":
22730 PRINT S3$;:GOSUB 1610:PRINT S1$;
22740 IF PA>69 THEN VD=.25
22750 IF PA>79 THEN VD=.5
22760 IF PA>89 THEN VD=.75
22770 IF PA>97 THEN VD=1
22780 IF FO<4 THEN VD=VD+(1-FO*.25)
22790 CT=4:CN=2:SR=VD:GOSUB 310
22810 PRINT S3$;"Behaald aantal punten: ";PA
22820 IF FO=0 THEN PRINT "De uitwerking was foutloos."
22830 IF FO>0 THEN PRINT "Aantal gemaakte fouten: ";FO
22840 IF VD=0 THEN PRINT "Deze keer helaas dus niets verdiend."
22850 IF VD=0 THEN PRINT "Volgende keer beter.":GOTO 22870
22860 PRINT "Deze ronde levert dus op: fl. "SR$;"."
22870 GOSUB 210:END
23000 REM ******************************
23010 REM **     OMBLADEREN           **
23020 REM ******************************
23030 IN$="":IF PK=1 THEN HO=25:VE=23:GOTO 23050
23040 HO=26:VE=19
23050 GOSUB 110:PRINT "< spatiebalk >";
23060 FOR XX=0 TO 100:IF IN$="" THEN GOSUB 200
23070 NEXT XX:GOSUB 110:PRINT "  spatiebalk  ";
23080 IF IN$<>"" THEN 23120
23090 FOR XX=0 TO 100:IF IN$="" THEN GOSUB 200
23100 NEXT XX
23110 IF IN$="" THEN 23050
23120 IF PK>1 THEN HO=0:VE=8:GOSUB 110:PRINT S6$;S6$;
23130 IF PK>1 THEN GOSUB 110:RETURN
23140 GOSUB 100:RETURN
30000 REM ******************************
30010 REM GEEN ZAKGELD IN HET PROGRAMMA
30020 REM DAN TE VERWIJDEREN DE REGELS:
30030 REM  1440- 1510,
30040 REM  1600- 1700
30050 REM 22710-22860
30060 REM REGEL 1250 UIT HET MENU DIENT
30070 REM TE WORDEN VERWIJDERD EN VAN
30080 REM REGEL 1260 DIENT DE TEKST TE
30090 REM WORDEN AANGEPAST.
30100 REM -----------------------------
30110 REM VEREENVOUDIGING VAN DE SOMMEN
30120 REM IS MOGELIJK DOOR DE VOLGENDE
30130 REM AANPASSINGEN:
30140 REM 
30150 REM OPTELLEN/AFTREKKEN:
30160 REM DE WAARDE 1000 IN DE REGELS
30170 REM 3130-3150 VERKLEINEN EN
30180 REM TOE TE VOEGEN REGEL
30190 REM 3155 IFZ>X+YTHENH=Z:Z=Y:Y=H
30210 REM 
30220 REM VERMENIGVULDIGEN
30230 REM DE WAARDE 20 IN DE REGELS
30240 REM 3330 EN 3340 VERLAGEN.
30250 REM 
30260 REM DELEN
30270 REM DE WAARDE 20 IN DE REGELS
30280 REM 3430 EN 3440 VERLAGEN.
30290 REM 
30300 REM BREUKEN
30310 REM DE WAARDEN 4 EN 8 IN REGELS
30320 REM 3540-3570 VERLAGEN EN/OF
30330 REM ZORGEN DAT DE NOEMERS GELIJK
30340 REM ZIJN TERWIJL DE OPGAVE WORDT
30450 REM BEPERKT TOT OPTELLEN EN
30460 REM AFTREKKEN. IN DAT GEVAL
30470 REM TOEVOEGEN REGEL:
30480 REM 3595 IFNA<>NBTHEN3540
30490 REM EN DE WAARDE 4 IN REGEL 3630
30500 REM VERANDEREN IN 2
30510 REM 
30520 REM INHOUD
30530 REM BEREKENINGEN UITSLUITEND IN
30540 REM DM3 DOOR DE WAARDEN 2 IN DE
30550 REM REGELS 5030, 5050 EN 5070
30560 REM TE VERANDEREN IN 1
30570 REM 
30580 REM RENTEBEREKENING
30590 REM IN REGEL 5530 DE WAARDE 18
30600 REM VERANDEREN IN 8 EN ' *.5 '
30610 REM VERWIJDEREN,
30620 REM IN REGEL 5540 MN=INT...ENZ.
30630 REM VERANDEREN IN MN=0
30640 REM -----------------------------
30660 REM DE TIJDSDUUR VOOR HET MAKEN
30670 REM VAN DE OPGAVEN VERANDEREN
30680 REM DOOR KLEINE CORRECTIES OP DE
30690 REM DE WAARDE .045 IN REGEL 20130
30700 REM -----------------------------
30710 REM GEEN AANWIJZINGEN BIJ FOUTEN
30720 REM DAN TOEVOEGEN REGEL
30730 REM 20595 PRINT" Nog 'ns.":FORXX
30740 REM =0TO900:NEXTXX:GOTO20720
30750 REM ----------------------------
31510 REM DIT PROGRAMMA WERD GESCHREVEN
31520 REM OP EEN COMMODORE 64 DOOR:
31530 REM     ******************
31540 REM    * H.P.M. SWINKELS, *
31550 REM   *  BOERDERIJWEG 44,  *
31560 REM   *  3262 CC           *
31570 REM    * OUD-BEIJERLAND   *
31580 REM     ******************
31590 REM COPYRIGHT NOS HILVERSUM 1987
