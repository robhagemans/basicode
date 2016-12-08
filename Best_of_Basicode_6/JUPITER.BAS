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
 1000 A=500:GOTO 20:REM Jupitermanen
 1010 GOSUB 100:REM scherm schoon
 1020 REM eerst scherm opmeten
 1030 VE=0:FOR I=0 TO 80:HO=I:GOSUB 110
 1040 GOSUB 120:IF HO<>I THEN HP=I:I=80
 1050 NEXT I:REM voorbij rand in HP
 1060 JV=.5:REM verschil Juliaanse dag
 1080 TS=15:REM tijdstap in minuten
 1090 PRINT:PRINT:PRINT
 1100 PK=0:REM omkering
 1110 PRINT"Prismakijker of omkerende kijker? ";
 1120 GOSUB 210:REM wacht op toets
 1130 IF(IN$="p") OR(IN$="P") THEN PK=1
 1140 PRINT IN$:SR=TS:GOSUB 300
 1150 PRINT"Tijdsinterval (nu ";SR$;" minuten)";
 1160 Q$="":INPUT Q$
 1170 IF LEN(Q$)<>0 THEN TS=VAL(Q$)
 1180 REM
 1190 REM Nederlandse maanden en
 1200 REM dagen
 1210 REM
 1220 DIM NM$(12),ND$(7),ZW$(2)
 1230 FOR I=1 TO 12:READ NM$(I):NEXT I
 1240 FOR I=1 TO 7:READ ND$(I):NEXT I
 1250 ZW$(1)=" wintertijd"
 1260 ZW$(2)=" zomertijd"
 1270 GOSUB 100:REM scherm schoon
 1280 PRINT:PRINT:PRINT"Invoer:"
 1290 PRINT:PRINT
 1300 PRINT"Dag van de maand (1-31)";
 1310 INPUT D
 1320 PRINT"Maand (1-12)";
 1330 INPUT M
 1340 PRINT"Jaar";
 1350 INPUT JY
 1360 IF JY<20 THEN JY=JY+2000:REM verkorte invoer
 1370 IF JY<100 THEN JY=JY+1900:REM verkorte invoer
 1380 GOSUB 2760:REM dag van de week
 1390 PRINT
 1400 PRINT"Tijd: uren (0-23)";
 1410 INPUT UR
 1420 PRINT"Tijd: minuten (0-59)";
 1430 INPUT MU
 1440 SE=0:REM seconden
 1450 GOSUB 3080:REM zomer- of wintertijd?
 1460 REM
 1470 REM Bepaal juliaanse dag
 1480 REM
 1490 GOSUB 2760:REM juliaanse dag
 1500 JD=P-JV:REM vereiste oorsprong
 1510 GOSUB 100:REM scherm schoon
 1520 PRINT:PRINT
 1530 PRINT:PRINT:PRINT:PRINT"Even geduld aub!"
 1540 PRINT:PRINT:PRINT"Ik zoek de maantjes!"
 1550 JD=JD+.5+(UR-A+MU/60+SE/3600)/24
 1560 P1=3.141592653589:REM pi
 1570 ZZ=203.40586*JD+311.72823:REM Io
 1580 GOSUB 3940:REM hele omlopen verwijderen
 1590 AI=ZZ*P1/180:REM Io
 1600 ZZ=101.2916323*JD+3.18259:REM Europa
 1610 GOSUB 3940:REM hele omlopen verwijderen
 1620 AE=ZZ*P1/180:REM Europa
 1630 ZZ=50.23451687*JD+298.85871:REM Ganymedes
 1640 GOSUB 3940:REM hele omlopen verwijderen
 1650 AG=ZZ*P1/180:REM Ganymedes
 1660 ZZ=21.48798021*JD+163.41509:REM Callisto
 1670 GOSUB 3940:REM hele omlopen verwijderen
 1680 AC=ZZ*P1/180:REM Callisto
 1690 ZZ=.9856003*JD+170.1211:REM Aarde
 1700 GOSUB 3940:REM hele omlopen verwijderen
 1710 AA=ZZ*P1/180:REM Aarde, radialen
 1720 ZZ=.0830853*JD+30.39551
 1730 GOSUB 3940:REM hele omlopen verwijderen
 1740 I2=ZZ*P1/180:REM radialen
 1750 ZZ=.9025179*JD+228.3184
 1760 GOSUB 3940:REM hele omlopen verwijderen
 1770 P2=ZZ:REM graden
 1780 P2=P2+SIN(2*AA)/50+SIN(AA)/.5210001
 1790 P3=SIN(2*I2)*.1673+SIN(I2)*5.5372
 1800 P2=P2-P3:REM graden
 1810 AA=SQR(28.07-COS(P2*P1/180)*10.406):REM graden
 1820 J=SIN(P1/180*P2)/AA:REM graden
 1830 I3=ATN(SIN(J*P1/180)/SQR(1-SIN(J*P1/180)^2))
 1840 I3=I3*(180/P1)^2
 1850 AA=AA/173
 1860 SI=5.906*SIN(AI+P1/180*(I3-P3-(AA*203.405863)))
 1870 SE=9.397001*SIN(AE+P1/180*(I3-P3-(AA*101.2916323)))
 1880 SG=14.989*SIN(AG+P1/180*(I3-P3-(AA*50.23451687)))
 1890 SC=26.364*SIN(AC+P1/180*(I3-P3-(AA*21.48798021)))
 1900 REM
 1910 REM Omkerende kijker?
 1920 REM
 1930 IF PK=1 THEN 1980
 1940 SI=-SI:REM Io
 1950 SE=-SE:REM Europa
 1960 SG=-SG:REM Ganymedes
 1970 SC=-SC:REM Callisto
 1980 GOSUB 100:REM scherm schoon
 1990 GOSUB 3510:REM uitvoer Nederlandse tijd
 2000 PRINT:PRINT"Plaats van de Jupitermanen"
 2010 PRINT"uitgedrukt in Jupiterstralen"
 2020 PRINT"gezien in een ";
 2030 IF PK=1 THEN PRINT"prismakijker"
 2040 IF PK=0 THEN PRINT"omkerende kijker"
 2050 PRINT"(negatief links van planeet,"
 2060 PRINT"positief rechts van planeet)"
 2070 PRINT
 2080 PRINT"Io .........";
 2090 SR=SI:GOSUB 3770:REM nette uitvoer
 2100 IF ABS(SI)>1 THEN 2140:REM niet binnen planeet
 2110 W9=COS(AI+P1/180*(I3-P3-(AA*203.405863)))
 2120 IF W9>0 THEN PRINT" voor Jupiter";
 2130 IF W9<0 THEN PRINT" achter Jupiter";
 2140 PRINT
 2150 PRINT"Europa .....";
 2160 SR=SE:GOSUB 3770:REM nette uitvoer
 2170 IF ABS(SE)>1 THEN 2210:REM niet binnen planeet
 2180 W9=COS(AE+P1/180*(I3-P3-(AA*101.2916323)))
 2190 IF W9>0 THEN PRINT" voor Jupiter";
 2200 IF W9<0 THEN PRINT" achter Jupiter";
 2210 PRINT
 2220 PRINT"Ganymedes ..";
 2230 SR=SG:GOSUB 3770:REM nette uitvoer
 2240 IF ABS(SG)>1 THEN 2280:REM niet binnen planeet
 2250 W9=COS(AG+P1/180*(I3-P3-(AA*50.23451687)))
 2260 IF W9>0 THEN PRINT" voor Jupiter";
 2270 IF W9<0 THEN PRINT" achter Jupiter";
 2280 PRINT
 2290 PRINT"Callisto ...";
 2300 SR=SC:GOSUB 3770:REM nette uitvoer
 2310 IF ABS(SC)>1 THEN 2350:REM niet binnen planeet
 2320 W9=COS(AC+P1/180*(I3-P3-(AA*21.48798021)))
 2330 IF W9>0 THEN PRINT" voor Jupiter";
 2340 IF W9<0 THEN PRINT" achter Jupiter";
 2350 PRINT:PRINT:PRINT:PRINT
 2360 PRINT"     'S':     andere tijd opgeven"
 2370 PRINT"     'D':     andere datum opgeven"
 2380 PRINT"     'E':     programma stoppen"
 2390 PRINT"Andere toets: volgende tijdstip";
 2400 GOSUB 120:REM haal cursorpositie
 2410 VE=VE-5:REM naar boven
 2420 ZZ=SI:REM Io
 2430 GOSUB 4010:REM horizontale positie
 2440 PRINT"i";
 2450 ZZ=SE:REM Europa
 2460 GOSUB 4010:REM horizontale positie
 2470 PRINT"e";
 2480 ZZ=SG:REM Ganymedes
 2490 GOSUB 4010:REM horizontale positie
 2500 PRINT"g";
 2510 ZZ=SC:REM Callisto
 2520 GOSUB 4010:REM horizontale positie
 2530 PRINT"c";
 2540 ZZ=0:REM Jupiter
 2550 GOSUB 4010:REM horizontale positie
 2560 PRINT"J";
 2570 GOSUB 200:REM kijk of toets
 2580 IF IN$="" THEN 2420:REM herhaal aanzicht
 2590 IF(IN$="e") OR(IN$="E") THEN 2660
 2600 IF(IN$="d") OR(IN$="D") THEN 1270
 2610 IF(IN$<>"s") AND(IN$<>"S") THEN 2630
 2615 VE=20:HO=0:GOSUB 110
 2620 D=INT(D):M=INT(M):JY=INT(JY):GOTO 1380
 2630 GOSUB 3850:REM bezig...
 2640 JD=JD+(TS/1440):REM verder in de tijd
 2650 GOTO 1570:REM opnieuw rekenen
 2660 GOSUB 100:REM scherm schoon bij 'E'
 2670 END:REM einde
 2680 REM
 2690 REM subroutine voor
 2700 REM juliaanse datum
 2710 REM
 2720 REM(uitvoer in P,
 2730 REM weekdag in N)
 2740 REM(invoer JY,M,D)
 2750 REM
 2760 KK=M+1
 2770 L=JY-1988
 2780 IF M<3 THEN KK=KK+12:L=L-1
 2790 P=-225.5+INT(365.25*L)+INT(30.6*KK)+D
 2800 P=P+2-INT(JY/100)+INT(JY/400)
 2810 N=P+6.5-7*INT((P+5.5)/7)
 2820 RETURN
 2830 REM
 2840 REM subroutine Westerse datum
 2850 REM uit P
 2860 REM(omgekeerde van vorige
 2870 REM subroutine)
 2880 REM
 2890 IP=INT(15+(P+32257.75)/36524.25)
 2900 Z=INT(P+.5)+IP-INT(IP/4)+1
 2910 JY=1988+INT((Z+102.9)/365.25)
 2920 JP=INT(365.25*(JY-1988))
 2930 M=INT((Z-JP+225)/30.6)
 2940 D=Z-JP+225-INT(30.6*M)
 2950 F=P-.5-INT(P-.5)
 2960 D=D+F
 2970 IF M>13 THEN M=M-12:JY=JY+1
 2980 IF INT(D)=0 THEN D=D+31:M=M-1
 2990 M=M-1
 3000 GOTO 2810:REM afsluiting via
 3010 REM weekdag
 3020 REM
 3030 REM subroutine zomertijd
 3040 REM voor tijdzone Nederland
 3050 REM invoer Nederlandse tijd
 3060 REM in m,d,ur,n
 3070 REM
 3080 A=1:REM tijdzone wintertijd
 3090 IF(M<3) OR(M>9) THEN RETURN
 3100 IF(M>3) AND(M<9) THEN A=2:RETURN
 3110 IF M<>3 THEN 3170
 3120 IF D-N>=24 THEN A=2
 3130 IF(A=1) OR(N<>1) THEN RETURN
 3140 IF(UR=2) THEN UR=UR+1
 3150 IF(UR<2) THEN A=1
 3160 RETURN
 3170 IF D-N<23 THEN A=2
 3180 IF(A=2) OR(N<>1) THEN RETURN
 3190 IF(UR<2) THEN A=2:REM zomer
 3200 IF(UR<>2) THEN RETURN
 3210 PRINT"Zomertijd of wintertijd?";
 3220 GOSUB 210:PRINT:REM haal toets
 3230 IF(IN$="z") OR(IN$="Z") THEN A=2
 3240 RETURN
 3250 REM
 3260 REM subroutine zomertijd
 3270 REM voor tijdzone Nederland
 3280 REM invoer P (Juliaanse datum utc)
 3290 REM uitvoer A
 3300 REM bijprodukten: D, M, JY, N
 3310 REM
 3320 GOSUB 2890:REM utc-dag
 3330 A=1:REM tijdzone wintertijd
 3340 IF(M<3) OR(M>9) THEN RETURN
 3350 IF(M>3) AND(M<9) THEN A=2:RETURN
 3360 IF M<>3 THEN 3420:REM september
 3370 IF D-N>=24 THEN A=2:REM maart
 3380 IF(A=1) OR(INT(N)<>1) THEN RETURN
 3390 P3=N-INT(N):REM na 12 utc
 3400 IF(P3<1/24) THEN A=1:REM tot 1 utc
 3410 RETURN
 3420 IF D-N<23 THEN A=2
 3430 IF(A=2) OR(INT(N)<>1) THEN RETURN
 3440 P3=N-INT(N):REM na 12 utc
 3450 IF(P3<1/24) THEN A=2:REM tot 1 utc
 3460 RETURN
 3470 REM
 3480 REM subroutine uitvoer
 3490 REM Nederlandse tijd
 3500 REM
 3510 P=JD+JV-.5:REM voor subroutine jd->d
 3520 GOSUB 3320:REM haal D, M, JY, N, A
 3530 P=P+A/24:REM Nederlandse tijd
 3540 GOSUB 2890:REM Nederlandse datum
 3545 SR=INT(D):GOSUB 300
 3550 PRINT ND$(INT(N));" ";SR$;" ";NM$(M);" ";
 3555 SR=JY:GOSUB 300:PRINT SR$
 3560 P9=(D-INT(D))*24:REM uren
 3570 Q9=(P9-INT(P9))*60:REM minuten
 3580 R9=(Q9-INT(Q9))*60:REM seconden
 3590 SR=INT(P9):GOSUB 3680:REM nette uitvoer
 3600 PRINT":";:REM scheiding uren/minuten
 3610 SR=INT(Q9):GOSUB 3680:REM nette uitvoer
 3620 PRINT ZW$(A)
 3630 RETURN
 3640 REM
 3650 REM uitvoer twee cijfers
 3660 REM invoer sr
 3670 REM
 3680 CT=2:REM aantal cijfers
 3690 CN=0:REM niets achter komma
 3700 GOSUB 310:REM sr$ terug
 3710 PRINT SR$;
 3720 RETURN
 3730 REM
 3740 REM uitvoer +xx.xx
 3750 REM invoer sr
 3760 REM
 3770 CT=6:REM aantal posities
 3780 CN=2:REM cijfers achter komma
 3790 GOSUB 310:REM sr$ terug
 3800 PRINT SR$;
 3810 RETURN
 3820 REM
 3830 REM kalmerende mededeling
 3840 REM
 3850 HO=5:REM horizontale positie
 3860 VE=23:REM verticale positie
 3870 GOSUB 110:REM zet cursor neer
 3880 PRINT"Bezig...";
 3890 RETURN
 3900 REM
 3910 REM subroutine
 3920 REM hele omlopen verwijderen
 3930 REM
 3940 ZZ=(ZZ/360-INT(ZZ/360))*360
 3950 IF ZZ<0 THEN ZZ=ZZ+360
 3960 RETURN
 3970 REM
 3980 REM subroutine aanzicht
 3990 REM Jupitersysteem
 4000 REM
 4010 HO=(ZZ+27)/54*(HP-1):REM waar?
 4020 GOSUB 110:REM zet cursor daar
 4030 RETURN
25000 REM
25010 REM Nederlandse maand- en
25020 REM dagnamen
25030 REM
25040 DATA"januari","februari","maart"
25050 DATA"april","mei","juni","juli"
25060 DATA"augustus","september"
25070 DATA"oktober","november"
25080 DATA"december"
25090 DATA"zondag"
25100 DATA"maandag","dinsdag"
25110 DATA"woensdag","donderdag"
25120 DATA"vrijdag","zaterdag"
30000 REM
30010 REM Literatuur:
30020 REM
30030 REM Eric Burgess,
30040 REM Celestial Basic,
30050 REM bladzijde 163-171.
30060 REM
30070 REM Basicode-2:
30080 REM
30090 REM Pim van Tend
30100 REM Veldheimwg 8
30110 REM 6871 CD  RENKUM
30115 REM 08373 - 15358
30120 REM
30130 REM*************************************
30140 REM************ E I N D E **************
30150 REM*************************************
30160 REM COPYRIGHT NOS HILVERSUM
