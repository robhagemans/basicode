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
 1000 A=600:GOTO 20
 1010 GOSUB 100:REM OOIT VAN I-2
 1020 PRINT"Even geduld...":DIM K$(6),A(20)
 1030 VE=0:FOR I=0 TO 80:HO=I:GOSUB 110
 1040 GOSUB 120:IF HO<>I THEN HP=I:I=80
 1050 NEXT I:FOR I=0 TO 40:HO=0:VE=I:GOSUB 110
 1060 GOSUB 120:IF VE<>I THEN VP=I:I=40
 1070 NEXT I:PT=0
 1080 GOSUB 1340:GOSUB 21000:GOTO 1480:REM** NAAR MENU **
 1090 REM BEELDKRANT TEKSTVORMER
 1100 KL$="":N=1
 1110 GOSUB 100:PRINT"OOIT VAN i GEHOORD-2 ?"
 1120 PRINT:PRINT"naar p)rinter of s)cherm ?";
 1130 GOSUB 210:GOSUB 1800
 1140 IF(IN$<>"p") AND(IN$<>"s") THEN 1130
 1150 PRINT IN$:PRINT
 1160 PT=1:IF IN$="s" THEN PT=0:GOSUB 1340:GOTO 1610
 1170 PRINT"hoeveel letters per regel ";
 1180 INPUT HP
 1190 PRINT:PRINT"kantlijnbreedte ";
 1200 INPUT SP:GOSUB 1900:KL$=SP$
 1210 HP=HP-SP:IF SP>1 THEN HP=HP-SP+2
 1220 PRINT:PRINT"hoeveel regels tekst per pagina ";
 1230 INPUT VP
 1240 PRINT:PRINT"k)ettingformulieren of l)osse vellen ?";
 1250 GOSUB 210:GOSUB 1800
 1260 IF(IN$<>"k") AND(IN$<>"l") THEN 1250
 1270 PRINT IN$:PRINT
 1280 KF=1:IF IN$="l" THEN KF=0:GOTO 1310
 1290 PRINT"hoeveel lege regels onderaan vel ";
 1300 INPUT LR:PRINT
 1310 PRINT"zet de printer klaar"
 1320 PRINT"en druk op een toets"
 1330 GOSUB 210:GOSUB 1340:GOTO 1610
 1340 RT=0:H=0
 1350 REM PRINT DE KOP
 1360 K$(0)="******************************"
 1370 K$(1)="*   OOIT VAN i GEHOORD ?     *"
 1380 K$(2)="*         deel 2             *"
 1390 K$(3)="*       oefen-demo's         *"
 1400 K$(4)="*   Historische notities     *"
 1410 K$(5)="*   Literatuur opgaven       *"
 1420 K$(6)="******************************"
 1430 GOSUB 100
 1440 SP=INT((HP-30)/2):IF PT=1 THEN SP=SP-3
 1450 GOSUB 1900
 1460 SR$=" ":GOSUB 20000
 1470 FOR I=0 TO 6:SR$=SP$+K$(I):GOSUB 20000:NEXT I:RETURN
 1480 GOSUB 100:PRINT:PRINT"OOIT VAN i GEHOORD?"
 1490 PRINT:PRINT"        MENU":PRINT
 1500 PRINT:PRINT"1. Oefen-demo's":PRINT
 1510 PRINT"2. Historische notities":PRINT
 1520 PRINT"3. Literatuur opgaven":PRINT
 1530 PRINT"4. Stoppen":PRINT
 1540 PRINT:PRINT"Geef het nummer van Uw keuze:";
 1550 GOSUB 210:K=VAL(IN$):IF(K<1) OR(K>4) THEN 1550
 1560 PRINT K:RESTORE:ON K GOTO 1930,1100,6000,18980
 1610 A$="":REM PRINT DE OVERIGE DATA
 1620 READ BB$:KL=0
 1630 GOSUB 23000
 1640 GOSUB 24000
 1650 IF KL=0 THEN 1630
 1660 GOSUB 21000:GOTO 1480
 1800 IF(IN$<"A") OR(IN$>"Z") THEN RETURN
 1810 IN$=CHR$(ASC(IN$)-ASC("A")+ASC("a"))
 1820 RETURN
 1900 SP$="":IF SP<1 THEN RETURN
 1910 FOR I=1 TO SP:SP$=SP$+" ":NEXT I
 1920 RETURN
 1930 GOSUB 100:HO=1:VE=2:GOSUB 110
 1940 PRINT"MENU - Oefen-demo's"
 1950 PRINT:PRINT"1. Conversie binair -> decimaal"
 1960 PRINT:PRINT"2. Conversie decimaal-> binair"
 1970 PRINT:PRINT"3. Algemeen conversie-prg."
 1980 PRINT:PRINT"4. Herleiding gew.br. -> 10-delige"
 1990 PRINT:PRINT"5. Herl.zuiver rep.br.-> gew.br."
 2000 PRINT:PRINT"6. Herl.gemengd rep.br.-> gew.br."
 2010 PRINT:PRINT"7. Machtsverheffing van i."
 2020 PRINT:PRINT"8. Derde-machts-wortels uit i."
 2030 PRINT:PRINT"9. Terug naar hoofd-menu."
 2040 PRINT:FOR S=1 TO HP-1:PRINT"-";:NEXT S
 2050 PRINT:PRINT"Geef het nummer van Uw keuze:";
 2060 GOSUB 210:K=VAL(IN$):IF(K<1) OR(K>9) THEN 2060
 2070 IF K=9 THEN 1480
 2080 ON K GOTO 2200,2090,2400,2600,2750,3010,3320,3610
 2090 GOSUB 100:PRINT"CONVERSIE DECIMAAL -> BINAIR":PRINT
 2100 I=0:PRINT"Geef decimaal getal:";:INPUT G1$
 2110 G1=VAL(G1$):G2=INT(G1/2)
 2120 IF(G1=2*G2) THEN I=I+1:A(I)=0:GOTO 2140
 2130 I=I+1:A(I)=1
 2140 IF G2<2 THEN 2160
 2150 G1=G2:G2=INT(G1/2):GOTO 2120
 2160 I=I+1:A(I)=G2:PRINT:PRINT"Wat is het binair:";
 2170 INPUT Z$:PRINT:PRINT"Controleer maar...":PRINT
 2180 FOR C=I TO 1 STEP-1:PRINT A(C);:NEXT C:GOSUB 19000
 2190 IF(K$="j") OR(K$="J") THEN 2090
 2195 GOTO 1930
 2200 GOSUB 100:PRINT"CONVERSIE BINAIR -> DECIMAAL":PRINT
 2210 PRINT"Geef binair getal (dus alleen 0 of 1)":INPUT A$
 2220 G=0:L=LEN(A$):V=0
 2230 FOR I=(L-1) TO 0 STEP-1
 2240 B$=MID$(A$,(I+1),1)
 2244 IF(B$<>"1") AND(B$<>"0") THEN V=1:I=0:GOTO 2255
 2250 B=VAL(B$):G=G+B*2^(L-1-I)
 2255 NEXT I:IF V=1 THEN 2210
 2260 PRINT:PRINT"Wat wordt dat decimaal";
 2270 INPUT C:IF(C<>G) THEN 2310
 2280 PRINT:PRINT"GOED !":GOSUB 19000
 2290 IF(K$="j") OR(K$="J") THEN 2200
 2300 GOTO 1930:REM** MENU **
 2310 PRINT:PRINT"FOUT ! -Kijk maar:":RT=2:GOSUB 21000
 2320 PRINT"Het getal was binair:";A$:G=0
 2330 FOR I=(L-1) TO 0 STEP-1:B$=MID$(A$,(I+1),1):B=VAL(B$)
 2340 CT=15:CN=0:SR=B*2^(L-1-I):GOSUB 310
 2350 PRINT SR$:G=G+SR:NEXT I
 2360 FOR Z=1 TO 20:PRINT"-";:NEXT Z
 2370 PRINT:PRINT"totaal =";:CT=7:SR=G:GOSUB 310:PRINT SR$
 2380 GOSUB 19000:IF(K$="j") OR(K$="J") THEN 2200
 2390 GOTO 1930:REM*** MENU ***
 2400 GOSUB 100:REM*** ALGEMEEN CONVERSIE PROGRAMMA ***
 2410 PRINT:PRINT"ALGEMEEN CONVERSIE PROGRAMMA":PRINT
 2420 PRINT"Geef talstelsel aan als GETAL"
 2430 PRINT"voorbeeld: 10-tallig stelsel -> 10":PRINT
 2440 PRINT"Welk getal herleiden:";:INPUT A$
 2445 LA=LEN(A$):IF LA=0 THEN 2440
 2450 PRINT:PRINT"Uit  welk talstelsel:";:INPUT A
 2460 PRINT:PRINT"Naar welk talstelsel:";:INPUT B
 2470 G=0:V=0:FOR T=1 TO LA
 2472 IN$=MID$(A$,T,1):GOSUB 1800:Q=ASC(IN$)
 2474 IF(IN$>="0") AND(IN$<="9") THEN P=Q-ASC("0")
 2480 IF(IN$>="a") AND(IN$<="z") THEN P=Q-ASC("a")+10
 2490 IF(P>=0) AND(P<=(A-1)) THEN G=G*A+P:GOTO 2505
 2500 PRINT"fout getal!":V=1:T=LA
 2505 NEXT T:IF V=1 THEN 2440
 2510 IF(B=10) THEN SR=G:GOSUB 300:B$=SR$:PRINT:GOTO 2570
 2515 B$="":IF(G<B) THEN 2550
 2520 D=G/B:E=INT(G-B*INT(D))
 2530 F=E+ASC("0"):IF(E>9) THEN F=E+ASC("A")-10
 2540 F$=CHR$(F):B$=F$+B$:G=INT(D):IF(G>=B) THEN 2520
 2550 F=G+ASC("0"):IF(G>9) THEN F=G+ASC("A")-10
 2560 F$=CHR$(F):B$=F$+B$:PRINT
 2570 PRINT A$;" (";A;"-tallig)= ";B$;" (";B;"-tallig)"
 2580 GOSUB 19000:IF(K$="j") OR(K$="J") THEN 2400
 2590 GOTO 1930
 2600 REM*** GEWONE BREUK -> 10-DELIGE BREUK ***
 2610 GOSUB 100:PRINT:PRINT"GEWONE BREUK -> 10-DELIGE BR."
 2620 PRINT:PRINT"Geef TELLER:";:INPUT TR:TE=TR:PRINT
 2630 PRINT"Geef NOEMER:";:INPUT NR:NZ=NR:PRINT
 2635 IF NZ=0 THEN PRINT"Deling door NUL !":GOTO 2710
 2640 PRINT"Hoeveel DECIMALEN:";:INPUT DC
 2650 HO=2:VE=10:GOSUB 110:PRINT"De breuk ";TE;"/";NZ;"="
 2660 PRINT:PRINT:IF(TE=NZ) THEN PRINT"1":GOTO 2710
 2670 IF(TE>NZ) THEN Q=INT(TE/NZ):PRINT Q;".";:GOTO 2730
 2680 IF(TE<NZ) THEN PRINT"0.";:TR=10*TE
 2690 FOR I=1 TO(DC+1):QU=INT(TR/NR+5E-03):PRINT QU;
 2700 RE=TR-(QU*NR):TR=10*RE:NEXT I
 2710 GOSUB 19000:IF(K$="j") OR(K$="J") THEN 2610
 2720 GOTO 1930
 2730 TR=10*(TE-(Q*NZ)):GOTO 2690
 2740 REM*** ZUIVER REP.BR -> 10-DELIGE BR.***
 2750 GOSUB 100:PRINT:PRINT"ZUIVER REP.BR.-> GEWONE BR."
 2760 PRINT:PRINT"Een zuiver repeterende breuk is een"
 2770 PRINT"breuk waarbij achter de komma,"
 2780 PRINT"uitsluitend de zich steeds herhalende"
 2790 PRINT"periode voorkomt."
 2800 PRINT:PRINT"De algemene regel is:":PRINT:PRINT
 2810 PRINT"       T"
 2820 PRINT" BR = ---"
 2830 PRINT"       N"
 2840 PRINT:PRINT"BR=rep.breuk met 1 periode(0 helen!)"
 2850 PRINT"T =de periode als geheel getal."
 2860 PRINT"N =een getal met evenveel negens als er"
 2870 PRINT"   cijfers repeteren.":RT=1:GOSUB 21000
 2880 GOSUB 100:PRINT"ZUIVER REP.Br.->GEWONE BREUK":PRINT
 2890 PRINT"Geef de breuk met 1 periode (0<BR<1)"
 2900 PRINT"bijv.0.428571 of 0.238095 of 0.36 enz."
 2910 INPUT BR$
 2920 IF(LEFT$(BR$,2)<>"0.") THEN PRINT"Fout":GOTO 2910
 2925 IF(LEN(BR$)<3) THEN PRINT"Fout":GOTO 2910
 2930 LT=LEN(BR$)-2:T$=RIGHT$(BR$,LT):N$=""
 2940 FOR I=1 TO LT:N$=N$+"9":NEXT I:N=VAL(N$):T=VAL(T$)
 2950 PRINT:PRINT"               ";T
 2960 PRINT BR$;"=      ---------------"
 2970 PRINT"               ";N
 2980 GOSUB 10010:GOSUB 19000
 2990 IF(K$="j") OR(K$="J") THEN 2880
 2995 GOTO 1930
 3000 REM*** GEMENGD REPETERENDE BREUK ***
 3010 GOSUB 100:PRINT:PRINT"GEMENGD REP.BR.->GEWONE BR."
 3020 PRINT:PRINT"De ALGEMENE REGEL is:":PRINT
 3030 PRINT"          T":PRINT"   BR =  ---"
 3040 PRINT"          N":PRINT
 3050 PRINT" T =geheel getal,bestaande uit alle"
 3060 PRINT"    niet-repeterende cijfers,plus een"
 3070 PRINT"    periode MIN het NIET-REP.deel.":PRINT
 3080 PRINT" N =zoveel negens als cijfers repeteren"
 3090 PRINT"    gevolgd door zoveel nullen als"
 3100 PRINT"    cijfers NIET-REPETEREN."
 3110 PRINT:PRINT"vb. 0.227 27 27 (per.=27,niet-rep.=2)"
 3120 PRINT:PRINT"              227-2   225    5"
 3130 PRINT"0.2272727...= ----- = --- = --"
 3140 PRINT"               990    990   22"
 3150 RT=1:GOSUB 21000:PRINT"GEM.REP.BR.->GEWONE BR."
 3160 PRINT:PRINT"Geef breuk met slechts een periode"
 3170 PRINT"(0<BR<1).Dus 0.163 63...-> 0.163":PRINT
 3180 PRINT"vb. 0.0 523809 523809 of 0.2 3 3 3...":PRINT
 3190 PRINT"BREUK =";:INPUT BR$
 3200 IF(LEFT$(BR$,2)<>"0.") THEN PRINT"FOUT":GOTO 3190
 3205 IF(LEN(BR$)<3) THEN PRINT"FOUT":GOTO 3190
 3210 PRINT"NIET-rep.deel=";:INPUT NR$:NR=VAL(NR$)
 3220 PRINT"een PERIODE  =";:INPUT PE$
 3230 LT=LEN(BR$)-2:LP=LEN(PE$):LR=LEN(NR$)
 3240 TE$=RIGHT$(BR$,LT):TE=VAL(TE$):T=TE-NR:N$=""
 3250 FOR I=1 TO LP:N$=N$+"9":NEXT I:NP=VAL(N$)
 3260 N=NP*10^LR:PRINT"               ";T
 3270 PRINT BR$;" =   ------------"
 3280 PRINT"               ";N:GOSUB 10010:GOSUB 19000
 3290 IF(K$="j") OR(K$="J") THEN GOSUB 100:GOTO 3160
 3300 GOTO 1930
 3310 REM*** MACHTSVERHEFFING VAN I ***
 3320 GOSUB 100:PRINT:PRINT"MACHTS-VERHEFFING van i":PRINT
 3330 PRINT"   i^2 = sqr(-1)^2 = -1":PRINT
 3340 PRINT"   i^3 = i*(-1)    = -i":PRINT
 3350 PRINT"   i^4 = i*(-i)    = +1":PRINT
 3360 PRINT"   i^5 = i*(+1)    = +i":PRINT
 3370 PRINT"   i^6 = i*(+i)    = -1    enz."
 3380 RT=1:GOSUB 21000
 3390 PRINT:PRINT"MACHTS-VERHEFFING van i":PRINT
 3400 PRINT"In het algemeen geldt:":PRINT
 3410 PRINT"   i^(4n)    = +1":PRINT
 3420 PRINT"   i^(4n+1)  = +i":PRINT
 3430 PRINT"   i^(4n+2)  = -1":PRINT
 3440 PRINT"   i^(4n+3)  = -i":PRINT
 3450 PRINT"   i^(4n+4)  = +1      enz.":PRINT
 3460 PRINT"(n kan zijn 0 ,pos. of neg.heel getal)"
 3470 RT=1:GOSUB 21000:PRINT:PRINT"OEFENING i^m = ....."
 3480 PRINT:PRINT"Geef macht van i. m=....";:INPUT M
 3482 IF M=INT(M) THEN 3490
 3484 PRINT"Alleen GEHELE getallen aub !":GOTO 3470
 3490 Q=INT(M/4):IF(M=4*Q) THEN A$="+1"
 3500 IF(M=4*Q+1) THEN A$="+i"
 3510 IF(M=4*Q+2) THEN A$="-1"
 3520 IF(M=4*Q+3) THEN A$="-i"
 3530 PRINT:PRINT"Vul in:  i^";M;" = ";:INPUT U$:PRINT
 3532 LU=LEN(U$):IF(LU<1) OR(LU>2) THEN 3550
 3534 T$=LEFT$(U$,1):IF LU=1 THEN T$="+"
 3536 IN$=RIGHT$(U$,1):GOSUB 1800
 3538 U$=T$+IN$
 3540 IF(U$=A$) THEN PRINT"GOED ZO !":GOTO 3580
 3550 PRINT"JAMMER ! Dat klopt niet !":PRINT
 3560 PRINT"De macht is een viervoud plus ";(M-4*Q):PRINT
 3570 PRINT"Het moest dus zijn:"
 3580 PRINT:PRINT"   i^";M;" = ";A$
 3590 GOSUB 19000:IF(K$="j") OR(K$="J") THEN 3310
 3600 GOTO 1930
 3610 GOSUB 100:REM*** DERDE-MACHTS-WORTELS UIT I ***
 3620 PRINT:PRINT"DERDE-MACHTS-WORTELS uit i":PRINT
 3630 PRINT"De formule ziet er vervaarlijk uit:":PRINT
 3640 PRINT"   n--------------------"
 3650 PRINT"  V r(cos a + i * sin a)  =  ":PRINT
 3660 PRINT"  r^(1/n) * ( cos (a+p*360 gr)/n +":PRINT
 3670 PRINT"  +i* sin( a+p*360 gr)/n )":PRINT
 3680 PRINT"  ( Waarin p= 0,1,2...n-1 )":PRINT
 3690 PRINT"  We nemen r=1 en gebruiken in plaats"
 3700 PRINT:PRINT"  van 360 gr = 2 * pi radialen":PRINT
 3710 PRINT"  p = 0 of 1 of 2"
 3720 RT=1:GOSUB 21000:PRINT
 3730 PRINT"DERDE-MACHTS-WORTELS uit i":PRINT
 3740 PRINT"De 3 derde-machts wortels uit 1 worden:"
 3750 PRINT:PRINT"cos 0 + i * sin 0 = 1..............=1"
 3760 PRINT:PRINT"   2         2     1 1     ---"
 3770 PRINT"cos-*pi+i*sin-*pi=--+-*i* V 3......=k"
 3780 PRINT"   3         3     2 2":PRINT
 3790 PRINT"   4         4     1 1     ---"
 3800 PRINT"cos-*pi+i*sin-*pi=----*i* V 3.....=k^2"
 3810 PRINT"   3         3     2 2":PRINT
 3820 PRINT"Volgens de formule van De Moivre is:":PRINT
 3830 PRINT"(cos a + i sin a)^n=cos n*a + i sin n*a"
 3840 RT=1:GOSUB 21000:PRINT
 3850 PRINT"Dus volgens De Moivre:":PRINT
 3860 PRINT"    4                4"
 3870 PRINT"cos - * pi + i * sin - * pi ="
 3880 PRINT"    3                3":PRINT
 3890 PRINT"     2                2"
 3900 PRINT"(cos - * pi + i * sin - * pi)^2"
 3910 PRINT"     3                3":PRINT
 3920 PRINT"Conclusie:de 3e wortel is het kwadraat"
 3930 PRINT"van de 2e.Maar de 2e blijkt ook het"
 3940 PRINT"kwadraat te zijn van de 3e wortel."
 3950 PRINT"Men stelt de 3e-machtswortels uit 1"
 3960 PRINT"voor door k en k^2.Het maakt niet uit"
 3970 PRINT"welke k en welke k^2 genoemd wordt:"
 3980 PRINT:PRINT"(k^2)^2 = k^4 = k^3 * k = 1 * k = k"
 3990 RT=1:GOSUB 21000:PRINT
 4000 PRINT"SAMENVATTEND:":PRINT
 4010 PRINT"De imaginaire 3e-machts wortels":PRINT
 4020 PRINT"  k en k^2  uit 1":PRINT
 4030 PRINT"    - zijn elkaars kwadraat":PRINT
 4040 PRINT"    - zijn toegevoegd complex en":PRINT
 4050 PRINT"    1 + k + k^2 = 0"
 4060 GOSUB 19000
 4070 IF(K$="j") OR(K$="J") THEN 3610
 4080 GOTO 1930
 6000 GOSUB 100:PRINT:PRINT"LITERATUUR-OPGAVE":PRINT
 6010 PRINT"Even geduld,ik haal de data..."
 6100 HO=1:VE=4:GOSUB 110:E$="$$$$$"
 6110 READ A$:IF A$<>E$ THEN 6110
 6120 PRINT:PRINT
 6130 GOTO 1100:REM*** AFDRUK LIT.OPGAVEN ***
