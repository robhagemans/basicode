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
 1000 A=500:GOTO 20:REM Waar staat de maan?
 1010 GOSUB 100:REM scherm schoon
 1020 JV=-7336.5:REM verschil Juliaanse dag
 1030 NU=1E-08:REM grens voor deling door nul
 1040 REM
 1050 REM standaardpositie = Utrecht
 1060 REM
 1070 BR=52.1:REM geografische breedte
 1080 LG=5.12:REM geografische lengte (oost>0)
 1090 TS=15:REM tijdstap in minuten
 1100 PRINT:PRINT:PRINT
 1110 PRINT"Geografische breedte (nu";
 1115 SR=BR:GOSUB 4020:PRINT")";
 1120 Q$="":INPUT Q$
 1130 IF LEN(Q$)<>0 THEN BR=VAL(Q$)
 1140 PRINT"Geografische lengte (nu";
 1145 SR=LG:GOSUB 4020:PRINT")";
 1150 Q$="":INPUT Q$
 1160 IF LEN(Q$)<>0 THEN LG=VAL(Q$)
 1165 SR=TS:GOSUB 300
 1170 PRINT"Tijdsinterval (nu ";SR$;" minuten)";
 1180 Q$="":INPUT Q$
 1190 IF LEN(Q$)<>0 THEN TS=VAL(Q$)
 1200 REM
 1210 REM Nederlandse maanden en
 1220 REM dagen
 1230 REM
 1240 DIM NM$(12),ND$(7),ZW$(2)
 1250 FOR I=1 TO 12:READ NM$(I):NEXT I
 1260 FOR I=1 TO 7:READ ND$(I):NEXT I
 1270 ZW$(1)=" wintertijd"
 1280 ZW$(2)=" zomertijd"
 1290 GOSUB 100:REM scherm schoon
 1300 PRINT:PRINT:PRINT"Invoer:"
 1310 PRINT:PRINT
 1320 PRINT"Dag van de maand (1-31)";
 1330 INPUT D
 1340 PRINT"Maand (1-12)";
 1350 INPUT M
 1360 PRINT"Jaar";
 1370 INPUT JY
 1380 IF JY<20 THEN JY=JY+2000:REM verkorte invoer
 1390 IF JY<100 THEN JY=JY+1900:REM verkorte invoer
 1400 GOSUB 3010:REM dag van de week
 1410 PRINT
 1420 PRINT"Tijd: uren (0-23)";
 1430 INPUT UR
 1440 PRINT"Tijd: minuten (0-59)";
 1450 INPUT MU:SE=0
 1460 GOSUB 3330:REM zomer- of wintertijd?
 1470 REM
 1480 REM Bepaal juliaanse dag
 1490 REM
 1500 GOSUB 3010:REM juliaanse dag
 1510 JD=P-JV:REM vereiste oorsprong
 1520 GOSUB 100:REM scherm schoon
 1530 PRINT:PRINT
 1540 PRINT:PRINT:PRINT:PRINT"Even geduld aub!"
 1550 PRINT:PRINT:PRINT"Ik zoek de maan!"
 1560 JD=JD+.5+(UR-A+MU/60+SE/3600)/24
 1580 P1=3.141592653589:REM pi
 1590 V4=SIN(BR*P1/180)
 1600 V5=COS(BR*P1/180)
 1610 V3=23.45*P1/180:REM hoek dierenriem evenaar
 1620 T=68+(JD+143.001)/365.25:REM jaren sinds 1900
 1630 L=270.434+4812.678831*T:REM gemiddelde lengte maan
 1640 M=296.105+4771.988491*T:REM gem. anomalie maan
 1650 F=L-259.183+19.3414201*T:REM knoopafstand maan
 1660 M2=358.476+359.9904975*T:REM gem. anomalie zon
 1670 D=L-279.697-360.0076893*T:REM elongatie maan-zon
 1680 E=1-2.495E-05*T:REM correctie excentriciteit aardbaan
 1690 REM
 1700 REM lengte maan
 1710 REM
 1720 L=L+6.28875*SIN(M/180*P1)+.21362*SIN(M/90*P1)
 1730 L=L+1.27402*SIN((2*D-M)/180*P1)
 1740 L=L+.65831*SIN(D/90*P1)
 1750 L=L-.1856*E*SIN(M2/180*P1)
 1760 L=L-.11434*SIN(F/90*P1)
 1770 L=L-.05879*SIN((M-D)/90*P1)
 1780 L=L+.05721*E*SIN((2*D-M2-M)/180*P1)
 1790 L=L+.05332*SIN((2*D+M)/180*P1)
 1800 L=L+.04587*E*SIN((2*D-M2)/180*P1)
 1810 L=L+.04101*E*SIN((M-M2)/180*P1)
 1820 L=L-.03476*SIN(D/180*P1)
 1830 L=L-.03046*E*SIN((M2+M)/180*P1)
 1840 L=L-360*INT(L/360)
 1850 REM
 1860 REM breedte maan
 1870 REM
 1880 B=0
 1890 B=B+5.12819*SIN(F/180*P1)
 1900 B=B+.28061*SIN((F+M)/180*P1)
 1910 B=B+.27769*SIN((M-F)/180*P1)
 1920 B=B+.17324*SIN((2*D-F)/180*P1)
 1930 B=B+.05541*SIN((2*D+F-M)/180*P1)
 1940 B=B+.04627*SIN((2*D-F-M)/180*P1)
 1950 B=B+.03257*SIN((2*D+F)/180*P1)
 1960 REM
 1970 REM V1 is rechte klimming maan
 1980 REM
 1990 Q9=TAN(B*P1/180)
 2000 IF ABS(Q9)<NU THEN Q9=NU
 2010 V=ATN(SIN(L*P1/180)/Q9)
 2020 IF ABS(SIN(V))>NU THEN 2060
 2030 V1=SIN(V-V3)/COS(V)*TAN(B*P1/180)
 2040 V1=ATN(V1/COS(L*P1/180))
 2050 GOTO 2070:REM ontwijk deling door nul
 2060 V1=ATN(SIN(V-V3)/SIN(V)*TAN(L*P1/180))
 2070 IF L>90 THEN 2110
 2080 IF V<0 THEN 2200
 2090 IF V-V3<0 THEN 2160
 2100 GOTO 2200
 2110 IF L>270 THEN 2140
 2120 V1=V1+P1
 2130 GOTO 2200
 2140 IF V<0 THEN 2160
 2150 IF V-V3<0 THEN 2200
 2160 V1=V1+2*P1
 2170 REM
 2180 REM V2 is declinatie maan
 2190 REM
 2200 V2=ATN(SIN(V1)/TAN(V-V3))
 2210 T9=(-14+(JD-231.1094)/365.2422)*366.2422+.3026496
 2220 T9=T9+LG/360:REM locale sterretijd
 2230 T9=(T9-INT(T9))*2*P1:REM in radialen
 2240 T3=T9-V1:REM uurhoek in radialen
 2250 IF T3>0 THEN 2270
 2260 T3=T3+2*P1
 2270 Z1=V4*SIN(V2)+V5*COS(V2)*COS(T3)
 2280 Z2=ATN(SQR(1-Z1*Z1)/Z1):REM zenitafstand
 2290 Z3=(-V5*SIN(V2)+V4*COS(V2)*COS(T3))/SIN(Z2)
 2300 IF Z3>1 THEN Z3=1
 2310 IF Z3<-1 THEN Z3=-1
 2320 Z4=ATN(SQR(1-Z3*Z3)/Z3)+P1
 2330 IF Z3>0 THEN 2350
 2340 Z4=Z4+P1
 2350 IF T3<=P1 THEN 2370
 2360 Z4=2*P1-Z4
 2370 GOSUB 100:REM scherm schoon
 2380 GOSUB 3760:REM uitvoer Nederlandse tijd
 2390 HE=90-Z2*180/P1:REM hoogte in graden
 2400 IF Z1<0 THEN HE=HE-180:REM onder horizon
 2410 PRINT:PRINT"Ten opzichte van de horizon:"
 2420 PRINT"Hoogte: ";
 2430 SR=HE:GOSUB 4020:REM nette uitvoer
 2440 PRINT" graden"
 2450 AZ=Z4/P1*180-360*INT(Z4/P1/2)
 2460 IF Z1<0 THEN AZ=540-AZ:REM onder horizon
 2470 IF AZ>360 THEN AZ=AZ-360:REM voorbij noorden
 2480 IF AZ<0 THEN AZ=AZ+360
 2490 PRINT"Azimut: ";
 2500 SR=AZ:GOSUB 4020:REM nette uitvoer
 2510 PRINT" graden"
 2520 PRINT:PRINT"Tussen de sterren:"
 2530 V9=24*V1/2/P1
 2540 PRINT"Rechte klimming: ";
 2550 SR=INT(V9):GOSUB 3930:REM nette uitvoer
 2560 PRINT" uur ";
 2570 SR=INT((V9-INT(V9))*60):REM minuten
 2580 GOSUB 3930:REM mooie vorm
 2590 PRINT" minuten"
 2600 V8=360*V2/2/P1
 2610 PRINT"Declinatie: ";
 2620 SR=INT(V8):IF SR<0 THEN SR=SR+1
 2630 GOSUB 300:REM mooie vorm
 2640 IF INT(V8)=-1 THEN SR$="-"+SR$
 2650 PRINT SR$;" graden ";
 2660 SR=ABS(INT((V8-SR)*60)):REM minuten
 2670 GOSUB 300:REM mooie vorm
 2680 PRINT SR$;" minuten"
 2690 PRINT"Breedte:";
 2700 SR=B:GOSUB 4020:REM nette uitvoer
 2710 PRINT" graden"
 2720 PRINT:PRINT"Plaatselijke sterretijd:"
 2730 V9=24*T9/2/P1
 2740 SR=INT(V9):GOSUB 3930:REM nette uitvoer
 2750 PRINT" uur ";
 2760 SR=INT((V9-INT(V9))*60):REM minuten
 2770 GOSUB 3930:REM mooie vorm
 2780 PRINT" minuten"
 2790 PRINT:PRINT"     'S':     andere tijd opgeven"
 2800 PRINT:PRINT"     'D':     andere datum opgeven"
 2810 PRINT:PRINT"     'E':     programma stoppen"
 2820 PRINT:PRINT"Andere toets: volgende tijdstip"
 2830 GOSUB 210:REM haal toets
 2840 IF(IN$="e") OR(IN$="E") THEN 2910
 2850 IF(IN$="d") OR(IN$="D") THEN 1290
 2860 IF(IN$<>"s") AND(IN$<>"S") THEN 2880
 2870 D=INT(D):M=INT(M):JY=INT(JY):GOTO 1400
 2880 GOSUB 4100:REM bezig...
 2890 JD=JD+(TS/1440):REM verder in de tijd
 2900 GOTO 1620:REM opnieuw rekenen
 2910 GOSUB 100:REM scherm schoon bij 'E'
 2920 END:REM einde
 2930 REM
 2940 REM subroutine voor
 2950 REM juliaanse datum
 2960 REM
 2970 REM(uitvoer in P,
 2980 REM weekdag in N)
 2990 REM(invoer JY,M,D)
 3000 REM
 3010 KK=M+1
 3020 L=JY-1988
 3030 IF M<3 THEN KK=KK+12:L=L-1
 3040 P=-225.5+INT(365.25*L)+INT(30.6*KK)+D
 3050 P=P+2-INT(JY/100)+INT(JY/400)
 3060 N=P+6.5-7*INT((P+5.5)/7)
 3070 RETURN
 3080 REM
 3090 REM subroutine Westerse datum
 3100 REM uit P
 3110 REM(omgekeerde van vorige
 3120 REM subroutine)
 3130 REM
 3140 IP=INT(15+(P+32257.75)/36524.25)
 3150 Z=INT(P+.5)+IP-INT(IP/4)+1
 3160 JY=1988+INT((Z+102.9)/365.25)
 3170 JP=INT(365.25*(JY-1988))
 3180 M=INT((Z-JP+225)/30.6)
 3190 D=Z-JP+225-INT(30.6*M)
 3200 F=P-.5-INT(P-.5)
 3210 D=D+F
 3220 IF M>13 THEN M=M-12:JY=JY+1
 3230 IF INT(D)=0 THEN D=D+31:M=M-1
 3240 M=M-1
 3250 GOTO 3060:REM afsluiting via
 3260 REM weekdag
 3270 REM
 3280 REM subroutine zomertijd
 3290 REM voor tijdzone Nederland
 3300 REM invoer Nederlandse tijd
 3310 REM in m,d,ur,n
 3320 REM
 3330 A=1:REM tijdzone wintertijd
 3340 IF(M<3) OR(M>9) THEN RETURN
 3350 IF(M>3) AND(M<9) THEN A=2:RETURN
 3360 IF M<>3 THEN 3420
 3370 IF D-N>=24 THEN A=2
 3380 IF(A=1) OR(N<>1) THEN RETURN
 3390 IF(UR=2) THEN UR=UR+1
 3400 IF(UR<2) THEN A=1
 3410 RETURN
 3420 IF D-N<23 THEN A=2
 3430 IF(A=2) OR(N<>1) THEN RETURN
 3440 IF(UR<2) THEN A=2:REM zomer
 3450 IF(UR<>2) THEN RETURN
 3460 PRINT"Zomertijd of wintertijd?";
 3470 GOSUB 210:PRINT:REM haal toets
 3480 IF(IN$="z") OR(IN$="Z") THEN A=2
 3490 RETURN
 3500 REM
 3510 REM subroutine zomertijd
 3520 REM voor tijdzone Nederland
 3530 REM invoer P (Juliaanse datum utc)
 3540 REM uitvoer A
 3550 REM bijprodukten: D, M, JY, N
 3560 REM
 3570 GOSUB 3140:REM utc-dag
 3580 A=1:REM tijdzone wintertijd
 3590 IF(M<3) OR(M>9) THEN RETURN
 3600 IF(M>3) AND(M<9) THEN A=2:RETURN
 3610 IF M<>3 THEN 3670:REM september
 3620 IF D-N>=24 THEN A=2:REM maart
 3630 IF(A=1) OR(INT(N)<>1) THEN RETURN
 3640 P3=N-INT(N):REM na 12 utc
 3650 IF(P3<1/24) THEN A=1:REM tot 1 utc
 3660 RETURN
 3670 IF D-N<23 THEN A=2
 3680 IF(A=2) OR(INT(N)<>1) THEN RETURN
 3690 P3=N-INT(N):REM na 12 utc
 3700 IF(P3<1/24) THEN A=2:REM tot 1 utc
 3710 RETURN
 3720 REM
 3730 REM subroutine uitvoer
 3740 REM Nederlandse tijd
 3750 REM
 3760 P=JD+JV-.5:REM voor subroutine jd->d
 3770 GOSUB 3570:REM haal D, M, JY, N, A
 3780 P=P+A/24:REM Nederlandse tijd
 3790 GOSUB 3140:REM Nederlandse datum
 3795 SR=INT(D):GOSUB 300
 3800 PRINT ND$(INT(N));" ";SR$;" ";NM$(M);" ";
 3805 SR=JY:GOSUB 300:PRINT SR$
 3810 P9=(D-INT(D))*24:REM uren
 3820 Q9=(P9-INT(P9))*60:REM minuten
 3830 R9=(Q9-INT(Q9))*60:REM seconden
 3840 SR=INT(P9):GOSUB 3930:REM nette uitvoer
 3850 PRINT":";:REM scheiding uren/minuten
 3860 SR=INT(Q9):GOSUB 3930:REM nette uitvoer
 3870 PRINT ZW$(A)
 3880 RETURN
 3890 REM
 3900 REM uitvoer twee cijfers
 3910 REM invoer sr
 3920 REM
 3930 CT=2:REM aantal cijfers
 3940 CN=0:REM niets achter komma
 3950 GOSUB 310:REM sr$ terug
 3960 PRINT SR$;
 3970 RETURN
 3980 REM
 3990 REM uitvoer +xx.xx
 4000 REM invoer sr
 4010 REM
 4020 CT=6:REM aantal posities
 4030 CN=2:REM cijfers achter komma
 4040 GOSUB 310:REM sr$ terug
 4050 PRINT SR$;
 4060 RETURN
 4070 REM
 4080 REM kalmerende mededeling
 4090 REM
 4100 HO=5:REM horizontale positie
 4110 VE=23:REM verticale positie
 4120 GOSUB 110:REM zet cursor neer
 4130 PRINT"Bezig...";
 4140 RETURN
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
30000 REM*************************************
30010 REM
30020 REM Belangrijkste veranderingen ten
30030 REM opzichte van de vorige versie:
30040 REM
30050 REM- Er zat een fout in de tijd.
30060 REM- Nederlandse winter- en zomertijd.
30070 REM- Vertaald naar het Nederlands.
30080 REM- Alles is wat netter gemaakt.
30090 REM
30100 REM Eerste versie van dit programma:
30110 REM Helmut Strasser (Oostenrijk)
30120 REM
30130 REM Tweede versie, maart 1984:
30140 REM Dieter Detmers (DH1BAI)
30150 REM Weserstrasse 47/49
30160 REM D-2970  Emden (W-Duitsland)
30170 REM
30180 REM Aan deze derde versie werkten:
30190 REM Rob van Gent,
30200 REM Sterrewacht Utrecht
30210 REM en
30220 REM Pim van Tend
30230 REM Veldheimwg 8
30240 REM 6871 CD  RENKUM
30245 REM 08373 - 15358
30250 REM
30260 REM*************************************
30270 REM************ E I N D E **************
30280 REM*************************************
30290 REM COPYRIGHT NOS HILVERSUM
