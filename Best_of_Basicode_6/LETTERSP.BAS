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
 1000 A=1000:GOTO 20:REM LETTERSPEL
 1010 GOSUB 100:PRINT"een ogenblik geduld a.u.b"
 1020 REM INLEZEN DATA
 1030 V=0:FB=12:C$="":K=0:W=0:TL=0
 1040 READ A$:IF A$="**" THEN 1060
 1050 W=W+1:TL=TL+LEN(A$):GOTO 1040
 1060 DIM C$(W)
 1070 RESTORE
 1080 FOR I=1 TO W:READ C$(I):NEXT I
 1090 REM LOGO + INSTRUCTIE
 1100 GOSUB 20000
 1110 REM HOOFDPROGRAMMA
 1120 GOSUB 1380:GOSUB 1260
 1130 GOSUB 1550:GOSUB 1460:GOSUB 1290:GOSUB 1650
 1140 IF C$<>Z$ THEN 1130
 1150 GOSUB 100:VE=5:HO=5:GOSUB 110
 1160 PRINT"Wil je nog een woord doen?:j/n";
 1170 GOSUB 210
 1180 GOSUB 3000
 1190 IF IN$="j" THEN 1220
 1200 IF IN$="n" THEN 20440
 1210 GOTO 1170
 1220 IF K<W THEN 1110
 1230 VE=7:HO=8:GOSUB 110
 1240 PRINT"Meer woorden zijn er niet"
 1250 FOR I=1 TO 2500:NEXT I:GOTO 20440
 1260 L=LEN(C$)
 1270 Z$=LEFT$("------------------------------",L)
 1280 RETURN
 1290 REM ZOEKSTRING MAKEN
 1300 V=0:FOR I=1 TO L
 1310 IF MID$(C$,I,1)<>L$ THEN 1350
 1320 V=V+1
 1330 IF I<2 THEN Z$=L$+MID$(Z$,I+1,L):GOTO 1350
 1340 Z$=LEFT$(Z$,I-1)+L$+MID$(Z$,I+1,L)
 1350 NEXT I
 1360 B=B+1:IF V=0 THEN F=F+1
 1370 RETURN
 1380 REM WOORD GENEREREN
 1390 GOSUB 260:I=INT(RV*W+1)
 1400 IF C$(I)="*" THEN 1380
 1410 C$=C$(I)
 1420 C$(I)="*"
 1430 K=K+1
 1440 B=0:F=0:P=0:G$=""
 1450 RETURN
 1460 REM LETTER HALEN
 1470 VE=12:HO=2:GOSUB 110
 1480 PRINT"Welke letter denk je nodig te hebben:"
 1490 VE=14:HO=15:GOSUB 110:PRINT"      "
 1500 VE=14:HO=5:GOSUB 110:PRINT"DE LETTER ";:INPUT L$
 1510 IF L$="" THEN GOSUB 250:GOTO 1490
 1520 IN$=LEFT$(L$,1)
 1530 GOSUB 3000:L$=IN$
 1540 G$=G$+L$+",":RETURN
 1550 REM SCHERM OPBOUW
 1560 VE=5:HO=2:GOSUB 110:PRINT"                    ";
 1570 PRINT"                     "
 1580 VE=18:HO=10:GOSUB 110:PRINT"                         "
 1590 VE=20:HO=10:GOSUB 110:PRINT"                         "
 1600 VE=2:HO=3:GOSUB 110:PRINT"BEURT ";B-P
 1610 HO=20:GOSUB 110:PRINT"AANTAL LETTERS:";L
 1620 VE=5:HO=2:GOSUB 110:PRINT"GEBRUIKTE LETTERS ";G$
 1630 VE=9:HO=5:GOSUB 110:PRINT"WOORD? ";Z$
 1640 RETURN
 1650 REM TEST OPLOSSING
 1660 IF(V=0) AND(F>=FB) THEN 1830
 1670 IF V=0 THEN RETURN
 1680 VE=18:HO=10:GOSUB 110:PRINT Z$
 1690 VE=20:HO=10:GOSUB 110:PRINT"OPLOSSING: ";:INPUT S$
 1700 GOSUB 2000:IF S$=C$ THEN 1730
 1710 P=P+1:IF B<=1 THEN P=0
 1720 RETURN
 1730 GOSUB 100:VE=2:HO=5:GOSUB 110:PRINT C$
 1740 REM GOEDE OPLOSSING
 1750 VE=5:HO=2:GOSUB 110
 1760 PRINT"Dit was de goede oplossing"
 1770 VE=7:HO=6:GOSUB 110
 1780 E$=" beurten"
 1790 IF B<=1 THEN B$=LEFT$(E$,6)+"."
 1800 IF B>1 THEN B$=E$+"."
 1810 PRINT"Geraden in totaal ";B;B$
 1820 FOR I=1 TO 2500:NEXT I:GOTO 1880
 1830 REM FOUTE OPLOSSING
 1840 GOSUB 100:VE=5:HO=6:GOSUB 110
 1850 PRINT"Maximum beurten bereikt."
 1860 VE=7:HO=4:GOSUB 110
 1870 PRINT"De oplossing is:";C$
 1880 Z$=C$:FOR I=1 TO 2500:NEXT I:RETURN
 2000 REM Converteer S$
 2010 SR$="":IF S$="" THEN RETURN
 2020 FOR I=1 TO LEN(S$)
 2030 IN$=MID$(S$,I,1):GOSUB 3000
 2040 SR$=SR$+IN$
 2050 NEXT I
 2060 S$=SR$:RETURN
 3000 REM Verander hoofdletter in kleine letter
 3010 IF(IN$<"A") OR(IN$>"Z") THEN RETURN
 3020 IN$=CHR$(ASC(IN$)-ASC("A")+ASC("a"))
 3030 RETURN
