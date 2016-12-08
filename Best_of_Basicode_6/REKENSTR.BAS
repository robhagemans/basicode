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
1000 A = 800: GOTO 20: REM Rekenstructie
1010 GOSUB 100
1012 DIM C(8), R(8), AW(8), T(8, 2)
1014 DIM C$(10), PZ$(8), AW$(8), R$(8)
1020 GOSUB 4310: REM scherm opmeten
1030 GOSUB 4420: REM beginscherm
1040 GOSUB 4550: REM init / uitleg
1050 GOSUB 2010: REM aantal cijfers
1060 GOSUB 2120: REM bepaal opgave
1070 GOSUB 2490: REM invoer
1080 GOSUB 3080: REM controle
1090 GOSUB 3260: REM tweede poging
1100 GOSUB 3490: REM nogmaals
1110 IF Q = 1 THEN 1050
1120 GOSUB 3780: REM resultaat
1130 END
1140 :
2000 REM aantal cijfers
2010 PRINT: PRINT S$; K$: HO = S: VE = 22: GOSUB 110
2020 PRINT K$; : VE = 3: GOSUB 110
2030 PRINT"Zet je schrap.   We gaan puzzelen...."
2040 PRINT
2050 PRINT S$; "Hoe groot wordt de som ?  2..t/m..8 ";
2060 GOSUB 4270: L = (ASC(IN$) - ASC("0"))
2070 IF(L < 2) OR(L > 8) THEN 2060
2080 HO = S + 5: VE = 8: GOSUB 110: PRINT"moment geduld..."
2090 PRINT: PZ$(L) = "": RETURN
2100 :
2110 REM opgave bepalen
2120 HO = S: VE = 10: GOSUB 110: PRINT K$;
2130 VE = 14: GOSUB 110: PRINT K$;
2140 P = 0: FOR I = 1 TO L
2150 GOSUB 260: C(I) = INT(RV * 10): IF C(I) < 1 THEN 2150
2160 SR = C(I): GOSUB 300: C$(I) = SR$: NEXT I
2170 FOR I = 1 TO L - 1: GOSUB 2370: NEXT I
2180 FOR I = 1 TO L - 1: R$(I) = PZ$(I): NEXT I
2190 GOSUB 3600
2200 IF(SR < -9999) OR(SR > 9999) THEN 2140
2210 IF MF = 1 THEN 2240
2220 IF(MF = 2) AND(SR < 0) THEN 2140
2230 IF(MF > 2) AND(Q <> 0) THEN 2140
2240 B$ = "": FOR I = 1 TO L: B$ = B$ + C$(I) + PZ$(I): NEXT I
2250 UK = SR: GOSUB 300: PZ$(L) = " = " + SR$
2260 HO = S: VE = 5: GOSUB 110: PRINT SP$
2270 PRINT S$; T$
2280 SR = L: GOSUB 300: PRINT
2290 PRINT S$; "Niveau "; MF$; ".";
2300 PRINT"     De "; SR$; " cijfers zijn :"
2310 HO = S + 1: VE = 12: GOSUB 110
2320 FOR I = 1 TO L - 1: PRINT C$(I); "   "; : NEXT I
2330 PRINT C$(L); PZ$(L)
2340 RETURN
2350 :
2360 REM keuze operator
2370 GOSUB 260: RT = INT(RV * 10)
2380 IF(RT < 1) OR(RT > NV) THEN 2370
2390 ON RT GOTO 2400, 2410, 2420, 2440
2400 PZ$(I) = "+": RETURN
2410 PZ$(I) = "-": RETURN
2420 PZ$(I) = "*": IF PZ$(I - 1) = "/" THEN 2370
2430 RETURN
2440 PZ$(I) = "/": DL = C(I) / C(I + 1)
2450 IF(INT(DL) <> DL) OR(PZ$(I - 1) = "/") THEN 2370
2460 RETURN
2470 :
2480 REM invoer antwoord
2490 X = 1: HO = S + 3: VE = 12: GOSUB 110
2500 FOR I = X TO L
2510 IF I = L THEN GOSUB 2710
2520 GOSUB 4270: AW = ASC(IN$): VB = 0
2530 IF(IN$ = "P") OR(IN$ = "p") THEN IN$ = "+"
2540 IF(IN$ = "M") OR(IN$ = "m") THEN IN$ = "-"
2550 IF(IN$ = "X") OR(IN$ = "x") THEN IN$ = "*"
2560 IF(IN$ = "D") OR(IN$ = "d") THEN IN$ = "/"
2570 IF(IN$ = "V") OR(IN$ = "v") THEN VB = 1
2580 IF(IN$ = "*") AND(NV < 3) THEN 2520
2590 IF(IN$ = "/") AND(NV < 4) THEN 2520
2600 IF(AW = 13) AND(I = L) THEN 2660
2610 IF(I = L) AND(VB = 0) THEN 2520
2620 IF(VB = 1) AND(I > X) THEN GOSUB 2830
2630 IF(IN$ = "+") OR(IN$ = "-") THEN 2650
2640 IF(IN$ <> "*") AND(IN$ <> "/") THEN 2520
2650 GOSUB 2770
2660 NEXT I
2670 HO = S: VE = 16: GOSUB 110: PRINT SP$
2680 RETURN
2690 :
2700 REM invoer klaar
2710 H1 = HO: V1 = VE: HO = S: VE = 16: GOSUB 110
2720 PRINT"Alles ingevuld, dan RETURN..."
2730 HO = H1: VE = V1: GOSUB 110
2740 RETURN
2750 :
2760 REM cursor plaats verder
2770 AW$(I) = IN$: PRINT IN$;
2780 IF P = 1 THEN GOSUB 2920
2790 HO = S + 3 + (I * 4): VE = 12: GOSUB 110
2800 RETURN
2810 :
2820 REM cursor plaats terug
2830 IF I <> L THEN 2850
2840 HO = S: VE = 16: GOSUB 110: PRINT SP$
2850 IF P = 1 THEN GOSUB 2980: RETURN
2860 HO = S + 3 + (I - 2) * 4: H1 = HO: VE = 12: GOSUB 110
2870 PRINT" "; : AW$(I) = "": I = I - 1
2880 HO = H1: VE = 12: GOSUB 110
2890 RETURN
2900 :
2910 REM cursor plaats poging 2
2920 FOR J = I + 1 TO L - 1
2930 IF AW(J) = 0 THEN I = J - 1: J = L - 1
2940 NEXT J
2950 RETURN
2960 :
2970 REM cursor terug poging 2
2980 IF I <> L THEN 3000
2990 HO = S: GOSUB 110: PRINT"Tweede poging...."
3000 Y = 0: FOR J = I - 1 TO X STEP-1
3010 IF AW(J) = 0 THEN Y = Y + 1: I = J: J = X
3020 NEXT J: IF Y = 0 THEN 3050
3030 HO = S + 3 + (I - 1) * 4: H1 = HO: VE = 12: GOSUB 110
3040 PRINT" "; : AW$(I) = "": HO = H1: GOSUB 110
3050 RETURN
3060 :
3070 REM controle
3080 FOR I = 1 TO L - 1: R$(I) = AW$(I): NEXT I
3090 GOSUB 3600: AC = SR
3100 HO = S: VE = 16: GOSUB 110
3110 IF UK = AC THEN 3160
3120 PRINT"Helaas niet goed."
3130 P = P + 1: IF P = 1 THEN RETURN
3140 VE = 18: GOSUB 110: PRINT"Het moest zijn... "; B$
3150 RETURN
3160 W$ = "SUPER": IF P = 1 THEN W$ = "GROTE"
3170 HO = S + 12: VE = 18: FOR I = 1 TO 3
3180 GOSUB 110: PRINT W$; " KLASSE"
3190 FOR J = 1 TO 4 * VT: NEXT J
3200 GOSUB 110: PRINT"            "
3210 FOR J = 1 TO 4 * VT: NEXT J
3220 NEXT I
3230 RETURN
3240 :
3250 REM tweede poging
3260 IF P <> 1 THEN RETURN
3270 FOR I = 1 TO 50 * VT: NEXT I
3280 FOR I = 1 TO L - 1: AW(I) = 1
3290 IF(PZ$(I) = AW$(I)) AND(MF < 4) THEN 3320
3300 AW(I) = 0: VE = 12: HO = S + 3 + (I - 1) * 4
3310 GOSUB 110: PRINT" ";
3320 NEXT I
3330 HO = S: VE = 16: GOSUB 110
3340 PRINT"Tweede poging...."
3350 FOR I = 1 TO L - 1
3360 IF AW(I) = 1 THEN 3390
3370 VE = 12: HO = S + 3 + (I - 1) * 4
3380 GOSUB 110: X = I: I = L - 1
3390 NEXT I
3400 L1 = -1: FOR I = L - 1 TO 1 STEP-1
3410 IF AW(I) = 1 THEN 3430
3420 I = 1
3430 L1 = L1 + 1: NEXT I
3440 L = L - L1: GOSUB 2500
3450 L = L + L1: GOSUB 3080
3460 RETURN
3470 :
3480 REM nog een keer
3490 T(L, P) = T(L, P) + 1
3500 HO = S + 4: VE = 20: GOSUB 110: Q = 0
3510 PRINT"Nog een keer proberen ?   J/n ";
3520 GOSUB 4270: X = ASC(IN$)
3530 IF(X = 13) OR(IN$ = "J") OR(IN$ = "j") THEN Q = 1
3540 IF(IN$ = "N") OR(IN$ = "n") THEN Q = 2
3550 IF Q = 0 THEN 3520
3560 IF Q = 1 THEN T = T + 1
3570 GOSUB 100: RETURN
3580 :
3590 REM reken
3600 FOR I = 1 TO L: R(I) = C(I): NEXT I
3610 FOR I = 1 TO L - 1
3620 IF(R$(I) = "+") OR(R$(I) = "-") THEN 3660
3630 IF R$(I) = "*" THEN R(I + 1) = R(I) * R(I + 1)
3640 IF R$(I) = "/" THEN R(I + 1) = R(I) / R(I + 1)
3650 R(I) = 0: R$(I) = "+": IF I > 1 THEN R$(I) = R$(I - 1)
3660 NEXT I: Q = 0
3670 SR = R(1): FOR I = 1 TO L - 1
3680 IF R$(I) = "+" THEN GOSUB 3740
3690 IF R$(I) = "-" THEN GOSUB 3750
3700 IF SR < 0 THEN Q = Q + 1
3710 NEXT I
3720 RETURN
3730 :
3740 SR = SR + R(I + 1): RETURN
3750 SR = SR - R(I + 1): RETURN
3760 :
3770 REM resultaat
3780 Y = 0: VT = INT(VT / 4): SR = T: GOSUB 300
3790 R$(1) = "GEWELDIG....   je had alles goed."
3800 R$(2) = "Jammer....   andere keer beter."
3810 B$ = "sommen": IF T = 1 THEN B$ = "som"
3820 C$(1) = "Je hebt " + SR$ + " puzzel " + B$ + " gemaakt."
3830 C$(2) = "Niveau " + MF$ + ".      1x     2x     mis"
3840 FOR C = 2 TO 8: B$ = "": SR = C: GOSUB 300
3850 C$(C + 1) = SR$ + " cijfers "
3860 FOR R = 0 TO 2: SR = T(C, R): GOSUB 300
3870 IF SR$ = "0" THEN SR$ = " "
3880 B$ = B$ + LEFT$(SP$, 7 - LEN(SR$)) + SR$
3890 NEXT R: C$(C + 1) = C$(C + 1) + B$
3900 NEXT C: X = 0
3910 FOR I = 2 TO 8: X = X + T(I, 2): NEXT I
3920 IF(X = 0) OR(X = T) THEN 3960
3930 Q = T - X: SR = Q: GOSUB 300
3940 B$ = "Je hebt " + SR$ + " goed en helaas "
3950 SR = X: GOSUB 300: C$(10) = B$ + SR$ + " fout."
3960 IF X = 0 THEN C$(10) = R$(1)
3970 IF X = T THEN C$(10) = R$(2)
3980 HO = S: X = 2
3990 FOR C = 1 TO 10: X = X + 1
4000 IF(C = 2) OR(C = 3) THEN X = X + 1
4010 IF C = 10 THEN X = X + 2
4020 VE = X: B$ = C$(C): GOSUB 5680
4030 NEXT C
4040 B$ = "Resultaat printen ?   J/n "
4050 HO = S + 3: VE = 18: GOSUB 5680
4060 GOSUB 4270: X = ASC(IN$)
4070 IF(IN$ = "N") OR(IN$ = "n") THEN 4170
4080 IF(X <> 13) AND(IN$ <> "J") AND(IN$ <> "j") THEN 4060
4090 GOSUB 4230: B$ = "Printer klaar ?    toets.."
4100 GOSUB 5680: GOSUB 4270: GOSUB 4230
4110 GOSUB 110: PRINT"  Er wordt geprint. ";
4120 FOR I = 1 TO 10
4130 IF(I = 2) OR(I = 3) THEN GOSUB 360
4140 IF I = 10 THEN GOSUB 360: GOSUB 360
4150 SR$ = "     " + C$(I): GOSUB 350: GOSUB 360
4160 NEXT I: FOR I = 1 TO 6: GOSUB 360: NEXT I
4170 GOSUB 4230: B$ = "Tot een volgende keer."
4180 GOSUB 5680
4190 PRINT: PRINT
4200 RETURN
4210 :
4220 REM regel leeg
4230 HO = S: GOSUB 110: PRINT SP$
4240 HO = S + 3: RETURN
4250 :
4260 REM Buffer legen + Toets lezen
4270 GOSUB 200: IF IN$ <> "" THEN 4270
4280 GOSUB 210: RETURN
4290 :
4300 REM Scherm opmeten
4310 VE = 0: FOR I = 0 TO 150
4320 PRINT"*"; : GOSUB 120
4330 PH = I: IF VE <> 0 THEN I = 150
4340 NEXT I: GOSUB 100
4350 S$ = " ": IF PH <= 39 THEN 4380
4360 X = INT((PH - 39) / 2)
4370 FOR I = 2 TO X: S$ = S$ + " ": NEXT I
4380 S = LEN(S$): GOSUB 6000
4390 RETURN
4400 :
4410 REM titel-scherm
4420 K$ = "REKENSTRUCTIE    "
4430 R$ = "": X = INT(PH / LEN(K$)) + 1
4440 FOR I = 1 TO X: R$ = R$ + K$: NEXT I
4450 FOR I = 1 TO 22: HO = I + 1: VE = I: GOSUB 110
4460 PRINT LEFT$(R$, PH - I - 1): NEXT I: Y = 0
4470 HO = 0: VE = 17: B$ = " een": GOSUB 5680
4480 VE = 18: B$ = " programma": GOSUB 5680
4490 VE = 19: B$ = " van": GOSUB 5680
4500 VE = 20: B$ = " L.D.R.P.Looyenga": GOSUB 5680
4510 RETURN
4520 :
4530 REM Init + uitleg
4550 T = 1: PZ$(0) = "": K$ = "": SP$ = ""
4560 FOR I = 1 TO 38: K$ = K$ + "*": SP$ = SP$ + " ": NEXT I
4570 VE = 22: B$ = " Wil je uitleg ? J/n ": GOSUB 5680
4580 GOSUB 4270: X = ASC(IN$)
4590 IF(IN$ = "N") OR(IN$ = "n") THEN 5340
4600 IF(X <> 13) AND(IN$ <> "J") AND(IN$ <> "j") THEN 4580
4610 :
4620 GOSUB 100: PRINT
4630 PRINT S$; "   Er moet gerekend gaan worden."
4640 PRINT
4650 PRINT S$; "De computer bedenkt een som, maar..."
4660 PRINT S$; "vergeet  + - * of /  neer te zetten."
4670 PRINT
4680 PRINT S$; "        Dat moet jij doen."
4690 PRINT
4700 PRINT S$; "Tussen de cijfers, die de computer op"
4710 PRINT S$; "het scherm zet, plaats je met toets.."
4720 PRINT
4730 PRINT S$; "     + of P   de Plus."
4740 PRINT S$; "     - of M   de Min."
4750 PRINT S$; "     * of X   het Maal teken."
4760 PRINT S$; "     / of D   het Deel teken."
4770 PRINT
4780 PRINT S$; " Verbeteren doe je met de toets  V."
4790 PRINT
4800 PRINT S$; "Je hebt twee pogingen om de puzzel op"
4810 PRINT S$; "te lossen.  Bij de tweede keer blijft"
4820 PRINT S$; "wat goed is staan. (Niet in niveau 4)"
4830 PRINT
4840 PRINT S$; "  Nu een toets voor het vervolg, ";
4850 GOSUB 4270
4860 :
4870 GOSUB 100: PRINT: PRINT
4880 PRINT S$; "     ****  BELANGRIJK  ****": PRINT
4890 PRINT S$; " X en / gaan VOOR plus en min !!! ";
4900 GOSUB 5970: GOSUB 5970: Y = 1
4910 HO = S: VE = 6: B$ = "Als voorbeeld geef ik een som...."
4920 GOSUB 5680: GOSUB 5970
4930 HO = S + 20: VE = 8: B$ = "7+5*6-9/3 ="
4940 GOSUB 5680
4950 HO = S: VE = 10: B$ = "Reken eerst uit"
4960 GOSUB 5680
4970 A$ = "5": HO = S + 22: VE = 8: X = 1: GOSUB 5770
4980 A$ = "*": HO = S + 23: VE = 8: GOSUB 5770
4990 A$ = "6": HO = S + 24: VE = 8: GOSUB 5770
5000 GOSUB 5970
5010 HO = S + 30: VE = 10: B$ = "=30"
5020 GOSUB 5680
5030 HO = S: VE = 11: B$ = "Daarna"
5040 GOSUB 5680
5050 A$ = "9": HO = S + 26: VE = 8: X = 2: GOSUB 5770
5060 A$ = "/": HO = S + 27: VE = 8: GOSUB 5770
5070 A$ = "3": HO = S + 28: VE = 8: GOSUB 5770
5080 GOSUB 5970
5090 HO = S + 30: VE = 11: B$ = "= 3"
5100 GOSUB 5680
5110 HO = S: VE = 13: B$ = "De som wordt nu..."
5120 GOSUB 5680
5130 A$ = "7": HO = S + 20: VE = 8: X = 4: GOSUB 5770
5140 A$ = "+": HO = S + 21: VE = 8: GOSUB 5770
5150 GOSUB 5970
5160 HO = S + 31: VE = 10: GOSUB 110: PRINT"  30"
5170 A$ = "30": HO = S + 33: VE = 9: X = 3: GOSUB 5770
5180 VE = 13: X = 10: GOSUB 5880
5190 GOSUB 5970
5200 A$ = "-": HO = S + 25: VE = 8: X = 4: GOSUB 5770
5210 GOSUB 5970
5220 A$ = " 3": HO = S + 31: VE = 10: X = 2: GOSUB 5770
5230 VE = 13: X = 5: GOSUB 5880
5240 GOSUB 5970
5250 HO = S + 30: B$ = "=34"
5260 GOSUB 5680: PRINT: PRINT: PRINT
5270 PRINT S$; "Als je de hele puzzel hebt ingevuld,"
5280 PRINT S$; "druk je op de  <RETURN>  toets en..."
5290 PRINT S$; "je ontdekt of de oplossing goed is."
5300 PRINT: PRINT
5310 PRINT S$; " Nu een toets, waarna het begint. ";
5320 GOSUB 4270
5330 :
5340 GOSUB 100: PRINT: PRINT
5350 PRINT S$; "       Moeilijkheids graad."
5360 PRINT: PRINT
5370 PRINT S$; "     Er zijn vier niveau's..."
5380 PRINT: PRINT
5390 PRINT S$; "  4  -  met plus en min."
5400 PRINT
5410 PRINT S$; "  3  -  met vermenigvuldigingen."
5420 PRINT
5430 PRINT S$; "  2  -  met delingen en kans op een"
5440 PRINT S$; "        negatieve tussen bewerking."
5450 PRINT
5460 PRINT S$; "  1  -  met kans op een positieve"
5470 PRINT S$; "        of negatieve eind uitkomst."
5480 HO = S: VE = 21: GOSUB 110: PRINT SP$;
5490 MF = 4: HO = S + 6: VE = 19: GOSUB 110: PRINT SP$: GOSUB 110
5500 PRINT"Welke opgaven wil je ";
5510 INPUT B$: PRINT: IF(B$ = "") OR(B$ = "4") THEN 5580
5520 MF = VAL(B$): IF(MF < 1) OR(MF > 4) THEN 5490
5530 IF(MF = 3) OR(MF = 4) THEN 5580
5540 PRINT S$; "  Wil je echt de moeilijken ?   J/n ";
5550 GOSUB 4270: X = ASC(IN$)
5560 IF(IN$ = "N") OR(IN$ = "n") THEN 5480
5570 IF(X <> 13) AND(IN$ <> "J") AND(IN$ <> "j") THEN 5550
5580 NV = 6 - MF: IF NV = 5 THEN NV = 4
5590 SR = MF: GOSUB 300: MF$ = SR$: GOSUB 100
5600 ON NV - 1 GOSUB 5630, 5640, 5650
5610 RETURN
5620 :
5630 T$ = "  Doe je best met plussen en minnen": RETURN
5640 T$ = "Denk eraan dat  X  voor  + en -  gaat": RETURN
5650 T$ = "Onthoud....  X en / gaan voor + en -": RETURN
5660 :
5670 REM plaats tekst
5680 GOSUB 110
5690 FOR I = 1 TO LEN(B$)
5700 FOR J = 1 TO VT: NEXT J
5710 PRINT MID$(B$, I, 1);
5720 NEXT I
5730 IF Y = 1 THEN GOSUB 5970
5740 RETURN
5750 :
5760 REM beweging omlaag
5770 S1$ = LEFT$(SP$, LEN(A$))
5780 FOR I = 1 TO X: VE = VE + 1
5790 FOR J = 1 TO VT: NEXT J
5800 GOSUB 110: PRINT A$;
5810 FOR J = 1 TO VT: NEXT J
5820 VE = VE + 1: GOSUB 110: PRINT A$;
5830 VE = VE - 1: GOSUB 110: PRINT S1$;
5840 NEXT I
5850 RETURN
5860 :
5870 REM beweging links
5880 FOR I = X TO 1 STEP-1: HO = HO - 1
5890 FOR J = 1 TO VT: NEXT J
5900 GOSUB 110: PRINT A$;
5910 FOR J = 1 TO VT: NEXT J
5920 HO = HO + 2: GOSUB 110: PRINT S1$;
5930 HO = HO - 2: NEXT I
5940 RETURN
5950 :
5960 REM pauze
5970 FOR I = 1 TO 20 * VT: NEXT I
5980 RETURN
5990 :
6000 VT = 50: RETURN: REM vertraging
6010 :
30000 REM U kunt de snelheid in enkele
30010 REM onderdelen van het programma
30020 REM wijzigen met de waarde van
30030 REM VT in regel 6000
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
30140 REM januari 1990
30150 REM
30160 REM Copyright NOS Hilversum
