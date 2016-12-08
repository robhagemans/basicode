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
 1000 A=2000:GOTO 20
 1010 REM> BRAILLE VERTALER <
 1020 DIM A$(42),B$(42),C$(42),L$(42)
 1030 FOR I=1 TO 42:READ A$(I),B$(I),C$(I),L$(I):NEXT I
 1040 REM> TITELBLAD <
 1050 GOSUB 100
 1060 VE=5:HO=0:GOSUB 110
 1070 PRINT"+-----------------------------------+"
 1080 PRINT"!:::::::::::::::::::::::::::::::::::!"
 1090 PRINT"!:: HET   B R A I L L E   SCHRIFT ::!"
 1100 PRINT"!:: ***************************** ::!"
 1110 PRINT"!:::::::::::::::::::::::::::::::::::!"
 1120 PRINT"+-----------------------------------+"
 1130 VE=20:HO=0:GOSUB 110
 1140 PRINT"Walther van den Elshout <> Basicode-2"
 1150 PRINT"***********************   (C)Aug.1988"
 1160 GOSUB 210
 1170 REM> MENU <
 1180 GOSUB 100
 1190 PRINT"====================================="
 1200 PRINT"!! MAAK EEN KEUZE UIT DIT  M E N U !!"
 1210 PRINT"====================================="
 1220 PRINT:PRINT"Informatie over braille ........... 1"
 1230 PRINT:PRINT"Demonstratie van alle brailletekens 2"
 1240 PRINT:PRINT"Lettertekens naar braille ......... 3"
 1250 PRINT:PRINT"Braille naar lettertekens ......... 4"
 1260 PRINT:PRINT"Stoppen ........................... 0"
 1270 PRINT
 1280 PRINT"====================================="
 1290 PRINT"!! MAAK EEN KEUZE UIT DIT  M E N U !!"
 1300 PRINT"====================================="
 1310 VE=20:HO=20:GOSUB 110
 1320 PRINT"KEUZE =>";:GOSUB 210
 1330 IF IN$="1" THEN 1390
 1340 IF IN$="2" THEN 1580
 1350 IF IN$="3" THEN 1710
 1360 IF IN$="4" THEN 2030
 1370 IF IN$="0" THEN 2470
 1380 GOSUB 250:GOTO 1310
 1390 REM> INFORMATIE <
 1400 GOSUB 100:PRINT"INFORMATIE OVER BRAILLE"
 1410 PRINT"***********************"
 1420 PRINT:PRINT"Louis Braille;"
 1430 PRINT:PRINT"               Zoals de naam al doet"
 1440 PRINT"vermoeden is Louis Braille de uitvinder"
 1450 PRINT"van het BRAILLE-schrift. Dit is een"
 1460 PRINT"schrift dat ontworpen is voor blinden"
 1470 PRINT"en slechtzienden. Zij lezen niet met"
 1480 PRINT"hun ogen maar met hun vingers. Door"
 1490 PRINT"het voelen van puntjes kunnen ze letter"
 1500 PRINT"voor letter lezen. Mensen die dat al"
 1510 PRINT"lang doen, kunnen dat net zo snel als"
 1520 PRINT"gewoon lezen. Met dit programma zie je"
 1530 PRINT"hoe het braille schrift gebruikt moet"
 1540 PRINT"worden."
 1550 VE=22:HO=0:GOSUB 110
 1560 PRINT"Druk op een toets voor het menu";:GOSUB 210
 1570 GOTO 1170
 1580 REM> DEMONSTRATIE <
 1590 GOSUB 100:PRINT"Het BRAILLE-schrift"
 1600 PRINT"==================="
 1610 VE=5:HO=0:GOSUB 110
 1620 FOR I=1 TO 42 STEP 3
 1630 PRINT A$(I);TAB(12);A$(I+1);TAB(24);A$(I+2)
 1640 PRINT B$(I);" > ";L$(I);TAB(12);B$(I+1);" > ";L$(I+1);
 1650 PRINT TAB(24);B$(I+2);" > ";L$(I+2)
 1660 PRINT C$(I);TAB(12);C$(I+1);TAB(24);C$(I+2)
 1670 PRINT:PRINT
 1680 IF I/2=INT(I/2) THEN GOSUB 2680
 1690 NEXT I
 1700 GOTO 1170
 1710 REM> LETTER NAAR BRAILLE <
 1720 GOSUB 100
 1730 PRINT"VAN LETTERTEKENS NAAR BRAILLE"
 1740 PRINT"*****************************"
 1750 VE=5:HO=0:GOSUB 110
 1760 PRINT"Toets een letterteken of cijfer in,"
 1770 PRINT"dan geef ik het braille-teken."
 1780 PRINT:PRINT"==>        ";:GOSUB 210
 1790 IF(IN$>="a") AND(IN$<="z") THEN GOSUB 2780
 1800 PRINT IN$
 1810 N=0
 1820 N=N+1
 1830 IF N>42 THEN 1860
 1840 IF IN$=L$(N) THEN 1880
 1850 GOTO 1820
 1860 PRINT:PRINT"Hiervoor is GEEN braille-teken !"
 1870 GOTO 1980
 1880 PRINT:PRINT"Het braille-teken is:"
 1890 VE=12:HO=10:GOSUB 110
 1900 IF N>32 THEN PRINT"+------+"
 1910 IF N<=32 THEN PRINT"+----+"
 1920 VE=13:GOSUB 110:PRINT"! ";A$(N);" !"
 1930 VE=14:GOSUB 110:PRINT"! ";B$(N);" !"
 1940 VE=15:GOSUB 110:PRINT"! ";C$(N);" !"
 1950 VE=16:GOSUB 110
 1960 IF N>32 THEN PRINT"+------+"
 1970 IF N<=32 THEN PRINT"+----+"
 1980 VE=20:HO=0:GOSUB 110
 1990 PRINT"1=Menu    <>    2=Ander letterteken";:GOSUB 210
 2000 IF IN$="1" THEN 1170
 2010 IF IN$="2" THEN 1710
 2020 GOTO 1980
 2030 REM> VAN BRAILLE NAAR LETTERS <
 2040 GOSUB 100
 2060 PRINT"VAN BRAILLE NAAR LETTERS"
 2070 PRINT"************************"
 2080 PRINT:PRINT"Elk braille-teken bestaat uit drie"
 2090 PRINT"regels."
 2100 PRINT"Je voert alleen de bovenste regel"
 2110 PRINT"(zonder spaties) in en de computer"
 2120 PRINT"geeft dan de mogelijke oplossing(en)."
 2130 PRINT:PRINT"-------------------------------------"
 2140 PRINT"Typ de bovenste regel en druk op"
 2150 PRINT"<RETURN>."
 2160 PRINT:PRINT"( Gebruik alleen  o  en  . )"
 2170 PRINT"                  ^      ^"
 2180 PRINT:PRINT"=>";:INPUT BT$
 2190 N=0
 2200 N=N+1:IF N>42 THEN 2340
 2210 IF A$(N)=BT$ THEN 2230
 2220 GOTO 2200
 2230 GOSUB 100:VE=8:HO=0:GOSUB 110
 2240 PRINT TAB(15);A$(N)
 2250 PRINT TAB(15);B$(N);"  > ";L$(N)
 2260 PRINT TAB(15);C$(N)
 2270 VE=20:HO=0:GOSUB 110
 2280 PRINT"V=verder  M=menu  N=nieuwe invoer";
 2290 GOSUB 210
 2300 IF(IN$="V") OR(IN$="v") THEN 2200
 2310 IF(IN$="M") OR(IN$="m") THEN 1170
 2320 IF(IN$="N") OR(IN$="n") THEN 2030
 2330 GOSUB 250:GOTO 2270
 2340 GOSUB 100
 2350 PRINT"Dit waren alle hierbij passende"
 2360 PRINT:PRINT"lettertekens."
 2370 PRINT:PRINT"Als er geen lettertekens op het"
 2380 PRINT:PRINT"beeldscherm zijn geweest dan wil"
 2390 PRINT:PRINT"dat zeggen dat dit brailleteken niet"
 2400 PRINT:PRINT"bestaat !"
 2410 VE=20:HO=0:GOSUB 110
 2420 PRINT"M = menu     N = Nieuwe invoer";
 2430 GOSUB 210
 2440 IF(IN$="m") OR(IN$="M") THEN 1170
 2450 IF(IN$="n") OR(IN$="N") THEN 2030
 2460 GOSUB 250:GOTO 2340
 2470 REM> EINDE <
 2480 GOSUB 100
 2490 FOR VE=0 TO 20:HO=0:GOSUB 110
 2500 PRINT":::::::::::::::::::::::::::::::::::::::"
 2510 NEXT VE
 2520 VE=6:HO=7:GOSUB 110
 2530 PRINT"* * ***** *******    ****"
 2540 VE=7:GOSUB 110
 2550 PRINT"* * *   * *   *  *   *"
 2560 VE=8:GOSUB 110
 2570 PRINT"* * *   * *   *  *******"
 2580 VE=9:GOSUB 110
 2590 PRINT"* * *   * *   *  *   *"
 2600 VE=10:GOSUB 110
 2610 PRINT" * *     *    ***    ****"
 2620 VE=12:GOSUB 110
 2630 PRINT"Walther  van den  Elshout"
 2640 VE=13:GOSUB 110
 2650 PRINT"(C)1988 BASICODE SOFTWARE"
 2660 VE=20:HO=0:GOSUB 110:END
 2670 REM> SPATIEBALK <
 2680 VE=22:HO=10:GOSUB 110
 2690 PRINT"< SPATIEBALK >";
 2700 FOR WA=1 TO 200:NEXT WA:GOSUB 200
 2710 GOSUB 110:PRINT"..............";
 2720 FOR WA=1 TO 200:NEXT WA
 2730 IF IN$=" " THEN 2750
 2740 GOTO 2680
 2750 HO=0:FOR VE=5 TO 14:GOSUB 110
 2760 PRINT"                                     "
 2770 NEXT VE:VE=5:GOSUB 110:RETURN
 2780 REM> HOOFDLETTERMODE <
 2790 W=ASC(IN$):W=W+(ASC("A")-ASC("a")):IN$=CHR$(W):RETURN
