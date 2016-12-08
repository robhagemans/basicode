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
 1000 A=600:GOTO 20:REM HOBBYSCOOP-KRANT
 1010 GOSUB 100:REM EERST SCHERM OPMETEN
 1020 I=0:J=I:VE=I:IP=64:JP=IP:FOR A=1 TO 7
 1030 I=I+IP:HO=I:GOSUB 110:GOSUB 120:IF HO<>I THEN I=I-IP
 1040 J=J+JP:VE=J:GOSUB 110:GOSUB 120:IF VE<>J THEN J=J-JP
 1050 IP=IP/2:JP=JP/2:NEXT A:HP=I+1:VP=J+1
 1060 REM BEGIN PROGRAMMA
 1070 DIM K$(6)
 1080 GOSUB 100:PRINT"HOBBYSCOOPKRANT"
 1090 PRINT:PRINT"Naar P)rinter of S)cherm ?";
 1100 GOSUB 210:GOSUB 1800
 1110 IF(IN$<>"P") AND(IN$<>"S") THEN 1100
 1120 PRINT IN$:PRINT
 1130 PT=1:IF IN$="S" THEN PT=0:GOTO 1310
 1140 PRINT"Hoeveel letters per regel ";
 1150 INPUT HP
 1160 PRINT:PRINT"Kantlijnbreedte ";
 1170 INPUT SP:GOSUB 1900:KL$=SP$
 1180 HP=HP-SP:IF SP>1 THEN HP=HP-SP+2
 1190 PRINT:PRINT"Hoeveel regels tekst per pagina ";
 1200 INPUT VP
 1210 PRINT:PRINT"K)ettingformulieren of L)osse vellen ?";
 1220 GOSUB 210:GOSUB 1800
 1230 IF(IN$<>"K") AND(IN$<>"L") THEN 1220
 1240 PRINT IN$:PRINT
 1250 KF=1:IF IN$="L" THEN KF=0:GOTO 1280
 1260 PRINT"Hoeveel lege regels onderaan vel ";
 1270 INPUT LR:PRINT
 1280 PRINT"Zet de printer klaar"
 1290 PRINT"en druk op een toets"
 1300 GOSUB 210
 1310 RT=0:H=0:N=1:KL=0
 1320 REM PRINT DE KOP
 1330 K$(0)="******************************"
 1340 K$(1)="*     N.O.S.- HOBBYSCOOP     *"
 1350 K$(2)="*        BEELDKRANT          *"
 1360 K$(3)="*           BIJ              *"
 1370 K$(4)="*         HET SPEL           *"
 1380 K$(5)="*   'ZEESLAG PER COMPUTER'   *"
 1390 K$(6)="******************************"
 1400 GOSUB 100
 1410 SP=INT((HP-30)/2):IF PT=1 THEN SP=SP-3
 1420 GOSUB 1900
 1430 SR$=" ":GOSUB 20000
 1440 FOR I=0 TO 6:SR$=SP$+K$(I):GOSUB 20000:NEXT I
 1450 RESTORE:READ DD$
 1460 SR$=" ":GOSUB 20000
 1510 SR$=" ":GOSUB 20000
 1520 SR$="Zend uw bijdragen voor onze":GOSUB 20000
 1530 SR$="beeldkrant aan:":GOSUB 20000
 1540 SR$=" ":GOSUB 20000
 1550 SR$="N.O.S. Hobbyscoop Beeldkrant,":GOSUB 20000
 1560 SR$="Postbus 1200,":GOSUB 20000
 1570 SR$="1200 BE Hilversum.":GOSUB 20000
 1580 A$="":REM PRINT DE OVERIGE DATA
 1590 READ BB$
 1600 GOSUB 23000
 1610 GOSUB 24000
 1620 IF KL=0 THEN 1600
 1630 END
 1800 IF(IN$<"a") OR(IN$>"z") THEN RETURN
 1810 IN$=CHR$(ASC(IN$)-ASC("a")+ASC("A"))
 1820 RETURN
 1900 SP$="":IF SP<1 THEN RETURN
 1910 FOR I=1 TO SP:SP$=SP$+" ":NEXT I
 1920 RETURN
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
21030 PRINT"<Toets voor verder>";
21040 GOSUB 210:GOSUB 100:RT=0:RETURN
22000 REM PAPIER VOL
22010 IF KF=1 THEN FOR I=1 TO LR:GOSUB 360:NEXT I:GOTO 22050
22020 PRINT"Zet de printer bovenaan nieuwe pagina"
22030 PRINT"en druk daarna op een toets."
22040 GOSUB 210:GOSUB 100
22050 RT=0:N=N+1:SR=N:GOSUB 300:N$=SR$
22060 SR$=DD$+", pag. "+N$
22070 RL=LEN(SR$):GOSUB 20060:SR$=""
22080 FOR I=1 TO RL:SR$=SR$+"-":NEXT I
22090 GOSUB 20060:SR$=" ":GOSUB 20060:RETURN
23000 IF BB$="$$$$$" THEN KL=1:H=1:RETURN
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
25000 DATA"Zeeslag per computer"
25010 DATA"#ZEESLAG PER COMPUTER"
25020 DATA"Doel van dit spel is het tot zinken"
25030 DATA"brengen van de vloot van de computer."
25040 DATA"Er zijn 100 verschillende vlootformaties"
25050 DATA"in het programma verwerkt, maar U kunt ook"
25060 DATA"de zelf gekozen posities van de"
25070 DATA"schepen zelf invoeren."
25080 DATA"Als U dit gedaan heeft, zal de computer zijn"
25090 DATA"vlootformatie uitzoeken en dan kan het spel"
25100 DATA"beginnen."
25110 DATA".In het kleine schermpje (window) onderaan het"
25120 DATA"scherm is vermeld wie er aan de beurt is,"
25130 DATA"hoeveel keer de speler of de computer"
25140 DATA"heeft geschoten,"
25150 DATA"hoeveel van deze 'torpedo's' raak waren"
25160 DATA"(rechts van het schuine streepje) en hoeveel"
25170 DATA"torpedo's er zijn misgeschoten. Op het scherm"
25180 DATA"bevinden zich twee speelvelden: die van de"
25190 DATA"speler en die van de computer. De schepen"
25200 DATA"van de speler zijn aangeduid met het hekje"
25210 DATA"(#). Als deze aan de beurt is, wordt er"
25220 DATA"naar een coordinaat gevraagd."
25230 DATA"Als deze raak is dan wordt dat vermeld"
25240 DATA"en wordt deze coordinaat met een kruisje (x) in"
25250 DATA"het veld van de computer aangeduid. Als zich op"
25260 DATA"deze plaatsen geen schepen van de"
25270 DATA"computer bevinden dan wordt hier een rondje (o)"
25280 DATA"op geplaatst. Zo is te zien welke"
25290 DATA"coordinaten er al zijn gebruikt. Wanneer de"
25300 DATA"computer aan de beurt is, werkt alles op"
25310 DATA"dezelfde manier, alleen worden de door de"
25320 DATA"computer uitgekozen coordinaten op het veld"
25330 DATA"van de speler geplaatst."
25340 DATA".Geef de coordinaten op de volgende manier weer:"
25350 DATA".bijv. a1 - B5 - J10 - e5"
25360 DATA". "
25370 DATA"Als de speler of de computer een schip van"
25380 DATA"de tegenstander heeft laten zinken, dan wordt"
25390 DATA"dit meteen vermeld."
25400 DATA"#VOORGEPROGRAMMEERDE VLOOTFORMATIES"
25410 DATA"De data bevatten 100 verschillende"
25420 DATA"vlootformaties die in het instructieboekje"
25430 DATA"van MB-Electronics vermeld staan. U"
25440 DATA"kunt zelf ook formaties toevoegen of nieuwe"
25450 DATA"invoeren. Dit gaat als volgt:"
25460 DATA". "
25470 DATA"De coordinaten van de schepen worden in deze"
25480 DATA"volgorde ingelezen:"
25490 DATA". "
25500 DATA"-Het vliegtuigmoederschip,"
25510 DATA".-De kruiser,"
25520 DATA".-De onderzeeer,"
25530 DATA".-Het fregat en",".-de mijnenveger."
25540 DATA". "
25550 DATA"Als U een schip in het veld hebt geplaatst"
25560 DATA"dan neemt U de bovenste of de linkse coordinaat"
25570 DATA"(bijv. b4) en vervolgens voegt U er een"
25580 DATA"'h' (het schip ligt horizontaal) of een 'v'"
25590 DATA"(het schip ligt verticaal) aan toe."
25600 DATA"Voor een vlootformatie heeft U 5 van zulke"
25610 DATA"coordinaten nodig, bv.: 'f2hg1hg7ha1hh4v'."
25620 DATA"Volgens deze formatie ligt:"
25630 DATA".-het vliegtuigmoederschip op f2-f3-f4-f5-f6"
25640 DATA".-de kruiser op g1-g2-g3-g4"
25650 DATA".-de onderzeeer op g7-g8-g9"
25660 DATA".-het fregat op a1-a2-a3"
25670 DATA".-de mijnenveger op h4-i4"
25680 DATA". "
25690 DATA"OPMERKING: Een schip mag NIET verticaal op"
25700 DATA"de laatste verticale rij staan, dus de"
25710 DATA"coordinaat mag nooit B10V of E10V zijn."
25720 DATA"De schepen mogen elkaar ook niet kruisen en"
25730 DATA"zich deels buiten het veld bevinden, dus"
25740 DATA"ook niet J1V of B10H."
25750 DATA".De data moeten worden afgesloten met vijf"
25760 DATA"dollartekens ($$$$$)."
25770 DATA".Voor het zelf invoeren van de coordinaten"
25780 DATA"geldt precies hetzelfde als het voorafgaande,"
25790 DATA"alleen hoeven de coordinaten niet in data"
25800 DATA"te worden geschreven, omdat ze door het"
25810 DATA"programma worden gevraagd."
25820 DATA". "
25830 DATA"Tot zover de uitleg bij het spel 'ZEESLAG§,"
25840 DATA"veel succes bij het invoeren van formaties"
25850 DATA"en veel plezier bij het spelen tegen de"
25860 DATA"computer!"
25870 DATA"$$$$$"
30000 REM COPYRIGHT NOS HILVERSUM
