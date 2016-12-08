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
 1000 A=500:GOTO 20:REM HIGH-EN LOW-PASS FILTERS
 1010 DIM A(43):PY=3.14159:J=0:GOTO 3110
 1020 REM NIEUWE PAGINA
 1030 PRINT"DRUK EEN TOETS VOOR VERVOLG  ";:GOSUB 210
 1040 GOSUB 100:RETURN
 1050 K=0
 1060 R5=R
 1070 IF R5<=1 THEN 1100
 1080 R5=R5/10
 1090 K=K+1:GOTO 1070
 1100 D=1:E=EM
 1110 M=INT((D+E)/2)
 1120 IF M=D THEN 1160
 1130 IF R5=A(M) THEN 1180
 1140 IF R5<A(M) THEN E=M:GOTO 1110
 1150 IF R5>A(M) THEN D=M:GOTO 1110
 1160 IF(R5-A(D))<(A(E)-R5) THEN R5=A(D):GOTO 1180
 1170 R5=A(E)
 1180 R5=R5*10^K
 1190 IF R5>10 THEN R5=INT(R5+.5)
 1200 RETURN
 1210 IF C<1E-09 THEN C=C*1000000000000:X$=" pF":RETURN
 1220 IF(C>=1E-09) AND(C<1E-06) THEN X$=" nF"
 1230 IF(C>=1E-09) AND(C<1E-06) THEN C=C*1000000000:RETURN
 1240 IF C>=1E-06 THEN C=C*1000000:X$=" uF"
 1250 RETURN
 1260 IF R<1000 THEN Y$=" Ohm":RETURN
 1270 IF(R>=1000) AND(R<1000000) THEN Y$=" kOhm"
 1280 IF(R>=1000) AND(R<1000000) THEN R=R*1E-03:RETURN
 1290 IF R>=1000000 THEN R=R*1E-06:Y$=" mOhm"
 1300 RETURN
 1310 PRINT"  +--------------+------------------+"
 1320 PRINT"  !     Lowpass  !                  !"
 1330 PRINT" +-+    filter   !     +------+    +-+"
 1340 PRINT" ! !    1.orde   !     !      !    ! !"
 1350 PRINT" ! ! R2          !     +1    8+ R3 ! !"
 1360 PRINT" ! !             !     !      !    ! !"
 1370 PRINT" +-+    ! !      +-----+2    7+U+  +-+"
 1380 PRINT"  !     ! ! C1         !      !     !"
 1390 PRINT"  +-----! !------+-----+3    6+-----+"
 1400 PRINT"  !     ! !      !     !      !     !"
 1410 PRINT"  !     ! !     +-+  U-+4    5+     !"
 1420 PRINT"  !             ! !    !      !     !"
 1430 PRINT"  !             ! !    +------+     !"
 1440 PRINT"  !             ! ! R1              !"
 1450 PRINT"  !             +-+      UA-741     !"
 1460 PRINT"  !              !                  !"
 1470 PRINT"  0 MASSA        0 IN           UIT 0"
 1480 PRINT:RETURN
 1490 PRINT:PRINT"VERSTERKING:V=1+(R3/R2)"
 1500 PRINT:GOSUB 1030
 1510 IF FK$="H" THEN 2680
 1520 GOTO 2480
 1530 PRINT"  +-------------+------------------+"
 1540 PRINT"  !    Highpass !                  !"
 1550 PRINT" +-+    filter  !     +------+    +-+"
 1560 PRINT" ! !    1.orde  !     !      !    ! !"
 1570 PRINT" ! ! R2         !     +1    8+ R3 ! !"
 1580 PRINT" ! !            !     !      !    ! !"
 1590 PRINT" +-+     ! !    +-----+2    7+U+  +-+"
 1600 PRINT"  !      ! ! C1       !      !     !"
 1610 PRINT"  !  0---! !----+-----+3    6+-----+"
 1620 PRINT"  !  IN  ! !    !     !      !     !"
 1630 PRINT"  !      ! !   +-+  -U+4    5+     !"
 1640 PRINT"  !            ! !    !      !     !"
 1650 PRINT"  !         R1 ! !    +------+     !"
 1660 PRINT"  !            ! !                 !"
 1670 PRINT"  !            +-+     UA-741      !"
 1680 PRINT"  !             !                  !"
 1690 PRINT"  +-------------0 MASSA        UIT 0"
 1700 PRINT:RETURN
 1710 PRINT"   Lowpass       +------------------+"
 1720 PRINT"   filter        !                  !"
 1730 PRINT"   1.orde        !     +------+     !"
 1740 PRINT"                 !     !      !     !"
 1750 PRINT"   V=1           !     +1    8+     !"
 1760 PRINT"                 !     !      !     !"
 1770 PRINT"        ! !      +-----+2    7+U+   !"
 1780 PRINT"        ! ! C1         !      !     !"
 1790 PRINT"  +-----! !------+-----+3    6+-----+"
 1800 PRINT"  !     ! !      !     !      !     !"
 1810 PRINT"  !     ! !     +-+  U-+4    5+     !"
 1820 PRINT"  !             ! !    !      !     !"
 1830 PRINT"  0             ! !    +------+     !"
 1840 PRINT"  MASSA         ! ! R1              !"
 1850 PRINT"                +-+      UA-741     !"
 1860 PRINT"                 !                  !"
 1870 PRINT"                 0 IN           UIT 0"
 1880 PRINT:RETURN
 1890 PRINT"  Highpass      +------------------+"
 1900 PRINT"  filter        !                  !"
 1910 PRINT"  1.orde        !     +------+     !"
 1920 PRINT"                !     !      !     !"
 1930 PRINT"  V=1           !     +1    8+     !"
 1940 PRINT"                !     !      !     !"
 1950 PRINT"         ! !    +-----+2    7+U+   !"
 1960 PRINT"         ! ! C1       !      !     !"
 1970 PRINT"  0------! !----+-----+3    6+-----+"
 1980 PRINT"  IN     ! !    !     !      !     !"
 1990 PRINT"         ! !   +-+  -U+4    5+     !"
 2000 PRINT"               ! !    !      !     !"
 2010 PRINT"            R1 ! !    +------+     !"
 2020 PRINT"               ! !                 !"
 2030 PRINT"               +-+     UA-741      !"
 2040 PRINT"                !                  !"
 2050 PRINT"                0 MASSA        UIT 0"
 2060 PRINT:RETURN
 2070 PRINT"                  ! !    +------------+"
 2080 PRINT"  Lowpass         ! !    !            !"
 2090 PRINT"  filter     +----! !----+  +------+  !"
 2100 PRINT"  2.orde     !    ! ! C4 !  !      !  !"
 2110 PRINT"             !    ! !    !  +1    8+  !"
 2120 PRINT"             !           !  !      !  !"
 2130 PRINT"             !           +--+2    7+U+!"
 2140 PRINT"    +-----+  !  +-----+     !      !  !"
 2150 PRINT"0---! R1  !--+--! R2  !--+--+3    6+--+"
 2160 PRINT"IN  +-----+     +-----+  !  !      !  !"
 2170 PRINT"                         !-U+4    5+  !"
 2180 PRINT"                         !  !      !  !"
 2190 PRINT"                  ! !    !  +------+  !"
 2200 PRINT"                  ! ! C3 !            !"
 2210 PRINT"       MASSA 0----! !----+   UA-741   !"
 2220 PRINT"                  ! !                 !"
 2230 PRINT"                  ! !             UIT 0"
 2240 PRINT:RETURN
 2250 PRINT"Versterking:V=1"
 2260 PRINT"R1=R2   C4=2*C3"
 2270 PRINT:GOSUB 1030:GOTO 2480
 2280 PRINT"                       +--------------+"
 2290 PRINT"Highpass     +-----+   !              !"
 2300 PRINT"filter    +--! R1  !---+   +------+   !"
 2310 PRINT"2.orde    !  +-----+   !   !      !   !"
 2320 PRINT"          !            !   +1    8+   !"
 2330 PRINT"          !            !   !      !   !"
 2340 PRINT"    ! !   !    ! !     +---+2    7+U+ !"
 2350 PRINT"    ! !   !    ! !         !      !   !"
 2360 PRINT"0---! !---+----! !-----+---+3    6+---+"
 2370 PRINT"IN  ! ! C3     ! ! C4  !   !      !   !"
 2380 PRINT"    ! !        ! !     ! -U+4    5+   !"
 2390 PRINT"                       !   !      !   !"
 2400 PRINT"                       !   +------+   !"
 2410 PRINT"             +-----+   !    UA-741    !"
 2420 PRINT"   MASSA 0---! R2  !---+              !"
 2430 PRINT"             +-----+              UIT 0"
 2440 PRINT:RETURN
 2450 PRINT"Versterking:V=1"
 2460 PRINT"C3=C4   R2=2*R1"
 2470 PRINT:GOSUB 1030:GOTO 2680
 2480 PRINT"-dB"
 2490 PRINT" 0 !................"
 2500 PRINT" 3 !                +  =Grensfrequentie"
 2510 PRINT" 9 !                 .              Fg."
 2520 PRINT"12 !                  ."
 2530 PRINT"15 !                   ."
 2540 PRINT"18 !  Lowpass-filter    ."
 2550 PRINT"21 !                     ."
 2560 PRINT"24 !                      .   Sperfreq."
 2570 PRINT"27 !                       .    Fs>Fg"
 2580 PRINT"30 !                        ."
 2590 PRINT"33 !   Voorbeeld grafiek     ."
 2600 PRINT"36 !   met norm-frequentie    ."
 2610 PRINT"39 !                           ."
 2620 PRINT"42 !                            ."
 2630 PRINT"45 !                             ."
 2640 PRINT"48 !                              ."
 2650 PRINT"   +-----+----+---+--+-----+----+---+--"
 2660 PRINT"F*.1    .2   .4  .7  1     2    4   7 10"
 2670 GOSUB 1030:GOTO 3630
 2680 PRINT"-dB"
 2690 PRINT" 0 !                  ................."
 2700 PRINT" 3 !Grensfrequentie  +"
 2710 PRINT" 9 ! Fg             ."
 2720 PRINT"12 !               ."
 2730 PRINT"15 !              ."
 2740 PRINT"18 !             .     Highpass-filter"
 2750 PRINT"21 !            ."
 2760 PRINT"24 ! Sper-     ."
 2770 PRINT"27 ! freq.    ."
 2780 PRINT"30 ! Fs<Fg   ."
 2790 PRINT"33 !        .        Voorbeeld grafiek"
 2800 PRINT"36 !       .        met norm-frequentie"
 2810 PRINT"39 !      ."
 2820 PRINT"42 !     ."
 2830 PRINT"45 !    ."
 2840 PRINT"48 !   ."
 2850 PRINT"   +-----+----+---+--+-----+----+---+--"
 2860 PRINT"F*.1    .2   .4  .7  1     2    4   7 10"
 2870 GOSUB 1030
 2880 GOTO 3630
 2890 PRINT"-dB"
 2900 PRINT" 0 !  Fg.        ......."
 2910 PRINT" 3 !  Highpass  +   Fm  +  Fg.Lowpass"
 2920 PRINT" 6 !           .         ."
 2930 PRINT" 9 !          .           ."
 2940 PRINT"12 !         .             ."
 2950 PRINT"15 !        .               ."
 2960 PRINT"18 !       .                 ."
 2970 PRINT"21 !      .                   ."
 2980 PRINT"24 !     .                     ."
 2990 PRINT"27 !    .       VOORBEELD       ."
 3000 PRINT"30 !   .     grafiek voor een    ."
 3010 PRINT"33 !  .      breedband-filter     ."
 3020 PRINT"36 ! .                             ."
 3030 PRINT"39 !.        Fm=SQR(FgLP*FgHP)      ."
 3040 PRINT"42 !         Q =Fm/(FgLP-FgHP)       ."
 3050 PRINT"45 !"
 3060 PRINT"   +---+---+--+-+-------+---+---+--+-+"
 3070 PRINT"F*.1  .2  .4 .7 1       1   2   4  7 10"
 3080 PRINT
 3090 PRINT"         * DANK VOOR UW AANDACHT *"
 3100 RETURN
 3110 GOSUB 100
 3120 PRINT"+++++++++++++++++++++++++++++++++++++++"
 3130 PRINT"+  AKTIEVE HIGH- EN LOW-PASS FILTERS  +"
 3140 PRINT"+++++++++++++++++++++++++++++++++++++++"
 3150 PRINT
 3160 PRINT"Voor deze filters worden de berekening"
 3170 PRINT"en samenstelling tot de 1.en 2.orde"
 3180 PRINT"behandeld,waarna U zelf in staat zult"
 3190 PRINT"zyn filters tot een hogere orde samen"
 3200 PRINT"te stellen door een kaskade-schakeling."
 3210 PRINT
 3220 PRINT"Door kaskade-schakeling van een Low-en"
 3230 PRINT"een High-pass filter kan een breedband-"
 3240 PRINT"filter worden opgebouwd.Een grafische"
 3250 PRINT"voorstelling van zo een breedbandfilter"
 3260 PRINT"ziet U aan het einde van dit programma."
 3270 PRINT:PRINT
 3280 PRINT"BASICODE-2 * PA0MAX * N.O.S.-HOBBYSCOOP"
 3290 PRINT:PRINT
 3300 GOSUB 1030:GOTO 3330
 3310 GOSUB 100:FK$="":Q$="":V$="":FG$="":FS$=""
 3320 RESTORE
 3330 PRINT"KIES HIGHPASS = H  OF LOWPASS = L ";
 3340 INPUT FK$
 3350 IF(FK$="H") OR(FK$="h") THEN FK$="H":GOTO 3390
 3360 IF(FK$="L") OR(FK$="l") THEN FK$="L":GOTO 3390
 3370 HO=35:VE=0:GOSUB 110:PRINT"   "
 3380 HO=0:VE=0:GOSUB 110:GOTO 3330
 3390 PRINT
 3400 PRINT"TOT DE 1.ORDE = 1  OF 2.ORDE  = 2 ";
 3410 INPUT Q$:Q=VAL(Q$)
 3420 IF(Q=1) OR(Q=2) THEN 3450
 3430 HO=35:VE=2:GOSUB 110:PRINT"   "
 3440 HO=0:VE=2:GOSUB 110:GOTO 3400
 3450 PRINT:IF Q=2 THEN 3510
 3460 PRINT"MET EEN VERSTERKING TUSSEN 1 EN 8 ";
 3470 INPUT V$:V=VAL(V$)
 3480 IF(V>=1) AND(V<=8) THEN 3520
 3490 HO=35:VE=4:GOSUB 110:PRINT"   "
 3500 HO=0:VE=4:GOSUB 110:GOTO 3460
 3510 PRINT"VERSTERKING FILTER TOT DE 2.ORDE = 1":V=1:VV=0
 3520 PRINT:IF J=1 THEN 3660
 3530 PRINT"VERVOLGENS KOMEN DE VOOR U GESCHIKTE"
 3540 PRINT"SCHAKELING EN GRAFIEK OP HET SCHERM."
 3550 PRINT:PRINT
 3560 GOSUB 1030
 3570 IF(FK$="L") AND(Q=1) AND(V>1) THEN GOSUB 1310:GOTO 1490
 3580 IF(FK$="L") AND(Q=1) AND(V=1) THEN GOSUB 1710:GOTO 1500
 3590 IF(FK$="H") AND(Q=1) AND(V>1) THEN GOSUB 1530:GOTO 1490
 3600 IF(FK$="H") AND(Q=1) AND(V=1) THEN GOSUB 1890:GOTO 1500
 3610 IF(FK$="L") AND(Q=2) THEN GOSUB 2070:GOTO 2250
 3620 IF(FK$="H") AND(Q=2) THEN GOSUB 2280:GOTO 2450
 3630 IF FK$="L" THEN PRINT"LOW- PASS FILTER"
 3640 IF FK$="H" THEN PRINT"HIGH-PASS FILTER"
 3650 PRINT"================":PRINT
 3660 PRINT"GRENSFREQUENTIE 10-50000 HERZ ";
 3670 INPUT FG$:FG=VAL(FG$)
 3680 IF(FG>=10) AND(FG<=50000) THEN 3730
 3690 HO=32:VE=3:IF J=1 THEN VE=6
 3700 GOSUB 110:PRINT"       "
 3710 HO=0:VE=3:IF J=1 THEN VE=6
 3720 GOSUB 110:GOTO 3660
 3730 PRINT
 3740 IF FK$="H" THEN 3820
 3750 PRINT"SPERFREQUENTIE > GRENSFREQ. ";
 3760 INPUT FS$:FS=VAL(FS$)
 3770 IF FS>FG THEN 3890
 3780 HO=30:VE=5:IF J=1 THEN VE=8
 3790 GOSUB 110:PRINT"        "
 3800 HO=0:VE=5:IF J=1 THEN VE=8
 3810 GOSUB 110:GOTO 3750
 3820 PRINT"SPERFREQUENTIE < GRENSFREQ. ";
 3830 INPUT FS$:FS=VAL(FS$)
 3840 IF(FS<FG) AND(FS>0) THEN 3890
 3850 HO=30:VE=5:IF J=1 THEN VE=8
 3860 GOSUB 110:PRINT"        "
 3870 HO=0:VE=5:IF J=1 THEN VE=8
 3880 GOSUB 110:GOTO 3820
 3890 J=0:Z=FS/FG
 3900 PRINT:IF Q=2 THEN 4110
 3910 IF V>1 THEN R2=10000
 3920 IF V=1 THEN R2=0
 3930 R3=(V-1)*R2
 3940 VV=INT((20*LOG(V)/LOG(10)*100))/100
 3950 C=2E-05/((FG+FS)/2)
 3960 CC=INT(C*10000000000+.01)/10000000000
 3970 R1=1/(2*PY*C*FG)
 3980 IF FK$="L" THEN A=-10*LOG(Z^2)/LOG(10)
 3990 IF FK$="H" THEN A=-10*LOG(1/Z^2)/LOG(10)
 4000 AA=INT(A*100)/100
 4010 GOTO 4220
 4020 SR=R1:GOSUB 10000
 4030 PRINT"Weerstand       R1 = ";SR$;" Ohm"
 4040 SR=R2:GOSUB 10000
 4050 PRINT"Weerstand       R2 = ";SR$;" Ohm"
 4060 SR=R3:GOSUB 10000
 4070 PRINT"Weerstand       R3 = ";SR$;" Ohm"
 4080 SR=CC:GOSUB 10000
 4090 PRINT"Condensator     C1 = ";SR$;" Farad"
 4100 GOTO 4380
 4110 C=2E-05/((FG+FS)/2)
 4120 R=SQR(1/(2^3*PY^2*C^2*FG^2))
 4130 IF FK$="L" THEN 4180
 4140 R1=INT(R):R2=INT(2*R)
 4150 C3=INT(C*10000000000+.01)/10000000000:C4=C3
 4160 A=-10*LOG(1/Z^4)/LOG(10)
 4170 GOTO 4210
 4180 R1=INT(R):R2=R1
 4190 C3=INT(C*10000000000+.01)/10000000000:C4=2*C3
 4200 A=-10*LOG(Z^4)/LOG(10)
 4210 AA=INT(A*100)/100
 4220 PRINT"HIERUIT VOLGT VOORLOPIG:"
 4230 PRINT:SR=FG:GOSUB 10000
 4240 PRINT"Grensfrequentie Fg = ";SR$;" Herz"
 4250 SR=FS:GOSUB 10000
 4260 PRINT"Sperfrequentie  Fs = ";SR$;" Herz"
 4270 SR=V:GOSUB 10000:PRINT"De versterking  V  = ";SR$;
 4280 SR=VV:GOSUB 10000:PRINT" = ";SR$;" dB."
 4290 IF Q=1 THEN 4020
 4300 SR=R1:GOSUB 10000
 4310 PRINT"Weerstand       R1 = ";SR$;" Ohm"
 4320 SR=R2:GOSUB 10000
 4330 PRINT"Weerstand       R2 = ";SR$;" Ohm"
 4340 SR=C3:GOSUB 10000
 4350 PRINT"Condensator     C3 = ";SR$;" Farad"
 4360 SR=C4:GOSUB 10000
 4370 PRINT"Condensator     C4 = ";SR$;" Farad"
 4380 PRINT:PRINT:C=C*1000000000000
 4390 GOSUB 1030
 4400 PRINT"MOMENT SVP"
 4410 EM=25:FOR I=1 TO 25:READ A(I):NEXT I
 4420 R=C:GOSUB 1050:C=R5
 4430 C=R5*1E-12:IF Q=2 THEN 4800
 4440 R1=1/(2*PY*C*FG)
 4450 GOSUB 1210
 4460 C1=C:C=R5*1E-12
 4470 EM=43:FOR I=1 TO 43:READ A(I):NEXT I
 4480 R=R1:GOSUB 1050:R=R5
 4490 GOSUB 1260
 4500 R1=R:R=R5:Z$=Y$
 4510 FG=INT(1/(2*PY*C*R)*100)/100
 4520 R=R2:GOSUB 1260:R2=R
 4530 IF V=1 THEN 4550
 4540 R=R3:GOSUB 1050:R=R5
 4550 GOSUB 1260:R3=R
 4560 IF V=1 THEN 4580
 4570 V1=1+(R3/R2):V=INT(V1*10)/10
 4580 VV=INT((20*LOG(V)/LOG(10)*100))/100
 4590 GOSUB 100
 4600 IF(FK$="H") AND(V=1) THEN GOSUB 1890:GOTO 4640
 4610 IF(FK$="L") AND(V=1) THEN GOSUB 1710:GOTO 4640
 4620 IF FK$="H" THEN GOSUB 1530
 4630 IF FK$="L" THEN GOSUB 1310
 4640 SR=C1:GOSUB 10000:PRINT"C1 = ";SR$;X$;TAB(20);
 4650 SR=FG:GOSUB 10000:PRINT"Fg = ";SR$;" Herz"
 4660 SR=R1:GOSUB 10000:PRINT"R1 = ";SR$;Z$;TAB(20);
 4670 SR=FS:GOSUB 10000:PRINT"Fs = ";SR$;" Herz"
 4680 IF V>1 THEN 4730
 4690 SR=V:GOSUB 10000:PRINT"V = ";SR$;
 4700 SR=VV:GOSUB 10000:PRINT" = ";SR$;" dB.";TAB(20);
 4710 SR=AA:GOSUB 10000:PRINT"Fs:Fg = ";SR$;" dB."
 4720 GOTO 5010
 4730 SR=R2:GOSUB 10000:PRINT"R2 = ";SR$;Y$;TAB(20);
 4740 SR=AA:GOSUB 10000:PRINT"Fs:Fg = ";SR$;" dB."
 4750 SR=INT(R3*10)/10:GOSUB 10000
 4760 PRINT"R3 = ";SR$;Y$;TAB(20);
 4770 SR=V:GOSUB 10000:PRINT"V = ";SR$;
 4780 SR=VV:GOSUB 10000:PRINT" = ";SR$;" dB."
 4790 GOTO 5010
 4800 R1=SQR(1/(2^3*PY^2*C^2*FG^2))
 4810 PRINT:GOSUB 1210:Z$=X$
 4820 C3=C:C=R5*1E-12
 4830 EM=43:FOR I=1 TO 43:READ A(I):NEXT I
 4840 R=R1:GOSUB 1050:R=R5
 4850 FG=INT(100/(2*PY*SQR(2*R^2*C^2)))/100
 4860 IF FK$="L" THEN C=2*C
 4870 GOSUB 1210:C4=C
 4880 GOSUB 1260:R1=R
 4890 IF FK$="L" THEN R2=R1
 4900 IF FK$="H" THEN R2=2*R1
 4910 GOSUB 100:IF FK$="L" THEN GOSUB 2070
 4920 IF FK$="H" THEN GOSUB 2280
 4930 SR=C3:GOSUB 10000:PRINT"C3 = ";SR$;Z$;TAB(20);
 4940 SR=FG:GOSUB 10000:PRINT"Fg = ";SR$;" Herz"
 4950 SR=C4:GOSUB 10000:PRINT"C4 = ";SR$;X$;TAB(20);
 4960 SR=FS:GOSUB 10000:PRINT"Fs = ";SR$;" Herz"
 4970 SR=R1:GOSUB 10000:PRINT"R1 = ";SR$;Y$;TAB(20);
 4980 SR=AA:GOSUB 10000:PRINT"Fs:Fg = ";SR$;" dB."
 4990 SR=R2:GOSUB 10000:PRINT"R2 = ";SR$;Y$;TAB(20);
 5000 PRINT"V = 1 = 0 dB."
 5010 HO=0:VE=23:GOSUB 110
 5020 PRINT"NOG MEER BEREKENEN ? (J/N)   ";:GOSUB 210
 5030 IF(IN$="J") OR(IN$="j") THEN J=1:GOTO 3310
 5040 IF(IN$="N") OR(IN$="n") THEN GOSUB 100:GOSUB 2890:END
 5050 GOTO 5010
