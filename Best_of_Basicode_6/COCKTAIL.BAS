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
 1000 A=200:GOTO 20
 1010 GOSUB 100
 1020 A$="(((TOETS)))"
 1030 B$="V=Verder T=Terug M=Menu S=Stop"
 1040 C$="Uw keuze ? "
 1050 D$="V=Verder T=Terug M=Menu"
 1060 E$="voor meer keuzen"
 1070 F$="(((SPATIEBALK)))"
 1080 PRINT
 1090 PRINT" CCC  OOO  CCC  K K  T   AAA  I  L  SSS"
 1100 PRINT" C C  O O  C C  K K TTT  A A  I  L  S S"
 1110 PRINT" C    O O  C    KK   T   A A  I  L  S  "
 1120 PRINT" C    O O  C    K    T   AAA  I  L  SSS"
 1130 PRINT" C    O O  C    KK   T   A A  I  L    S"
 1140 PRINT" C C  O O  C C  K K  T   A A  I  L  S S"
 1150 PRINT" CCC  OOO  CCC  K K  TT  A A  I  L  SSS":PRINT
 1160 PRINT"            mixen en mengen":PRINT
 1170 PRINT"                 door":PRINT
 1180 PRINT"           WIL VAN DER HEIDEN"
 1190 VE=18:HO=13:GOSUB 110:PRINT A$:GOSUB 210:GOSUB 100
 1200 REM 1E MENU
 1210 PRINT"        MENU":PRINT
 1220 PRINT"        1=GRONDREGELS":PRINT
 1230 PRINT"        2=COCKTAILS":PRINT
 1240 PRINT"        3=GEREEDSCHAP":PRINT
 1250 PRINT"        4=BARTAAL":PRINT
 1260 PRINT"        5=TEMPERATUUR":PRINT
 1270 PRINT"        6=SCHENKTIJDEN"
 1290 VE=20:HO=8:GOSUB 110:PRINT C$:GOSUB 210:GOSUB 100
 1300 IF(IN$<"1") OR(IN$>"6") THEN 1200
 1310 ON VAL(IN$) GOTO 1380,1550,8820,9100,9400,9600
 1360 REM ALGEMEEN
 1380 PRINT"         GRONDREGELS          VEL 1":PRINT
 1390 PRINT" Wie mixt, moet op de goede manier"
 1400 PRINT" mixen, namelijk met verstand van zaken."
 1410 PRINT" Oefening baart ook hier kunst en"
 1420 PRINT" daarom hier wat basisregels om"
 1430 PRINT" U opweg te helpen."
 1440 PRINT" Gebruik uitsluitend de beste"
 1450 PRINT" ingredienten."
 1460 PRINT" Cocktails en longdrinks moeten"
 1470 PRINT" ijskoud zijn."
 1480 PRINT" Alleen de kenner mag experimenteren."
 1490 PRINT" Zelf bij elkaar gefantaseerde"
 1500 PRINT" cocktails moet U geen bekende"
 1510 PRINT" namen geven."
 1520 PRINT" Bij het mixen moet u de maten"
 1530 PRINT" en hoeveelheden aanhouden.":PRINT
 1540 VE=20:HO=13:GOSUB 110:PRINT A$:GOSUB 210:GOSUB 100
 1550 REM COCKTAILSOORTEN 1E DEEL
 1560 PRINT"         COCKTAILS-1          VEL 2":PRINT
 1570 PRINT"         1=GIN-LEMMON JUICE"
 1580 PRINT"         2=GIN-VERMOUTH"
 1590 PRINT"         3=GIN-LIME JUICE"
 1600 PRINT"         4=GIN-CURACAO"
 1610 PRINT"         5=GIN-COINTREAU"
 1620 PRINT"         6=GIN-GRENADINE"
 1630 PRINT"         7=GIN-CITROEN"
 1640 PRINT"         8=GIN-SUIKERSTROOP"
 1650 PRINT"         9=GIN-CREME DE MENTHE"
 1660 VE=16:HO=9:GOSUB 110:PRINT C$;" 1/9"
 1670 VE=18:HO=9:GOSUB 110:PRINT E$
 1680 VE=20:HO=9:GOSUB 110:PRINT F$
 1690 GOSUB 210:GOSUB 100
 1700 IF IN$="1" THEN 3100
 1710 IF IN$="2" THEN 3320
 1720 IF IN$="3" THEN 4050
 1730 IF IN$="4" THEN 4250
 1740 IF IN$="5" THEN 4450
 1750 IF IN$="6" THEN 4600
 1760 IF IN$="7" THEN 4800
 1770 IF IN$="8" THEN 5000
 1780 IF IN$="9" THEN 5200
 1790 IF IN$=" " THEN 1850
 1800 GOTO 1550
 1850 REM COCKTAILS-2
 1860 PRINT"         COCKTAILS-2          VEL 3":PRINT
 1870 PRINT"         1=BIERCOCKTAIL"
 1880 PRINT"         2=TARWEBIER"
 1890 PRINT"         3=SANGRIA"
 1900 PRINT"         4=PUNCH"
 1910 PRINT"         5=WODKA"
 1920 PRINT"         6=WODKA-2"
 1930 PRINT"         7=WODKA-3"
 1940 PRINT"         8=MELK"
 1960 VE=16:HO=9:GOSUB 110:PRINT C$;"  1/8"
 1970 VE=18:HO=9:GOSUB 110:PRINT E$
 1975 VE=20:HO=9:GOSUB 110:PRINT F$
 1980 GOSUB 210:GOSUB 100
 1990 IF IN$="1" THEN 5400
 2000 IF IN$="2" THEN 5600
 2010 IF IN$="3" THEN 5800
 2020 IF IN$="4" THEN 6000
 2030 IF IN$="5" THEN 6200
 2040 IF IN$="6" THEN 6400
 2050 IF IN$="7" THEN 6650
 2060 IF IN$="8" THEN 6850
 2080 IF IN$=" " THEN 2100
 2090 GOTO 1850
 2100 REM COCKTAILS-3
 2120 PRINT"         COCKTAILS-3          VEL 4":PRINT
 2140 PRINT"         1=GINGER-GRAPE"
 2150 PRINT"         2=KOKOSSHAKE"
 2160 PRINT"         3=KLEURTJES"
 2170 PRINT"         4=RUM"
 2180 PRINT"         5=RUM-2"
 2190 PRINT"         6=RUM-3"
 2200 PRINT"         7=BOWL"
 2210 PRINT"         8=ALCOHOLVRIJ"
 2220 PRINT"         9=OPNIEUW KIEZEN"
 2230 VE=16:HO=9:GOSUB 110:PRINT C$;"  1/9"
 2240 GOSUB 210:GOSUB 100
 2250 IF IN$="1" THEN 7050
 2260 IF IN$="2" THEN 7300
 2270 IF IN$="3" THEN 7500
 2280 IF IN$="4" THEN 7700
 2290 IF IN$="5" THEN 7900
 2300 IF IN$="6" THEN 8150
 2310 IF IN$="7" THEN 8400
 2320 IF IN$="8" THEN 8650
 2330 IF IN$="9" THEN 1550
 2340 GOTO 2100
 3100 REM GIN-LEMONJUICE
 3150 PRINT"         GIN-LEMON JUICE      VEL 5":PRINT
 3160 PRINT" PINK LADY":PRINT
 3170 PRINT" 5 Delen Gin"
 3180 PRINT" 2 Delen Lemon Juice"
 3190 PRINT" 2 Delen Brandy"
 3200 PRINT" 1 Deel Grenadine rood"
 3210 PRINT" 1 Eiwit per 2 glazen"
 3220 PRINT" Shake'n met ijs en serveren in"
 3230 PRINT" een cocktailglas.":PRINT
 3240 PRINT" CHOCOLATE SOLDIER":PRINT
 3250 PRINT" 4 Delen Gin"
 3260 PRINT" 2 Delen Dubonnet"
 3270 PRINT" 1 Deel Lemon Juice":PRINT
 3280 PRINT" Serveren met gesnipperd ijs."
 3290 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 3300 IF(IN$="M") OR(IN$="m") THEN 1200
 3310 IF(IN$="T") OR(IN$="t") THEN 2100
 3320 REM GIN-VERMOUTH
 3370 PRINT"         GIN-VERMOUTH         VEL 6":PRINT
 3380 PRINT" THE ROSE":PRINT
 3390 PRINT" 4 Delen Gin"
 3400 PRINT" 1 Deel Vermouth"
 3410 PRINT" 1 Deel Cherry-Brandy":PRINT
 3420 PRINT" Serveren met gesnipperd ijs.":PRINT
 3430 PRINT" POLO":PRINT
 3440 PRINT" 1 Deel Gin"
 3450 PRINT" 1 Deel rode Vermouth"
 3460 PRINT" 1 Deel droge Vermouth"
 3470 PRINT" 1 Deel Citroensap":PRINT
 3480 PRINT" Serveren met gesnipperd ijs."
 3490 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 3500 IF(IN$="M") OR(IN$="m") THEN 1200
 3510 IF(IN$="T") OR(IN$="t") THEN 3100
 3520 REM GIN-VERMOUTH-2
 3550 PRINT"         GIN-VERMOUTH         VEL 7":PRINT
 3560 PRINT" ORANGE BLOOM":PRINT
 3570 PRINT" 2 Delen Gin"
 3580 PRINT" 1 Deel rode Vermouth"
 3890 PRINT" 1 Deel Cointreau":PRINT
 3900 PRINT" Shake'n met 3-4 ijsblokjes"
 3910 PRINT" Serveren in cocktailglas.":PRINT
 3920 PRINT" COOPERS TOWN":PRINT
 3930 PRINT" 1/3 Deel Gin"
 3940 PRINT" 1/3 Deel rode Vermouth"
 3960 PRINT" 1/3 Deel droge Vermouth":PRINT
 3970 PRINT" Schudden met verse"
 3980 PRINT" mintblaadjes."
 3990 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 4000 IF(IN$="M") OR(IN$="m") THEN 1200
 4010 IF(IN$="T") OR(IN$="t") THEN 3320
 4050 REM GIN-LIME-JUICE
 4070 PRINT"         GIN-LIME-JUICE       VEL 8":PRINT
 4080 PRINT" BLUE LADY":PRINT
 4090 PRINT" 7-8 Delen Gin"
 4100 PRINT" 2 Delen Blue Curacao"
 4110 PRINT" 1 Deel vers geperst Lime-Juice"
 4120 PRINT" 1 Eiwit per 2 glazen":PRINT
 4130 PRINT" Shake'n met ijs tot het romig is"
 4140 PRINT" geworden.":PRINT
 4150 PRINT" GIMLET":PRINT
 4160 PRINT" 3 Delen Gin"
 4170 PRINT" 1 Deel Lime-Juice"
 4180 PRINT
 4190 PRINT" Met ijs roeren."
 4220 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 4230 IF(IN$="M") OR(IN$="m") THEN 1200
 4240 IF(IN$="T") OR(IN$="t") THEN 3520
 4250 REM GIN-CURACAO
 4270 PRINT"         GIN-CURACAO          VEL 9":PRINT
 4280 PRINT" HAWAIIAN":PRINT
 4290 PRINT" 2 Delen Gin"
 4300 PRINT" 1 Deel Curacao":PRINT
 4310 PRINT" 1 Deel Sinaasappelsap":PRINT
 4320 PRINT" Doe 3 ijsblokjes in de shaker. Voeg"
 4330 PRINT" de ingredienten toe en schud flink.":PRINT
 4350 PRINT" LADY CHATTERLY":PRINT
 4360 PRINT" 3 Delen Gin"
 4370 PRINT" 1 Deel Curacao"
 4380 PRINT" 1 Deel droge Vermouth"
 4390 PRINT" 1 Deel Sinaasappelsap":PRINT
 4400 PRINT" Shake'n met 3 ijsblokjes."
 4410 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 4420 IF(IN$="M") OR(IN$="m") THEN 1200
 4430 IF(IN$="T") OR(IN$="t") THEN 4070
 4450 REM GIN-COINTREAU
 4470 PRINT"         GIN-COINTREAU        VEL 10":PRINT
 4480 PRINT" OPAL":PRINT
 4490 PRINT" 3 Delen Gin"
 4500 PRINT" 1 Deel Cointreau"
 4510 PRINT" 2 Delen Sinaasappelsap":PRINT
 4520 PRINT" Met 2 ijsblokjes schudden"
 4530 PRINT" in een shaker."
 4540 PRINT" Serveren in een cocktailglas.":PRINT
 4560 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 4570 IF(IN$="M") OR(IN$="m") THEN 1200
 4580 IF(IN$="T") OR(IN$="t") THEN 4270
 4600 REM GIN-GRENADINE
 4620 PRINT"         GIN-GRENADINE        VEL 11":PRINT
 4630 PRINT" CLOVER CLUB":PRINT
 4640 PRINT" 4 Delen Gin"
 4650 PRINT" 2 Delen Grenadine"
 4660 PRINT" 1 Eiwit"
 4670 PRINT" Sap van 1/2 Citroen"
 4680 PRINT
 4690 PRINT" Serveren voor het eten als"
 4700 PRINT" een soort alcoholische soep."
 4710 PRINT" Schudden in de shaker met"
 4720 PRINT" 3 ijsblokjes."
 4730 PRINT" Serveren in ballonglas."
 4750 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 4760 IF(IN$="M") OR(IN$="m") THEN 1200
 4770 IF(IN$="T") OR(IN$="t") THEN 4470
 4800 REM GIN-CITROEN
 4820 PRINT"         GIN-CITROEN          VEL 12":PRINT
 4830 PRINT" GIN FIX":PRINT
 4840 PRINT" Leg 3 ijsblokjes in de shaker."
 4850 PRINT" Doe het sap van 1/2 citroen en"
 4860 PRINT" 1 theel. suiker, wat water en"
 4870 PRINT" 5 cl. Gin erbij."
 4880 PRINT" Flink schudden. Zeven boven een"
 4890 PRINT" bowlglas dat U eerst halfvol"
 4900 PRINT" ijsgruis hebt gedaan. Omroeren"
 4910 PRINT" en garneren met vruchten,"
 4920 PRINT" bijvoorbeeld aardbeien,"
 4930 PRINT" ('s winters kunt U diepvries"
 4940 PRINT" vruchten gebruiken.)"
 4960 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 4970 IF(IN$="M") OR(IN$="m") THEN 1200
 4980 IF(IN$="T") OR(IN$="t") THEN 4600
 5000 REM GIN-SUIKERSTROOP
 5020 PRINT"         GIN-SUIKERSTROOP     VEL 13":PRINT
 5030 PRINT" CHAMPAGNE FIZZ":PRINT
 5040 PRINT" 3 Delen Gin"
 5050 PRINT" 2 Delen Citroensap"
 5060 PRINT" 1 Deel Suikerstroop":PRINT
 5070 PRINT" Serveren in een glas voor rode wijn"
 5080 PRINT" en aanvullen met Champagne of Sekt.":PRINT
 5090 PRINT" FRENCE 75":PRINT
 5100 PRINT" 4 Delen Gin"
 5110 PRINT" 2 Delen Citroensap"
 5120 PRINT" 1 Deel Suikerstroop":PRINT
 5130 PRINT" Vul het op met gekoelde droge"
 5140 PRINT" Mousserende witte wijn."
 5150 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 5160 IF(IN$="M") OR(IN$="m") THEN 1200
 5170 IF(IN$="T") OR(IN$="t") THEN 4800
 5200 REM GIN-CREME DE MENTHE
 5220 PRINT"         GIN-CREME DE MENTHE  VEL 14":PRINT
 5230 PRINT" ALEXANDERS SISTERS":PRINT
 5240 PRINT" 1 Deel Dry Gin"
 5250 PRINT" 1 Deel Creme de Menthe groen"
 5260 PRINT" 1 Deel Room":PRINT
 5270 PRINT" Serveer in een Champagnecoupe"
 5350 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 5360 IF(IN$="M") OR(IN$="m") THEN 1200
 5370 IF(IN$="T") OR(IN$="t") THEN 5000
 5400 REM BIER
 5420 PRINT"         BIER COCKTAILS        VEL 15":PRINT
 5430 PRINT" BLACK VELVET":PRINT
 5440 PRINT" Een hoog glas van tevoren goed koken."
 5450 PRINT" Neem een fles ijskoude Sekt in"
 5460 PRINT" de rechter en een ijskoude"
 5470 PRINT" Stout Bier in de linkerhand."
 5480 PRINT" Schenk ze tegelijkertijd langzaam"
 5490 PRINT" in het glas.":PRINT
 5500 PRINT" Niet roeren."
 5550 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 5560 IF(IN$="M") OR(IN$="m") THEN 1200
 5570 IF(IN$="T") OR(IN$="t") THEN 5200
 5600 REM BIER-2
 5620 PRINT"         TARWE BIER           VEL 16":PRINT
 5630 PRINT" RAFRAICHISSEMENT":PRINT
 5640 PRINT" Schenk op 5 delen Tarwebier"
 5650 PRINT" 2 delen Sekt.":PRINT
 5660 PRINT" Pas op, het schuimt ontzettend!":PRINT
 5670 PRINT" RUSZ":PRINT
 5680 PRINT" Vermeng gelijke delen Tarwebier"
 5690 PRINT" met ijskoude Citroenlimonade."
 5750 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 5760 IF(IN$="M") OR(IN$="m") THEN 1200
 5770 IF(IN$="T") OR(IN$="t") THEN 5400
 5800 REM SANGRIA
 5820 PRINT"         SANGRIA              VEL 17":PRINT
 5830 PRINT" SANGRIA PINK":PRINT
 5840 PRINT" 1 L.Sangria"
 5850 PRINT" 1/2 borrelglaasje Cointreau"
 5860 PRINT" 2 rijpe Perziken"
 5870 PRINT" 1 Sinaasappel (vruchtvlees)"
 5880 PRINT" 6 schijfjes Citroen en Sodawater":PRINT
 5890 PRINT" Doe de gepelde en in stukjes"
 5900 PRINT" gesneden sinaas- en perzikstukjes"
 5910 PRINT" in de Sangria. Ongeveer 2 uur laten"
 5920 PRINT" intrekken. Maak de Bowl wat"
 5930 PRINT" pittiger met Cointreau. Serveer"
 5940 PRINT" met een schijfje Citroen."
 5950 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 5960 IF(IN$="M") OR(IN$="m") THEN 1200
 5970 IF(IN$="T") OR(IN$="t") THEN 5600
 6000 REM PUNCH
 6020 PRINT"         PUNCH                VEL 18":PRINT
 6030 PRINT" ZEELEEUW":PRINT
 6040 PRINT" Verhit per persoon 1/8 L. witte Wijn"
 6050 PRINT" Niet laten koken. Roer er wat suiker"
 6060 PRINT" door en een dubbele Rum. Laat er een"
 6070 PRINT" schijfje Citroen in zwemmen.":PRINT
 6080 PRINT" WATER-PUNCH":PRINT
 6090 PRINT" Vul met gelijke delen Port, Rum"
 6100 PRINT" en rode Bordeaux een wijd glas."
 6110 PRINT" Laat het met een beetje suiker"
 6120 PRINT" heet worden."
 6130 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 6140 IF(IN$="M") OR(IN$="m") THEN 1200
 6150 IF(IN$="T") OR(IN$="t") THEN 5800
 6200 REM WODKA
 6210 PRINT"         WODKA                VEL 19":PRINT
 6220 PRINT" BLOODY MARY":PRINT
 6230 PRINT" Schud 3 cl. wodka met 5 cl. tomaten-"
 6240 PRINT" sap, een snufje zout, 3 druppels"
 6250 PRINT" Tabasco en 6 druppels Worcestershire-"
 6260 PRINT" sauce, het sap van 1/2 grote"
 6270 PRINT" citroen en 3 ijsblokjes ongeveer"
 6280 PRINT" 15 sec. in de shaker. Schenk het"
 6290 PRINT" door de strainer in een Collinsglas.":PRINT
 6300 PRINT" Doe geen ijs in het glas,"
 6310 PRINT" strooi er geen peper over en doe"
 6320 PRINT" er geen andere ingredienten bij."
 6350 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 6360 IF(IN$="M") OR(IN$="m") THEN 1200
 6370 IF(IN$="T") OR(IN$="t") THEN 6000
 6400 REM WODKA-2
 6410 PRINT"         WODKA-2              VEL 20":PRINT
 6420 PRINT" MOSCOW MULE":PRINT
 6430 PRINT" Doe 3 ijsblokjes in een bierpul."
 6440 PRINT" Schenk er 1 theel. citroensap bij"
 6450 PRINT" en 8 cl. ijskoude wodka."
 6460 PRINT" Vul het aan met ginger ale en"
 6470 PRINT" garneer met een schijfje citroen."
 6480 PRINT" Als U teveel drinkt van deze"
 6490 PRINT" Russische muilezel, dan kunt U"
 6500 PRINT" plotseling de man met de hamer"
 6510 PRINT" ontmoeten.":PRINT
 6520 PRINT" Dus opgepast.":PRINT
 6530 PRINT" Want dat is niet de"
 6540 PRINT" bedoeling van een longdrink."
 6590 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 6600 IF(IN$="M") OR(IN$="m") THEN 1200
 6610 IF(IN$="T") OR(IN$="t") THEN 6200
 6650 REM WODKA-3
 6670 PRINT"         WODKA-3              VEL 21":PRINT
 6680 PRINT" WODKA COOLER":PRINT
 6690 PRINT" Doe een 1/2 theelepel poedersuiker"
 6700 PRINT" in een Collinsglas, schenk er"
 6710 PRINT" 6 cl. soda bij en roer beide om"
 6720 PRINT" (Voorzichtig, het schuimt.)"
 6730 PRINT" Doe ijsgruis in het glas"
 6740 PRINT" (voor 2/3 vullen) en giet er 6 cl."
 6750 PRINT" Wodka bij. Vul het mengsel aan met"
 6760 PRINT" ginger ale. Hang spiraaltjes citroen-"
 6770 PRINT" schil aan de rand van het glas."
 6780 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 6790 IF(IN$="M") OR(IN$="m") THEN 1200
 6800 IF(IN$="T") OR(IN$="t") THEN 6400
 6850 REM MELKCOCKTAILS
 6870 PRINT"         MELKCOCKTAIL          VEL 22":PRINT
 6880 PRINT" VRUCHTEN MELK":PRINT
 6890 PRINT" 2/3 Deel Melk"
 6900 PRINT" 1/3 Deel Vruchtensap":PRINT
 6910 PRINT" Goed roeren en direkt serveren.":PRINT
 6920 PRINT" IJSMELK":PRINT
 6930 PRINT" 1 L. Melk"
 6940 PRINT" 125 gr. Suiker"
 6950 PRINT" Stukje Citroenschil en wat kaneel":PRINT
 6960 PRINT" Breng de melk aan de kook."
 6970 PRINT" Roer de suiker erdoor en doe de"
 6980 PRINT" Citroenschil er in. Af laten"
 6990 PRINT" koelen en schenk het in een glas."
 7020 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 7030 IF(IN$="M") OR(IN$="m") THEN 1200
 7040 IF(IN$="T") OR(IN$="t") THEN 6650
 7050 REM GRAPE GINGER
 7070 PRINT"         GRAPE GINGER         VEL 23":PRINT
 7080 PRINT" Vermeng 4 flessen Ginger ale met"
 7090 PRINT" 1/2 liter druivensap en het sap"
 7100 PRINT" van 1 Citroen en 2 Sinaasappelen.":PRINT
 7110 PRINT" Schenk het mengsel in glazen die"
 7120 PRINT" U garneert met vliesdunne schijfjes"
 7130 PRINT" Sinaasappel en voeg naar smaak suiker"
 7140 PRINT" toe. Gebruik voor drinks altijd"
 7150 PRINT" suikerstroop om de drankjes zoet"
 7160 PRINT" te maken (U laat 1 kopje suiker"
 7170 PRINT" oplossen in 1/2 kopje water)."
 7180 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 7190 IF(IN$="M") OR(IN$="m") THEN 1200
 7200 IF(IN$="T") OR(IN$="t") THEN 6850
 7300 REM KOKOS
 7310 PRINT"         KOKOS                VEL 24":PRINT
 7320 PRINT" KOKOS SHAKE":PRINT
 7330 PRINT" Meng 2 delen melk met 2 delen roomijs"
 7340 PRINT" en 1 deel witte Rum, en 1 deel ge-"
 7350 PRINT" raspte kokos erdoor. Flink shake'n.":PRINT
 7370 PRINT" COCO PINK LOPEZ":PRINT
 7380 PRINT" 1/3 blik Cream of coconut"
 7390 PRINT" 1 bakje ijsblokjes"
 7400 PRINT" 1/3 blik sinaasappelsap"
 7410 PRINT" 1 theelepel Creme de Cassis":PRINT
 7420 PRINT" Goed schudden in een mixbeker."
 7430 PRINT" Doe 2 ijsblokjes in een groot"
 7440 PRINT" glas en schenk het mengsel erop. De"
 7450 PRINT" inhoudsmaat van het blikje is 35 cl."
 7470 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 7480 IF(IN$="M") OR(IN$="m") THEN 1200
 7490 IF(IN$="T") OR(IN$="t") THEN 7050
 7500 REM KLEURTJES
 7510 PRINT"         KLEURTJES            VEL 25":PRINT
 7520 PRINT" HELDER BLAUW":PRINT
 7530 PRINT" Meng in een longdrinkglas:"
 7540 PRINT" 1 Deel Malibu"
 7550 PRINT" 1 Deel Curacao"
 7560 PRINT" 3 Delen Tonic"
 7570 PRINT" Opvullen met ijsblokjes.":PRINT
 7580 PRINT" HELDER GROEN":PRINT
 7590 PRINT" 3 bolletjes meloen"
 7600 PRINT" 1 eetlepel Creme de Menthe"
 7610 PRINT" 1 schepje suiker"
 7620 PRINT" Leg de bolletjes in een ruime coupe."
 7630 PRINT" Daaroverheen per glas 1 schepje"
 7640 PRINT" suiker,1 eetlepel Creme de Menthe"
 7650 PRINT" en opvullen met mousserende wijn."
 7670 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 7680 IF(IN$="M") OR(IN$="m") THEN 1200
 7690 IF(IN$="T") OR(IN$="t") THEN 7300
 7700 REM RUM
 7720 PRINT"         RUM                  VEL 26":PRINT
 7730 PRINT" CUBA LIBRE":PRINT
 7740 PRINT" Doe 3 ijsblokjes in een groot glas,"
 7750 PRINT" daarbij het sap van 1/2 citroen"
 7760 PRINT" en 4 cl. witte Rum."
 7770 PRINT" Met Cola bijvullen.":PRINT
 7780 PRINT" CONQUISTADORES":PRINT
 7790 PRINT" Doe 2 ijsblokjes in een hoog glas,"
 7800 PRINT" schenk daarover 5 cl. witte Rum"
 7810 PRINT" en 3 cl. sinaasappelsap en voeg"
 7820 PRINT" 1 cocktailkers toe."
 7830 PRINT" Omroeren en met bitter lemon"
 7840 PRINT" bijvullen."
 7870 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 7880 IF(IN$="M") OR(IN$="m") THEN 1200
 7890 IF(IN$="T") OR(IN$="t") THEN 7500
 7900 REM RUM-2
 7920 PRINT"         RUM-2                VEL 27":PRINT
 7930 PRINT" SCREWDRIVER JAMAICA":PRINT
 7940 PRINT" Doe 2 ijsblokjes in een hoog glas"
 7950 PRINT" en daarop 4 cl. Bruine Rum van 54%."
 7960 PRINT" Goed omroeren en met sinaasappel-"
 7970 PRINT" sap aanvullen.":PRINT
 7980 PRINT" RUM TWISTER":PRINT
 7990 PRINT" Doe in eem shake'r het sap van"
 8000 PRINT" een citroen, 5 cl. witte Rum"
 8010 PRINT" en 1 cl. Cointreau. Schudden"
 8020 PRINT" met fijngehakt ijs. Schenk het"
 8030 PRINT" mengsel door de strainer in een"
 8040 PRINT" glas, doe er royaal fijngehakt"
 8050 PRINT" ijs in en vul het op met sodawater."
 8060 PRINT" Met een Citroenschijfje garneren."
 8100 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 8110 IF(IN$="M") OR(IN$="m") THEN 1200
 8120 IF(IN$="T") OR(IN$="t") THEN 7700
 8150 REM RUM-3
 8170 PRINT"         RUM-3                VEL 28":PRINT
 8180 PRINT" TIKI JOE":PRINT
 8190 PRINT" 2 cl. Witte Rum."
 8200 PRINT" 2 cl. Campari."
 8210 PRINT" Samen roeren en schenk het mengsel"
 8220 PRINT" in een glas op veel ijs en vul"
 8230 PRINT" het aan met sinaasappelsap.":PRINT
 8240 PRINT" TROPICAL":PRINT
 8250 PRINT" Doe in een glas 2 ijsblokjes"
 8260 PRINT" en een paar stukjes ananas."
 8270 PRINT" Schenk er 3 cl. Jamaica Rum bij."
 8280 PRINT" Goed omroeren en met Sangria"
 8290 PRINT" aanvullen."
 8350 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 8360 IF(IN$="M") OR(IN$="m") THEN 1200
 8370 IF(IN$="T") OR(IN$="t") THEN 7900
 8400 REM BOWL
 8420 PRINT"         BOWL                 VEL 29":PRINT
 8430 PRINT" ANANAS BOWL":PRINT
 8440 PRINT" Leg kwartplakken Ananas in een"
 8450 PRINT" gekoeld glas en schenk er een"
 8460 PRINT" lekkere, droge, mousserende wijn"
 8470 PRINT" over. U kunt dit mengsel direct"
 8480 PRINT" drinken.":PRINT
 8490 PRINT" AARDBEIEN BOWL":PRINT
 8500 PRINT" Gebruik op vier flessen lichte"
 8510 PRINT" Moezel of Rijnwijn. 500 gr. onge-"
 8520 PRINT" wassen aardbeien zonder suiker."
 8530 PRINT" Laat ze een kwartier trekken en"
 8540 PRINT" geef ze in grote bekers niet kouder"
 8550 PRINT" dan op kamer temperatuur. U kunt"
 8560 PRINT" er eventueel nog Sekt bijschenken."
 8600 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 8610 IF(IN$="M") OR(IN$="m") THEN 1200
 8620 IF(IN$="T") OR(IN$="t") THEN 8150
 8650 REM ALKOHOLVRIJ
 8670 PRINT"         ALKOHOL VRIJ         VEL 30":PRINT
 8680 PRINT" APPELPUNCH":PRINT
 8690 PRINT" Breng 1/2 liter water aan de kook"
 8700 PRINT" met 75 gr. suiker en 3 stukjes"
 8710 PRINT" pijpkaneel van 5 cm. lengte."
 8720 PRINT" En laat het water 5 min. koken."
 8730 PRINT" Neem de pan van het vuur en doe er"
 8740 PRINT" 1/2 L. appelsap,1/8 L. sinaasappelsap,"
 8750 PRINT" het sap van 1 citroen en 1/8 L. water"
 8760 PRINT" bij. Maak de punch warm, maar"
 8770 PRINT" niet heet.Serveer hem met een"
 8780 PRINT" schijfje citroen."
 8790 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 8800 IF(IN$="M") OR(IN$="m") THEN 1200
 8810 IF(IN$="T") OR(IN$="t") THEN 8400
 8820 REM GEREEDSCHAP
 8830 PRINT"         GEREEDSCHAP          VEL 31":PRINT
 8840 PRINT" De vier belangrijkste apparaten"
 8850 PRINT" die U moet hebben zijn:":PRINT
 8860 PRINT" Een Mixglas,":PRINT
 8870 PRINT" Een Roerlepel,":PRINT
 8880 PRINT" Een Barzeef (Strainer),":PRINT
 8890 PRINT" En een Meetglas,":PRINT
 9000 PRINT" waarin U de ingredienten"
 9010 PRINT" voor de drankjes afmeet."
 9070 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 9080 IF(IN$="M") OR(IN$="m") THEN 1200
 9090 IF(IN$="T") OR(IN$="t") THEN 8650
 9100 REM BARTAAL
 9110 PRINT"         BARTAAL              VEL 32":PRINT
 9120 PRINT" COBBLER: longdrink met veel fijn-"
 9130 PRINT" gehakt ijs,waarover men de alkohol"
 9140 PRINT" naar keuze schenkt (garneren met"
 9150 PRINT" een vrucht).":PRINT
 9160 PRINT" COCKTAIL: een kort drankje, dat"
 9170 PRINT" gemixt of geshaked wordt.":PRINT
 9180 PRINT" COOLER: fizz met ginger ale aangevuld.":PRINT
 9190 PRINT" DAISY: fizz met grenadine plus"
 9200 PRINT" kersen op sap. Met soda erbij is"
 9210 PRINT" het een dames drankje.":PRINT
 9220 PRINT" FIZZ: longdrink waarvoor citroensap"
 9230 PRINT" en wat poedersuiker heel lang"
 9240 PRINT" geshaked worden met Gin.":PRINT
 9250 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 9255 IF(IN$="M") OR(IN$="m") THEN 1200
 9257 IF(IN$="T") OR(IN$="t") THEN 8820
 9259 REM BARTAAL
 9260 PRINT"         BARTAAL-2            VEL 33":PRINT
 9270 PRINT:PRINT" FLIP: short longdrink. Het is"
 9280 PRINT" een cocktail met een eierdooier."
 9290 PRINT" Hij wordt altijd geshaked.":PRINT
 9300 PRINT" JULEP: vul een glas met fijnge-"
 9310 PRINT" schaafd ijs, schenk er een sterke"
 9320 PRINT" drank over en roer tot het glas"
 9330 PRINT" beslaat. Garneer dan met mint en"
 9340 PRINT" vruchten. U kunt het ook serveren"
 9350 PRINT" in een zilveren beker.":PRINT
 9360 PRINT" SOUR: hetzelfde als een fizz."
 9370 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 9380 IF(IN$="M") OR(IN$="m") THEN 1200
 9390 IF(IN$="T") OR(IN$="t") THEN 9100
 9400 REM TEMPERATUUR
 9410 PRINT"         TEMPERATUUR          VEL 34":PRINT
 9420 PRINT" Rode wijnen nooit koel serveren.":PRINT
 9430 PRINT" Witte wijnen altijd koel serveren.":PRINT
 9440 PRINT" Bier              5 graden"
 9450 PRINT" Witte Bordeaux   10 graden"
 9460 PRINT" Rijn-Moezel      10 graden"
 9470 PRINT" Champagne        10 graden"
 9480 PRINT" Witte Bourgogne  10 graden"
 9490 PRINT" Rose-wijnen      10 graden"
 9500 PRINT" Vermouth-wit     12 graden"
 9510 PRINT" Sherry           14 graden"
 9520 PRINT" Rode Bourgogne   16 graden"
 9530 PRINT" Rode Bordeaux    18 graden"
 9540 PRINT" Port             18 graden"
 9550 VE=20:HO=1:GOSUB 110:PRINT D$:GOSUB 210:GOSUB 100
 9560 IF(IN$="M") OR(IN$="m") THEN 1200
 9570 IF(IN$="T") OR(IN$="t") THEN 9260
 9600 REM TIJDEN
 9610 PRINT"         SCHENKTIJDEN         VEL 35":PRINT
 9620 PRINT" 's Morgens kunt U een flip drinken,"
 9630 PRINT" vanaf elf uur een pick me up."
 9640 PRINT" Voor het eten een aperitief of"
 9650 PRINT" een Martini."
 9660 PRINT" Na het eten een zoete Cocktail"
 9670 PRINT" of een Cognac."
 9680 PRINT" Als het theetijd is een cobbler"
 9690 PRINT" of een koude Punch."
 9700 PRINT" Tegen een uur of zes een Fix."
 9710 PRINT" Bij de avondmaaltijd beginnen"
 9720 PRINT" met een Martini, na het eten"
 9730 PRINT" een Sours."
 9740 PRINT" Bij het dansen een Fizz,"
 9750 PRINT" of Higball."
 9770 VE=20:HO=1:GOSUB 110:PRINT B$:GOSUB 210:GOSUB 100
 9780 IF(IN$="M") OR(IN$="m") THEN 1200
 9790 IF(IN$="T") OR(IN$="t") THEN 9400
 9800 VE=10:HO=12:GOSUB 110:PRINT"Met dank aan"
 9810 VE=12:HO=12:GOSUB 110:PRINT"FREEK en ROB"
 9820 VE=14:HO=12:GOSUB 110:PRINT"voor het lenen"
 9830 VE=16:HO=12:GOSUB 110:PRINT"van hun recepten"
 9840 END
30000 REM**************************
30010 REM* COCKTAILS              *
30020 REM* J.W.V.D.HEIDEN         *
30030 REM* RODEZAND 13            *
30040 REM* 3421 BA OUDEWATER      *
30050 REM* COMMODORE-64           *
30060 REM* SEPTEMBER-1989         *
30070 REM* COPYRIGHT NOS HILVERSUM*
30080 REM**************************
