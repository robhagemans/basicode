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
 1000 A=500:GOTO 20
 1010 REM*** MORSESEINEN ***
 1020 DIM L$(36),T$(36)
 1030 FOR X=1 TO 36:READ L$(X),T$(X):NEXT X
 1100 REM*** TITEL ***
 1110 GOSUB 100
 1120 PRINT" X   X   XXXXX   XXXXX   XXXXX   XXXXX"
 1130 PRINT" XX XX   X   X   X   X   X       X"
 1140 PRINT" X X X   X   X   XXXXX   XXXXX   XXX"
 1150 PRINT" X   X   X   X   X  X        X   X"
 1160 PRINT" X   X   XXXXX   X   X   XXXXX   XXXXX"
 1170 VE=15:HO=12:GOSUB 110
 1180 PRINT"S E I N E N";
 1190 GOSUB 250:FOR WA=1 TO 50:NEXT WA
 1200 GOSUB 110:PRINT"           ";
 1210 GOSUB 250
 1220 GOSUB 200:IF IN$<>"" THEN 1240
 1230 GOTO 1170
 1240 GOSUB 100:VE=0:HO=2:GOSUB 110
 1250 PRINT"M O R S E S E I N E N    L E R E N"
 1260 VE=1:GOSUB 110
 1270 PRINT"-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
 1275 PRINT
 1280 PRINT"Na de ontdekking van de elektriciteit"
 1290 PRINT"ontwikkelde Samuel MORSE de elektrische"
 1300 PRINT"telegraaf. (tele=ver/grapho=schrijven)"
 1310 PRINT"Deze telegraaf kon lange en korte piep-"
 1320 PRINT"toontjes langs elektrische draden door-"
 1330 PRINT"seinen. Morse bedacht voor iedere let-"
 1340 PRINT"ter van het alfabet en voor de cijfers"
 1350 PRINT"van 1 tot 10 een geluidssignaal."
 1360 PRINT"We noemen dit het MORSE-ALFABET."
 1370 PRINT"De meest gebruikte letter, de E, gaf"
 1380 PRINT"een kort signaal: de punt. Het lange"
 1390 PRINT"signaal noemen we streep. Hiermee werd"
 1400 PRINT"de letter T aangeduid."
 1410 PRINT"De andere letters en cijfers duidde hij"
 1420 PRINT"aan met meerdere punten en strepen."
 1425 PRINT"Voor het gemak noemen we in dit pro-"
 1426 PRINT"gramma de cijfers ook letters."
 1430 PRINT"Het hele morsestelsel ziet er als"
 1440 PRINT"volgt uit:"
 1450 GOSUB 10000
 1460 GOSUB 100
 1470 PRINT"Het MORSE-alfabet"
 1480 PRINT"================="
 1490 VE=2:FOR X=1 TO 12
 1500 VE=VE+1:HO=0:GOSUB 110
 1510 PRINT L$(X);" ";T$(X)
 1520 NEXT X
 1530 VE=2:FOR X=13 TO 24
 1540 VE=VE+1:HO=15:GOSUB 110
 1550 PRINT L$(X);" ";T$(X)
 1560 NEXT X
 1570 VE=2:FOR X=25 TO 36
 1580 VE=VE+1:HO=30:GOSUB 110
 1590 PRINT L$(X);" ";T$(X)
 1600 NEXT X
 1610 GOSUB 10000
 1620 REM*** MENU ***
 1630 GOSUB 100:VE=3:HO=0:GOSUB 110
 1640 PRINT"+-------------------------------------+"
 1650 PRINT"!                                     !"
 1660 PRINT"! NOG EEN KEER UITLEGGEN .......... 1 !"
 1670 PRINT"!                                     !"
 1680 PRINT"! VAN MORSE NAAR LETTERS .......... 2 !"
 1690 PRINT"!                                     !"
 1700 PRINT"! VAN LETTERS NAAR MORSE .......... 3 !"
 1710 PRINT"!                                     !"
 1720 PRINT"! TEST LETTERS <> MORSE ........... 4 !"
 1730 PRINT"!                                     !"
 1740 PRINT"! TEST MORSE <> LETTERS ........... 5 !"
 1750 PRINT"!                                     !"
 1760 PRINT"! S T O P P E N ................... 6 !"
 1770 PRINT"!                                     !"
 1780 PRINT"+-------------------------------------+"
 1790 VE=22:HO=28:GOSUB 110:PRINT"Keuze => ..";
 1800 GOSUB 210
 1810 IF IN$="1" THEN 1240
 1820 IF IN$="2" THEN 2000
 1830 IF IN$="3" THEN 3000
 1840 IF IN$="4" THEN 4000
 1850 IF IN$="5" THEN 5000
 1860 IF IN$="6" THEN 6000
 1870 GOTO 1800
 2000 REM* VAN MORSE NAAR LETTERS *
 2010 GOSUB 100:Q=0
 2020 PRINT"VAN MORSE NAAR LETTERS"
 2030 PRINT"######################"
 2040 VE=4:HO=0:GOSUB 110
 2050 PRINT"======================================="
 2060 VE=8:GOSUB 110
 2070 PRINT"======================================="
 2080 VE=6:GOSUB 110
 2085 PRINT"Geef MORSE teken + <RETURN> =>";
 2086 INPUT MT$
 2090 FOR X=1 TO 36:IF MT$=T$(X) THEN Q=1:LR$=L$(X)
 2100 NEXT X
 2110 VE=12:GOSUB 110
 2120 IF Q=1 THEN PRINT"De letter is: ";LR$
 2121 IF Q=1 THEN PRINT"              ="
 2130 IF Q=0 THEN PRINT"Dit teken is geen MORSE-teken !"
 2140 VE=20:GOSUB 110
 2150 PRINT"Nieuw morseteken = 1          Menu = 2";
 2160 GOSUB 210
 2170 IF IN$="1" THEN 2000
 2180 IF IN$="2" THEN 1620
 2190 GOTO 2160
 3000 REM* VAN LETTERS NAAR MORSE *
 3010 GOSUB 100:Q=0
 3020 PRINT"VAN LETTERS NAAR MORSE"
 3030 PRINT"######################"
 3040 VE=4:HO=0:GOSUB 110
 3050 PRINT"======================================="
 3060 VE=8:GOSUB 110
 3070 PRINT"======================================="
 3080 VE=6:GOSUB 110
 3085 PRINT"Geef LETTERteken => ";
 3086 GOSUB 210:LT$=IN$
 3087 A=ASC("a"):B=ASC("z"):C=ASC(LT$):D=ASC("a")-ASC("A")
 3088 IF(C>=A) AND(C<=B) THEN C=C-D:LT$=CHR$(C)
 3089 PRINT LT$
 3090 FOR X=1 TO 36:IF LT$=L$(X) THEN Q=1:MT$=T$(X)
 3100 NEXT X
 3110 VE=12:GOSUB 110
 3120 IF Q=1 THEN PRINT"Het MORSE-teken is: ";MT$
 3130 IF Q=0 THEN PRINT"Voor dit teken is geen MORSE-teken !"
 3140 VE=20:GOSUB 110
 3150 PRINT"Nieuw letterteken = 1         Menu = 2";
 3160 GOSUB 210
 3170 IF IN$="1" THEN 3000
 3180 IF IN$="2" THEN 1620
 3190 GOTO 3160
 4000 REM* TEST LETTERS <> MORSE *
 4010 GOSUB 100
 4020 PRINT"TEST LETTERS <> MORSE"
 4030 PRINT"#####################"
 4040 PRINT"Ik geef een letter en jij geeft het"
 4050 PRINT"MORSE-teken:"
 4060 PRINT"======================================="
 4070 GOSUB 260:Y=INT(36*RV)+1
 4080 VE=6:HO=0:GOSUB 110
 4090 PRINT"LETTERTEKEN = ";L$(Y)
 4100 VE=8:GOSUB 110
 4110 PRINT"======================================="
 4120 VE=10:GOSUB 110
 4130 PRINT"MORSETEKEN + <RETURN> = ";
 4140 INPUT MT$
 4150 VE=12:GOSUB 110
 4160 PRINT"======================================="
 4170 VE=14:HO=15:GOSUB 110
 4180 IF MT$=T$(Y) THEN PRINT"GOED ZO !!!":GOTO 4200
 4190 PRINT"JAMMER HOOR."
 4192 VE=18:HO=0:GOSUB 110
 4194 PRINT"Het MORSE-teken is: ";T$(Y)
 4200 VE=21:HO=0:GOSUB 110
 4210 PRINT"NOG EENS = 1                  MENU = 2";
 4220 GOSUB 210
 4230 IF IN$="1" THEN 4000
 4240 IF IN$="2" THEN 1620
 4250 GOTO 4220
 5000 REM* TEST MORSE <> LETTERS *
 5010 GOSUB 100
 5020 PRINT"TEST MORSE <> LETTERS"
 5030 PRINT"#####################"
 5040 PRINT"Ik geef een morse-teken en jij de"
 5050 PRINT"letter die erbij hoort:"
 5060 PRINT"======================================="
 5070 GOSUB 260:Y=INT(36*RV)+1
 5080 VE=6:HO=0:GOSUB 110
 5090 PRINT"MORSE-teken = ";T$(Y)
 5100 VE=8:GOSUB 110
 5110 PRINT"======================================="
 5120 VE=10:GOSUB 110
 5130 PRINT"LETTERteken = ";
 5140 GOSUB 210
 5142 A=ASC("a"):B=ASC("z"):C=ASC(IN$)
 5144 D=ASC("a")-ASC("A")
 5146 IF(C>=A) AND(C<=B) THEN C=C-D:IN$=CHR$(C)
 5148 PRINT IN$
 5150 VE=12:GOSUB 110
 5160 PRINT"======================================="
 5170 VE=14:HO=15:GOSUB 110
 5180 IF IN$=L$(Y) THEN PRINT"GOED ZO !!!":GOTO 5200
 5190 PRINT"JAMMER HOOR."
 5192 VE=18:HO=0:GOSUB 110
 5194 PRINT"Het LETTER-teken is: ";L$(Y)
 5200 VE=21:HO=0:GOSUB 110
 5210 PRINT"NOG EENS = 1                  MENU = 2";
 5220 GOSUB 210
 5230 IF IN$="1" THEN 5000
 5240 IF IN$="2" THEN 1620
 5250 GOTO 5220
 6000 REM*** EINDE ***
 6010 GOSUB 100
 6020 VE=5:HO=0:GOSUB 110
 6030 PRINT"***************************************"
 6040 FOR VE=6 TO 12:GOSUB 110
 6050 PRINT"*                                     *"
 6060 NEXT VE
 6070 PRINT"***************************************"
 6080 VE=7:HO=2:GOSUB 110
 6090 PRINT" DIT";:GOSUB 7000:PRINT" BASICODE-2";
 6100 GOSUB 7000:PRINT" PROGRAMMA"
 6105 VE=VE+1:HO=HO+1:GOSUB 110
 6110 GOSUB 7000:PRINT" WERD";
 6120 GOSUB 7000:PRINT" GEMAAKT";
 6130 GOSUB 7000:PRINT" DOOR";
 6135 VE=VE+1:HO=HO+1:GOSUB 110
 6140 GOSUB 7000:PRINT" WALTHER";
 6150 GOSUB 7000:PRINT" VAN DEN";
 6160 GOSUB 7000:PRINT" ELSHOUT";
 6165 VE=VE+2:HO=25:GOSUB 110
 6170 GOSUB 7000:PRINT" JUNI 1988";
 6180 GOSUB 250:GOSUB 250:GOSUB 250
 6200 VE=18:HO=0:GOSUB 110
 6210 PRINT"C O P Y R I G H T   N O S     HILVERSUM"
 6220 END
 7000 GOSUB 250:FOR WA=1 TO 500:NEXT WA:RETURN