10000 REM Maak van SR een string SR$
10010 REM met max. SD decimalen.
10020 SD=2
10030 S0=SR:S1=ABS(S0):S2=INT(S1)
10040 IF S1=S2 THEN GOSUB 300:RETURN
10050 SM=1:IF SD>0 THEN FOR SI=1 TO SD:SM=SM*10:NEXT SI
10060 S3=INT((S1-S2)*SM+.5):IF S3=SM THEN S3=0:S2=S2+1
10070 SR=S2*SGN(S0):GOSUB 300:IF S3=0 THEN 10140
10080 IF(S2=0) AND(S0<0) THEN SR$="-"+SR$
10090 SH$=SR$+".":SR=S3:GOSUB 300
10100 IF LEN(SR$)<SD THEN SR$="0"+SR$:GOTO 10100
10110 IF LEN(SR$)<2 THEN 10130
10120 IF RIGHT$(SR$,1)="0" THEN GOSUB 10150:GOTO 10110
10130 SR$=SH$+SR$
10140 SR=S0:RETURN
10150 SR$=LEFT$(SR$,LEN(SR$)-1):RETURN
25000 REM BY LOWPASS 2.ORDE:C4=2*C3
25010 REM DAAROM IS DE NORMREEKS E12
25020 REM UITGEBREID MET ELKE WAARDE
25030 REM 2 * IN SERIE
25040 DATA .1,.11,.12,.135,.15,.165,.18
25050 DATA .195,.22,.235,.27,.28,.33,.34
25060 DATA .39,.41,.47,.5,.56,.6,.68
25070 DATA .75,.82,.9,1
25080 REM BY HIGHPASS 2.ORDE:R2=2*R1
25090 REM DAAROM IS DE NORMREEKS E24
25100 REM UITGEBREID MET ELKE WAARDE
25110 REM 2 * IN SERIE
25120 DATA .1,.102,.11,.112,.12,.124,.13
25130 DATA .136,.15,.16,.164,.18,.182,.2
25140 DATA .22,.24,.26,.27,.3,.32,.33,.36
25150 DATA .39,.4,.43,.44,.47,.48,.51,.54
25160 DATA .56,.6,.62,.66,.68,.72,.75,.78
25170 DATA .82,.86,.91,.94,1
30000 REM BEREKENING VAN:
30010 REM HIGH-EN LOWPASS FILTERS IN
30020 REM DE EERSTE EN TWEEDE ORDE.
30030 REM ALLEEN DE EERSTE BEREKENING
30040 REM DOORLOOPT HET HELE PROGRAMMA.
30050 REM BIJ VERDERE BEREKENINGEN ZIET
30060 REM U ALLEEN HET SCHEMA SAMEN MET
30070 REM DE UITKOMST.
30080 REM AUTEUR PA0MAX MAX WOLFF
30090 REM LUCHTHAVENLAAN 66 TILBURG
30100 REM VERSIE 1.3  JANUARI 1989
30110 REM COPYRIGHTS N.O.S. HOBBYSCOOP
