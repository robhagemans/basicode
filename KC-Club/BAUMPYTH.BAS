1000 A=200:GOTO 20:REM   DE BOOM VAN PYTHAGORAS  BC3
1010 DIM DX(9),DY(9),EX(9),EY(9),FX(9),FY(9),GX(9),GY(9)
1020 GOSUB 100:CN=0:HT=HO
1030 REM === de titelpagina ===
1040 FOR N=1 TO 5:READ SR$:HO=5:VE=5+N
1050 GOSUB 110:GOSUB 150:NEXT N
1060 VE=15:GOSUB 110:PRINT "    Wil je uitleg (J/N) ";
1070 GOSUB 210:IF (IN$<>"J")AND(IN$<>"j") THEN 1110
1080 REM === uitleg subroutine ===
1090 GOSUB 600:GOSUB 3020
1100 REM === DE TEKENING ===
1110 GOSUB 600
1120 REM === de lijst ===
1130 XX=.0844:YY=.67:C=1.33
1140 HO=0:VE=0:GOSUB 620:VE=.999:GOSUB 630
1150 HO=.999:GOSUB 630:VE=0:GOSUB 630:HO=0:GOSUB 630
1160 REM === de boomstam ===
1170 HO=.5-XX:VE=1:GOSUB 620:VE=YY:GOSUB 630
1180 HO=.5+XX:GOSUB 630:VE=1:GOSUB 630
1190 REM === de takken ===
1200 FOR L=2 TO 9
1210 N=0:AX=.5-XX:AY=.5:BX=.5+XX:BY=AY:GOSUB 2040
1220 NEXT L
1230 REM (wie haast heeft kan FORL=2TO9
1240 REM veranderen in L=9 en dan NEXTL
1250 REM weglaten)
1260 REM === vasthoud-lus ===
1270 GOSUB 210:IF IN=13 THEN 950
1280 GOTO 1270
2000 REM 
2010 REM === TEKEN-SUBROUTINE ===
2020 REM (werkt recursief, d.w.z. deze
2030 REM subroutine roept zichzelf aan)
2040 IF N=L THEN RETURN
2050 N=N+1
2060 MX=(AX+BX)/2:MY=(AY+BY)/2:CX=MX-MY+AY
2070 CY=MX+MY-AX:VX=CX-AX:VY=CY-AY
2080 DX(N)=CX+VX:DY(N)=CY+VY:EX(N)=BX+VX:EY(N)=BY+VY
2090 WX=CX-BX:WY=CY-BY:FX(N)=AX+WX:FY(N)=AY+WY
2100 GX(N)=CX+WX:GY(N)=CY+WY
2110 HO=AX:VE=C*(1-AY):GOSUB 620
2120 HO=DX(N):VE=C*(1-DY(N)):GOSUB 630
2130 HO=EX(N):VE=C*(1-EY(N)):GOSUB 630
2140 HO=BX:VE=C*(1-BY):GOSUB 630
2150 HO=GX(N):VE=C*(1-GY(N)):GOSUB 630
2160 HO=FX(N):VE=C*(1-FY(N)):GOSUB 630
2170 HO=AX:VE=C*(1-AY):GOSUB 630
2180 AX=DX(N):AY=DY(N):BX=EX(N):BY=EY(N):GOSUB 2040
2190 AX=FX(N):AY=FY(N):BX=GX(N):BY=GY(N):GOSUB 2040
2200 N=N-1:RETURN
3000 REM === UITLEG-SUBROUTINE ===
3010 REM --- de tekst ---
3020 FOR K=1 TO 18:READ SR$
3030 HO=0:VE=K*.05:GOSUB 650
3040 NEXT K
3050 REM --- het tekeningetje ---
3060 HO=.2*36/HT:VE=.78:GOSUB 620
3070 VE=VE+.16:GOSUB 630:HO=HO+.06:GOSUB 630
3080 VE=VE-.08:GOSUB 630:HO=HO-.12:GOSUB 630
3090 VE=VE-.08:GOSUB 630:HO=HO+.06:GOSUB 630
3100 VE=VE-.08:HO=HO+.06:GOSUB 630
3110 VE=VE+.08:HO=HO+.06:GOSUB 630
3120 VE=VE+.08:HO=HO-.06:GOSUB 630
3130 VE=VE-.08:HO=HO-.06:GOSUB 630
3140 GOSUB 210:RETURN
25000 DATA "                     "
25010 DATA "D E   B O O M   V A N"
25020 DATA "                     "
25030 DATA " P Y T H A G O R A S "
25040 DATA "                     "
25050 DATA "PYTHAGORAS leefde in Griekenland"
25060 DATA "van ca 570 tot 497 voor Christus"
25070 DATA "Naar hem is de bekende 'stelling"
25080 DATA "van Pythagoras' genoemd,  die de"
25090 DATA "verhouding  aangeeft  tussen  de"
25100 DATA "drie zijden van een rechthoekige"
25110 DATA "driehoek."
25120 DATA "Met een groot aantal herhalingen"
25130 DATA "van de figuur die bij deze stel-"
25140 DATA "ling hoort tekent de computer op"
25150 DATA "kunstzinnige wijze een boom."
25160 DATA " "
25170 DATA "De stelling van Pythagoras luidt"," "
25180 DATA "                   2    2    2"
25190 DATA "                  A  + B  = C"
25200 DATA " "
25210 DATA "             Tik op een toets..."
30000 REM ==============================
30010 REM GEMAAKT OP EEN BBC-COMPUTER
30020 REM 17 AUG. 1987 DOOR
32000 REM Ch.W.Brederode
32010 REM Von Bonninghausenlaan 33
32020 REM 2161 ES  LISSE