10000 REM*** TOETS ROUTINE ***
10010 VE=22:HO=15:GOSUB 110
10020 PRINT"<TOETS>";
10030 GOSUB 110
10035 FOR WA=1 TO 99:NEXT WA
10040 PRINT"=-----=";
10050 GOSUB 200:IF IN$<>"" THEN RETURN
10060 FOR WA=1 TO 99:NEXT WA
10070 GOTO 10000
25000 DATA"A",".-","B","-...","C","-.-.","D","-.."
25010 DATA"E",".","F","..-.","G","--.","H","...."
25020 DATA"I","..","J",".---","K","-.-","L",".-.."
25030 DATA"M","--","N","-.","O","---","P",".--."
25040 DATA"Q","--.-","R",".-.","S","...","T","-"
25050 DATA"U","..-","V","...-","W",".--","X","-..-"
25060 DATA"Y","-.--","Z","--.."
25070 DATA"1",".----","2","..---","3","...--"
25080 DATA"4","....-","5",".....","6","-...."
25090 DATA"7","--...","8","---..","9","----."
25100 DATA"0","-----"
30000 REM****************************
30010 REM*  M O R S E S E I N E N   *
30020 REM*  =====================   *
30030 REM*                          *
30040 REM* WALTHER VAN DEN ELSHOUT  *
30050 REM* VAN GORKUMLAAN 151       *
30060 REM* 5641 WP  EINDHOVEN       *
30070 REM*                          *
30080 REM* AQUARIUS 40KAR./16K      *
30090 REM*                          *
30100 REM* COPYRIGHT NOS  HILVERSUM *
30110 REM****************************
