	SUBROUTINE CHKARM(PLAY,START,STOP,INDEX,ARMS)
	IMPLICIT INTEGER(A-Z)
	DOUBLE PRECISION CONTIN(6)
	DIMENSION NATION(42),TERR(6,42),AMOUNT(6),WORLD(6)
	COMMON /NATION/NATION/AMOUNT/AMOUNT/CONTIN/CONTIN/TERR/TERR
	DATA WORLD/5,2,5,3,2,7/

	DO 20  F=START , STOP
	DO 10  Y=1 , AMOUNT(PLAY)
	IF (NATION(F).EQ.TERR(PLAY,Y)) GO TO  20
10	CONTINUE
	RETURN
20	CONTINUE
	TYPE 30,CONTIN(INDEX)
30	FORMAT(1X,'YOU OWN ALL OF ',A10)
	ARMS=ARMS+WORLD(INDEX)
	RETURN
	END
