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
 1000 A=1000:GOTO 20:REM*** Valutatabel ***
 1010 GOSUB 100:HO=12:VE=4:GOSUB 110
 1015 PRINT"Even geduld":GOSUB 24000
 1020 HO=12:VE=4:GOSUB 110:PRINT"VALUTATABEL"
 1030 HO=0:VE=7:GOSUB 110
 1040 PRINT"Wilt U een toelichting? (j/N)";
 1050 GOSUB 210:IF(IN$="j") OR(IN$="J") THEN 20000
 1060 GOSUB 110:PRINT"                                "
 1500 PRINT:PRINT"WELK LAND        : ";:INPUT LD$
 1510 PRINT:PRINT"WELKE MUNT       : ";:INPUT MT$
 1520 PRINT:PRINT"Geef de wisselkoers voor 100 ";MT$
 1530 PRINT:PRINT"WISSELKOERS      : ";:INPUT WK$
 1540 PRINT:PRINT"DATUM            : ";:INPUT DT$
 2000 GOSUB 23000:SR$="LAND: "+LD$
 2010 LT=(71-(LEN(SR$)+LEN(MT$)+LEN(DT$)))/2
 2020 IF(INT(LT)<>LT) THEN SR$=SR$+" "
 2030 LT=INT(LT):FOR L=1 TO LT
 2040 SR$=SR$+" ":NEXT L:SR$=SR$+"MUNT: "+MT$
 2050 FOR L=1 TO LT:SR$=SR$+" ":NEXT L:SR$=SR$+DT$
 2100 GOSUB 350:GOSUB 360:SR$=L1$:GOSUB 350:GOSUB 360
 3000 V=VAL(WK$)/100:IF(V>1) THEN CN=2:I=.1
 3010 IF(V<=1) THEN I=1
 3020 IF(V<=.1) THEN I=10
 3030 IF(V<=.01) THEN I=100
 3040 KR$="      I":SR=0:GOSUB 310:KR$=KR$+SR$
 3060 FOR L=1 TO 9:SR=SR+I:GOSUB 310:KR$=KR$+SR$
 3070 NEXT L:SR$=KR$:GOSUB 350:GOSUB 360
 3080 SR$=L2$:GOSUB 350:GOSUB 360
 4000 FOR L=0 TO(240*I) STEP(10*I)
 4010 CT=5:CN=0:SR=L:GOSUB 310:R$=SR$+" I"
 4020 FOR M=0 TO INT((9*I)+.5) STEP I
 4030 CT=7:CN=2:SR=(L+M)*V:GOSUB 310:R$=R$+SR$
 4040 NEXT M:SR$=R$:GOSUB 350:GOSUB 360
 4050 NEXT L:SR$=L3$:GOSUB 350:GOSUB 360
 4060 SR=I*10:GOSUB 300:I$=SR$
 5000 L=140*I:M=5*I:R$="VOORBEELD: De omrekening van"
 5010 CT=LEN(I$)+2:CN=0:IF(V>1) THEN CT=6:CN=2
 5020 SR=L+M:GOSUB 310:VB$=SR$:R$=R$+SR$+" "+MT$
 5030 R$=R$+": Zoek in kolom A ":SR=L:GOSUB 300
 5040 R$=R$+SR$+" op en in":SR$=R$:GOSUB 350:GOSUB 360
 5050 CT=CT-1:SR=M:GOSUB 310:R$="kolom B"+SR$+". In het"
 5060 R$=R$+" kruispunt van de twee kolommen vindt U de"
 5070 R$=R$+" tegenwaarde":SR$=R$:GOSUB 350:GOSUB 360
 5080 R$="van"+VB$+" "+MT$+". Deze bedraagt Fl."
 5090 CT=6:CN=2:SR=(L+M)*V:GOSUB 310:R$=R$+SR$+"."
 5100 FOR L=1 TO(65-LEN(R$)):R$=R$+" ":NEXT L
 5110 R$=R$+"NOS Basicode":SR$=R$:GOSUB 350:GOSUB 360
 5120 GOSUB 360
 5200 GOSUB 100:END
20000 GOSUB 100
20010 HO=12:VE=4:GOSUB 110:PRINT"VALUTATABEL":PRINT
20020 PRINT:PRINT"Met dit Basicode-programma kunt U,"
20030 PRINT"op Uw printer, tabellen maken van"
20040 PRINT"de waarde van het buitenlandse geld"
20050 PRINT"op Uw vakantiebestemming.":PRINT
20060 PRINT"De tabellen worden geprint volgens"
20070 PRINT"een model dat is ontworpen door de"
20080 PRINT"heer M.F. Schilham uit Hoevelaken."
20090 PRINT"Tabellen volgens dit model worden"
20100 PRINT"ook afgedrukt in de Kampeer- en"
20110 PRINT"CaravanKampioen van de ANWB."
20120 PRINT:PRINT"De aktuele wisselkoersen vindt U"
20130 PRINT"op pagina 568 van NOS Teletekst."
20140 GOSUB 23010:HO=12:VE=4:GOSUB 110:PRINT"VALUTATABEL"
20150 HO=0:VE=7:GOSUB 110
20160 PRINT"Indien Uw printer beschikt over de"
20170 PRINT"mogelijkheid om 'CONDENSED' te printen,"
20180 PRINT"krijgt de tabel een zeer handzaam"
20190 PRINT"formaat. Experimenteer eventueel ook"
20200 PRINT"met lettertypes voor het verkrijgen"
20210 PRINT"van de beste leesbaarheid.":PRINT
20220 PRINT"Als U niet condensed kunt printen, is"
20230 PRINT"er natuurlijk ook nog de mogelijkheid"
20240 PRINT"om de uitgeprinte tabellen met een"
20250 PRINT"fotokopieermachine te verkleinen."
20260 PRINT:PRINT"WIJ WENSEN U EEN PRETTIGE VAKANTIE..."
20270 PRINT".....met de NOS Basicode Valutatabel."
20280 GOSUB 23010:GOTO 1020
23000 HO=20:VE=22:GOSUB 110:PRINT"Zet printer klaar";
23010 HO=20:VE=23:GOSUB 110:PRINT"TOETS  SPATIEBALK";
23020 GOSUB 210:IF(IN$<>" ") THEN 23020
23030 GOSUB 100:RETURN
24000 L1$="<--A->I<":L2$="------I---":L3$="----------"
24010 FOR L=1 TO 33:L1$=L1$+"-":L2$=L2$+"-":L3$=L3$+"-"
24020 NEXT L:L1$=L1$+"B":FOR L=1 TO 34:L1$=L1$+"-"
24030 L2$=L2$+"-":L3$=L3$+"-":NEXT L:L1$=L1$+">"
24040 CT=7:CN=0
24090 RETURN
30000 REM ooooooooooooooooooooooooooooo
30010 REM o        VALUTATABEL        o
30020 REM o                           o
30030 REM o  naar een oorspronkelijk  o
30040 REM o  idee van  M.F. Schilham  o
30050 REM o                           o
30060 REM o       geschreven in       o
30070 REM o       NOS  BASICODE       o
30080 REM o                           o
30090 REM o     Chris Bouws           o
30100 REM o     Postbus 1360          o
30110 REM o     3430 BJ Nieuwegein    o
30120 REM ooooooooooooooooooooooooooooo
30130 REM Copyright Chr. Bouws     1991
30140 REM Copyright NOS Hilversum  1991