10000 REM*** VEREENV.BREUK-SUB-ROUTINE ***
10010 C=T:D=N
10020 Q=C-INT(C/D+5E-03)*D:C=D:D=Q:IF(Q>0) THEN 10020
10030 PRINT:PRINT:PRINT"                 ";T/C
10040 PRINT"vereenvoudigd = ---------"
10050 PRINT"                 ";N/C:RETURN
18970 REM*** EINDE ***
18980 GOSUB 100:HO=15:VE=10:GOSUB 110:PRINT"TOT ZIENS"
18990 VE=20:GOSUB 110:END
19000 REM***NOG EEN KEER ?-SUB-ROUTINE ***
19010 HO=1:VE=20:GOSUB 110:FOR I=1 TO HP-1:PRINT"-";:NEXT I
19020 HO=18:VE=22:GOSUB 110:PRINT"Nog een keer?(j/n)";
19030 GOSUB 210:K$=IN$:RETURN
20000 REM AFDRUK SUBROUTINE
20010 IF SR$="" THEN RETURN
20020 IF PT=1 THEN 20060
20030 PRINT SR$
20040 RT=RT+1:IF RT=VP-4 THEN GOSUB 21000
20050 RETURN
20060 SR$=KL$+SR$:GOSUB 350:GOSUB 360:RT=RT+1
20070 IF RT=VP THEN GOSUB 22000
20080 RETURN
21000 REM SCHERM VOL
21010 IF RT=0 THEN RETURN
21020 HO=0:VE=VP-1:GOSUB 110
21030 PRINT"<toets voor verder>";
21040 GOSUB 210:GOSUB 100:RT=0:RETURN
22000 REM PAPIER VOL
22010 IF KF=1 THEN FOR I=1 TO LR:GOSUB 360:NEXT I:GOTO 22050
22020 PRINT"zet de printer bovenaan nieuwe pagina"
22030 PRINT"en druk daarna op een toets."
22040 GOSUB 210:GOSUB 100
22050 RT=0:N=N+1:SR=N:GOSUB 300:N$=SR$
22060 SR$="Ooit van 'i' gehoord?, pag. "+N$
22070 RL=LEN(SR$):GOSUB 20060:SR$=""
22080 FOR I=1 TO RL:SR$=SR$+"-":NEXT I
22090 GOSUB 20060:SR$=" ":GOSUB 20060:RETURN
23000 IF BB$="$$$$$" THEN H=1:KL=1:RETURN
23010 IF A$<>"" THEN A$=A$+" "
23020 A$=A$+BB$:READ BB$
23030 IF LEFT$(BB$,1)="#" THEN H=1:RETURN
23040 IF LEFT$(BB$,1)="." THEN H=1:RETURN
23050 IF A$=". " THEN RETURN
23060 IF LEFT$(A$,1)="#" THEN RETURN
23070 IF LEN(A$)<HP THEN 23000
23080 RETURN
24000 REM PRINT MET AANGEPASTE REGELLENGTE
24010 IF LEFT$(A$,1)="#" THEN H=2
24020 IF(LEFT$(A$,1)<>".") AND(H<2) THEN 24070
24030 A$=RIGHT$(A$,LEN(A$)-1)
24040 IF H<2 THEN 24070
24050 IF PT=0 THEN GOSUB 21000
24060 IF PT=1 THEN SR$=" ":GOSUB 20000
24070 IF A$=" " THEN SR$=A$:A$="":GOSUB 20000:GOTO 24160
24080 L=LEN(A$):IF(H=0) AND(L<HP) THEN RETURN
24090 IF L<HP THEN SR$=A$:A$="":GOSUB 20000:GOTO 24150
24100 J=0:FOR I=HP TO 1 STEP-1
24110 IF MID$(A$,I,1)=" " THEN J=I:I=1
24120 NEXT I:IF J=0 THEN J=HP:L=L+1
24130 SR$=LEFT$(A$,J-1):A$=RIGHT$(A$,L-J)
24140 GOSUB 20000:GOTO 24080
24150 IF H=2 THEN SR$=" ":GOSUB 20000
24160 H=0:RETURN
25000 DATA"#HISTORISCHE NOTITIES."
25010 DATA"ABACIST",". Rekenaar,die een abacus gebruikt."
25020 DATA"Rond de 12e eeuw waren er twee rekenscholen,"
25030 DATA"die elkaar de voorrang betwistten:"
25040 DATA".     de Abacisten en",".     Algoritmici."
25050 DATA". ","ABACUS",". Gelinieerd rekenbord, op"
25060 DATA"de lijnen waarvan schijfjes waren geplaatst,"
25070 DATA"die naar de lijn waarop ze lagen, eenheden,"
25080 DATA"tientallen enz. aanduidden.",". "
25090 DATA"AHMES",". Egyptische wiskundige, die leefde"
25100 DATA"tussen 2000 en 1700 voor Chr. Van hem is het"
25110 DATA"oudste rekenkundig geschrift, dat we kennen."
25120 DATA"Het is geschreven op papyrus. Het geeft"
25130 DATA"berekeningen met breuken. Ahmes werkt al met"
25140 DATA"een onbekende, die hij 'hoopje' noemt."
25150 DATA"Voorbeeld: 'Hoopje, zijn zevende, het geheel"
25160 DATA"maakt 19.' (=x/7 + x = 19).Ahmes rekent het"
25170 DATA"jaar al op 365 dagen. Voor pi neemt hij"
25180 DATA"3.1604",". ","ALGORITME",". De naam van de"
25190 DATA"Arabische wiskundige:"
25200 DATA". Abu Abd Allah Muhammad b. Musa al-"
25210 DATA"Huwarizmi (ook wel: Mohammed ibn Musa"
25220 DATA"Alchwarizmi), geboren in Khorassan of"
25230 DATA"Huwarizmi, thans Khiwa, leefde onder Kalief"
25240 DATA"Al Mamum (814-833) te Bagdad. Zijn naam werd"
25250 DATA"in de 13e eeuw in het Latijn vertaald en"
25260 DATA"vervormd tot Algorithmi. Later noemde men"
25270 DATA"elke, tot regel geworden bewerking tot in de"
25280 DATA"18e eeuw: Algoritmus.",". "
25290 DATA"ALGORITHMICI",". ","Zij die zich bij het"
25300 DATA"rekenen, van de Indo- Arabische cijfers"
25310 DATA"bedienen.",". ","ARGAND J.R.",". Geboren te"
25320 DATA"Geneve (1768) - overleden omstreeks 1825. Hij"
25330 DATA"stelde imaginaire getallen meetkundig voor in"
25340 DATA"1806. De naam MODULUS van een complex getal"
25350 DATA"komt voor het eerst voor bij Argand (1814)."
25360 DATA". Modulus = sqr(a^2+b^2) = VECTOR OA.",". "
25370 DATA"BOMBELLI van Bologne.",". In 1572 schreef"
25380 DATA"hij een werk over Algebra. Hij toonde aan,"
25390 DATA"dat de wortels van een 3e- machts vergelijking"
25400 DATA"soms een imaginaire vorm aan nemen (Cardanus)"
25410 DATA"maar inderdaad reeel zijn.",". "
25420 DATA"BRAHMEGUPTA",". ","Deze Hindoe is geboren in"
25430 DATA"598 na Chr. in India. Hij gebruikte als een"
25440 DATA"der eersten de cijfers inclusief de nul"
25450 DATA"consequent. Hij gaf regels voor de hoofd-"
25460 DATA"bewerkingen met gehele en gebroken getallen."
25470 DATA"Hij berekende de wortel van vierkants-"
25480 DATA"vergelijkingen en rekende met negatieve"
25490 DATA"getallen.Verder bestudeerde hij rechthoekige"
25500 DATA"driehoeken.",". ","DEDEKIND Julius, Wilhelm,"
25510 DATA"Richard. (1831- 1916)",". Hij verzorgde een"
25520 DATA"2e vermeerderde druk van het boek van Gauss:"
25530 DATA"'Vorlesungen ueber Zahlen- Theorie' in 1871."
25540 DATA"Bekend werd ook de z.g. 'SNEDE van DEDEKIND'."
25550 DATA". ","DIRICHLET Lejeune (1805- 1859)"
25560 DATA". Dirichlet vereenvoudigde sommige zaken,"
25570 DATA"die Gauss had gevonden. Geboren in Duitsland,"
25580 DATA"ging hij in 1822 naar Parijs, maar in 1826"
25590 DATA"keerde hij naar Duitsland terug. Hij was de"
25600 DATA"eerste hoogleraar, die voorlezingen over"
25610 DATA"getallen- leer hield. Zij verschenen in 1863"
25620 DATA"in druk: 'Vorlesungen ueber Zahlen- Theorie'."
25630 DATA". ","DESCARTES Rene (Renatus Cartesius)"
25640 DATA". Geb.Touraine 1596 - + Stockholm 1650."
25650 DATA". Hij wijdde de jaren 1615 en 1616 vooral"
25660 DATA"aan de studie van de wiskunde.In 1617 trad hij"
25670 DATA"in het leger van Prins Maurits te Breda.In het"
25680 DATA"begin van de 30-jarige oorlog nam hij dienst"
25690 DATA"in het Beierse leger.In 1621 verliet hij de"
25700 DATA"krijgs- dienst om te studeren. Hij werd"
25710 DATA"vooral bekend als wijsgeer. ('Cogito ergo"
25720 DATA"sum' = Als ik denk, besta ik!). In de wiskunde"
25730 DATA"ontwikkelde hij de analytische meetkunde."
25740 DATA". Descartes voerde het gebruik in om de"
25750 DATA"onbekende aan te geven door x, y, z..."
25760 DATA"Misschien doordat Cataldi daarvoor een I"
25770 DATA"met een streepje er door gebruikte. Descartes"
25780 DATA"gebruikte als eerste het woord IMAGINAIR. Op"
25790 DATA"verzoek van Koningin Christina van Zweden,"
25800 DATA"trok hij in 1649 naar Stockholm, waar hij in"
25810 DATA"1650 overleed.",". "
25820 DATA"EULER Leonhard (1707- 1783)",". Geboren te"
25830 DATA"Bazel. Leerling van Bernoulli. Katharina I"
25840 DATA"haalde hem naar Petersburg. In 1747 kwam"
25850 DATA"Euler naar Berlijn op verzoek van Frederik"
25860 DATA"de Grote, maar in 1766 keerde hij terug naar"
25870 DATA"Petersburg. Kort daarop werd hij blind, maar"
25880 DATA"de overige 17 jaren van zijn leven, wijdde"
25890 DATA"hij toch nog aan zijn wiskunde- studie."
25900 DATA". Van Euler stamt de aanwijzing van het"
25910 DATA"grondtal van de nat.log. 'e'."
25920 DATA". In 1737 wees hij het eerst op de verhouding"
25930 DATA"van de omtrek van de cirkel tot zijn middel-"
25940 DATA"lijn door 'pi'. In 1748 gaf Euler 'pi' op in"
25950 DATA"127 decimalen.",". In 1749 voerde Euler het"
25960 DATA"teken 'i' in voor de IMAGINAIRE eenheid."
25970 DATA"Bekend is de VERGELIJKING van EULER:"
25980 DATA".  e^(i*A)=cos A + i * sin A"
25990 DATA".  (hoek A in boogmaat gemeten.)",". "
26000 DATA"GAUSS Carl Friedrich.",". (1777- 1855)"
26010 DATA". Geboren te Brunswijk als zoon van een"
26020 DATA"metselaar.Zelf zei hij, dat hij 'rekende,voor"
26030 DATA"hij praten kon'. De Hertog van Brunswijk liet"
26040 DATA"hem opleiden.In 1807 bood de Keizer van"
26050 DATA"Rusland hem een zetel aan in de Akademie van"
26060 DATA"Petersburg,maar Gauss koos voor het"
26070 DATA"directeurschap van de Sterrenwacht en"
26080 DATA"hoogleraar in de sterrenkunde te Goettingen."
26090 DATA". In 1799 leverde Gauss het bewijs, dat een"
26100 DATA"n-de machts- vergelijking n wortels heeft"
26110 DATA"van de vorm: a+b*i",". "
26120 DATA"HAMILTON W.R.",". (1801- 1865)."
26130 DATA". Hoogleraar in de sterrenkunde te Dublin."
26140 DATA". Door Hamilton is het woord VECTOR ingevoerd."
26150 DATA"Hij nam 3 verschillende imaginaire eenheden"
26160 DATA"aan, overeenkomend met 3 onderling recht-"
26170 DATA"hoekige richtingen in de ruimte. De 3 eenheden"
26180 DATA"duidde hij aan met i,j,k."
26190 DATA". In 1843 ontdekte Hamilton de QUATERNIONEN."
26200 DATA"Dat zijn getallen met de vorm:"
26210 DATA". a + b*i + c*j + d*k"
26220 DATA". waarbij a, b, c en d reele getallen zijn en"
26230 DATA"i, j, en k imaginaire eenheden, waarbij dan"
26240 DATA"geldt:",". i^2=-1, j^2=-1, en k^2=-1 en i*j=k"
26250 DATA". ","LEGENDRE Adrien, Marie.",". (1752- 1833)"
26260 DATA". Legendre was van 1775- 1780 belast met het"
26270 DATA"geven van wiskunde aan de militaire school"
26280 DATA"van Parijs. In 1795 werd hij hoog- leraar aan"
26290 DATA"de Normaal- school. In 1798 verscheen een"
26300 DATA"samenvatting van zijn verhandelingen over"
26310 DATA"getallen- leer: 'Essai sur la theorie des"
26320 DATA"nombres'. Bekend is ook zijn 'Methode der"
26330 DATA"kleinste kwadraten' uit de waarschijnlijk-"
26340 DATA"heids- rekening.",". "
26350 DATA"LEIBNIZ Gottfried, Wilhelm.",". Leipzig 1646-"
26360 DATA"Hannover 1716.",". Saksisch diplomaat, wijsgeer"
26370 DATA"en wiskundige. Leibniz schreef veel. Er zijn"
26380 DATA"15000 brieven van hem bewaard, die op 1000"
26390 DATA"personen betrekking hadden. In 1676 werd hij"
26400 DATA"in Hannover hof- bibliothecaris (salaris 600"
26410 DATA"thaler !) en leermeester van Sophie Charlotte,"
26420 DATA"de latere koningin van Brandenburg- Pruissen."
26430 DATA"Hij stichtte in Berlijn de Academie voor"
26440 DATA"wetenschappen en werd door de keurvorst"
26450 DATA"benoemd tot eerste president (van 1700- 1704)."
26460 DATA"Hij stond in hoog aanzien, maar stierf toch"
26470 DATA"eenzaam en verlaten. De geestelijkheid"
26480 DATA"verdacht hem van libertinisme en het volk"
26490 DATA"verbasterde zijn naam tot 'loeve- nix'= geloof"
26500 DATA"niets. Leibniz geldt als de ontwerper van de"
26510 DATA"differentiaal- en integraal- rekening (1684)."
26520 DATA"In 1684 publiceerde hij 'Ueber Maxima und"
26530 DATA"Minima usw.'. In 1668 schreef hij over"
26540 DATA"permutaties en combinaties. In 1684 gebruikte"
26550 DATA"hij voor het eerst het ':'- teken voor DELEN."
26560 DATA"Tussen 1672 en 1676 was hij veel in Parijs,"
26570 DATA"waar hij Christiaan Huygens het bekende"
26580 DATA". sqr(1+ sqr(-3))+ sqr(1- sqr(-3)) = sqr(6)"
26590 DATA"voorlegde.",". In 1714 kwam hij tot de"
26600 DATA"FORMULE van LEIBNIZ:",". "
26610 DATA" 1          1   1   1   1"
26620 DATA". - pi = 1 - - + - - - + - -...."
26630 DATA". 4          3   5   7   9",". "
26640 DATA"In 1690 stelde Leibniz in Rome het 2-tallig"
26650 DATA"stelsel op (dyadiek). Omstreeks die tijd"
26660 DATA"voerde hij het functie- begrip in. Leibniz"
26670 DATA"gaf de waarden x en y van een punt in het"
26680 DATA"vlak de naam COORDINATEN.",". "
26690 DATA"DE MOIVRE (1667- 1754).",". ","Geboren in"
26700 DATA"Frankrijk, trok hij op 18-j. leeftijd"
26710 DATA"met zijn ouders naar Londen t.g.v. de"
26720 DATA"herroeping van het Edikt van Nantes. Hij was"
26730 DATA"een vriend van Newton. Vooral oorspronkelijk"
26740 DATA"op het gebied van de driehoeks- meting. Op"
26750 DATA"latere leeftijd voorzag hij in zijn onderhoud"
26760 DATA"door in een kroeg vragen over kans- spelen"
26770 DATA"te beantwoorden. (1717 werk over kans-"
26780 DATA"rekening).",". "
26790 DATA"MARCO POLO.",". Het geldwezen en de krijgs-"
26800 DATA"kunde hadden oorspronkelijk aan eenheden"
26810 DATA"tot duizend voldoende. Het was de rijkdom"
26820 DATA"van Marco Polo, die de term millioen nodig"
26830 DATA"maakte.",". "
26840 DATA"PYTHAGORAS",". (580- 500 v.Chr.)",". Pythagoras"
26850 DATA"is geboren uit Phoenicische ouders op het"
26860 DATA"Griekse eiland Samos. Hij verbleef vele jaren"
26870 DATA"in Egypte. Toen hij naar Samos terug keerde,"
26880 DATA"stond dit onder de tyran Polykrates. Toen zijn"
26890 DATA"plan om op Samos een school te stichten"
26900 DATA"mislukte, trok hij rond 530 voor Chr. naar"
26910 DATA"Groot- Griekenland, in Zuid Italie. Hier"
26920 DATA"stichtte hij de beroemde school van"
26930 DATA"Pythagoras te Croton. Het was meer een"
26940 DATA"geheim genootschap, met strenge tucht en"
26950 DATA"allerlei geheimzinnige gebruiken. De"
26960 DATA"geheimzinnigheid maakte hen verdacht,"
26970 DATA"politieke tegenstanders verwekten een oproer"
26980 DATA"en verwoestten de gebouwen van de school."
26990 DATA". Pythagoras vluchtte naar METAPONTUM, waar"
27000 DATA"hij vermoord werd.",". De school legde zich"
27010 DATA"o.m. toe op MEETKUNDE. Aan Pythagoras wordt"
27020 DATA"o.m. toegeschreven:"
27030 DATA". -het onderscheid tussen even en"
27040 DATA".  oneven getallen."
27050 DATA". -de uitspraak:"
27060 DATA".  'Het wezen der dingen is het getal'"
27070 DATA". -de stelling:'muzikale intervallen"
27080 DATA".  zijn uit te drukken in verhoudingen"
27090 DATA".  van eenvoudige gehele getallen.'"
27100 DATA". -Het meest bekend is zijn:"
27110 DATA".  'THEOREMA van PYTHAGORAS'",". "
27120 DATA"Volgens een legende zou Pythagoras als dank"
27130 DATA"voor zijn ontdekking aan de Goden een"
27140 DATA"hecatombe (=100) ossen geofferd hebben, maar"
27150 DATA"dit is moeilijk overeen te brengen met de"
27160 DATA"theorie van de ziels- verhuizing, die tot de"
27170 DATA"leer van Pythagoras behoort.",". "
27180 DATA"    -- Einde Hist. Notities --"
27190 DATA"$$$$$"
27200 DATA". ",". ",". BEKNOPTE GESCHIEDENIS der WISKUNDE"
27210 DATA". J.Versluys - Amsterdam - 1902",". "
27220 DATA". VREEMDE WOORDEN in de WISKUNDE"
27230 DATA". E.J.Dijksterhuis - Groningen - 1939",". "
27240 DATA". WISKUNDE"
27250 DATA". E.J.E.Huffer - Roermond-Maaseik",". "
27260 DATA". DE MACHT van het GETAL"
27270 DATA". Dudley Sacket - Rotterdam",". "
27280 DATA". Van 1 X 1 naar INTEGRAAL"
27290 DATA". Colerus - Bilthoven - MCMXL",". "
27300 DATA". LAGERE ALGEBRA , eerste deel"
27310 DATA". Wijdenes - Groningen -1942",". "
27320 DATA". DE TOVERTUIN der WISKUNDE"
27330 DATA". Niklitschek - Zutphen","$$$$$"
30000 REM*****************************
30010 REM* HARRY EYCK / NEER         *
30020 REM* OP C.64  -  MAART 1989    *
30030 REM*****************************
30040 REM* COPYRIGHT NOS HILVERSUM   *
30050 REM*****************************