25000 DATA"o.","..","..","A"
25010 DATA"o.","o.","..","B"
25020 DATA"oo","..","..","C"
25030 DATA"oo",".o","..","D"
25040 DATA"o.",".o","..","E"
25050 DATA"oo","o.","..","F"
25060 DATA"oo","oo","..","G"
25070 DATA"o.","oo","..","H"
25080 DATA".o","o.","..","I"
25090 DATA".o","oo","..","J"
25100 DATA"o.","..","o.","K"
25110 DATA"o.","o.","o.","L"
25120 DATA"oo","..","o.","M"
25130 DATA"oo",".o","o.","N"
25140 DATA"o.",".o","o.","O"
25150 DATA"oo","o.","o.","P"
25160 DATA"oo","oo","o.","Q"
25170 DATA"o.","oo","o.","R"
25180 DATA".o","o.","o.","S"
25190 DATA".o","oo","o.","T"
25200 DATA"o.","..","oo","U"
25210 DATA"o.","o.","oo","V"
25220 DATA".o","oo",".o","W"
25230 DATA"oo","..","oo","X"
25240 DATA"oo",".o","oo","Y"
25250 DATA"o.",".o","oo","Z"
25260 DATA"..","oo",".o","."
25270 DATA"..","o.","o.",","
25280 DATA"..","o.",".o","?"
25290 DATA"..","..","o.","!"
25300 DATA"..","..",".o","HfdL."
25310 DATA".o",".o","oo","Cyfer"
25320 DATA".oo.",".o..","oo..","1"
25330 DATA".oo.",".oo.","oo..","2"
25340 DATA".ooo",".o..","oo..","3"
25350 DATA".ooo",".o.o","oo..","4"
25360 DATA".oo.",".o.o","oo..","5"
25370 DATA".ooo",".oo.","oo..","6"
25380 DATA".ooo",".ooo","oo..","7"
25390 DATA".oo.",".ooo","oo..","8"
25400 DATA".o.o",".oo.","oo..","9"
25410 DATA".o.o",".ooo","oo..","0"
30000 REM%%%%%%%%%%%%%%%%%%%%%%%%%%%
30010 REM%                         %
30020 REM% WALTHER VAN DEN ELSHOUT %
30030 REM% GEN. WICHERSLAAN 14     %
30040 REM% 5623 GS  EINDHOVEN      %
30050 REM% TEL: 040-451098         %
30060 REM%                         %
30070 REM% COMMODORE 64            %
30080 REM%                         %
30090 REM% NOVEMBER 1988           %
30100 REM% COPYRIGHT NOS HILVERSUM %
30110 REM%                         %
30120 REM%%%%%%%%%%%%%%%%%%%%%%%%%%%
