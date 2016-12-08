10 GOTO 1000:REM Basicode-2 subroutines
20 CLEAR:IN$=" ":SR=0:SR$="":CT=0:CN=0:OHT%=80:OVT%=24
22 KEY OFF:SCREEN 0:WIDTH OHT%:COLOR 7,0,0:CLS:RANDOMIZE TIMER*100
29 GOTO 1010
100 CLS:RETURN
110 GOSUB 111:LOCATE OVE%+1,OHO%+1:RETURN
111 OVE%=INT(VE):OHO%=INT(HO)
112 IF OVE%<0 THEN OVE%=0 ELSE IF OVE%>=OVT% THEN OVE%=OVT%-1
113 IF OHO%<0 THEN OHO%=0 ELSE IF OHO%>=OHT% THEN OHO%=OHT%-1
114 RETURN
120 HO=POS(0)-1:VE=CSRLIN-1:RETURN
200 IN$=INKEY$:RETURN
210 IN$=INPUT$(1):RETURN
250 BEEP:RETURN
260 RV=RND:RETURN
270 FR=FRE(""):RETURN
300 SR$=MID$(STR$(ABS(SR)),2):IF LEFT$(SR$,1)="." THEN SR$="0"+SR$
301 IF SR<0 THEN SR$="-"+SR$
302 RETURN
310 O#=ABS(SR)+.5*10^-CN:O!=INT(O#):O#=1+O#-O!:O$=""
311 IF CN THEN O$="."+STRING$(CN,48):IF O#>1 THEN MID$(O$,1)=MID$(STR$(O#),3)
312 O$=MID$(STR$(O!),2)+O$:IF VAL(O$)>0 AND SR<0 THEN O$="-"+O$
313 IF LEN(O$)<=CT THEN SR$=SPACE$(CT-LEN(O$))+O$:RETURN
314 SR$=STRING$(CT,42):RETURN
350 LPRINT SR$;:RETURN
360 LPRINT:RETURN
1000 A = 200: GOTO 20: REM Schoonspringen
1010 GOSUB 100: DIM R(64)
1020 GOSUB 2430: REM init + scherm opmeten
1030 GOSUB 2560: REM titelscherm uitleg
1040 GOSUB 1780: REM teken speelbord
1050 :
1060 HO = S + 4: VE = 20: GOSUB 110: PRINT L$
1070 IF Q = 1 THEN GOSUB 1920
1080 Q = 0: IF W = 0 THEN B$ = "Start "
1090 IF W > 0 THEN B$ = "Sprong "
1100 B$ = B$ + "getal ? ": GOSUB 1970
1110 Z$ = "": GOSUB 1370: Z = VAL(Z$)
1120 :
1130 IF(Z$ = "S") OR(Z$ = "s") THEN 1290
1140 IF(Z < 1) OR(Z > 64) THEN Q = 1: GOTO 1060
1150 V = INT((Z - 1) / 8) + 1: H = Z - (V - 1) * 8
1160 IF W = 0 THEN 1240
1170 VC = ABS(V1 - V): CH = ABS(H1 - H)
1180 IF R(Z) = 1 THEN Q = 1
1190 IF(VC <> 1) AND(VC <> 2) THEN Q = 1
1200 IF VC = 1 THEN IF CH <> 2 THEN Q = 1
1210 IF VC = 2 THEN IF CH <> 1 THEN Q = 1
1220 IF Q = 1 THEN 1060
1230 GOSUB 1510
1240 GOSUB 1560: R(Z) = 1
1250 W = W + 1: GOSUB 1610
1260 V1 = V: H1 = H
1270 IF W <> 64 THEN 1060
1280 :
1290 B$ = "": IF W = 64 THEN GOSUB 1680
1300 HO = S + 1: VE = 20: GOSUB 110: PRINT L$
1310 B$ = B$ + " Nog een keer ?  J/n ": GOSUB 1970
1320 GOSUB 2100: IF T = 1 THEN 1040
1330 GOSUB 2250
1340 END
1350 :
1360 REM invoer
1370 GOSUB 120
1380 GOSUB 2050: IF TS = 13 THEN 1470
1390 IF(IN$ = "S") OR(IN$ = "s") OR(IN$ = "0") THEN 1420
1400 IF(IN$ = "V") OR(IN$ = "v") THEN 1440
1410 IF VAL(IN$) = 0 THEN 1380
1420 IF LEN(Z$) = 2 THEN 1380
1430 Z$ = Z$ + IN$: PRINT IN$; : HO = HO + 1: GOTO 1380
1440 IF Z$ = "" THEN 1380
1450 HO = HO - 1: GOSUB 110: PRINT" "; : GOSUB 110
1460 L = LEN(Z$): IF L > 1 THEN Z$ = LEFT$(Z$, L - 1): GOTO 1380
1465 Z$ = ""
1470 IF Z$ = "" THEN 1380
1480 RETURN
1490 :
1500 REM veld leeg
1510 HO = S + H1 * 2 + H1 - 1: VE = V1 * 2
1520 GOSUB 110: PRINT"  ";
1530 RETURN
1540 :
1550 REM plaats ##
1560 HO = S + H * 2 + H - 1: VE = V * 2
1570 GOSUB 110: PRINT"##";
1580 RETURN
1590 :
1600 REM print stand
1610 SR = W: GOSUB 310: HO = S + 35: VE = 6
1620 GOSUB 110: PRINT SR$: VE = 8
1630 SR = 64 - W: GOSUB 310
1640 GOSUB 110: PRINT SR$
1650 RETURN
1660 :
1670 REM bord leeg
1680 GOSUB 1510: FOR I = 1 TO 10: GOSUB 1740
1690 GOSUB 1570: GOSUB 1740: GOSUB 1520
1700 NEXT I: B$ = "Gefeliciteerd !"
1710 RETURN
1720 :
1730 REM knipper vertraging
1740 FOR V = 1 TO 4: GOSUB 2170: NEXT V
1750 RETURN
1760 :
1770 REM teken speelbord
1780 FOR I = 1 TO 64: R(I) = 0: NEXT I
1790 GOSUB 100: PRINT: FOR I = 0 TO 8
1800 PRINT S$; " +--+--+--+--+--+--+--+--+"
1810 IF I < 8 THEN PRINT S$; " :";
1820 FOR J = 1 TO 8: IF I = 8 THEN 1840
1830 SR = I * 8 + J: GOSUB 310: PRINT SR$; ":";
1840 NEXT J: PRINT: NEXT I: W = 0: HO = S + 28
1850 VE = 6: B$ = " Weg    0": GOSUB 1970
1860 VE = 8: B$ = " Over  64": GOSUB 1970
1870 VE = 14: B$ = " V = Verb.": GOSUB 1970
1880 VE = 16: B$ = " S = Stop": GOSUB 1970
1890 RETURN
1900 :
1910 REM ongeldige zet
1920 GOSUB 250: B$ = "Ongeldige zet !!"
1930 GOSUB 1970: GOSUB 2210: GOSUB 110
1940 PRINT L$: RETURN
1950 :
1960 REM plaats tekst
1970 GOSUB 110
1980 FOR I = 1 TO LEN(B$)
1990 GOSUB 2170
2000 PRINT MID$(B$, I, 1);
2010 NEXT I
2020 RETURN
2030 :
2040 REM leeg buffer haal toets
2050 GOSUB 200: IF IN$ <> "" THEN 2050
2060 GOSUB 210: TS = ASC(IN$)
2070 RETURN
2080 :
2090 REM Ja / Nee
2100 T = 0: GOSUB 2050
2110 IF(TS = 13) OR(IN$ = "J") OR(IN$ = "j") THEN T = 1
2120 IF(IN$ = "N") OR(IN$ = "n") THEN T = 2
2130 IF T = 0 THEN 2100
2140 RETURN
2150 :
2160 REM pauze kort
2170 FOR J = 1 TO VT: NEXT J
2180 RETURN
2190 :
2200 REM pauze lang
2210 FOR I = 1 TO 20 * VT: NEXT I
2220 RETURN
2230 :
2240 REM afsluiting
2250 GOSUB 100: IF W = 64 THEN 2380
2260 PRINT: PRINT
2270 PRINT S$; "     Wil het niet lukken..."
2280 PRINT
2290 PRINT S$; " Stuur dan een gefrankeerde - en aan"
2300 PRINT S$; " U zelf geadresseerde enveloppe naar,"
2310 PRINT
2320 PRINT S$; "     L.Looyenga"
2330 PRINT S$; "     Stamperweg 1"
2340 PRINT S$; "     3813 SZ Amersfoort"
2350 PRINT
2360 PRINT S$; " U ontvangt dan een oplossing."
2370 :
2380 HO = S + 2: VE = 14: B$ = "Tot een volgende keer."
2390 GOSUB 1970: PRINT: PRINT
2400 RETURN
2410 :
2420 REM init + scherm opmeten
2430 R(0) = 1: CT = 2: CN = 0: Q = 0
2440 L$ = "": FOR I = 1 TO 25: L$ = L$ + " ": NEXT I
2450 VE = 0: FOR I = 0 TO 150
2460 PRINT"*"; : GOSUB 120
2470 PH = I: IF VE <> 0 THEN I = 150
2480 NEXT I: GOSUB 100
2490 S$ = " ": IF PH <= 39 THEN 2520
2500 X = INT((PH - 39) / 2)
2510 FOR I = 2 TO X: S$ = S$ + " ": NEXT I
2520 S = LEN(S$): GOSUB 3400
2530 RETURN
2540 :
2550 REM titelscherm uitleg
2560 K$ = "SCHOONSPRINGEN   "
2570 R$ = "": X = INT(PH / LEN(K$)) + 1
2580 FOR I = 1 TO X: R$ = R$ + K$: NEXT I
2590 FOR I = 1 TO 22: HO = I + 1: VE = I: GOSUB 110
2600 PRINT LEFT$(R$, PH - I - 1): NEXT I
2610 HO = 0: VE = 17: B$ = " een": GOSUB 1970
2620 VE = 18: B$ = " programma": GOSUB 1970
2630 VE = 19: B$ = " van": GOSUB 1970
2640 VE = 20: B$ = " L.D.R.P.Looyenga": GOSUB 1970
2650 VE = 22: B$ = " Wil je uitleg ? J/n ": GOSUB 1970
2660 GOSUB 2100: IF T = 2 THEN 3180
2670 :
2680 GOSUB 100: PRINT: PRINT
2690 PRINT S$; " De opzet van dit denkspel is - met"
2700 PRINT S$; " de paardesprong - alle 64 velden"
2710 PRINT S$; " van het speelbord schoon te maken."
2720 PRINT
2730 PRINT S$; " De velden zijn genummerd  1 t/m 64."
2740 PRINT
2750 PRINT S$; " Als het startveld is opgegeven komt"
2760 PRINT S$; " daar ## te staan."
2770 PRINT
2780 PRINT S$; " Nu moet er een sprong getal ingetikt"
2790 PRINT S$; " worden, waarna de ##  naar het veld"
2800 PRINT S$; " met dit getal springt. Een zet naar"
2810 PRINT S$; " een leeg veld is ongeldig."
2820 PRINT
2830 PRINT S$; " S  i.p.v. een getal is stoppen en"
2840 PRINT S$; " eventueel opnieuw beginnen."
2850 PRINT
2860 PRINT S$; " Met V wordt een tikfout verbeterd."
2870 PRINT: PRINT
2880 PRINT S$; "      Verder na een toets... ";
2890 GOSUB 2050
2900 :
2910 GOSUB 100: PRINT: PRINT
2920 PRINT S$; "      De toegestane zetten zijn:"
2930 PRINT: PRINT: PRINT: L1$ = LEFT$(L$, 10)
2940 PRINT S$; L1$; "   +--+  +--+"
2950 PRINT S$; L1$; "   :  :  :  :"
2960 PRINT S$; L1$; "+--+--+  +--+--+"
2970 PRINT S$; L1$; ":  :        :  :"
2980 PRINT S$; L1$; "+--+  +--+  +--+"
2990 PRINT S$; L1$; "      :  :"
3000 PRINT S$; L1$; "+--+  +--+  +--+"
3010 PRINT S$; L1$; ":  :        :  :"
3020 PRINT S$; L1$; "+--+--+  +--+--+"
3030 PRINT S$; L1$; "   :  :  :  :"
3040 PRINT S$; L1$; "   +--+  +--+"
3050 GOSUB 3210
3060 PRINT S$; "Nog een keer de zetten ?   J/n ";
3070 GOSUB 2100: IF T = 2 THEN 3180
3080 :
3090 GOSUB 100: PRINT: PRINT
3100 PRINT S$; "  Nogmaals de toegestane zetten:"
3110 PRINT: PRINT
3120 U1$ = S$ + L1$ + ":  :  :  :  :  :"
3130 U2$ = S$ + "        --+--+--+--+--+--+--"
3140 FOR I = 1 TO 6: PRINT U1$: PRINT U2$: NEXT I
3150 PRINT U1$: GOSUB 3210
3160 PRINT S$; "Na een toets gaan we spelen... ";
3170 GOSUB 2050
3180 VT = INT(VT / 3): RETURN
3190 :
3200 REM zetten
3210 HO = S + 17: VE = 11: GOSUB 1570: GOSUB 2210
3220 RESTORE: FOR Z = 1 TO 8: READ Z$
3230 FOR I = 1 TO 4: IF I = 3 THEN 3270
3240 X = I: IF I = 4 THEN X = 3
3250 HO = S + VAL(MID$(Z$, (X - 1) * 5 + 1, 2))
3260 VE = VAL(MID$(Z$, (X - 1) * 5 + 3, 2))
3270 IF(I = 1) OR(I = 3) THEN GOSUB 1520
3280 IF(I = 2) OR(I = 4) THEN GOSUB 1570
3290 GOSUB 2170: NEXT I: GOSUB 2210
3300 IF Z = 8 THEN 3320
3310 HO = S + 17: VE = 11: GOSUB 1570: GOSUB 2210
3320 NEXT Z: HO = 2: VE = 20: GOSUB 110
3330 RETURN
3340 :
3400 VT = 40: RETURN: REM vertraging
3410 :
25000 DATA"1711 1411 1109","1711 1709 1407"
25010 DATA"1711 1709 2007","1711 2011 2309"
25020 DATA"1711 2011 2313","1711 1713 2015"
25030 DATA"1711 1713 1415","1711 1411 1113"
30000 REM U kunt de snelheid in enkele
30010 REM onderdelen van het programma
30020 REM wijzigen met de waarde van
30030 REM VT in regel 3400
30040 REM
30050 REM Programma geschreven in
30060 REM BASICODE 2  door:
30070 REM
30080 REM L.D.R.P.Looyenga
30090 REM Stamperweg 1
30100 REM 3813 SZ Amersfoort
30110 REM
30120 REM op een Yuppie PC
30130 REM
30140 REM november 1990
30150 REM
30160 REM Copyright NOS Hilversum
