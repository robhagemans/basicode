1 REM BASICODE 2 standaard inplementatie 21/4/83
2 REM                      door Henk Wevers
3 REM  Voor aanpassing aan computer/terminal
4 REM  zie basicode.doc file op deze diskette
5 REM initialisatie
6 REM Deze versie voor MBASIC 5.21 en hoger ! (met INKEY$)
7 PRINT CHR$(27);"*";CHR$(0);CHR$(0);CHR$(0);CHR$(26);:WIDTH(255)
10 GOTO 1000
19 REM regels 20-100 clear a, niet nodig voor mbasic
20 GOTO 1010
99 REM  regel 100-110 clear screen
100 PRINT CHR$(27);"*";CHR$(0);CHR$(0);CHR$(0);CHR$(26);:RETURN
109 REM regel 110 - 120 set cursor op HO en VE
110 REM TERMINAL = 24 X 80 !
111 IF HO>79 THEN HO=79
112 IF VE>23 THEN VE=23
113 PRINT CHR$(27);"=";CHR$(VE+32);CHR$(HO+32);
115 RETURN
119 REM regel 120-130 haal cursorpositie in HO en VE
120 IF HO > 79 THEN HO=80
121 IF VE > 23 THEN VE=23
122 REM  voor terminal 24 x 80
124 RETURN
200 IN$=INKEY$:RETURN
210 GOSUB 200:IF IN$="" THEN 210
211 RETURN
250 PRINT CHR$(7);:RETURN
260 RV=RND(1):RETURN
270 FR=FRE(2):RETURN
300 SR$=STR$(SR)
301 O7=LEN(SR$):IF O7=0 THEN RETURN
302 IF RIGHT$(SR$,1)<>" " THEN 304
303 SR$=LEFT$(SR$,O7-1):GOTO 301
304 IF LEFT$(SR$,1)<>" " THEN RETURN
305 SR$=RIGHT$(SR$,O7-1):GOTO 301
310 O4=SR:IF CN<>0 THEN 316
312 SR=INT(SR+.5):GOSUB 300:GOTO 330
316 O5=SGN(SR):SR=ABS(SR):O8=INT(SR):O9=SR-O8
318 FOR O6=1 TO CN:O9=O9*10:NEXT O6
320 O9=INT(O9+.5):SR=O9:GOSUB 300
322 O9$=RIGHT$("00000000000000000000"+SR$,CN)
324 IF O8=0 AND O9=0 THEN O5=1
326 SR=O8:GOSUB 300:IF O5=-1 THEN SR$="-"+SR$
328 SR$=SR$+"."+O9$
330 IF LEN(SR$)<=CT THEN 334
332 SR$=LEFT$("********************",CT):GOTO 340
334 SR$=RIGHT$("                    "+SR$,CT)
340 SR=O4:RETURN
350 LPRINT SR$;:RETURN
360 LPRINT:RETURN
