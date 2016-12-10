1000 A=3000:GOTO 20:REM Duitse naamvallen
1010 REM 
1020 REM link
1030 REM 
1040 GOSUB 20250:REM scherm opmeten
1050 GOSUB 22050:REM uitleg
1060 GOSUB 20010:REM initialisatie
1070 GOSUB 20370:REM menu
1080 GOTO 1070
20000 REM 
20010 REM initialisatie
20020 REM 
20030 GOSUB 21900
20040 DIM NV$(12,11),D$(31),VB$(12,1)
20050 DIM S(2),N$(4,1),R(2,3),F$(12)
20060 FOR X=1 TO 31:READ D$(X):NEXT X
20070 FOR X=0 TO 11
20080 FOR Y=0 TO 12
20090 READ N:NV$(Y,X)=D$(N)
20100 NEXT Y:NEXT X
20110 FOR X=0 TO 12
20120 FOR Y=0 TO 1
20130 READ VB$(X,Y):NEXT Y:NEXT X
20140 FOR X=0 TO 4
20150 FOR Y=0 TO 1
20160 READ N$(X,Y):NEXT Y:NEXT X
20170 FOR X=0 TO 12:READ F$(X):NEXT X
20180 RETURN
20190 REM 
20200 REM centreer
20210 REM 
20220 GOSUB 120:HO=(H-LEN(S$))/2:GOSUB 110
20230 PRINT S$;:RETURN
20240 REM 
20250 REM scherm opmeten
20260 REM 
20270 VE=0:GOSUB 100
20280 FOR X=0 TO 80:HO=X:GOSUB 110:GOSUB 120:NEXT X
20290 FOR Y=0 TO 35:VE=Y:GOSUB 110:GOSUB 120:NEXT Y
20300 H=HO:V=VE:RETURN
20310 REM 
20320 REM spaties
20330 REM 
20340 FOR X=1 TO S:T$=" "+T$:NEXT X:T$="$$"+T$
20350 GOSUB 22130:RETURN
20360 REM 
20370 REM menu
20380 REM 
20390 GOSUB 100
20400 S$="MENU":PRINT :GOSUB 20200:PRINT 
20410 S=(H-31)/2
20420 T$="1. Schema op printer afdrukken":GOSUB 20320
20430 T$="2. Naamvallen oefenen":GOSUB 20320
20440 T$="3. Uitleg":GOSUB 20320
20450 T$="4. Nieuw bijv. naamw. verbuigen":GOSUB 20320
20460 GOSUB 22260
20470 IF IN$="1" THEN GOSUB 20700
20480 IF IN$="2" THEN GOSUB 21020
20490 IF IN$="3" THEN GOSUB 22050
20500 IF IN$="4" THEN GOSUB 22320
20510 RETURN
20520 REM 
20530 REM print dik
20540 REM 
20550 IF E=1 THEN P$=P$+CHR$(27)+CHR$(69)+CHR$(27)+CHR$(71)
20560 RETURN
20570 REM 
20580 REM print normaal
20590 REM 
20600 IF E=1 THEN P$=P$+CHR$(27)+CHR$(70)+CHR$(27)+CHR$(72)
20610 RETURN
20620 REM 
20630 REM print groepen
20640 REM 
20650 SR$="                   GROEP 1"
20660 SR$=SR$+"                GROEP 2"
20670 SR$=SR$+"                GROEP 3"
20680 GOSUB 350:GOSUB 360:GOSUB 360:RETURN
20690 REM 
20700 REM printerafdruk
20710 REM 
20720 GOSUB 100:PRINT :S$="SUB-MENU":GOSUB 20200
20730 PRINT :S=(H-29)/2
20740 T$="1. Epson-compatible 80-koloms":GOSUB 20320
20750 T$="2. Andere 80-koloms printer":GOSUB 20320
20760 GOSUB 22260:REM keuze
20770 E=0
20780 IF IN$="1" THEN E=1
20790 GOSUB 21900:REM geduld
20800 S(0)=11:S(1)=40:S(2)=76
20810 IF E=0 THEN S(1)=32:S(2)=60
20820 FOR X=0 TO 4
20830 GOSUB 360:FOR W=0 TO 3
20840 GOSUB 360:P$=""
20850 FOR Y=0 TO 2
20860 IF (Y>0) AND(X=4) THEN 20950
20870 IF (X=0) AND(W=0) AND(Y=0) THEN GOSUB 20630
20880 IF (W<2) AND(Y=0) THEN P$=N$(X,W)
20890 FOR L=1 TO S(Y)-LEN(P$):P$=P$+" ":NEXT L
20900 SR=W+1:GOSUB 300
20910 P$=P$+SR$+". "+NV$(X*3+Y,W*3)+" "+VB$(X*3+Y,0)+"-"
20920 GOSUB 20530
20930 P$=P$+NV$(X*3+Y,W*3+1)+" ":GOSUB 20580
20940 P$=P$+VB$(X*3+Y,1)+NV$(X*3+Y,W*3+2)
20950 NEXT Y:SR$=P$:GOSUB 350:NEXT W:NEXT X
20960 GOSUB 360:RETURN
20970 REM 
20980 REM sterretjes
20990 REM 
21000 F=F+1:FOR TS=1 TO S:PRINT "*";:NEXT TS:RETURN
21010 REM 
21020 REM oefenen
21030 REM 
21040 GOSUB 260:X=INT(RV*5)
21050 GOSUB 260:Y=INT(RV*3)
21060 IF (X=4) AND(Y>0) THEN 21040
21070 GOSUB 100:PRINT :F=0
21080 S$="VERBUIGINGEN OEFENEN"
21090 GOSUB 20220:PRINT 
21100 T$="$Hoe luidt de verbuiging van":GOSUB 22130
21110 PRINT :PRINT 
21120 S$=NV$(X*3+Y,0)+" "+VB$(X*3+Y,0)+NV$(X*3+Y,1)
21130 S$=S$+" "+VB$(X*3+Y,1)+NV$(X*3+Y,2)
21140 GOSUB 20220
21150 HO=0:VE=14:GOSUB 110
21160 T$="Kies een andere uitgang door op de":GOSUB 22130
21170 T$="spatiebalk te drukken.":GOSUB 22130
21180 T$="$$Juiste uitgang? druk op RETURN.":GOSUB 22130
21190 PRINT :LE=0:IF Y=0 THEN A=1:B=6:LE=3
21200 IF Y=1 THEN A=7:B=12:LE=5
21210 IF (Y=1) AND(X=3) THEN A=20:B=25:LE=6
21220 IF X=4 THEN A=26:B=31:LE=6
21230 FOR L=0 TO 3:R(0,L)=0
21240 HO=0:VE=8+L:GOSUB 110
21250 PRINT ;L+1;"e nv:";TAB(8+LE);VB$(X*3+Y,0);
21260 PRINT TAB(LEN(VB$(X*3+Y,0))+LE+11);VB$(X*3+Y,1)
21270 NEXT L
21280 FOR VE=8 TO 11
21290 IF Y=2 THEN 21370
21300 L=A
21310 HO=7:GOSUB 110
21320 PRINT D$(L);
21330 GOSUB 210:IF IN$<>" " THEN 21360
21340 L=L+1:IF L>B THEN 21300
21350 GOTO 21310
21360 R(0,VE-8)=L
21370 L=13:HO=LEN(VB$(X*3+Y,0))+LE+8
21380 GOSUB 110
21390 PRINT D$(L);
21400 GOSUB 210:IF IN$<>" " THEN 21430
21410 L=L+1:IF L>19 THEN 21370
21420 GOTO 21380
21430 R(1,VE-8)=L:HO=HO+LEN(VB$(X*3+Y,1))+3
21440 L=0
21450 GOSUB 110
21460 PRINT D$(L);
21470 IF L=0 THEN PRINT "- ";
21480 GOSUB 210:IF IN$<>" " THEN 21520
21490 L=L+1:IF L>18 THEN L=0
21500 IF L=1 THEN L=16
21510 GOTO 21450
21520 R(2,VE-8)=L:NEXT VE
21530 IF Y=2 THEN R(0,0)=0
21540 T$="#$Zo heb jij het gedaan:"
21550 GOSUB 22130:REM print 'mooi'
21560 HO=0:VE=9:GOSUB 110:T$="Zo luidt de juiste verbuiging:"
21570 GOSUB 22130:VE=15:HO=0:GOSUB 110
21580 FOR W=0 TO 3:VE=4+W:GOSUB 110
21590 PRINT ;W+1;". ";D$(R(0,W));" ";VB$(X*3+Y,0);D$(R(1,W));
21600 PRINT " ";VB$(X*3+Y,1);D$(R(2,W))
21610 VE=11+W:GOSUB 110
21620 PRINT ;W+1;". ";NV$(X*3+Y,3*W);" ";
21630 PRINT VB$(X*3+Y,0);NV$(X*3+Y,W*3+1);
21640 PRINT " ";VB$(X*3+Y,1);NV$(X*3+Y,W*3+2)
21650 NEXT W
21660 GOSUB 21850:REM druk op 'n toets
21670 T$="#$De sterretjes geven de door jou":GOSUB 22130
21680 T$="gemaakte fouten aan.":GOSUB 22130
21690 FOR W=0 TO 3:HO=0:VE=5+W:GOSUB 110
21700 PRINT ;W+1;". ";
21710 IF D$(R(0,W))<>NV$(X*3+Y,W*3) THEN S=LE:GOSUB 20980
21720 IF D$(R(0,W))=NV$(X*3+Y,W*3) THEN PRINT D$(R(0,W));
21730 PRINT " ";VB$(X*3+Y,0);
21740 IF D$(R(1,W))<>NV$(X*3+Y,W*3+1) THEN S=2:GOSUB 20980
21750 IF D$(R(1,W))=NV$(X*3+Y,W*3+1) THEN PRINT D$(R(1,W));
21760 PRINT " ";VB$(X*3+Y,1);
21770 IF D$(R(2,W))<>NV$(X*3+Y,W*3+2) THEN S=1:GOSUB 20980
21780 IF D$(R(2,W))=NV$(X*3+Y,W*3+2) THEN PRINT D$(R(2,W));
21790 NEXT W
21800 T$="$$Je hebt in totaal "+F$(F)+" fout"
21810 IF F<>1 THEN T$=T$+"en"
21820 T$=T$+" gemaakt.":GOSUB 22130
21830 GOSUB 21850:RETURN
21840 REM 
21850 REM druk op 'n toets
21860 REM 
21870 PRINT :PRINT :S$="Druk op een toets."
21880 GOSUB 20200:GOSUB 210:RETURN
21890 REM 
21900 REM geduld
21910 REM 
21920 GOSUB 100:VE=V/2:GOSUB 110
21930 S$="Even geduld A.U.B.":GOSUB 20200
21940 RETURN
21950 REM 
21960 REM wis linker karakter
21970 REM 
21980 PRINT :T$=RIGHT$(T$,LEN(T$)-1):RETURN
21990 REM 
22000 REM print woord
22010 REM 
22020 GOSUB 120:IF LEN(W$)-1+HO>H THEN PRINT 
22030 PRINT W$;:W$="":RETURN
22040 REM 
22050 REM uitleg
22060 REM 
22070 RESTORE 
22080 READ T$
22090 GOSUB 22130:REM print 'mooi'
22100 IF T$=". " THEN RETURN
22110 GOTO 22080
22120 REM 
22130 REM print 'mooi'
22140 REM 
22150 T$=T$+" ":W$=""
22160 IF LEFT$(T$,1)="#" THEN GOSUB 100:GOSUB 21960
22170 IF LEFT$(T$,1)="$" THEN GOSUB 21960:GOTO 22170
22180 IF LEFT$(T$,1)="%" THEN GOSUB 21850:GOSUB 100:GOSUB 21960
22190 IF T$=". " THEN RETURN
22200 FOR L=1 TO LEN(T$)
22210 M$=MID$(T$,L,1)
22220 W$=W$+M$
22230 IF M$=" " THEN GOSUB 22000
22240 NEXT L:RETURN
22250 REM 
22260 REM keuze
22270 REM 
22280 PRINT :PRINT :S$="Maak uw keuze.":GOSUB 20200
22290 GOSUB 200:IF IN$="" THEN 22290
22300 RETURN
22310 REM 
22320 REM verbuig
22330 REM 
22340 GOSUB 100:PRINT :S$="SUB-MENU VERBUIGEN":GOSUB 20200
22350 T$="$$Volgens welke groep moet het bijv. nw."
22360 GOSUB 22130:T$="verbogen worden?":GOSUB 22130
22370 T$="$$Volgens de:":GOSUB 22130
22380 S=(H-24)/2
22390 T$="1. eerste of 'der' groep":GOSUB 20320
22400 T$="2. tweede of 'ein' groep":GOSUB 20320
22410 T$="3. derde groep":GOSUB 20320
22420 GOSUB 22260:YY=VAL(IN$)-1
22430 IF (YY<0) OR(YY>2) THEN 22340
22440 GOSUB 100:PRINT :S$="SUB-MENU VERBUIGEN":GOSUB 20200
22450 T$="$$Tot welke groep hoort het zelfst. nw?"
22460 GOSUB 22130:REM print 'mooi'
22470 Q=4
22480 IF YY=0 THEN Q=5
22490 FOR SR=1 TO Q:GOSUB 300
22500 T$=SR$+". "+N$(SR-1,0)+" "+N$(SR-1,1)
22510 GOSUB 20320:NEXT SR:GOSUB 22260:XX=VAL(IN$)-1
22520 IF (XX=4) AND(YY>0) THEN 22440
22530 IF (XX<0) OR(XX>4) THEN 22440
22540 GOSUB 100:PRINT :S$="VERBUIGEN":GOSUB 20200
22550 T$="$$voer nu het bijv. naamw. in.":GOSUB 22130
22560 T$="$$bijv: gut, treu, alt, kalt, wild enz."
22570 GOSUB 22130:PRINT :PRINT :INPUT S$
22580 GOSUB 22720:BN$=T$:REM omzet hoodletters
22590 T$="$$Voer nu het zelfst. naamw. in,":GOSUB 22130
22600 T$="$$bijv: Mann, Frau, Buch, Wetter enz.":GOSUB 22130
22610 PRINT :PRINT :INPUT S$
22620 GOSUB 22720:REM omzet hoodletters
22630 ZN$=CHR$(ASC(LEFT$(T$,1))-32)+RIGHT$(T$,TS-2)
22640 GOSUB 100:PRINT :S$="VERBUIGEN":GOSUB 20200
22650 T$="$$Zo luidt de juiste verbuiging:":GOSUB 22130
22660 PRINT :PRINT 
22670 FOR W=0 TO 3
22680 PRINT ;W+1;". ";NV$(XX*3+YY,W*3);" ";BN$;
22685 PRINT NV$(XX*3+YY,W*3+1);
22690 PRINT " ";ZN$;NV$(XX*3+YY,W*3+2)
22700 NEXT W:GOSUB 21850:RETURN
22710 REM 
22720 REM omzet hoofdletters
22730 REM naar kleine letters
22740 REM 
22750 T$="":FOR TS=1 TO LEN(S$)
22760 M=ASC(MID$(S$,TS,1))
22770 IF (M>64) AND(M<91) THEN M=M+32
22780 T$=T$+CHR$(M):NEXT TS
22790 RETURN
25000 DATA "#HET BIJVOEGLIJK NAAMWOORD"
25010 DATA "$$eerste of 'der'-groep (z.g. zwakke verbuiging)"
25020 DATA "$$Na een bepalend woord van deze groep krijgt"
25030 DATA "het bijvoeglijk naamwoord 11x -en en 5x -e,"
25040 DATA "nl. in de"
25050 DATA "$$1e naamval mannelijk;"
25060 DATA "$1e en 4e naamval vrouwelijk;"
25070 DATA "$1e en 4e naamval onzijdig."
25080 DATA "$$Uitzondering: Na einige, mehrere,"
25090 DATA "verschiedene, viele en samtliche krijgt het"
25100 DATA "bijv. nw. in de 1e"
25110 DATA "en 4e nvl. -e in plaats van -en!"
25120 DATA "%Tweede of 'ein'-groep (z.g. gemengde"
25130 DATA "verbuiging)"
25140 DATA "$$Na een bepalend woord van deze groep krijgt"
25150 DATA "het bijv. nw. eveneens en op dezelfde 11"
25160 DATA "plaatsen -en, op de 5 overblijvende plaatsen"
25170 DATA "een andere uitgang, nl."
25180 DATA "$$-er in de 1e naamval mannelijk;"
25190 DATA "$-e  in de 1e en 4e naamval vrouwelijk;"
25200 DATA "$-es in de 1e en 4e naamval onzijdig."
25210 DATA "%De derde groep (z.g. sterke verbuiging)"
25220 DATA "$$Wordt het bijv. nw. NIET voorafgegaan door"
25230 DATA "een bepalend woord van de 'der' of 'ein' groep,"
25240 DATA "dan krijgt het de uitgangen van dies-er, dies-e,"
25250 DATA "dies-es enz."
25260 DATA "$$Uitzondering: In de 2e nvl. mannelijk en"
25270 DATA "onzijdig enkelvoud staat -en in plaats van het"
25280 DATA "te verwachten regelmatige -es."
25290 DATA "%Opmerking:"
25300 DATA "$$Twee of meer bijv. naamwoorden achter elkaar"
25310 DATA "worden op dezelfde wijze verbogen:"
25320 DATA "$$der gut-e alt-e Mann"
25330 DATA "$$gross-e wild-e Tiere."
25340 DATA "%."
25350 DATA "die","des","das","den","dem","der"
25360 DATA "einer","eines","einen","eine ","ein  ","einem"
25370 DATA "er","em","e ","s ","n","es","en"
25380 DATA "keiner","keinem","kein  "
25390 DATA "keine ","keinen","keines"
25400 DATA "vielem","vieles","viele "
25410 DATA "viel ","vielen","vieler"
25420 DATA 6,11,0,1,10,0,3,11,0,1,23,0,28
25430 DATA 15,13,13,15,15,15,15,18,18,19,19,15,15
25440 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0
25450 DATA 2,8,0,6,7,0,2,8,0,6,20,0,31
25460 DATA 19,19,19,19,19,13,19,19,19,19,19,13,13
25470 DATA 18,18,18,0,0,0,18,18,16,0,0,0,0
25480 DATA 5,12,0,6,7,0,5,12,0,4,24,0,30
25490 DATA 19,19,14,19,19,13,19,19,14,19,19,19,19
25500 DATA 0,0,0,0,0,0,0,0,0,17,17,17,17
25510 DATA 4,9,0,1,10,0,3,11,0,1,23,0,28
25520 DATA 19,19,19,15,15,15,15,18,18,19,19,15,15
25530 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0
25540 DATA "gut","Mann","treu","Hund","rot","Wein"
25550 DATA "gut","Frau","alt","Mutter","heiss","Suppe"
25560 DATA "gut","Buch","klein","Land","kalt","Wetter"
25570 DATA "gut","Leute","gross","Freunde","wild","Tiere"
25580 DATA "gut","Leute"
25590 DATA "mannelijk","enkelvoud","vrouwelijk","enkelvoud"
25600 DATA "onzijdig","enkelvoud","meervoud","","meervoud"
25610 DATA "uitzon."
25620 DATA "nul","een","twee","drie","vier","vijf","zes"
25630 DATA "zeven","acht","negen","tien","elf","twaalf"
30000 REM 
30010 REM  dit is een
30020 REM  Basicode-2 programma 
30030 REM  van
30040 REM 
30050 REM  Iwan van Rienen (15 jaar)
30060 REM  van Kijfhoeklaan 94
30070 REM  2597 TE  Den Haag
30080 REM 
30090 REM Regels 20520-20560 en
30100 REM regels 20570-20610 kunnen
30110 REM eventueel voor uw printer
30120 REM aangepast worden.
30130 REM 
30140 REM 
30150 REM 
30160 REM   copyright (c) 1987 
30170 REM   NOS  Hilversum
