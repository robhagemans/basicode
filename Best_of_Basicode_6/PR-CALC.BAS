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
 1000 A=4000:GOTO 20:REM PROGRAMMEERBARE CALCULATOR
 1010 PM=50:PE=0:NL=ASC("0")
 1020 DIM P$(PM),N$(10),E(10),S(10),D$(9),HH(9,2)
 1030 REM IN P$ WORDT HET (GECODEERDE) PROGRAMMA
 1040 REM OPGESLAGEN; PM BEPAALT DE MAXIMALE
 1050 REM PROGRAMMALENGTE
 2000 GOSUB 100:HO=3:VE=6
 2010 PRINT"       PROGRAMMEERBARE CALCULATOR":PRINT
 2015 PRINT"In geheugen: ";PE;" regels.":GOSUB 110
 2020 PRINT"**********************************"
 2030 PRINT"   * P: Programma veranderen        *"
 2040 PRINT"   *                                *"
 2050 PRINT"   * S: Start programma             *"
 2060 PRINT"   *                                *"
 2070 PRINT"   * B: Bewaar gecodeerd programma  *"
 2080 PRINT"   * V: Voer gecodeerd programma in *"
 2090 PRINT"   *                                *"
 2100 PRINT"   * Q: Stoppen                     *"
 2110 PRINT"   **********************************"
 2120 PRINT:PRINT:PRINT"Keuze:";
 2130 GOSUB 6000
 2140 IF IN$="V" THEN 2500
 2150 IF IN$="B" THEN 2750
 2160 IF IN$="P" THEN 3000
 2170 IF IN$="S" THEN 10000
 2180 IF IN$="Q" THEN 2200
 2190 GOSUB 250:GOTO 2130
 2200 GOSUB 100:END
 2500 GOSUB 100:IF PE=0 THEN 2540
 2510 PRINT"Met deze optie gaat het huidige pro-"
 2520 PRINT"gramma verloren. Doorgaan? (J/N)"
 2530 GOSUB 6000:IF IN$<>"J" THEN 2000
 2540 GOSUB 100:PRINT"Typ de code in; sluit af met <ENTER>."
 2550 PRINT:PRINT:INPUT D$:PE=0
 2560 A=LEN(D$):IF A<2 THEN 2000
 2561 C$="":IF RIGHT$(D$,1)<>"*" THEN 2710
 2562 FOR A=1 TO LEN(D$):IN$=MID$(D$,A,1):GOSUB 6010
 2563 C$=C$+IN$:NEXT A
 2565 A=1
 2570 D$=MID$(C$,A,1):A=A+1:F=0:P$(PE)=D$
 2590 IF(D$="B") OR(D$="C") OR(D$="W") OR(D$="N") THEN 2700
 2600 IF(D$="T") OR(D$="K") THEN GOSUB 2910:GOTO 2700
 2605 IF D$="P" THEN GOSUB 2920:GOTO 2700
 2610 IF D$="H" THEN GOSUB 2910:GOSUB 2920:GOTO 2700
 2620 IF(D$="O") OR(D$="A") OR(D$="V") OR(D$="D") THEN 2909
 2630 IF D$="M" THEN GOSUB 2908:GOTO 2700
 2640 IF(D$<>"I") OR(A>=LEN(C$)) THEN F=1:GOTO 2700
 2650 GOSUB 2910:D$=MID$(C$,A,1):A=A+1
 2660 P$(PE)=P$(PE)+D$:IF D$="M" THEN GOSUB 2910:GOTO 2700
 2670 IF(D$="+") OR(D$="-") THEN 2930
 2680 GOSUB 2920
 2700 IF F=0 THEN 2720
 2710 GOSUB 100:PRINT"Er zit een fout in de dataregel:"
 2711 PRINT:PRINT LEFT$(C$,A-1);" ???":PRINT
 2715 PE=0:GOTO 2900
 2720 PE=PE+1:IF A=LEN(C$) THEN 2730
 2725 IF PE<=PM THEN 2570
 2726 GOTO 2710
 2730 PRINT:PRINT"De dataregel is goed ingelezen.":GOTO 2900
 2750 IF PE=0 THEN 2000
 2751 GOSUB 100:PRINT"Op printer? (J/N)":GOSUB 6000
 2752 J=0:IF IN$="J" THEN J=1:GOTO 2800
 2755 GOSUB 100:PRINT"Hieronder ziet u het programma,"
 2760 PRINT"weergegeven in de code die het program-"
 2770 PRINT"ma intern gebruikt. Als u deze code"
 2780 PRINT"opschrijft, kunt u ze later met optie"
 2790 PRINT"'V' weer invoeren.":PRINT:PRINT
 2800 SR$="":FOR A=0 TO PE-1:SR$=SR$+P$(A):E$=""
 2805 IF LEN(P$(A))>=3 THEN E$=MID$(P$(A),3,1)
 2810 IF(E$="+") OR(E$="-") THEN SR$=SR$+"#"
 2820 NEXT A:SR$=SR$+"*"
 2830 IF J=1 THEN GOSUB 350:GOSUB 360:GOTO 2850
 2840 PRINT SR$
 2850 PRINT:PRINT
 2900 PRINT"Druk op een toets.":GOSUB 210:GOTO 2000
 2908 GOSUB 2910:GOSUB 2910:GOTO 2920
 2909 GOSUB 2910:GOSUB 2910:GOSUB 2910:GOTO 2700
 2910 IF A>=LEN(C$) THEN F=1:RETURN
 2911 E$=MID$(C$,A,1):A=A+1:P$(PE)=P$(PE)+E$
 2912 IF(E$<"0") OR(E$>"9") THEN F=1
 2913 RETURN
 2920 IF A>=LEN(C$) THEN F=1:RETURN
 2921 E$=MID$(C$,A,1):A=A+1:P$(PE)=P$(PE)+E$
 2922 IF E$="#" THEN 2910
 2923 IF(E$<"0") OR(E$>"9") THEN F=1:RETURN
 2924 E$=MID$(C$,A,1)
 2925 IF(E$<"0") OR(E$>"9") THEN RETURN
 2926 A=A+1:P$(PE)=P$(PE)+E$:GOTO 2924
 2930 IF A>=LEN(C$) THEN F=1:GOTO 2700
 2931 D$=MID$(C$,A,1):A=A+1
 2932 IF D$="#" THEN 2700
 2933 P$(PE)=P$(PE)+D$:GOTO 2930
 3000 GOSUB 100:PRINT"Typ 'H' voor hulp."
 3100 PRINT:PRINT">";:GOSUB 6000:C$=IN$:PRINT C$
 3120 PRINT:IF C$="L" THEN PP=0:GOSUB 3300
 3125 IF C$="P" THEN PP=1:GOSUB 3300
 3130 IF C$="H" THEN GOSUB 3200
 3140 IF C$="W" THEN GOSUB 3400
 3150 IF C$="M" THEN 2000
 3160 IF C$="T" THEN GOSUB 3500
 3170 IF C$="U" THEN GOSUB 3600
 3180 IF C$="O" THEN GOSUB 3700
 3190 GOTO 3100
 3200 PRINT"H -- Deze hulppagina"
 3210 PRINT"L -- Listing van het programma"
 3215 PRINT"P -- Listing op printer"
 3220 PRINT"W -- Weghalen van delen vh programma"
 3230 PRINT"T -- Regels tussenvoegen"
 3240 PRINT"U -- Programma uitbreiden"
 3250 PRINT"O -- Regel overtikken"
 3260 PRINT"M -- Naar het hoofdmenu":RETURN
 3300 R=0
 3301 IF R=PE THEN RETURN
 3302 GOSUB 200:IF IN$<>"" THEN 3306
 3303 GOSUB 3310:IF PP=1 THEN GOSUB 350:GOSUB 360
 3304 IF PP=0 THEN PRINT SR$
 3305 R=R+1:GOTO 3301
 3306 GOSUB 6010:C$=IN$:PRINT">";C$:RETURN
 3310 SR=0:E$=P$(R):SR=R+1:GOSUB 300:D$=LEFT$(E$,1)
 3311 IF R<9 THEN SR$=" "+SR$
 3312 SR$=SR$+" "
 3313 IF(D$="O") OR(D$="A") OR(D$="V") OR(D$="D") THEN 3350
 3314 IF D$="I" THEN 3360
 3316 IF D$="M" THEN 3370
 3318 W$="BEKIJK M":IF D$="H" THEN 3380
 3320 IF D$="T" THEN W$="TERUG #"
 3322 IF D$="P" THEN W$="PRECISIE "
 3324 IF D$="B" THEN W$="PRINTER AAN"
 3326 IF D$="C" THEN W$="PRINTER UIT"
 3328 IF D$="N" THEN W$="NORMAAL"
 3330 IF D$="W" THEN W$="WETENS."
 3332 SR$=SR$+W$
 3334 IF LEN(E$)>1 THEN SR$=SR$+RIGHT$(E$,LEN(E$)-1)
 3336 RETURN
 3350 SR$=SR$+"M"+MID$(E$,2,1)+" = M"+MID$(E$,3,1)+" "
 3352 IF D$="O" THEN SR$=SR$+"+ M"
 3353 IF D$="A" THEN SR$=SR$+"- M"
 3354 IF D$="V" THEN SR$=SR$+"* M"
 3355 IF D$="D" THEN SR$=SR$+"/ M"
 3356 SR$=SR$+MID$(E$,4,1):RETURN
 3360 SR$=SR$+"M"+MID$(E$,2,1)+" = "+MID$(E$,3,LEN(E$)-2)
 3361 RETURN
 3370 SR$=SR$+"M"+MID$(E$,2,1)+" = M"+MID$(E$,3,1)+" ^ "
 3371 SR$=SR$+MID$(E$,4,LEN(E$)-3):RETURN
 3380 SR$=SR$+"HERHAAL #"+MID$(E$,2,1)+";"
 3381 SR$=SR$+MID$(E$,3,LEN(E$)-2):RETURN
 3400 PRINT"Geef eerste regel die weggehaald moet"
 3410 PRINT"worden:"
 3420 INPUT R1:IF(R1=INT(R1)) AND(R1>0) THEN 3440
 3430 PRINT"Foute regel..":RETURN
 3440 PRINT"Geef laatste regel:"
 3450 INPUT R2:IF(R2=INT(R2)) AND(R2>=R1) THEN 3470
 3460 GOTO 3430
 3470 IF R2>PE THEN 3430
 3475 R0=R2-R1+1:IF R2=PE THEN 3490
 3480 FOR A=R2 TO PE-1:P$(A-R0)=P$(A):NEXT A
 3490 PE=PE-R0:RETURN
 3500 IF PE>PM THEN PRINT"Geen ruimte..":RETURN
 3510 PRINT"Invoegen voor welke regel?"
 3520 INPUT R1:IF(R1<1) OR(R1<>INT(R1)) OR(R1>PE) THEN 3430
 3525 R1=R1-1
 3530 GOSUB 100
 3550 IF PE<=PM THEN 3560
 3555 GOSUB 100:PRINT"Geheugen vol..":RETURN
 3560 GOSUB 4000:IF ND=1 THEN GOSUB 100:RETURN
 3561 IF R1=PE THEN 3580
 3565 FOR A=PE TO R1+1 STEP-1
 3570 P$(A)=P$(A-1):NEXT A
 3580 P$(R1)=RE$:R1=R1+1:PE=PE+1:GOTO 3550
 3600 R1=PE:GOTO 3530
 3700 PRINT"Welke regel overtikken?":INPUT R1
 3710 IF(R1<1) OR(R1>PE) OR(R1>INT(R1)) THEN 3430
 3720 GOSUB 100:R1=R1-1:GOSUB 4000
 3730 IF ND=0 THEN P$(R1)=RE$
 3740 GOSUB 100:RETURN
 4000 ND=0:HO=0:VE=0:IF R1<9 THEN HO=1
 4010 GOSUB 110:PRINT R1+1;:FOR A=1 TO 30
 4020 PRINT"          ";:NEXT A:HO=0:VE=13
 4030 GOSUB 110:PRINT"L = Regel leeg"
 4040 GOSUB 5010:GOSUB 5020
 4050 RE$=""
 4100 HO=4:VE=0:GOSUB 110:GOSUB 6000:C$=IN$
 4110 RE$=C$:IF C$="S" THEN ND=1:RETURN
 4120 IF(C$="N") OR(C$="W") OR(C$="A") OR(C$="U") THEN 4300
 4130 IF C$="K" THEN 4700
 4135 IF C$="T" THEN 5100
 4140 IF C$="P" THEN PRINT"PRECISIE ";:GOTO 4900
 4150 IF C$="H" THEN 4800
 4160 IF C$="I" THEN PRINT"M";:GOTO 4600
 4170 IF C$="B" THEN PRINT"M";:GOTO 4500
 4200 GOSUB 250:GOTO 4100
 4300 IF C$="U" THEN C$="C":PRINT"PRINTER UIT";
 4310 IF C$="A" THEN C$="B":PRINT"PRINTER AAN";
 4320 IF C$="W" THEN PRINT"WETENS.";
 4330 IF C$="N" THEN PRINT"NORMAAL";
 4340 RE$=C$
 4400 GOSUB 5010:HO=0:VE=14:GOSUB 110
 4405 PRINT"ENTER = regel invoeren":GOSUB 5050
 4410 GOSUB 6000:IF IN$=CHR$(13) THEN 4450
 4420 IF IN$="S" THEN ND=1:GOTO 4450
 4430 IF IN$="L" THEN GOSUB 4450:GOTO 4000
 4440 GOTO 4410
 4450 HO=0:VE=14:GOSUB 110
 4460 PRINT"                          ":RETURN
 4500 RE$="":GOSUB 4750:IF LL=1 THEN 4000
 4505 IF ND=1 THEN RETURN
 4510 PRINT" = M";:GOSUB 4750:IF LL=1 THEN 4000
 4515 IF ND=1 THEN RETURN
 4520 GOSUB 5060:PRINT" ";
 4525 GOSUB 6000:IF IN$="L" THEN 4000
 4530 IF IN$="S" THEN ND=1:RETURN
 4535 D$="":IF IN$="*" THEN D$="V"
 4540 IF IN$="/" THEN D$="D"
 4545 IF IN$="+" THEN D$="O"
 4550 IF IN$="-" THEN D$="A"
 4555 IF IN$="^" THEN D$="M"
 4560 IF D$="" THEN GOSUB 250:GOTO 4525
 4565 PRINT IN$;" ";:RE$=D$+RE$:IF D$="M" THEN 4900
 4570 PRINT"M";:GOSUB 4750:IF LL=1 THEN 4000
 4575 IF ND=1 THEN RETURN
 4580 GOTO 4400
 4600 GOSUB 4750:IF LL=1 THEN 4000
 4601 IF ND=1 THEN RETURN
 4602 PRINT" = ";:F=0:GOSUB 5070
 4610 GOSUB 6000:IF(IN$="M") OR(IN$="#") THEN 4680
 4612 IF IN$="-" THEN 4628
 4620 IF IN$="S" THEN ND=1:RETURN
 4622 IF IN$="L" THEN 4000
 4623 IF IN$="." THEN 4628
 4624 IF(IN$=CHR$(13)) AND(F=1) THEN 4640
 4625 IF(IN$<"0") OR(IN$>"9") THEN GOSUB 250:GOTO 4630
 4628 RE$=RE$+IN$:PRINT IN$;:FF=F:F=1
 4629 IF FF=0 THEN GOSUB 5010:GOSUB 5050
 4630 IF F=0 THEN 4610
 4631 GOSUB 6000:GOTO 4620
 4640 X$=MID$(RE$,3,1):IF(X$="-") OR(X$="+") THEN RETURN
 4650 RE$=LEFT$(RE$,2)+"+"+RIGHT$(RE$,LEN(RE$)-2)
 4655 RETURN
 4680 PRINT IN$;:RE$=RE$+IN$:GOTO 4720
 4700 PRINT"BEKIJK M";
 4720 GOSUB 4750:IF LL=1 THEN 4000
 4730 IF ND=1 THEN RETURN
 4740 GOTO 4400
 4750 LL=0:GOSUB 5040
 4760 GOSUB 6000
 4765 IF IN$="L" THEN LL=1:RETURN
 4766 IF IN$="S" THEN ND=1:RETURN
 4770 IF(IN$<"0") OR(IN$>"9") THEN 4790
 4780 RE$=RE$+IN$:PRINT IN$;:RETURN
 4790 GOSUB 250:GOTO 4760
 4800 PRINT"HERHAAL #";:GOSUB 4850
 4820 IF N<10 THEN 4830
 4824 GOSUB 100:PRINT"Nestingfout. Toets.."
 4826 ND=1:GOSUB 210:RETURN
 4830 PRINT N;";";:RE$=RE$+CHR$(NL+N):GOTO 4900
 4850 N=0:IF R1=0 THEN RETURN
 4860 A=R1-1
 4861 X$=LEFT$(P$(A),1)
 4862 IF(X$="T") OR(X$="H") THEN 4865
 4863 A=A-1:IF A>=0 THEN 4861
 4864 RETURN
 4865 N=VAL(MID$(P$(A),2,1)):IF X$="H" THEN N=N+1
 4870 RETURN
 4900 L=LEN(RE$):GOSUB 5030
 4902 GOSUB 6000:IF IN$="L" THEN 4000
 4903 IF IN$="S" THEN ND=1:RETURN
 4904 IF(IN$=CHR$(13)) AND(LEN(RE$)<>L) THEN RETURN
 4905 IF((IN$<"0") OR(IN$>"9")) AND(IN$<>"#") THEN 4950
 4906 IF(IN$="#") AND(LEN(RE$)<>L) THEN 4950
 4908 IF LEN(RE$)<L+2 THEN 4920
 4910 IF MID$(RE$,L+1,1)="#" THEN 4950
 4920 RE$=RE$+IN$:PRINT IN$;:GOTO 4902
 4950 GOSUB 250:GOTO 4902
 5000 HO=0:VE=10:GOSUB 110:RETURN
 5010 GOSUB 120:H=HO:V=VE
 5011 GOSUB 5000:FOR A=1 TO 8:PRINT"          ";:NEXT A
 5012 GOTO 5000
 5020 GOSUB 5000
 5021 PRINT"Bewerking/Inv./beK./Herhaal/Terug/Stop"
 5022 PRINT"Precisie/printer Aan Uit/Wetens./Norm"
 5023 RETURN
 5030 GOSUB 5010:PRINT"Enter een integer getal of loop-"
 5031 PRINT"variabele. (#+getal)":GOTO 5050
 5040 GOSUB 5010:PRINT"Geef een getal van 0 tot 9"
 5050 HO=H:VE=V:GOSUB 110:RETURN
 5060 GOSUB 5010:PRINT"Geef rekensymbool (+-*/^)"
 5061 GOTO 5050
 5070 GOSUB 5010:PRINT"Druk op: M, #, of typ getal in."
 5071 GOTO 5050
 5100 PRINT"TERUG #";:GOSUB 4850:IF N=0 THEN 4824
 5110 RE$=RE$+CHR$(NL+N-1):PRINT N-1;
 5120 GOTO 4400
 6000 GOSUB 210
 6010 IF(IN$<"a") OR(IN$>"z") THEN RETURN
 6020 IN$=CHR$(ASC(IN$)-ASC("a")+ASC("A")):RETURN
 9000 REM**************************
 9010 REM*                        *
 9020 REM* OP REGEL 10000 E.V.    *
 9030 REM* STAAN DE ROUTINES VOOR *
 9040 REM* DE DECODERING VAN DE   * 
 9050 REM* OPDRACHTEN IN P$, EN   *
 9060 REM* VOOR HET REKENEN.      *
 9070 REM*                        *
 9080 REM**************************
