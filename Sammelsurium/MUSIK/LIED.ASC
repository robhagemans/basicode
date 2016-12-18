1000 A=100:GOTO 20:REM ### LIED ###
1010 RESTORE:SR$="Alle meine Entchen":VE=0
1020 HO=INT((HO-LEN(SR$)-6)/2):GOSUB 110:GOSUB 150:PRINT
1030 FOR I=1 TO 27
1040 SV=0:SD=2:GOSUB 400
1050 SV=15:READ A$,SP,SD
1060 IF SD<0 THEN SD=-SD:PRINT
1070 GOSUB 400:PRINT A$;:SD=1:SV=0:GOSUB 400
1080 NEXT I
1090 GOSUB 210:GOTO 950
25000 REM---- Data-Zeilen ------
25010 DATA "Al",67,3,"le",69,3," mei",71,3,"ne",72,3
25020 DATA " Ent",74,6,"chen",74,6,"schwim",76,-3
25030 DATA "men",76,3," auf",76,3," dem",76,3," See",74,9
25040 DATA "schwim",76,-3,"men",76,3
25050 DATA " auf",76,3," dem",76,3," See",74,9
25060 DATA "Koepf",72,-3,"chen",72,3," in",72,3," das",72,3
25070 DATA " Was",71,6,"ser",71,6,"Schwaenz",74,-3
25080 DATA "chen",74,3," in",74,3," die",74,3," Hoeh",67,10
30000 REM ---- Programm-Ende-----
30010 REM Ein Kinderlied wird gespielt
32000 REM -----------------------
32010 REM H. Voelz; 11.5.89; 24.8.89 fuer Rundfunk
32020 REM XT-compatibler Rechner
