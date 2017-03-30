1000 A=100:GOTO 20:REM ### FORMAT ###
1010 SR$="Formatieren":HO=INT((HO-LEN(SR$)-6)/2)
1020 VE=0:GOSUB 110:GOSUB 150:PRINT
1030 SR$="123456789123":INPUT"Zeichenzahl =";CT
1040 SR=VAL(SR$):INPUT"Nachkommastellen =";CN
1050 PRINT:PRINT"SR$";TAB(CT+5);"SR"
1060 FOR I=1 TO 14
1070 GOSUB 310:PRINT SR$;" : ";SR:SR=SR/9
1080 NEXT I
1090 INPUT"0=Ende; 1=weiter";B
1100 IF B=1 THEN 1030
1110 GOTO 950
1120 REM ----Programm-Ende------
30000 REM Zeigt die Moeglichkeiten der Zahlen-
30010 REM darstellung. Der String ist bewusst
30020 REM so gross gewaehlt, dass auch die
30030 REM die Genauigkeit der Arithmetik und
30040 REM die Rundung getestet werden kann.
32000 REM -----------------------
32010 REM H. Voelz; 10.5.89; 24.8.89 fuer Rundfunk
32020 REM XT-compatibler Rechner