10000 GOSUB 100:HO=0:VE=7:GOSUB 110:FOR A=0 TO 4:SR=A
10010 GOSUB 300:PRINT"M";SR$;": Leeg.":HO=20:GOSUB 110
10020 SR=A+5:GOSUB 300:PRINT"M";SR$;": Leeg.":VE=VE+1
10025 N$(A)="":N$(A+5)="":NEXT A:VE=VE+1
10030 FOR A=0 TO 4:HO=0:GOSUB 110:PRINT"#";A;": -"
10040 HO=20:GOSUB 110:PRINT"#";A+5;": -":VE=VE+1
10045 NEXT A
10050 FS=1:R=0:NR=1:PR=0:QI=0:GOSUB 18000
10060 HO=0:VE=21:GOSUB 110
10070 PRINT"DRUK OP 'Q' OM TE STOPPEN"
10100 GOSUB 18000:IF R=PE THEN 17000
10102 IF FS=0 THEN 10130
10105 GOSUB 3310:HO=0:VE=0:GOSUB 110:FOR A=1 TO 12
10110 PRINT"             ";:NEXT A:GOSUB 110
10120 PRINT SR$
10130 I$=P$(R):C$=LEFT$(I$,1)
10140 IF C$="T" THEN 16000
10150 IF C$="H" THEN 16020
10160 IF C$="P" THEN 16040
10170 IF C$="B" THEN QI=1:GOTO 11000
10180 IF C$="C" THEN QI=0:GOTO 11000
10190 IF C$="W" THEN NR=0:GOTO 11000
10200 IF C$="N" THEN NR=1:GOTO 11000
10210 IF C$="K" THEN 16100
10220 IF C$="I" THEN 16200
10230 IF C$="O" THEN 16300
10240 IF C$="A" THEN 16310
10250 IF C$="V" THEN 16320
10260 IF C$="D" THEN 16330
10270 IF C$<>"M" THEN 16340
10280 G=VAL(MID$(I$,2,1)):M=VAL(MID$(I$,3,1))
10290 P=4:GOSUB 16060:IF LEN(N$(M))=0 THEN 16406
10300 N$(10)=N$(M):E(10)=E(M):S(10)=S(M)
10310 N$(G)="1":E(G)=0:S(G)=1
10320 IF I=0 THEN 16410
10330 IF I/2=INT(I/2) THEN 10400
10340 I$=N$(G):E1=E(G):S1=S(G)
10350 T$=N$(10):E2=E(10):S2=S(10):GOSUB 23000
10400 I=INT(I/2)
10410 IF I=0 THEN N$(10)="":GOTO 16410
10420 G1=G:G=10:I$=N$(G):E1=E(G):S1=S(G)
10430 T$=I$:E2=E1:S2=S1:GOSUB 23000:G=G1
10440 GOTO 10330
11000 R=R+1:GOSUB 200:GOSUB 6010:IF IN$<>"Q" THEN 10100
11010 GOTO 17000
16000 M=VAL(MID$(I$,2,1)):HH(M,1)=HH(M,1)+1
16001 HH(M,0)=HH(M,0)-1:IF HH(M,0)>0 THEN R=HH(M,2)
16005 HO=20*INT(M/5):IF FS=0 THEN 11000
16006 VE=13+M-HO/4:GOSUB 110:PRINT"#";M;":";
16007 IF HH(M,0)<=0 THEN PRINT" - ":GOTO 11000
16008 PRINT HH(M,1);"  ":GOTO 11000
16020 M=VAL(MID$(I$,2,1)):P=3:GOSUB 16060
16021 HH(M,0)=I:HH(M,2)=R:HH(M,1)=1:IF I>0 THEN 16005
16022 V$="T"+CHR$(NL+M):A=R
16023 IF LEFT$(P$(A),2)=V$ THEN R=A:GOTO 11000
16024 A=A+1:IF A<=PE THEN 16023
16025 E$="Nesting error!":GOTO 16080
16040 P=2:GOSUB 16060:PR=I:GOTO 11000
16060 I=0:IF MID$(I$,P,1)="#" THEN 16070
16061 FOR A=P TO LEN(I$):I=I*10+VAL(MID$(I$,A,1))
16062 NEXT A:RETURN
16070 I=HH(VAL(MID$(I$,P+1,1)),1):RETURN
16080 GOSUB 100:PRINT"Regel ";R+1;":";E$:PRINT"Toets."
16081 GOSUB 210:GOTO 2000
16100 IF FS*(1-QI)=1 THEN GOSUB 100:FS=0
16101 M=VAL(MID$(I$,2,1))
16102 IF N$(M)="" THEN 16406
16105 SR=LEN(N$(M))-1+E(M):GOSUB 300
16110 GA=(1-NR)*SR-E(M):P$="":IF GA=0 THEN 16130
16115 IF GA<=LEN(N$(M)) THEN 16125
16117 P$=N$(M)
16120 IF(LEN(P$)<GA) THEN P$="0"+P$:GOTO 16120
16123 P$="."+P$:GOTO 16130
16125 P$="."+RIGHT$(N$(M),GA)
16130 IF GA>=LEN(N$(M)) THEN P$="0"+P$:GOTO 16140
16135 P$=LEFT$(N$(M),LEN(N$(M))-GA)+P$
16140 IF(S(M)<0) AND(N$(M)<>"0") THEN P$="-"+P$
16145 IF(NR=1) OR(N$(M)="0") THEN 16155
16150 P$=P$+" * 10 ^ "+SR$
16155 P$="M"+CHR$(NL+M)+" = "+P$
16157 IF QI=0 THEN PRINT P$:GOTO 11000
16160 SR$=P$:GOSUB 350:GOSUB 360:GOTO 11000
16200 G=VAL(MID$(I$,2,1)):C$=MID$(I$,3,1)
16201 IF C$="M" THEN 16210
16202 IF(C$="+") OR(C$="-") THEN 19000
16203 P=3:N$(G)="":GOSUB 16060:M=1
16204 IF M*10<=I THEN M=M*10:GOTO 16204
16205 N$(G)=N$(G)+CHR$(NL+INT(I/M))
16206 I=I-M*INT(I/M):M=M/10:IF M>=1 THEN 16205
16207 S(G)=1:E(G)=0:GOTO 16410
16210 G1=VAL(MID$(I$,4,1))
16211 N$(G)=N$(G1):S(G)=S(G1):E(G)=E(G1):GOTO 16410
16300 GOSUB 16400:IF S2<>2 THEN GOSUB 25000:GOTO 16410
16305 GOTO 16406
16310 GOSUB 16400:IF S2<>2 THEN S2=-S2:GOSUB 25000:GOTO 16410
16315 GOTO 16406
16320 GOSUB 16420:IF LEN(N$(G1))<LEN(N$(G2)) THEN 16325
16322 G0=G1:G1=G2:G2=G0
16325 GOSUB 16401:IF S2<>2 THEN GOSUB 23000:GOTO 16410
16327 GOTO 16406
16330 GOSUB 16400:IF S2<>2 THEN GOSUB 24000:IF S2=2 THEN 16080
16333 IF S2<>2 THEN 16410
16335 GOTO 16406
16340 GOSUB 100:PRINT"Onbekend commando!! Toets.."
16341 GOSUB 210:GOTO 2000
16400 GOSUB 16420
16401 T$=N$(G2):S2=S(G2):E2=E(G2)
16403 I$=N$(G1):S1=S(G1):E1=E(G1)
16404 IF(LEN(I$)=0) OR(LEN(T$)=0) THEN S2=2
16405 RETURN
16406 E$="Geheugen leeg!":GOTO 16080
16410 IF FS=0 THEN 11000
16411 HO=20*INT(G/5):VE=7+G-HO/4:GOSUB 110
16412 SR=G:GOSUB 300
16413 PRINT"M";SR$;":";LEN(N$(G));"     ":GOTO 11000
16420 G1=VAL(MID$(I$,3,1)):G2=VAL(MID$(I$,4,1))
16421 G=VAL(MID$(I$,2,1)):RETURN
17000 IF FS=1 THEN GOSUB 100
17010 PRINT
17020 PRINT"Programma beeindigd. Toets.":GOSUB 210
17030 GOTO 2000
18000 IF FS=0 THEN RETURN
18005 HO=0:VE=19:GOSUB 110:PRINT"PRINTER ";
18010 IF QI=0 THEN PRINT"UIT";
18020 IF QI=1 THEN PRINT"AAN";
18030 PRINT"   ";
18040 IF NR=1 THEN PRINT"NORMAAL";
18050 IF NR=0 THEN PRINT"WETENS.";
18060 PRINT"   ";
18070 PRINT"PRECISIE:";PR;"   ";:RETURN
19000 E(G)=0:R$=RIGHT$(I$,LEN(I$)-3)
19010 S(G)=1:IF C$="-" THEN S(G)=-1
19030 IF LEN(R$)=0 THEN 19150
19040 IF LEN(R$)=1 THEN 19060
19050 IF LEFT$(R$,1)="0" THEN 19150
19060 N$(G)="":FL=0:FOR A=1 TO LEN(R$)
19070 G$=MID$(R$,A,1)
19080 IF(G$>="0") AND(G$<="9") THEN 19120
19090 IF(G$<>".") OR(E(G)<>0) THEN FL=1
19100 E(G)=.1:IF A=LEN(R$) THEN FL=1
19110 GOTO 19135
19120 IF E(G)<>0 THEN E(G)=E(G)-1
19130 N$(G)=N$(G)+G$
19135 NEXT A:E(G)=INT(E(G))
19140 IF FL=0 THEN GOSUB 27000:GOTO 16410
19150 E$="Fout getal!":GOTO 16080
22997 REM**************
22998 REM* VERMENIGV. *
22999 REM**************
23000 N$(G)="":S(G)=S1*S2:E(G)=E1+E2
23010 L1=LEN(I$):L2=LEN(T$):C=0:FOR A=0 TO L1+L2-2
23020 B1=L1-A:B2=L2:IF B1<1 THEN B2=L2+B1-1:B1=1
23030 RM=B2-1:IF RM>L1-B1 THEN RM=L1-B1
23040 FOR D=0 TO RM:U=ASC(MID$(I$,B1+D,1))-NL
23050 C=C+U*(ASC(MID$(T$,B2-D,1))-NL):NEXT D
23060 U=C-10*INT(C/10):C=INT(C/10)
23070 N$(G)=CHR$(NL+U)+N$(G):NEXT A
23080 IF C<>0 THEN SR=C:GOSUB 300:N$(G)=SR$+N$(G)
23190 GOTO 27000
23997 REM***********
23998 REM*  DELEN  *
23999 REM***********
24000 N$(G)="":S(G)=S1*S2
24002 IF T$="0" THEN 24600
24005 E(G)=E1-E2:CM=0
24010 IF LEN(I$)>=LEN(T$) THEN 24015
24012 I$="0"+I$:CM=CM+1:GOTO 24010
24015 BB=ASC(LEFT$(T$,1))-NL:GOSUB 24300
24020 V$="":IF LEN(T$)=2 THEN 24022
24021 V$=LEFT$(I$,LEN(T$)-2)
24022 A=LEN(T$)-1
24023 IF A<=LEN(I$) THEN V$=V$+MID$(I$,A,1):GOTO 24030
24024 RR=1
24025 IF MID$(V$,RR,1)<>"0" THEN 24028
24026 RR=RR+1:IF RR<=LEN(V$) THEN 24025
24027 GOTO 25130
24028 V$=V$+"0":IF E(G)<-PR THEN 25130
24029 E(G)=E(G)-1
24030 IF LEN(V$)<LEN(T$) THEN V$="0"+V$
24040 T=VAL(LEFT$(V$,2))
24050 Q=INT(T/(BB+1)):IF T/BB<1 THEN 24200
24180 IF Q>9 THEN Q=9:GOTO 24200
24181 S=1
24185 IF MID$(V$,S,1)<MID$(D$(Q),S,1) THEN Q=Q-1:GOTO 24200
24190 IF MID$(V$,S,1)>MID$(D$(Q),S,1) THEN Q=Q+1:GOTO 24180
24195 S=S+1:IF S<=LEN(V$) THEN 24185
24200 C$="":N$(G)=N$(G)+CHR$(NL+Q)
24205 C=0:FOR S=LEN(V$) TO 1 STEP-1
24210 U=VAL(MID$(V$,S,1))-VAL(MID$(D$(Q),S,1))+C
24220 C=INT(U/10):U=U-10*C:C$=CHR$(NL+U)+C$
24230 NEXT S:V$=C$
24240 IF(LEFT$(V$,1)<>"0") OR(LEN(V$)+1<LEN(T$)) THEN 24260
24245 IF LEN(V$)<2 THEN V$="":GOTO 24240
24250 V$=RIGHT$(V$,LEN(V$)-1):GOTO 24240
24260 A=A+1:GOTO 24023
24300 D$(0)="0"
24310 IF LEN(D$(0))>LEN(T$) THEN T$="0"+T$:GOTO 24330
24320 D$(0)=D$(0)+"0":GOTO 24310
24330 FOR A=0 TO 8:D$(A+1)="":C=0:FOR S=LEN(T$) TO 1 STEP-1
24340 U=ASC(MID$(D$(A),S,1))+ASC(MID$(T$,S,1))-2*NL+C
24350 C=INT(U/10):U=U-10*C
24360 D$(A+1)=CHR$(NL+U)+D$(A+1):NEXT S:NEXT A:RETURN
24600 E$="Deling door nul!":S2=2:RETURN
24997 REM*****************
24998 REM* OPTELL./AFTR. *
24999 REM*****************
25000 IF E1<E2 THEN T$=T$+"0":E2=E2-1:GOTO 25000
25005 IF E1>E2 THEN I$=I$+"0":E1=E1-1:GOTO 25000
25008 IF LEN(I$)<LEN(T$) THEN I$="0"+I$:GOTO 25000
25010 IF LEN(I$)>LEN(T$) THEN T$="0"+T$:GOTO 25010
25015 E(G)=E1
25020 N$(G)="":IF S1*S2=1 THEN S(G)=S1:GOTO 25500
25030 GG=1:A=1
25040 IF MID$(I$,A,1)>MID$(T$,A,1) THEN 25070
25050 IF MID$(I$,A,1)<MID$(T$,A,1) THEN GG=-1:GOTO 25070
25055 A=A+1:IF A<=LEN(I$) THEN 25040
25060 N$(G)="0":GOTO 27000
25070 S(G)=S1*GG:IF GG=-1 THEN N$(G)=I$:I$=T$:T$=N$(G)
25080 N$(G)="":C=0:FOR A=LEN(I$) TO 1 STEP-1
25090 U=ASC(MID$(I$,A,1))-ASC(MID$(T$,A,1))+C
25100 C=INT(U/10):U=U-10*C
25110 N$(G)=CHR$(NL+U)+N$(G):NEXT A
25130 IF(LEFT$(N$(G),1)<>"0") OR(LEN(N$(G))=1) THEN 27000
25140 N$(G)=RIGHT$(N$(G),LEN(N$(G))-1):GOTO 25130
25500 C=0:FOR A=LEN(I$) TO 1 STEP-1
25510 U=ASC(MID$(I$,A,1))+ASC(MID$(T$,A,1))
25520 U=U+C-2*NL:C=INT(U/10):U=U-10*C
25530 N$(G)=CHR$(U+NL)+N$(G):NEXT A
25540 N$(G)=CHR$(C+NL)+N$(G):GOTO 25130
26997 REM************
26998 REM* AFRONDEN *
26999 REM************
27000 IF-E(G)<=PR THEN 27110
27010 IF LEN(N$(G))<-E(G)-PR THEN N$(G)="0":GOTO 27110
27020 P=LEN(N$(G))+E(G)+PR+1
27030 IF MID$(N$(G),P,1)<"5" THEN 27100
27040 IF P=1 THEN N$(G)="1"+N$(G):GOTO 27100
27050 U=VAL(MID$(N$(G),P-1,1))+1
27060 C=INT(U/10):U=U-10*C:U$=CHR$(U+NL)
27065 IF P<3 THEN T$=U$:GOTO 27080
27070 T$=LEFT$(N$(G),P-2)+U$
27080 N$(G)=T$+RIGHT$(N$(G),LEN(N$(G))-P+1)
27090 P=P-1:IF C=1 THEN 27040
27100 P1=LEN(N$(G))+PR+E(G):IF P1<1 THEN P1=1:N$(G)="0"
27101 N$(G)=LEFT$(N$(G),P1)
27105 E(G)=-PR
27110 IF N$(G)="0" THEN S(G)=1:E(G)=0
27120 IF E(G)=0 THEN RETURN
27130 IF RIGHT$(N$(G),1)<>"0" THEN RETURN
27140 N$(G)=LEFT$(N$(G),LEN(N$(G))-1):E(G)=E(G)+1
27150 GOTO 27120
30000 REM*****************************
30010 REM
30020 REM PROGRAMMEERBARE CALCULATOR
30030 REM
30040 REM EERSTE VERSIE KLAAR OP 7/6/88
30050 REM
30060 REM
30070 REM DOOR G.A. LUNTER
30080 REM BORDINE 44
30090 REM 8604 AD  SNEEK
30100 REM
30110 REM*****************************
30120 REM COPYRIGHT NOS HILVERSUM
