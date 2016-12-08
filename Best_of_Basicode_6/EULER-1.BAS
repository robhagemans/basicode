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
 1010 GOSUB 100:REM OOIT VAN 'E' GEHOORD?
 1020 PRINT"--- even geduld ---"
 1030 VE=0:FOR I=0 TO 80:HO=I:GOSUB 110
 1040 GOSUB 120:IF HO<>I THEN HP=I:I=80
 1050 NEXT I:FOR I=0 TO 40:HO=0:VE=I:GOSUB 110
 1060 GOSUB 120:IF VE<>I THEN VP=I:I=40
 1070 NEXT I:SB=HP:SH=VP
 1080 REM BEGIN PROGRAMMA
 1090 DIM K$(6)
 1100 KL$="":GOTO 5000:REM* MENU *
 1110 GOSUB 100:PRINT"ooit van 'e' gehoord?"
 1120 PRINT:PRINT"naar P)rinter of S)cherm ?";
 1130 GOSUB 210:GOSUB 1800
 1140 IF(IN$<>"P") AND(IN$<>"S") THEN 1130
 1150 PRINT IN$:PRINT
 1160 PT=1:IF IN$="S" THEN PT=0:GOTO 1340
 1170 PRINT"hoeveel letters per regel ";
 1180 INPUT HP
 1190 PRINT:PRINT"kantlijnbreedte ";
 1200 INPUT SP:GOSUB 1900:KL$=SP$
 1210 HP=HP-SP:IF SP>1 THEN HP=HP-SP+2
 1220 PRINT:PRINT"hoeveel regels tekst per pagina ";
 1230 INPUT VP
 1240 PRINT:PRINT"K)ettingformulieren of L)osse vellen ?";
 1250 GOSUB 210:GOSUB 1800
 1260 IF(IN$<>"K") AND(IN$<>"L") THEN 1250
 1270 PRINT IN$:PRINT
 1280 KF=1:IF IN$="L" THEN KF=0:GOTO 1310
 1290 PRINT"hoeveel lege regels onderaan vel ";
 1300 INPUT LR:PRINT
 1310 PRINT"zet de printer klaar"
 1320 PRINT"en druk op een toets"
 1330 GOSUB 210
 1340 RT=0:H=0:N=1
 1350 REM PRINT DE KOP
 1360 K$(0)="******************************"
 1370 K$(1)="*                            *"
 1380 K$(2)="*   ooit van 'e' gehoord ?   *"
 1390 K$(3)="*   verzameling wetens-      *"
 1400 K$(4)="*   waardigheden over 'e'    *"
 1410 K$(5)="*                            *"
 1420 K$(6)="******************************"
 1430 GOSUB 100
 1440 SP=INT((HP-30)/2):IF PT=1 THEN SP=SP-3
 1450 GOSUB 1900
 1460 SR$=" ":GOSUB 20000
 1470 FOR I=0 TO 6:SR$=SP$+K$(I):GOSUB 20000:NEXT I
 1610 A$="":RESTORE:REM PRINT DE OVERIGE DATA
 1620 READ BB$:KL=0
 1630 GOSUB 23000
 1640 GOSUB 24000
 1650 IF KL=0 THEN 1630
 1670 GOTO 5000
 1800 IF(IN$<"a") OR(IN$>"z") THEN RETURN
 1810 IN$=CHR$(ASC(IN$)-ASC("a")+ASC("A"))
 1820 RETURN
 1900 SP$="":IF SP<1 THEN RETURN
 1910 FOR I=1 TO SP:SP$=SP$+" ":NEXT I
 1920 RETURN
 2000 GOSUB 100:END
 3000 REM*** BENADERING 'E' ***
 3010 GOSUB 100:HO=5:VE=2:GOSUB 110
 3020 PRINT" Benadering van getal 'e'"
 3030 VE=4:GOSUB 110:PRINT"(naar com.info-1/88-p.68)"
 3040 HO=1:VE=7:GOSUB 110
 3050 PRINT"e= 1/0! + 1/1! + 1/2! + 1/3! + ..."
 3060 VE=10:GOSUB 110
 3070 PRINT"e=1:y=1:fort=1 to 15:y=y*t"
 3080 PRINT" e=e+1/y:print e:next t"
 3090 GOSUB 21020
 3100 HO=2:VE=1:GOSUB 110
 3110 PRINT"Getal 'e' benaderen"
 3120 HO=0:VE=3:GOSUB 110
 3130 PRINT"e=1/0! + 1/1! + 1/2! + 1.3! +...":PRINT
 3140 E=1:Y=1:FOR T=1 TO 15:Y=Y*T:E=E+1/Y:PRINT E:NEXT T
 3150 GOSUB 21020:GOTO 5000:REM* MENU *
 4000 REM*** DEMO LOG-GEBRUIK ***
 4010 GOSUB 100:HO=5:VE=4:GOSUB 110
 4020 PRINT"*** DEMO log.-gebruik ***"
 4030 HO=1:VE=6:GOSUB 110:PRINT"Indien a = getal"
 4040 VE=8:GOSUB 110:PRINT"dan geeft pl=log(a)/log(10)+1"
 4050 VE=10:GOSUB 110:PRINT"het aantal cijfers van dat getal."
 4060 VE=12:GOSUB 110:PRINT"Zo kan men het aantal"
 4070 VE=14:GOSUB 110:PRINT"spaties bepalen of getallen"
 4080 VE=16:GOSUB 110:PRINT"geformateerd uit geven."
 4090 GOSUB 21020
 4100 PRINT"DEMO-log-gebruik (vervolg)"
 4110 PRINT"---------------"
 4120 HO=0:VE=4:GOSUB 110
 4130 PRINT"aantal cijfers voor komma = aantal spa-"
 4135 PRINT"ties."
 4140 PRINT"a<>0 !-stoppen  als  a=0":PRINT
 4150 PRINT"Geef getal a:";:INPUT A
 4160 IF A<=0 THEN 5000:REM* MENU *
 4170 PL=LOG(A)/LOG(10)+1:PRINT
 4180 PRINT"1234567890  =positie controle"
 4190 PRINT LEFT$("         ",PL);"*****"
 4200 PRINT:GOTO 4150
 4210 GOSUB 100:PRINT"       DEMO LOG-GEBRUIK 2"
 4220 PRINT"       Breuken vereenvoudigen"
 4230 HO=0:VE=5:GOSUB 110
 4240 PRINT"Int(log(h)/log(10)+1) geeft het aantal"
 4250 PRINT"cijfers van de HELEN van h.":PRINT
 4260 PRINT"ct bij gosub 310 geeft de totale lengte"
 4270 PRINT"van sr$. cn het aantal characters na de"
 4280 PRINT"decimale punt.":PRINT
 4290 PRINT"--DRUK Toets--":GOSUB 210
 4292 GOSUB 100:PRINT"Teller : ";:INPUT TE:PE=TE
 4294 PRINT"Noemer : ";:INPUT NO
 4296 H=INT(TE/NO):R=TE-H*NO:TE=R:IF R=0 THEN 4400
 4298 C=TE:D=NO
 4300 Q=C-INT(C/D)*D:C=D:D=Q:IF Q>0 THEN 4300
 4302 HO=0:VE=10:GOSUB 110
 4304 PRINT" Vereenvoudigd:"
 4306 CT=LOG(NO/C)/LOG(10)+1:CN=0
 4308 CQ=1:IF H>0 THEN CQ=LOG(H)/LOG(10)+1
 4310 CQ$=LEFT$("         ",CQ)
 4312 CT=LOG(NO/C)/LOG(10)+1:PRINT
 4314 PRINT"  TELLER: ";CQ$
 4316 PRINT"  ------- ";CQ$;"  ";
 4318 PRINT LEFT$("-------------",CT)
 4320 PRINT"  NOEMER: ";CQ$
 4330 HO=12+CQ:VE=12:GOSUB 110:SR=TE/C:CT=INT(CT):GOSUB 310
 4340 PRINT SR$:VE=14:GOSUB 110:SR=NO/C:GOSUB 310:PRINT SR$
 4350 IF H>0 THEN HO=11:VE=13:GOSUB 110:PRINT H
 4360 HO=15+CT+CQ:VE=12:GOSUB 110
 4370 PRINT"   (=";TE;" :";C;")"
 4380 VE=14:GOSUB 110
 4390 PRINT"   (=";NO;" :";C;")"
 4400 HO=2:VE=17:GOSUB 110:PRINT"Breuk heeft waarde ";PE/NO
 4410 HO=0:VE=19:GOSUB 110
 4420 PRINT"Nog een breuk (J/N)?";:GOSUB 210
 4430 IF(IN$="j") OR(IN$="J") THEN 4292
 4990 REM*** MENU ***
 5000 GOSUB 100:HO=5:VE=4:GOSUB 110:PRINT"MENU : GETAL 'e'"
 5010 HO=5:VE=6:GOSUB 110:PRINT"1. Komplete tekst"
 5020 VE=8:GOSUB 110:PRINT"2. Benadering 'e'"
 5030 VE=10:GOSUB 110:PRINT"3. Log.gebruik-demo 1"
 5040 VE=12:GOSUB 110:PRINT"4. Log.gebruik-demo 2"
 5050 VE=14:GOSUB 110:PRINT"5. Stoppen"
 5060 HP=SB:VP=SH:HO=1:VE=VP-1:GOSUB 110
 5070 PRINT"<Geef nummer van Uw keuze>";
 5080 GOSUB 210:K=VAL(IN$):IF(K<1) OR(K>5) THEN 5080
 5090 ON K GOTO 1110,3000,4000,4210,2000
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
22060 SR$="Ooit van 'e' gehoord, deel 1, pag. "+N$
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
25000 DATA"#          Ooit van 'e' gehoord ?"
25010 DATA". In de METROLOGIE is 'E' als voorvoeg-"
25020 DATA". sel symbool voor EXA ,d.w.z.voor een"
25030 DATA". factor 10^18."
25040 DATA". "
25050 DATA". In de NATUURKUNDE is 'E' o.a.symbool"
25060 DATA". voor energie en elasticiteitsmodulus,"
25070 DATA". is'e'symbool voor een elektron en"
25080 DATA". is'e'symbool voor elementaire lading."
25090 DATA". "
25100 DATA". Dit programma bekijkt 'e' in de"
25110 DATA". = WISKUNDE. =",". "
25120 DATA". 'e' is een IRRATIONAAL"
25130 DATA".            COMPLEX"
25140 DATA".            TRANSCENDENT getal met als"
25150 DATA". getalswaarde:"
25160 DATA".            e = 2,7182818284........"
25170 DATA"#'e' is te definieren als:"
25180 DATA". "
25190 DATA".       1  1    1      1"
25200 DATA". e = 1+-+---+-----+-------......"
25210 DATA".       1 1*2 1*2*3 1*2*3*4"
25220 DATA". "
25230 DATA".'e' is het GRONDTAL van de NATUURLIJKE"
25240 DATA". "
25250 DATA". LOGARITMEN."
25260 DATA"#           LOGARITME"
25270 DATA".BEGRIP:"
25280 DATA".           b"
25290 DATA".       In a  =c staan 3 getallen"
25300 DATA".-is a en b gegeven,dan spreekt men van"
25310 DATA".       MACHTSVERHEFFING"
25320 DATA". vb. 2^3=8",". "
25330 DATA".-is b en c gegeven,dan spreekt men van"
25340 DATA".       WORTELTREKKING"
25350 DATA".     3         3---"
25360 DATA". vb.2  =8  --> v 8 = 2",". "
25370 DATA".-Er is nog een derde mogelijkheid:"
25380 DATA". a en c zijn gegeven,b is gevraagd."
25390 DATA".     b"
25400 DATA". vb.2  =8  --> dus b=3"
25410 DATA". Men zegt dan:3 is de LOGARITME van 8"
25420 DATA"# Dat schrijft men als"
25430 DATA". 2"
25440 DATA".  log 8 = 3",". "
25450 DATA".DEFINITIE:onder de a=logaritme van c,"
25460 DATA".(voorwaarden:a>c,a<>1,c>0) verstaat"
25470 DATA". men de EXPONENT van de macht,waartoe"
25480 DATA". men a moet verheffen om c als uitkomst"
25490 DATA". te krijgen.a=BASIS(grondtal),c=NUMERUS",". "
25500 DATA".Hieruit volgt de definitie-formule:"
25510 DATA".       a"
25520 DATA".        log c"
25530 DATA".     a        = c"
25540 DATA"#  EIGENSCHAPPEN LOGARITMEN"
25550 DATA". g          g        g"
25560 DATA".  log a*b =  log a +  log b",". "
25570 DATA". g          g        g"
25580 DATA".  log a/b =  log a -  log b",". "
25590 DATA". g     n        g"
25600 DATA".  log a   = n *  log a",". "
25610 DATA". g    n--          g"
25620 DATA".  log v a = (1/n)*  log a",". "
25630 DATA". -bijzondere gevallen:"
25640 DATA". g"
25650 DATA".  log 1 = 0",". "
25660 DATA". g"
25670 DATA".  log g = 1"
25680 DATA"#     LOGARITME-STELSELS"
25690 DATA"Om met logaritmen te kunnen rekenen is het"
25700 DATA"nodig, dat men van alle getallen de logaritmen"
25710 DATA".voor EENZELFDE BASIS kent.(basis=grondtal)"
25720 DATA". ",". Er zijn slechts 2 grondtallen in gebruik:"
25730 DATA". ",". -grondtal 10 -> BRIGGSE of GEWONE"
25740 DATA"logaritmen.(log a)."
25750 DATA". ",". -grondtal e  -> NATUURLIJKE logaritmen"
25760 DATA"(ln a)",". ",".Vroeger had men ook nog de"
25770 DATA"NEPERSE logaritmen. Zie deel 2:Hist.Notities."
25800 DATA"# De NATUURLIJKE logaritmen"
25810 DATA"(met grondtal e) worden"
25820 DATA"vooral gebruikt in de hogere wiskunde.",". "
25830 DATA". De natuurlijke logaritmen zijn meer van"
25840 DATA"theoretisch dan van practisch nut.",". "
25850 DATA". In de praktijk maakt men meestal gebruik van"
25860 DATA"het grondtal 10. De meeste computers geven"
25870 DATA"de natuurlijke logaritme. De log met grondtal 10"
25880 DATA"krijgt men,door het resultaat"
25890 DATA". TE DELEN door ln(10)",". "
25900 DATA".   10"
25910 DATA".     log(x) = ln(x)/ln(10)"
25920 DATA"# "," De logaritmen van de getallen van 1"
25930 DATA"tot 20000 en van 90000"
25940 DATA"tot 100000 voor het grondtal 10"
25950 DATA"zijn berekend door de Engelsman Henry Briggs"
25960 DATA"in 14 decimalen in 1624.",". "
25970 DATA". De logaritmen van de getallen van 20000 tot"
25980 DATA"90000 voor het grondtal 10 zijn berekend"
25990 DATA"door de Goudse boekhandelaar en rekenmeester"
26000 DATA".     Adriaen Vlacq (1628)",". "
26010 DATA".Verdere bekende namen op dit gebied zijn:"
26020 DATA".   Francois Callet(an iii,dat is 1795)"
26030 DATA".   Vega,Schoen,Kohler,Long(Engelsman,1724)"
26040 DATA"#  De NATUURLIJKE LOGARITMEN"
26050 DATA".       (grondtal = e)",". "
26060 DATA".Het grondtal van de natuurlijke log.is e."
26070 DATA". ",".               1    1    1         1"
26080 DATA".e = lim ( 1 + -- + -- + -- + .. + -- )"
26090 DATA".   1->oo      1!   2!   3!        n!"
26100 DATA". ",".e = 2,718281828459...",". "
26110 DATA".De logaritme van een getal a wordt aangeduid"
26120 DATA"met lg a of (ten onrechte!) met nep.log a."
26130 DATA"De aanduiding NEPERIAANS dankt zijn ontstaan"
26140 DATA"aan de misvatting dat NEPER dat getal"
26150 DATA"als grondtal gebruikte."
26160 DATA"#Opmerking:"
26170 DATA".          Daar een negatief getal geen"
26180 DATA"logaritme heeft,"
26190 DATA"stelt men eerst het teken vast en berekent"
26200 DATA"daarna de volstrekte waarde."
26210 DATA"#     OMZETTINGEN"
26220 DATA".  (gewone log.in natuurlijke log)",". "
26230 DATA".           (brigg.)logx    log x"
26240 DATA".(nat.lg x)=------------ = --------- ="
26250 DATA".               log e      0.4342945",". "
26260 DATA".log x * 2.3025851",". "
26270 DATA".  (nat.log in gewone log.)",". "
26280 DATA".             (nat.)lg x       lg x"
26290 DATA".(brigg.)logx= ---------- = --------- ="
26300 DATA".                 lg 10     2.3025851",". "
26310 DATA".lg x * 0.4342945"
26320 DATA"#     OMZETTINGEN"
26330 DATA". Men kan het ene log.stelsel omrekenen naar het"
26340 DATA"andere. Daartoe dient de z.g.MODULUS:",". "
26350 DATA".  m = 0.4342944819",". "
26360 DATA".afgerond wordt dat dan:",". "
26370 DATA".  m = 0.4342945",". "
26380 DATA".en 1"
26390 DATA".   - = 2.3025850929"
26400 DATA".   m"
26410 DATA"# De formules worden dan",". "
26420 DATA".  10            e"
26430 DATA".    log x = m *  log x",". "
26440 DATA".en ",". "
26450 DATA".   e        1   10"
26460 DATA".    log x = - *   log x"
26470 DATA".            m"
26480 DATA"# Logaritme van het grondtal = 1"
26490 DATA". In elk logaritme-stelsel is de logaritme"
26500 DATA"van het grondtal = 1 en de logaritme van een"
26510 DATA"macht van het grondtal is gelijk aan de"
26520 DATA"EXPONENT van die macht.",". "
26530 DATA". vb.  10                   0"
26540 DATA".        log 1 = 0   want 10 = 1",". "
26550 DATA".      10                     3"
26560 DATA".        log 1000 = 3 want  10 = 1000",". "
26570 DATA".      10     1               -3    1"
26580 DATA".        log ---- = -3 want 10  = ----"
26590 DATA".            1000                 1000"
26600 DATA"# ",". De logaritmen van alle getallen TUSSEN"
26610 DATA"twee gehele machten van het grondtal in, zijn"
26620 DATA"IRRATIONALE getallen. Deze bevatten de"
26630 DATA"logaritme van de dichtsbijzijnde lagere macht"
26640 DATA"van het grondtal.",". "
26650 DATA". vb.  10"
26660 DATA".        log 105 = 2.02119......",". "
26670 DATA". Het getal 2,dat de logaritme van"
26680 DATA".   2"
26690 DATA". 10 = 100  is,noemt men de WIJZER,",". "
26700 DATA". de tiendelige rest noemt men de MANTISSE."
26710 DATA". Van mantissa = rest,toegift."
26720 DATA". De naam mantisse voor de groep cijfers achter"
26730 DATA"de komma stamt van WALLIS(1616-1703)."
26740 DATA". Sedert EULER (1707-1783) wordt mantisse"
26750 DATA"gebruikt voor de"
26760 DATA"cijfers achter de komma bij logaritme."
26770 DATA"# EIGENSCHAPPEN van e"
26780 DATA". e is een IRRATIONAAL  getal",". "
26790 DATA". e is een TRANSCENDENT getal",". "
26800 DATA". e is een COMPLEX      getal",". "
26810 DATA". e is een tiendelige breuk,met een oneindig"
26820 DATA"doorlopende mantisse.",". "
26830 DATA". e = 2.71828182845904523536...enz",". "
26840 DATA". Deze uitkomst is, zoals de Grieken sinds"
26850 DATA"Pythagoras zeiden:'alogos'=niet uit te spreken,"
26860 DATA"onzinnig. Ze is in tegenspraak met ons verstand"
26870 DATA"(rede), onze 'ratio'. Vandaar de term"
26880 DATA".   IRRATIONALE GETALLEN"
26890 DATA". Op de getallenrechte kan men deze NIET EXACT"
26900 DATA" aangeven."
26910 DATA"#   Het getal pi"
26920 DATA". Een ander voorbeeld van irrationaal getal"
26930 DATA"is het getal"
26940 DATA". pi = 3.14159265358979323846...enz"
26950 DATA". ",". In 1873 ontdekte HERMITE,dat het getal e"
26960 DATA"TRANSCENDENT is.",". "
26970 DATA". Vereenvoudigd gezegd,betekent dit :"
26980 DATA". Er bestaan onder de irrationale getallen"
26990 DATA"nog bijzondere getallen, die men door geen"
27000 DATA"enkele rekenkundige bewerking met gehele"
27010 DATA"getallen kan verkrijgen. Deze getallen noemt"
27020 DATA"men TRANSCENDENTE getallen."
27030 DATA"# e = TRANSCENDENT"
27040 DATA". e = een grootheid, die niet door een"
27050 DATA"vergelijking van zekere graad kan worden"
27060 DATA"bepaald. Die iedere algebraische vergelijking"
27070 DATA"te boven gaat."
27080 DATA". (LEIBNITZ ,1646-1716)"
27090 DATA". ",". e = COMPLEX",". "
27100 DATA". Complexe getallen bestaan uit een reeel"
27110 DATA"deel en een imaginair deel.",". "
27120 DATA"( a + b*i )."
27130 DATA"# Verband tussen 1,e,i en pi"
27140 DATA". In 1748 vond EULER het verband tussen"
27150 DATA"de vier wonderlijke getallen:",". "
27160 DATA".   1 , e , i en pi ",". "
27170 DATA". in de betrekking:",". ",". "
27180 DATA".       2*i*(pi)"
27190 DATA".      e         = 1",". ",". "
27200 DATA". en"
27210 DATA".       i*(pi)"
27220 DATA".      e        = -1","# "
27230 DATA"$$$$$"
30000 REM**** OOIT VAN 'E' GEHOORD ***
30010 REM**** DEEL 1 - TEKST       ***
30020 REM**** (IN DEEL 2 VOLGEN    ***
30030 REM**** HISTORISCHE NOTITIES ***
30040 REM**** EN LITERATUUR-OPGAVE ***
30050 REM
30060 REM**** HARRY EYCK / NEER    ***
30070 REM**** OP COMMODORE C/64    ***
30080 REM**** JUNI 1988            ***
30090 REM COPYRIGHT NOS HILVERSUM