20000 REM LOGO
20010 GOSUB 100:VE=2:HO=4:GOSUB 110
20020 PRINT"*    **** ***** ***** **** *****"
20030 VE=3:HO=4:GOSUB 110
20040 PRINT"*    *      *     *   *    *   *"
20050 VE=4:HO=4:GOSUB 110
20060 PRINT"*    *      *     *   *    *   *"
20070 VE=5:HO=4:GOSUB 110
20080 PRINT"*    ***    *     *   ***  *****"
20090 VE=6:HO=4:GOSUB 110
20100 PRINT"*    *      *     *   *    * *"
20110 VE=7:HO=4:GOSUB 110
20120 PRINT"*    *      *     *   *    *  *"
20130 VE=8:HO=4:GOSUB 110
20140 PRINT"**** ****   *     *   **** *   *"
20150 VE=13:HO=9:GOSUB 110:PRINT"***** ***** ***** *"
20160 VE=14:HO=9:GOSUB 110:PRINT"*     *   * *     *"
20170 VE=15:HO=9:GOSUB 110:PRINT"*     *   * *     *"
20180 VE=16:HO=9:GOSUB 110:PRINT"*     *   * *     *"
20190 VE=17:HO=9:GOSUB 110:PRINT"***** ***** ***   *"
20200 VE=18:HO=13:GOSUB 110:PRINT"* *     *     *"
20210 VE=19:HO=13:GOSUB 110:PRINT"* *     *     *"
20220 VE=20:HO=13:GOSUB 110:PRINT"* *     *     *"
20230 VE=21:HO=9:GOSUB 110:PRINT"***** *     ***** *****"
20240 FOR I=1 TO 5000:NEXT I
20250 REM INSTRUCTIE
20260 GOSUB 100:VE=1:HO=14:GOSUB 110:PRINT"LETTER SPEL"
20270 PRINT:PRINT:PRINT"In dit spel moet je proberen";
20280 PRINT" een woord"
20290 PRINT"te vinden door letter voor letter dit"
20300 PRINT"in te tikken."
20310 PRINT"Er wordt aangegeven uit hoeveel letters"
20320 PRINT"het woord bestaat en welke letters je"
20330 PRINT"al gebruikt hebt."
20340 PRINT"Als je na 12 letters het woord nog niet"
20350 PRINT"gevonden hebt, het raden naar het woord"
20360 PRINT"wordt daarbij niet meegeteld, dan geeft"
20370 PRINT"de computer het antwoord."
20380 VE=22:HO=13:GOSUB 110:PRINT"DRUK EEN TOETS":GOSUB 210
20390 GOSUB 100:VE=5:HO=0:GOSUB 110
20400 PRINT"In dit spel zitten ";W;" woorden met in"
20410 VE=7:GOSUB 110:PRINT"het totaal ";TL;" letters."
20420 VE=22:HO=13:GOSUB 110:PRINT"DRUK EEN TOETS"
20430 GOSUB 210:GOSUB 100:RETURN
20440 REM EINDE PROGRAMMA
20450 GOSUB 100:VE=2:HO=0:GOSUB 110
20460 FOR I=1 TO 40:PRINT"*";:NEXT I
20470 VE=7:HO=10:GOSUB 110:PRINT"TOT"
20480 VE=10:HO=15:GOSUB 110:PRINT"DE"
20490 VE=13:HO=20:GOSUB 110:PRINT"VOLGENDE"
20500 VE=16:HO=30:GOSUB 110:PRINT"KEER"
20510 VE=20:HO=0:GOSUB 110
20520 FOR I=1 TO 40:PRINT"*";:NEXT I
20530 FOR I=1 TO 5000:NEXT I:FOR X=1 TO 4:GOSUB 250:NEXT X
20540 END
25000 REM DATA WOORDEN
25010 DATA"flatgebouw","radio","tuin","computer","auto"
25020 DATA"hobbyscoop","telescoop","weerstand","huis"
25030 DATA"kleur","garage","jaargetijde","basisschool"
25040 DATA"meester","slager","bakker","torenflat"
25050 DATA"benzinepomp","commodore","automonteur"
25060 DATA"geboorte","dagboek","krant","politieagent"
25070 DATA"videorecorder","belasting","aanslag","basicode"
25080 DATA"huismeester","tegelzetter","hovenier","school"
25090 DATA"woord","krachtveld","landschap","taxi","caravan"
25100 DATA"dokter","minimum","meisje","achterlicht","boek"
25110 DATA"ongeveer","wapenkunde","verouderd","sterrenkunde"
25120 DATA"klinkers","medeklinkers","woordenboek","bijbel"
25130 DATA"vrouwelijk","meervoud","grammatica","camping"
25140 DATA"nederlander","aap","adamsappel","adder","fluit"
25150 DATA"afhangen","afkoelen","keren","afstandsbediening"
25160 DATA"alfabet","algebra","arreslee","rechtbank"
25170 DATA"bakboord","autoband","balpen","bloemencorso"
25180 DATA"boom","brood","rekenen","taal","trommel"
25190 DATA"gemeente","trouwring","gespannen","timmerman"
25200 DATA"gevaar","gips","potlood","grafkamer","gympjes"
25210 DATA"hapje","instorten","klant","klap","leugenaar"
25220 DATA"medewerking","nazomer","winter","sneeuwpop","lat"
25230 DATA"vissen","overladen","pijpsleutel","pinksteren"
25240 DATA"roken","schietbaan","schilmesje","schrikkeljaar"
25250 DATA"hamer","raadslid","burgemeester","stekker","klap"
25260 DATA"tractor","stempel","stoomboot","stofzuiger"
25270 DATA"talent","tekenbord","terras","testbeeld","toon"
25280 DATA"woordenbestand","oplossing","automatisering"
25290 DATA"**"
30000 REM
30010 REM********** JAN.1987 *********
30020 REM
30030 REM LETTERSPEL GEMAAKT
30040 REM
30050 REM DOOR
30060 REM
30070 REM R.J. V/D ZEE
30080 REM
30090 REM BRAAMKAMP 40
30100 REM
30110 REM 7206 HB ZUTPHEN
30120 REM
30130 REM TEL. 05750-21736
30140 REM
30150 REM*****************************
30160 REM
30170 REM COPYRIGHT NOS HIVERSUM
