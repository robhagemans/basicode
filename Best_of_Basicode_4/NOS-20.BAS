1000 A=1000:GOTO 20:REM REKENFRIEK
1010 DIM LC$(25):DIM W(10),X(10),Y(10),Z(10),AF(10)
1015 GOSUB 100
1020 HO=6:VE=4:GOSUB 110:PRINT "**************"
1030 HO=6:VE=5:GOSUB 110:PRINT "*            *"
1040 HO=6:VE=6:GOSUB 110:PRINT "* REKENFRIEK *"
1050 HO=6:VE=7:GOSUB 110:PRINT "*            *"
1060 HO=6:VE=8:GOSUB 110:PRINT "**************"
1070 HO=0:VE=12:GOSUB 110:PRINT "     */^?=%+-*/^?=%+-/^?="
1080 HO=3:VE=15:GOSUB 110:PRINT "Hallo,mijn naam is"
1090 HO=7:VE=17:GOSUB 110:PRINT "REKENFRIEK"
1100 HO=3:VE=21:GOSUB 110:PRINT "Hoe heet jij";:INPUT NA$
1110 IF NA$<>"" THEN 1160
1120 HO=3:VE=21:GOSUB 110:PRINT "Heb jij geen naam???"
1130 FOR J=1 TO 1000:NEXT J
1140 HO=3:VE=21:GOSUB 110:PRINT "                           "
1150 GOTO 1100
1160 GOSUB 100
1170 HO=3:VE=3:GOSUB 110:PRINT "Hallo ";NA$
1180 HO=1:VE=5:GOSUB 110
1190 PRINT "Leuk dat je met mij wilt rekenen."
1200 HO=1:VE=9:GOSUB 110:PRINT "Wil je eerst uitleg (j/n)?"
1210 GOSUB 210:F$=IN$
1220 IF F$="S" THEN 6410
1230 IF F$="s" THEN 6410
1240 IF F$="J" THEN 1290
1250 IF F$="j" THEN 1290
1260 IF F$="N" THEN 1710
1270 IF F$="n" THEN 1710
1280 GOTO 1210
1290 GOSUB 100
1300 PRINT "   "NA$;","
1310 PRINT :PRINT "ik zal het net zo moeilijk"
1320 PRINT "maken als je zelf wenst."
1330 PRINT :PRINT "Welke rekenbewerking je wilt gaan"
1340 PRINT "doen kun je op het"
1350 PRINT "-MENU-scherm kiezen."
1360 PRINT :PRINT "Bij het berekenen van de antwoorden"
1370 PRINT "mag je net zoveel kladpapier"
1380 PRINT "gebruiken als je wilt"
1390 PRINT "maar probeer het zoveel"
1400 PRINT "mogelijk uit je hoofd te doen."
1410 GOSUB 5120
1420 PRINT "Het gebruiken van een zakrekenmachine"
1430 PRINT "voor het vinden van de antwoorden"
1440 PRINT "maakt me ziek.Ik neem aan dat je"
1450 PRINT "me dat niet wilt aandoen!"
1460 PRINT :PRINT "Je krijgt steeds blokken van 10"
1470 PRINT "vragen,waarna je kunt kiezen om door"
1480 PRINT "te gaan met dezelfde of met een"
1490 PRINT "een andere rekenkundige bewerking."
1500 PRINT :PRINT "Na 10 vragen vertel ik je hoe hoog"
1510 PRINT "je score is. Als je het antwoord"
1520 PRINT "direkt goed hebt krijg je 10 punten."
1530 PRINT "Is je 2e antwoord goed dan"
1540 PRINT "krijg je 5 punten."
1550 GOSUB 5120
1560 PRINT :PRINT "De score wordt bepaald door"
1570 PRINT "het totaal aantal behaalde punten"
1580 PRINT "te delen door het aantal "
1590 PRINT "gestelde vragen."
1600 PRINT :PRINT "Naar aanleiding van jouw score geef"
1610 PRINT "ik je advies om je speelniveau"
1620 PRINT "te verhogen,te verlagen,of"
1630 PRINT "hetzelfde te laten."
1640 PRINT :PRINT "Elke keer als ik je een antwoord"
1650 PRINT "vraag,kun je stoppen. In plaats"
1660 PRINT "van een antwoord druk je dan -S- in."
1670 GOSUB 5120:REM Volgende scherm'
1680 PRINT :PRINT "Na ieder antwoord moet je -RETURN-"
1690 PRINT "indrukken,anders krijg ik jouw"
1700 PRINT "antwoord niet tezien."
1710 GOSUB 100:HO=6:VE=10:GOSUB 110:PRINT "SUCCES ";NA$
1720 GOSUB 5120:REM Volgende scherm'
1730 GOSUB 100:K=0
1740 HO=10:VE=2:GOSUB 110:PRINT "MENU"
1750 HO=4:VE=12:GOSUB 110:PRINT "-M-MACHTSVERHEFFEN."
1760 HO=4:VE=14:GOSUB 110:PRINT "-W-WORTELTREKKEN."
1770 HO=4:VE=16:GOSUB 110:PRINT "-S-STOPPEN."
1780 HO=5:VE=22:GOSUB 110:PRINT NA$;",maak je keuze."
1790 GOSUB 210:A$=IN$
1800 IF A$="M" THEN H=12:GOSUB 9510:K=3:GOTO 1870
1810 IF A$="m" THEN H=12:GOSUB 9510:K=3:GOTO 1870
1820 IF A$="W" THEN H=14:GOSUB 9510:K=4:GOTO 2440
1830 IF A$="w" THEN H=14:GOSUB 9510:K=4:GOTO 2440
1840 IF A$="S" THEN H=16:GOSUB 9510:GOTO 6410
1850 IF A$="s" THEN H=16:GOSUB 9510:GOTO 6410
1860 GOTO 1790
1870 REM 
1880 REM Machtsverheffen
1890 REM 
1900 GOSUB 100:R$="0"
1910 HO=3:VE=3:GOSUB 110:PRINT NA$;","
1920 HO=1:VE=5:GOSUB 110
1930 PRINT "  wil je eerst uitleg over"
1940 PRINT "   machtsverheffen (j/n)?"
1950 GOSUB 210:A$=IN$
1960 IF A$="S" THEN 6410
1970 IF A$="s" THEN 6410
1980 IF A$="J" THEN 2030
1990 IF A$="j" THEN 2030
2000 IF A$="N" THEN 2040
2010 IF A$="n" THEN 2040
2020 GOTO 1950
2030 GOSUB 6650:REM Uitleg'
2040 GOSUB 3070:REM Moeilijkheids                       graad'
2050 GOSUB 7040:REM Grootte van                      de macht'
2060 GOSUB 4240:REM Getalsoort'
2070 GOSUB 4660:REM Getallen                        genereren'
2080 GOSUB 100:N=0
2090 FOR I=1 TO 10
2100 B$="0"
2110 AW=(INT((W(I)^X(I)+.5/GW)*GW))/GW
2120 GOSUB 5060:REM Vraag bij                         opgaven'
2130 HO=0:VE=8:GOSUB 110:PRINT W(I);"^";X(I);"=";:INPUT B$
2140 IF B$="S" THEN 6410
2150 IF B$="s" THEN 6410
2160 B=(INT((VAL(B$)+.5/GW)*GW))/GW
2170 GOSUB 5210:REM Controle                         antwoord'
2180 GOSUB 100
2190 NEXT I
2200 GOSUB 6150:REM Advies'
2210 HO=2:VE=20:GOSUB 110
2220 PRINT "Wil je met machtsverheffen"
2230 PRINT "  door gaan (j/n)?"
2240 GOSUB 210:A$=IN$
2250 IF A$="S" THEN 6410
2260 IF A$="s" THEN 6410
2270 IF A$="J" THEN 1870
2280 IF A$="j" THEN 1870
2290 IF A$="N" THEN 2320
2300 IF A$="n" THEN 2320
2310 GOTO 2240
2320 GOSUB 100
2330 HO=2:VE=20:GOSUB 110
2340 PRINT "Wil je een andere"
2350 PRINT "  rekenbewerking doen (j/n)?"
2360 GOSUB 210:A$=IN$
2370 IF A$="J" THEN 1730
2380 IF A$="j" THEN 1730
2390 IF A$="N" THEN 6410
2400 IF A$="n" THEN 6410
2410 IF A$="S" THEN 6410
2420 IF A$="s" THEN 6410
2430 GOTO 2360
2440 REM 
2450 REM Worteltrekken
2460 REM 
2470 GOSUB 100:R$="0"
2480 HO=3:VE=3:GOSUB 110:PRINT NA$;","
2490 HO=2:VE=5:GOSUB 110
2500 PRINT "wil je eerst uitleg over"
2510 PRINT "  worteltrekken (j/n)?"
2520 GOSUB 210:A$=IN$
2530 IF A$="S" THEN 6410
2540 IF A$="s" THEN 6410
2550 IF A$="J" THEN 2600
2560 IF A$="j" THEN 2600
2570 IF A$="N" THEN 2610
2580 IF A$="n" THEN 2610
2590 GOTO 2520
2600 GOSUB 7380:REM Uitleg'
2610 GOSUB 3070:REM Moeilijkheids                       graad'
2620 GOSUB 9830:REM Grootte van                     de macht'
2630 GOSUB 4240:REM Getalsoort'
2640 AG$="1"
2650 GOSUB 4660:REM Getallen                        genereren'
2660 GOSUB 100:N=0
2670 FOR I=1 TO 10
2680 B$="0"
2690 IF G=1 THEN 2720
2700 IF Q>2 THEN 2720
2710 GOTO 2730
2720 W(I)=(INT(W(I)^(1/Q)))^Q
2730 AW=(INT((W(I)^(1/Q)+.5/GW)*GW))/GW
2740 GOSUB 5060:REM Vraag bij                         opgaven'
2750 IF Q<>2 THEN HO=1:VE=8:GOSUB 110:PRINT Q
2760 HO=2:VE=9:GOSUB 110:PRINT "V";W(I);"=";:INPUT B$
2770 IF B$="S" THEN 6410
2780 IF B$="s" THEN 6410
2790 B=(INT((VAL(B$)+.5/GW)*GW))/GW
2800 GOSUB 5210:REM Controle                         antwoord'
2810 GOSUB 100
2820 NEXT I
2830 GOSUB 6150:REM Advies'
2840 HO=2:VE=20:GOSUB 110
2850 PRINT "Wil je met worteltrekken"
2860 PRINT "  door gaan (j/n)?"
2870 GOSUB 210:A$=IN$
2880 IF A$="S" THEN 6410
2890 IF A$="s" THEN 6410
2900 IF A$="J" THEN 2440
2910 IF A$="j" THEN 2440
2920 IF A$="N" THEN 2950
2930 IF A$="n" THEN 2950
2940 GOTO 2870
2950 GOSUB 100
2960 HO=2:VE=20:GOSUB 110
2970 PRINT "Wil je een andere"
2980 PRINT "  rekenbewerking doen (j/n)?"
2990 GOSUB 210:A$=IN$
3000 IF A$="J" THEN 1730
3010 IF A$="j" THEN 1730
3020 IF A$="N" THEN 6410
3030 IF A$="n" THEN 6410
3040 IF A$="S" THEN 6410
3050 IF A$="s" THEN 6410
3060 GOTO 2990
3070 REM 
3080 REM Moeilijkheidsgraad
3090 REM 
3100 GOSUB 100
3110 HO=3:VE=2:GOSUB 110:PRINT NA$;","
3120 HO=1:VE=4:GOSUB 110:PRINT "je moet nu de"
3130 PRINT " moeilijkheidsgraad kiezen.Ik wil"
3140 PRINT " graag weten hoe groot de getallen,"
3150 PRINT " waarmee je wilt rekenen,moeten"
3160 PRINT " zijn.Op het volgende scherm kun"
3170 PRINT " je jouw keuze aangeven met 0,1,..of 9"
3180 IF K<>4 THEN 3220
3190 HO=1:VE=14:GOSUB 110:PRINT "Advies:kies tenminste -3-"
3200 PRINT " anders krijg je bijna steeds"
3210 PRINT " dezelfde opgaven."
3220 GOSUB 5120:REM Volgende scherm'
3230 HO=5:VE=0:GOSUB 110:PRINT "MOEILIJKHEIDSGRAAD"
3240 HO=2:VE=2:GOSUB 110:PRINT "-1-Getallen van 0 t/m      5"
3250 HO=2:VE=4:GOSUB 110:PRINT "-2-Getallen van 0 t/m     10"
3260 HO=2:VE=6:GOSUB 110:PRINT "-3-Getallen van 0 t/m     20"
3270 HO=2:VE=8:GOSUB 110:PRINT "-4-Getallen van 0 t/m     50"
3280 HO=2:VE=10:GOSUB 110:PRINT "-5-Getallen van 0 t/m    100"
3290 HO=2:VE=12:GOSUB 110:PRINT "-6-Getallen van 0 t/m    500"
3300 HO=2:VE=14:GOSUB 110:PRINT "-7-Getallen van 0 t/m  1.000"
3310 HO=2:VE=16:GOSUB 110:PRINT "-8-Getallen van 0 t/m  5.000"
3320 HO=2:VE=18:GOSUB 110:PRINT "-9-Getallen van 0 t/m 10.000"
3330 HO=2:VE=20:GOSUB 110:PRINT "-0-Getallen zelf bepalen"
3340 HO=2:VE=22:GOSUB 110:PRINT NA$;",wat kies je?"
3350 GOSUB 210:M$=IN$
3360 IF M$="S" THEN 6410
3370 IF M$="s" THEN 6410
3380 IF M$="1" THEN H=2:GOSUB 9620:MH=5:GOTO 3490
3390 IF M$="2" THEN H=4:GOSUB 9620:MH=10:GOTO 3490
3400 IF M$="3" THEN H=6:GOSUB 9620:MH=20:GOTO 3490
3410 IF M$="4" THEN H=8:GOSUB 9620:MH=50:GOTO 3490
3420 IF M$="5" THEN H=10:GOSUB 9620:MH=100:GOTO 3490
3430 IF M$="6" THEN H=12:GOSUB 9620:MH=500:GOTO 3490
3440 IF M$="7" THEN H=14:GOSUB 9620:MH=1000:GOTO 3490
3450 IF M$="8" THEN H=16:GOSUB 9620:MH=5000:GOTO 3490
3460 IF M$="9" THEN H=18:GOSUB 9620:MH=10000:GOTO 3490
3470 IF M$="0" THEN H=20:GOSUB 9620:GOTO 3510
3480 GOTO 3350
3490 ML=0
3500 GOTO 4230
3510 GOSUB 100
3520 HO=5:VE=2:GOSUB 110:PRINT "MOEILIJKHEIDSGRAAD"
3530 HO=3:VE=5:GOSUB 110:PRINT NA$;","
3540 PRINT :PRINT "vertel me maar wat het kleinste"
3550 PRINT "en grootste getal is waarmee"
3560 PRINT "je wilt rekenen."
3570 HO=3:VE=12:GOSUB 110:PRINT "Kleinste getal is";
3580 INPUT ML$
3590 IF ML$="S" THEN 6410
3600 IF ML$="s" THEN 6410
3610 RESTORE 
3620 FOR I=1 TO 10
3630 READ L$(I)
3640 NEXT I
3650 L=LEN(ML$)
3660 LG=0
3670 FOR J=1 TO L
3680 LC$(J)=MID$(ML$,J,1)
3690 FOR I=1 TO 10
3700 IF LC$(J)=L$(I) THEN 3900
3710 NEXT I
3720 IF LC$(J)="E" THEN 3740
3730 GOTO 3770
3740 IF J<>1 THEN 3760
3750 GOTO 3770
3760 IF J<>L THEN LG=LG+1:IF LG<2 THEN 3900
3770 IF LC$(J)="+" THEN 3790
3780 GOTO 3810
3790 IF J=1 THEN 3900
3800 IF LC$(J-1)="E" THEN 3900
3810 IF LC$(J)="-" THEN 3830
3820 GOTO 3850
3830 IF J=1 THEN 3900
3840 IF LC$(J-1)="E" THEN 3900
3850 IF LC$(J)="." THEN 3870
3860 GOTO 3880
3870 IF LG=0 THEN 3900
3880 HO=3:VE=12:GOSUB 110:PRINT "                           "
3890 GOTO 3570
3900 NEXT J
3910 ML=VAL(ML$)
3920 HO=3:VE=15:GOSUB 110:PRINT "Grootste getal is";
3930 INPUT MH$
3940 IF MH$="S" THEN 6410
3950 IF MH$="s" THEN 6410
3960 L=LEN(MH$)
3970 LG=0
3980 FOR J=1 TO L
3990 LC$(J)=MID$(MH$,J,1)
4000 FOR I=1 TO 10
4010 IF LC$(J)=L$(I) THEN 4210
4020 NEXT I
4030 IF LC$(J)="E" THEN 4050
4040 GOTO 4080
4050 IF J<>1 THEN 4070
4060 GOTO 4080
4070 IF J<>L THEN LG=LG+1:IF LG<2 THEN 4210
4080 IF LC$(J)="+" THEN 4100
4090 GOTO 4120
4100 IF J=1 THEN 4210
4110 IF LC$(J-1)="E" THEN 4210
4120 IF LC$(J)="-" THEN 4140
4130 GOTO 4160
4140 IF J=1 THEN 4210
4150 IF LC$(J-1)="E" THEN 4210
4160 IF LC$(J)="." THEN 4180
4170 GOTO 4190
4180 IF LG=0 THEN 4210
4190 HO=3:VE=15:GOSUB 110:PRINT "                            "
4200 GOTO 3920
4210 NEXT J
4220 MH=VAL(MH$)
4230 RETURN
4240 REM 
4250 REM Getalsoort
4260 REM 
4270 GOSUB 100
4280 HO=3:VE=2:GOSUB 110:PRINT NA$;","
4290 PRINT :PRINT "je moet nu (bij het volgende scherm)"
4300 PRINT "kiezen of je met gehele of gebroken"
4310 PRINT "getallen (getallen met een komma"
4320 PRINT "erin) wilt rekenen."
4330 PRINT :PRINT "Bij decimale (=gebroken) getallen"
4340 PRINT "worden de antwoorden zonodig afgerond"
4350 PRINT "op 2 of 4 cijfers achter de komma,"
4360 PRINT "e.e.a.afhankelijk van jouw keuze."
4370 PRINT :PRINT "In getallen wordt een komma "
4380 PRINT "weergegeven als een punt-.-"
4390 GOSUB 5120:REM Volgende scherm'
4400 HO=5:VE=2:GOSUB 110:PRINT "GETALSOORT"
4410 HO=2:VE=4:GOSUB 110:PRINT "-1-Alleen gehele getallen."
4420 HO=2:VE=6:GOSUB 110
4430 PRINT "-2-Alleen antwoord decimaal"
4440 PRINT "     max. 2 decimalen."
4450 HO=2:VE=10:GOSUB 110
4460 PRINT "-3-Alleen antwoord decimaal"
4470 PRINT "     max. 4 decimalen."
4480 HO=2:VE=14:GOSUB 110
4490 PRINT "-4-Alle getallen decimaal"
4500 PRINT "     max. 2 decimalen."
4510 HO=2:VE=17:GOSUB 110
4520 PRINT "-5-Alle getallen decimaal"
4530 PRINT "     max. 4 decimalen."
4540 HO=2:VE=22:GOSUB 110:PRINT NA$;",wat kies je?"
4550 GOSUB 210:G$=IN$
4560 IF G$="S" THEN 6410
4570 IF G$="s" THEN 6410
4580 IF G$="1" THEN H=4:GOSUB 9620:GH=1:GW=1:GOTO 4640
4590 IF G$="2" THEN H=6:GOSUB 9620:GH=1:GW=100:GOTO 4640
4600 IF G$="3" THEN H=10:GOSUB 9620:GH=1:GW=10000:GOTO 4640
4610 IF G$="4" THEN H=14:GOSUB 9620:GH=100:GW=100:GOTO 4640
4620 IF G$="5" THEN H=17:GOSUB 9620:GH=10000:GW=10000:GOTO 4640
4630 GOTO 4550
4640 G=VAL(G$)
4650 RETURN
4660 REM 
4670 REM  Getallen genereren
4680 REM 
4690 GOSUB 100:GA=0
4700 HO=1:VE=10:GOSUB 110:PRINT "EVEN GEDULD ";NA$;","
4710 HO=1:VE=12:GOSUB 110:PRINT "ik moet even getallen"
4720 HO=1:VE=14:GOSUB 110:PRINT "bedenken."
4730 FOR I=1 TO 10:GOTO 4770
4740 GA=GA-1:GOTO 4770
4750 GA=GA-2:GOTO 4770
4760 GA=GA-3
4770 XT=0:YT=0:ZT=0
4780 FOR J=1 TO I*I:NEXT J
4790 GOSUB 260
4800 W(I)=(INT(RV*MH*GH+.5))/GH
4810 IF W(I)<ML THEN 4790
4820 IF W(I)=W(I-1) THEN 4790
4830 IF I>2 THEN 4850
4840 GOTO 4860
4850 IF W(I)=W(I-2) THEN 4790
4860 GA=GA+1
4870 HO=1:VE=20:GOSUB 110:PRINT "Ik heb er al:";GA
4880 FOR J=1 TO 50:NEXT J
4890 IF K=4 THEN 5010
4900 GOSUB 260
4910 X(I)=(INT(RV*MM*GH+.5))/GH
4920 X(I)=INT(X(I)+.5)
4930 IF X(I)<ML THEN 4900
4940 IF X(I)=X(I-1) THEN 4900
4950 IF I>2 THEN 4970
4960 GOTO 4980
4970 IF X(I)=X(I-2) THEN 4900
4980 GA=GA+1
4990 HO=1:VE=20:GOSUB 110:PRINT "Ik heb er al:";GA
5000 FOR J=1 TO 50:NEXT J
5010 NEXT I
5020 GOSUB 100
5030 HO=1:VE=20:GOSUB 110:PRINT "Zo,ik heb ze allemaal!"
5040 FOR J=1 TO 1000:NEXT J
5050 RETURN
5060 REM 
5070 REM  Vraag bij opgaven
5080 REM 
5090 HO=3:VE=3:GOSUB 110:PRINT NA$;","
5100 HO=1:VE=5:GOSUB 110:PRINT "kun je beantwoorden:"
5110 RETURN
5120 REM 
5130 REM Volgende scherm
5140 REM 
5150 HO=5:VE=21:GOSUB 110:PRINT "Druk op een knop."
5160 GOSUB 210:A$=IN$
5170 IF A$="S" THEN 6410
5180 IF A$="s" THEN 6410
5190 GOSUB 100
5200 RETURN
5210 REM 
5220 REM  Controle antwoord
5230 REM 
5240 IF R$="2" THEN 5260
5250 GOTO 5270
5260 IF RB<>RA THEN 5280
5270 IF B=AW THEN 5520
5280 GOSUB 5650:REM Uitspraken                       bij fout'
5290 GOSUB 6090:REM Geluid fout'
5300 HO=1:VE=12:GOSUB 110:PRINT C$
5310 RB$="0":B$="0"
5320 HO=1:VE=14:GOSUB 110:PRINT "Wat is het goede antwoord?"
5330 IF R$="2" THEN HO=6:VE=17:GOSUB 110:PRINT "Rest"
5340 HO=1:VE=16:GOSUB 110:PRINT "2e poging";:INPUT B$
5350 IF B$="S" THEN 6410
5360 IF B$="s" THEN 6410
5370 HO=1:VE=12:GOSUB 110:PRINT "                            "
5380 HO=1:VE=14:GOSUB 110:PRINT "                            "
5390 B=(INT((VAL(B$)+.5/GW)*GW))/GW
5400 IF R$<>"2" THEN 5460
5410 HO=10:VE=17:GOSUB 110:INPUT RB$
5420 IF RB$="S" THEN 6410
5430 IF RB$="s" THEN 6410
5440 RB=VAL(RB$)
5450 IF (RB<>RA) THEN 5470
5460 IF B=AW THEN 5550
5470 GOSUB 6090:REM Geluid fout'
5480 HO=1:VE=18:GOSUB 110:PRINT "Wat jammer,het goede"
5490 HO=1:VE=20:GOSUB 110:PRINT "antwoord is:";AW;
5500 IF R$="2" THEN PRINT " rest:";RA
5510 GOTO 5600
5520 GOSUB 5820:REM Uitspraken                       bij goed'
5530 GOSUB 6040:REM Geluid goed'
5540 N=N+10:HO=1:VE=18:GOSUB 110:PRINT D$:GOTO 5590
5550 GOSUB 6000:REM Uitspraken             bij 2e poging goed'
5560 GOSUB 6040:REM Geluid goed'
5570 N=N+5
5580 HO=1:VE=18:GOSUB 110:PRINT E$
5590 HO=1:VE=20:GOSUB 110:PRINT "je antwoord is goed."
5600 WR=(INT(N/I*10))/10
5610 HO=1:VE=22:GOSUB 110:PRINT "OPGAVEN:";I
5620 HO=16:VE=22:GOSUB 110:PRINT "SCORE  :";WR
5630 FOR J=1 TO 2000:NEXT J
5640 RETURN
5650 REM 
5660 REM  Uitspraken bij fout
5670 REM 
5680 GOSUB 260
5690 C=INT(RV*11)
5700 IF C=0 THEN C$="nee toch"
5710 IF C=1 THEN C$="je weet wel beter"
5720 IF C=2 THEN C$="hoe kom je er bij"
5730 IF C=3 THEN C$="hoe bedenk je het"
5740 IF C=4 THEN C$="dit is helemaal fout"
5750 IF C=5 THEN C$="dit is echt niet goed"
5760 IF C=6 THEN C$="weet je dat wel zeker"
5770 IF C=7 THEN C$="je bent een oenemeloen"
5780 IF C=8 THEN C$="ik schrik van je antwoord"
5790 IF C=9 THEN C$="dit valt me van je tegen"
5800 IF C=10 THEN C$="ik had beter van je verwacht"
5810 RETURN
5820 REM 
5830 REM  Uitspraken bij goed
5840 REM 
5850 GOSUB 260
5860 D=INT(RV*12)
5870 IF D=0 THEN D$="onwijs gaaf"
5880 IF D=1 THEN D$="tof he"
5890 IF D=2 THEN D$="je doet het te gek"
5900 IF D=3 THEN D$="gaaf,je bent een kei"
5910 IF D=4 THEN D$="je bent echt steengoed"
5920 IF D=5 THEN D$="je bent een genie"
5930 IF D=6 THEN D$="heel goed,ga zo door"
5940 IF D=7 THEN D$="hoe krijg je het voor elkaar"
5950 IF D=8 THEN D$="uit de kunst"
5960 IF D=9 THEN D$="wauw!!"
5970 IF D=10 THEN D$="prima!"
5980 IF D=11 THEN D$="subliem!"
5990 RETURN
6000 REM 
6010 REM  Uitspraken bij 2e
6020 REM  poging goed
6030 REM 
6040 GOSUB 260
6050 E=INT(RV*8)
6060 IF E=0 THEN E$="dat is beter"
6070 IF E=1 THEN E$="zo gaat ie goed"
6080 IF E=2 THEN E$="ga zo door"
6090 IF E=3 THEN E$="hou vol"
6100 IF E=4 THEN E$="prima"
6110 IF E=5 THEN E$="zo ken ik je weer"
6120 IF E=6 THEN E$="gefeliciteerd"
6130 IF E=7 THEN E$="ik ben weer tevreden"
6140 RETURN
6150 REM 
6160 REM  Advies
6170 REM 
6180 HO=3:VE=3:GOSUB 110:PRINT NA$;","
6190 HO=2:VE=5:GOSUB 110:PRINT "je score is:";WR
6200 HO=2:VE=10:GOSUB 110:PRINT "Wil je mijn advies?(j/n)"
6210 GOSUB 210:AD$=IN$
6220 IF AD$="S" THEN 6410
6230 IF AD$="s" THEN 6410
6240 IF AD$="N" THEN 6390
6250 IF AD$="n" THEN 6390
6260 IF AD$="J" THEN 6290
6270 IF AD$="j" THEN 6290
6280 GOTO 6210
6290 IF WR<5 THEN 6340
6300 IF WR>7 THEN 6360
6310 HO=2:VE=10:GOSUB 110:PRINT "Het gaat wel aardig,maar"
6320 PRINT "  het kan nog beter.Blijf nog oefenen"
6330 PRINT "  op hetzelfde niveau!":GOTO 6380
6340 HO=2:VE=10:GOSUB 110:PRINT "Oefen nog maar eens een"
6350 PRINT "  tijdje op een lager niveau!":GOTO 6380
6360 HO=2:VE=10:GOSUB 110:PRINT "Het gaat prima,probeer    "
6370 PRINT "  maar eens moeilijker opgaven!"
6380 FOR J=1 TO 3000:NEXT J
6390 GOSUB 100
6400 RETURN
6410 REM 
6420 REM  Stoppen
6430 REM 
6440 GOSUB 100
6450 HO=3:VE=5:GOSUB 110:PRINT NA$;","
6460 HO=1:VE=7:GOSUB 110:PRINT "weet je zeker dat je"
6470 HO=1:VE=9:GOSUB 110:PRINT "wilt stoppen? (j/n)"
6480 GOSUB 210:S$=IN$
6490 IF S$="J" THEN 6540
6500 IF S$="j" THEN 6540
6510 IF S$="N" THEN 1730
6520 IF S$="n" THEN 1730
6530 GOTO 6480
6540 GOSUB 100
6550 FOR J=1 TO 7
6560 HO=16:VE=9:GOSUB 110
6570 PRINT "TOT"
6580 HO=15:VE=15:GOSUB 110
6590 PRINT "ZIENS"
6600 FOR I=1 TO 250:NEXT I
6610 GOSUB 100
6620 FOR I=1 TO 150:NEXT I
6630 NEXT J
6640 END
6650 REM 
6660 REM Uitleg
6670 REM      machtsverheffen
6680 REM 
6690 GOSUB 100
6700 HO=3:VE=2:GOSUB 110:PRINT NA$;","
6710 HO=1:VE=4:GOSUB 110:PRINT "machtsverheffen is eigenlijk"
6720 HO=1:VE=6:GOSUB 110:PRINT "een bijzondere vorm van"
6730 HO=1:VE=8:GOSUB 110:PRINT "vermenigvuldigen."
6740 HO=1:VE=11:GOSUB 110:PRINT "Machtsverheffen betekent:"
6750 HO=1:VE=13:GOSUB 110:PRINT "vermenigvuldig het grondtal"
6760 HO=1:VE=15:GOSUB 110:PRINT "zoveel keer met zichzelf"
6770 HO=1:VE=17:GOSUB 110:PRINT "als de macht groot is."
6780 GOSUB 5120:REM Volgende scherm'
6790 HO=3:VE=2:GOSUB 110:PRINT "Voorbeeld 1 :"
6800 HO=1:VE=4:GOSUB 110:PRINT "2^4 (zeg:twee tot de vierde"
6810 HO=1:VE=6:GOSUB 110:PRINT "of twee tot de macht vier)"
6820 HO=1:VE=8:GOSUB 110:PRINT "is:2*2*2*2;het antwoord"
6830 HO=1:VE=10:GOSUB 110:PRINT "is dus:16."
6840 HO=1:VE=12:GOSUB 110:PRINT " 2 is hier het grondtal"
6850 HO=1:VE=14:GOSUB 110:PRINT " 4 is hier de macht"
6860 GOSUB 5120:REM Volgende scherm'
6870 HO=3:VE=2:GOSUB 110:PRINT "Voorbeeld 2 :"
6880 HO=1:VE=4:GOSUB 110:PRINT "5^2 (grondtal=5,macht=2)"
6890 HO=1:VE=6:GOSUB 110:PRINT "5^2=5*5=25"
6900 HO=3:VE=10:GOSUB 110:PRINT "Voorbeeld 3 :"
6910 HO=1:VE=12:GOSUB 110:PRINT "4^3 (grondtal=4,macht=3)"
6920 HO=1:VE=14:GOSUB 110:PRINT "4^3=4*4*4=64"
6930 HO=1:VE=17:GOSUB 110:PRINT "Ik zal voor de 'machten'"
6940 PRINT " alleen gehele getallen geven"
6950 HO=3:VE=21:GOSUB 110:PRINT "Uitleg nog eens (j/n)?"
6960 GOSUB 210:A$=IN$
6970 IF A$="S" THEN 6410
6980 IF A$="s" THEN 6410
6990 IF A$="J" THEN 6650
7000 IF A$="j" THEN 6650
7010 IF A$="N" THEN RETURN
7020 IF A$="n" THEN RETURN
7030 GOTO 6960
7040 REM 
7050 REM Grootte van de macht
7060 REM      machtsverheffen
7070 GOSUB 100:MM$="0"
7080 HO=3:VE=2:GOSUB 110:PRINT NA$;","
7090 HO=2:VE=5:GOSUB 110:PRINT "je moet nu de grootte van"
7100 PRINT "  de macht kiezen(m.a.w.:hoe vaak"
7110 PRINT "  wil je het grondgetal met"
7120 PRINT "  zichzelf vermenigvuldigen)."
7130 HO=2:VE=11:GOSUB 110:PRINT "Bedenk bij je keuze dat"
7140 PRINT "  b.v.  5^4 (vijf tot de macht vier,"
7150 PRINT "  dit is 5*5*5*5) al 625 is!!"
7160 GOSUB 5120:REM Volgende scherm'
7170 HO=3:VE=2:GOSUB 110:PRINT "Grootte van de macht"
7180 HO=2:VE=4:GOSUB 110:PRINT "-1-Machten t/m  3"
7190 HO=2:VE=6:GOSUB 110:PRINT "-2-Machten t/m  5"
7200 HO=2:VE=8:GOSUB 110:PRINT "-3-Machten t/m  8"
7210 HO=2:VE=10:GOSUB 110:PRINT "-4-Machten t/m 10"
7220 HO=2:VE=12:GOSUB 110:PRINT "-5-Machten t/m 15"
7230 HO=2:VE=14:GOSUB 110:PRINT "-6-Machten t/m 20"
7240 HO=2:VE=16:GOSUB 110:PRINT "-7-Machten t/m 25"
7250 HO=3:VE=22:GOSUB 110:PRINT NA$;",wat kies je?"
7260 GOSUB 210:MM$=IN$
7270 IF MM$="S" THEN 6410
7280 IF MM$="s" THEN 6410
7290 IF MM$="1" THEN H=4:GOSUB 9620:MM=3:GOTO 7370
7300 IF MM$="2" THEN H=6:GOSUB 9620:MM=5:GOTO 7370
7310 IF MM$="3" THEN H=8:GOSUB 9620:MM=8:GOTO 7370
7320 IF MM$="4" THEN H=10:GOSUB 9620:MM=10:GOTO 7370
7330 IF MM$="5" THEN H=12:GOSUB 9620:MM=15:GOTO 7370
7340 IF MM$="6" THEN H=14:GOSUB 9620:MM=20:GOTO 7370
7350 IF MM$="7" THEN H=16:GOSUB 9620:MM=25:GOTO 7370
7360 GOTO 7260
7370 RETURN
7380 REM 
7390 REM Uitleg                             machtsverheffen
7400 REM 
7410 GOSUB 100
7420 HO=3:VE=2:GOSUB 110:PRINT NA$;","
7430 HO=1:VE=4:GOSUB 110:PRINT "worteltrekken is het"
7440 HO=1:VE=6:GOSUB 110:PRINT "tegenovergestelde van"
7450 HO=1:VE=8:GOSUB 110:PRINT "machtsverheffen."
7460 HO=1:VE=11:GOSUB 110:PRINT "Worteltrekken wordt"
7470 HO=1:VE=13:GOSUB 110:PRINT "aangegeven door -V- hetgeen"
7480 HO=1:VE=15:GOSUB 110:PRINT "zonder verdere aanduiding"
7490 HO=1:VE=17:GOSUB 110:PRINT "de 2e-machtswortel betekent"
7500 GOSUB 5120:REM Volgende scherm'
7510 HO=1:VE=2:GOSUB 110:PRINT "De andere machten worden als"
7520 PRINT " volgt aangegeven:"
7530 HO=26:VE=5:GOSUB 110:PRINT "3"
7540 HO=1:VE=6:GOSUB 110:PRINT "de 3e-machts wortel als -V-"
7550 HO=26:VE=8:GOSUB 110:PRINT "4"
7560 HO=1:VE=9:GOSUB 110:PRINT "de 4e-machts wortel als -V-"
7570 HO=26:VE=11:GOSUB 110:PRINT "5"
7580 HO=1:VE=12:GOSUB 110:PRINT "de 5e machts wortel als -V-"
7590 HO=1:VE=15:GOSUB 110:PRINT "enz,enz,enz."
7600 GOSUB 5120:REM Volgende scherm'
7610 HO=1:VE=2:GOSUB 110:PRINT "We zullen nu gaan kijken"
7620 HO=1:VE=4:GOSUB 110:PRINT "naar de 2e-machts wortel."
7630 HO=1:VE=7:GOSUB 110:PRINT "Als gevraagd wordt de wortel"
7640 HO=1:VE=9:GOSUB 110:PRINT "uit een getal te trekken"
7650 HO=1:VE=11:GOSUB 110:PRINT "b.v.V25(zeg: wortel uit 25)"
7660 HO=1:VE=13:GOSUB 110:PRINT "dan moet een getal gezocht"
7670 HO=1:VE=15:GOSUB 110:PRINT "worden dat,met zichzelf"
7680 HO=1:VE=17:GOSUB 110:PRINT "vermenigvuldigt,25 oplevert"
7690 GOSUB 5120:REM Volgende scherm'
7700 HO=1:VE=2:GOSUB 110:PRINT "Dus:V25=5 want 5*5=25"
7710 HO=1:VE=4:GOSUB 110:PRINT "Evenzo is V4=2 en V49=7 enz."
7720 HO=1:VE=7:GOSUB 110:PRINT "Bij deze kleine getallen"
7730 HO=1:VE=9:GOSUB 110:PRINT "gaat het vinden van het"
7740 HO=1:VE=11:GOSUB 110:PRINT "antwoord vrij eenvoudig."
7750 HO=1:VE=13:GOSUB 110:PRINT "Meestal gaat het minder"
7760 HO=1:VE=15:GOSUB 110:PRINT "eenvoudig zoals b.v.V56 of"
7770 HO=1:VE=17:GOSUB 110:PRINT "V127 of V625 enz."
7780 GOSUB 5120:REM Volgende scherm'
7790 HO=1:VE=2:GOSUB 110:PRINT "Als voorbeeld gaan we V57"
7800 HO=1:VE=4:GOSUB 110:PRINT "bepalen."
7810 HO=1:VE=7:GOSUB 110:PRINT "Dit gebeurt in een aantal"
7820 HO=1:VE=9:GOSUB 110:PRINT "stappen."
7830 HO=1:VE=11:GOSUB 110:PRINT "Het-op papier-uitrekenen"
7840 HO=1:VE=13:GOSUB 110:PRINT "van de wortel uit een getal"
7850 HO=1:VE=15:GOSUB 110:PRINT "lijkt op een staartdeling."
7860 GOSUB 5120:REM Volgende scherm'
7870 HO=1:VE=2:GOSUB 110:PRINT "Stap 1:Verdeel 57 vanuit de"
7880 HO=1:VE=4:GOSUB 110:PRINT "komma (=. op scherm) naar"
7890 HO=1:VE=6:GOSUB 110:PRINT "links en rechts in groepjes"
7900 HO=1:VE=8:GOSUB 110:PRINT "van 2 cijfers."
7910 HO=1:VE=11:GOSUB 110:PRINT "Antw:57 kan ook geschreven"
7920 HO=1:VE=13:GOSUB 110:PRINT "worden als 57.00000000"
7930 HO=1:VE=15:GOSUB 110:PRINT "dus verdeling in groepjes"
7940 HO=1:VE=17:GOSUB 110:PRINT "geeft:57 . 00 00 00 00"
7950 GOSUB 5120:REM Volgende scherm'
7960 HO=10:VE=2:GOSUB 110:PRINT "V57.000000=?"
7970 HO=7:VE=3:GOSUB 110:PRINT "a*a=__"
7980 HO=1:VE=17:GOSUB 110:PRINT "Stap 2:Vul voor a een getal"
7990 HO=1:VE=18:GOSUB 110:PRINT "in zodat a*a kleiner is"
8000 HO=1:VE=19:GOSUB 110:PRINT "dan 57."
8010 HO=1:VE=20:GOSUB 110:PRINT "Antw:a=7 (7*7=49)"
8020 GOSUB 9740:REM Volgende  stap'
8030 HO=21:VE=2:GOSUB 110:PRINT "7"
8040 HO=7:VE=3:GOSUB 110:PRINT "7*7=49"
8050 HO=11:VE=4:GOSUB 110:PRINT "____ -"
8060 HO=12:VE=5:GOSUB 110:PRINT "8"
8070 HO=1:VE=17:GOSUB 110:PRINT "Stap 3:Haal de volgende 2  "
8080 HO=1:VE=18:GOSUB 110:PRINT "cijfers aan;deze staan    "
8090 HO=1:VE=19:GOSUB 110:PRINT "achter de komma dus plaats"
8100 HO=1:VE=20:GOSUB 110:PRINT "een komma in het antwoord."
8110 FOR J=1 TO 1000:NEXT J
8120 HO=14:VE=5:GOSUB 110:PRINT "00"
8130 GOSUB 9740:REM Volgende  stap'
8140 HO=22:VE=2:GOSUB 110:PRINT "."
8150 HO=6:VE=6:GOSUB 110:PRINT "da*a= _ __"
8160 HO=1:VE=17:GOSUB 110:PRINT "Stap 4:Vul voor d een getal"
8170 HO=1:VE=18:GOSUB 110:PRINT "in ter grootte van 2x het  "
8180 HO=1:VE=19:GOSUB 110:PRINT "antwoord tot nu toe        "
8190 HO=1:VE=20:GOSUB 110:PRINT "Antw:d=14 (2*7)            "
8200 GOSUB 9740:REM Volgende  stap'
8210 HO=5:VE=6:GOSUB 110:PRINT "14a*a= _ __"
8220 HO=1:VE=17:GOSUB 110:PRINT "Stap 5:Vul voor a een getal"
8230 HO=1:VE=18:GOSUB 110:PRINT "in zodat 14a*a kleiner is  "
8240 HO=1:VE=19:GOSUB 110:PRINT "dan 800                     "
8250 HO=1:VE=20:GOSUB 110:PRINT "Antw:a=5 (145*5=725)        "
8260 GOSUB 9740:REM Volgende  stap'
8270 HO=23:VE=2:GOSUB 110:PRINT "5"
8280 HO=5:VE=6:GOSUB 110:PRINT "145*5= 7 25"
8290 HO=12:VE=7:GOSUB 110:PRINT "________ -"
8300 HO=14:VE=8:GOSUB 110:PRINT "75"
8310 HO=1:VE=17:GOSUB 110:PRINT "                            "
8320 HO=1:VE=18:GOSUB 110:PRINT "Stap 6:Haal de volgende 2"
8330 HO=1:VE=19:GOSUB 110:PRINT "cijfers aan"
8340 HO=1:VE=20:GOSUB 110:PRINT "                            "
8350 FOR J=1 TO 1000:NEXT J
8360 HO=16:VE=8:GOSUB 110:PRINT "00"
8370 GOSUB 9740:REM Volgende  stap'
8380 HO=6:VE=9:GOSUB 110:PRINT "da*a=   ____"
8390 HO=1:VE=17:GOSUB 110:PRINT "Stap 7:Vul voor d weer een"
8400 HO=1:VE=18:GOSUB 110:PRINT "getal in ter grootte van  "
8410 HO=1:VE=19:GOSUB 110:PRINT "2x het antwoord tot nu toe"
8420 HO=1:VE=20:GOSUB 110:PRINT "(de komma telt hier niet)."
8430 HO=1:VE=21:GOSUB 110:PRINT "Antw:d=150 (2*75)          "
8440 GOSUB 9740:REM Volgende  stap'
8450 HO=4:VE=9:GOSUB 110:PRINT "150a*a=   ____"
8460 HO=1:VE=17:GOSUB 110:PRINT "Stap 8:Vul voor a een getal"
8470 HO=1:VE=18:GOSUB 110:PRINT "in zodat 150a*a kleiner is"
8480 HO=1:VE=19:GOSUB 110:PRINT "dan 7500                   "
8490 HO=1:VE=20:GOSUB 110:PRINT "Antw:a=4 (1504*4=6016)     "
8500 HO=1:VE=21:GOSUB 110:PRINT "                           "
8510 GOSUB 9740:REM Volgende  stap'
8520 HO=24:VE=2:GOSUB 110:PRINT "4"
8530 HO=4:VE=9:GOSUB 110:PRINT "1504*4=   6016"
8540 HO=14:VE=10:GOSUB 110:PRINT "________ -"
8550 HO=14:VE=11:GOSUB 110:PRINT "1484"
8560 HO=1:VE=17:GOSUB 110:PRINT "                            "
8570 HO=1:VE=18:GOSUB 110:PRINT "Stap 9:Haal de volgende 2 "
8580 HO=1:VE=19:GOSUB 110:PRINT "cijfers aan."
8590 HO=1:VE=20:GOSUB 110:PRINT "                            "
8600 FOR J=1 TO 1000:NEXT J
8610 HO=18:VE=11:GOSUB 110:PRINT "00"
8620 GOSUB 9740:REM Volgende  stap'
8630 HO=6:VE=12:GOSUB 110:PRINT "da*a=   ______"
8640 HO=1:VE=17:GOSUB 110:PRINT "Stap 10:Vul voor d een    "
8650 HO=1:VE=18:GOSUB 110:PRINT "getal in ter grootte van "
8660 HO=1:VE=19:GOSUB 110:PRINT "2x het antwoord tot nu toe."
8670 HO=1:VE=20:GOSUB 110:PRINT "Antw:d=1508 (2*754)"
8680 GOSUB 9740:REM Volgende  stap'
8690 HO=3:VE=12:GOSUB 110:PRINT "1508a*a=   ______"
8700 HO=1:VE=17:GOSUB 110:PRINT "Stap 11:Vul voor a een getal"
8710 HO=1:VE=18:GOSUB 110:PRINT "in zodat 1508a*a kleiner is "
8720 HO=1:VE=19:GOSUB 110:PRINT "dan 148400                  "
8730 HO=1:VE=20:GOSUB 110:PRINT "Antw:a=9 (15089*9=135801)   "
8740 GOSUB 9740:REM Volgende  stap'
8750 HO=25:VE=2:GOSUB 110:PRINT "9"
8760 HO=3:VE=12:GOSUB 110:PRINT "15089*9=   135801"
8770 HO=14:VE=13:GOSUB 110:PRINT "____________ -"
8780 HO=15:VE=14:GOSUB 110:PRINT "12599"
8790 HO=1:VE=17:GOSUB 110:PRINT "Op deze wijze kun je zo lang"
8800 HO=1:VE=18:GOSUB 110:PRINT "doorgaan tot de rest 0 wordt"
8810 HO=1:VE=19:GOSUB 110:PRINT "Als je een antwoord met 2   "
8820 HO=1:VE=20:GOSUB 110:PRINT "cijfers na de komma wilt   "
8830 HO=1:VE=21:GOSUB 110:PRINT "hoef je niet door te gaan.  "
8840 GOSUB 9740:REM Volgende  stap'
8850 HO=1:VE=17:GOSUB 110:PRINT "Na afronding is het         "
8860 HO=1:VE=18:GOSUB 110:PRINT "antwoord dan: 7.55          "
8870 HO=1:VE=19:GOSUB 110:PRINT "Dus V57=7.55              "
8880 HO=1:VE=20:GOSUB 110:PRINT "                            "
8890 PRINT "                                             "
8900 GOSUB 5120:REM Volgende scherm'
8910 HO=1:VE=3:GOSUB 110:PRINT "We zullen  een 2e voorbeeld"
8920 HO=1:VE=5:GOSUB 110:PRINT "bekijken.Dit voorbeeld laat,"
8930 HO=1:VE=7:GOSUB 110:PRINT "zonder toelichting,stap voor"
8940 HO=1:VE=9:GOSUB 110:PRINT "stap de bewerkingen zien."
8950 GOSUB 5120:REM Volgende scherm'
8960 HO=10:VE=2:GOSUB 110:PRINT "V75076=?"
8970 FOR J=1 TO 1000:NEXT J
8980 HO=7:VE=3:GOSUB 110:PRINT "_*_=_"
8990 FOR J=1 TO 1000:NEXT J
9000 HO=17:VE=2:GOSUB 110:PRINT "2"
9010 HO=7:VE=3:GOSUB 110:PRINT "2*2=4"
9020 HO=11:VE=4:GOSUB 110:PRINT "__ -"
9030 FOR J=1 TO 1000:NEXT J
9040 HO=11:VE=5:GOSUB 110:PRINT "3"
9050 FOR J=1 TO 1000:NEXT J
9060 HO=12:VE=5:GOSUB 110:PRINT "50"
9070 FOR J=1 TO 1000:NEXT J
9080 HO=6:VE=6:GOSUB 110:PRINT "4_*_=___"
9090 FOR J=1 TO 1000:NEXT J
9100 HO=18:VE=2:GOSUB 110:PRINT "7"
9110 HO=6:VE=6:GOSUB 110:PRINT "47*7=329"
9120 HO=11:VE=7:GOSUB 110:PRINT "______ -"
9130 FOR J=1 TO 1000:NEXT J
9140 HO=12:VE=8:GOSUB 110:PRINT "21"
9150 FOR J=1 TO 1000:NEXT J
9160 HO=14:VE=8:GOSUB 110:PRINT "76"
9170 FOR J=1 TO 1000:NEXT J
9180 HO=5:VE=9:GOSUB 110:PRINT "54_*_= ____"
9190 FOR J=1 TO 1000:NEXT J
9200 HO=19:VE=2:GOSUB 110:PRINT "4"
9210 HO=5:VE=9:GOSUB 110:PRINT "544*4= 2176"
9220 HO=12:VE=10:GOSUB 110:PRINT "________ -"
9230 HO=15:VE=11:GOSUB 110:PRINT "0"
9240 FOR J=1 TO 1000:NEXT J
9250 HO=1:VE=15:GOSUB 110:PRINT "De wortel uit 75076 is: 274"
9260 GOSUB 5120:REM Volgende scherm'
9270 HO=1:VE=2:GOSUB 110:PRINT "Tot nu toe hebben we"
9280 PRINT " alleen naar de 2e-machts wortel"
9290 PRINT " gekeken."
9300 HO=1:VE=6:GOSUB 110:PRINT "Ook hogere-machts wortels"
9310 PRINT " kunnen -op papier- berekend worden."
9320 PRINT " Tenzij het om kleine getallen gaat"
9330 PRINT " gaat kunnen deze veel sneller op"
9340 PRINT " een andere manier (b.v.met"
9350 PRINT " logaritmen) berekend worden."
9360 HO=1:VE=13:GOSUB 110:PRINT "Daarop zullen we hier"
9370 PRINT " niet verder ingaan."
9380 HO=1:VE=16:GOSUB 110:PRINT "Als je dadelijk kiest voor"
9390 PRINT " het rekenen met hogere machten"
9400 PRINT " dan 2 zal ik er voor zorgen dat"
9410 PRINT " het antwoord een geheel getal is."
9420 HO=3:VE=22:GOSUB 110:PRINT "Uitleg nog eens (j/n)?"
9430 GOSUB 210:A$=IN$
9440 IF A$="S" THEN 6410
9450 IF A$="s" THEN 6410
9460 IF A$="J" THEN 7380
9470 IF A$="j" THEN 7380
9480 IF A$="N" THEN RETURN
9490 IF A$="n" THEN RETURN
9500 GOTO 9430
9510 REM 
9520 REM Aangeven keuze menu
9530 REM 
9540 HO=5:VE=22:GOSUB 110:PRINT "                            "
9550 FOR I=1 TO 5
9560 HO=1:VE=H:GOSUB 110:PRINT ">>>"
9570 FOR J=1 TO 250:NEXT J
9580 HO=1:VE=H:GOSUB 110:PRINT "   "
9590 FOR J=1 TO 150:NEXT J
9600 NEXT I
9610 RETURN
9620 REM 
9630 REM Aangeven keuze
9640 REM        voor overige
9650 REM 
9660 HO=1:VE=22:GOSUB 110:PRINT "                            "
9670 FOR I=1 TO 5
9680 HO=0:VE=H:GOSUB 110:PRINT ">>"
9690 FOR J=1 TO 250:NEXT J
9700 HO=0:VE=H:GOSUB 110:PRINT "  "
9710 FOR J=1 TO 150:NEXT J
9720 NEXT I
9730 RETURN
9740 REM 
9750 REM Volgende stap
9760 REM 
9770 HO=1:VE=22:GOSUB 110:PRINT "Volgende stap:druk een knop"
9780 GOSUB 210
9790 IF IN$="S" THEN 6410
9800 IF IN$="s" THEN 6410
9810 HO=1:VE=22:GOSUB 110:PRINT "                            "
9820 RETURN
9830 REM 
9840 REM Grootte van de macht
9850 REM   worteltrekken
9860 GOSUB 100:Q$="0"
9870 HO=3:VE=2:GOSUB 110:PRINT NA$;","
9880 HO=2:VE=5:GOSUB 110:PRINT "je moet nu de grootte van"
9890 PRINT "  de macht kiezen (m.a.w.:hoe vaak"
9900 PRINT "  moet het antwoord met zichzelf"
9910 PRINT "  vermenigvuldigen worden)."
9920 GOSUB 5120:REM Volgende scherm'
9930 HO=3:VE=2:GOSUB 110:PRINT "Grootte van de macht"
9940 HO=2:VE=4:GOSUB 110:PRINT "-1-Macht is 2"
9950 HO=2:VE=6:GOSUB 110:PRINT "-2-Macht is 3"
9960 HO=2:VE=8:GOSUB 110:PRINT "-3-Macht is 4"
9970 HO=2:VE=10:GOSUB 110:PRINT "-4-Macht is 5"
9980 HO=3:VE=22:GOSUB 110:PRINT NA$;",wat kies je?"
9990 GOSUB 210:Q$=IN$
10000 IF Q$="S" THEN 6410
10010 IF Q$="s" THEN 6410
10020 IF Q$="1" THEN H=4:GOSUB 9620:Q=2:GOTO 10070
10030 IF Q$="2" THEN H=6:GOSUB 9620:Q=3:GOTO 10070
10040 IF Q$="3" THEN H=8:GOSUB 9620:Q=4:GOTO 10070
10050 IF Q$="4" THEN H=10:GOSUB 9620:Q=5:GOTO 10070
10060 GOTO 9990
10070 RETURN
10080 DATA "0","1","2","3","4","5","6","7","8","9"
10090 REM 
10100 REM REKENFRIEK
10110 REM 
10120 REM  ONTWERP (c)
10130 REM J.A.v.ENGELAND
10140 REM  ALMERE
10150 REM 
10160 REM OP EEN MSX-COMPUTER
10170 REM  PHILIPS VG-8020
10180 REM 
10190 REM  FEBRUARI 1987
10200 REM *********************
30000 REM COPYRIGHT NOS HILVERSUM
