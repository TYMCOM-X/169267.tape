	OPEN (UNIT=20,FILE='REQUES.DIR',MODE='IMAGE')
	N=0
10	READ(20,END=999)M
	WRITE(22,20)N,M
	N= N+1
	GO TO 10
20	FORMAT(T2,I5,2X,O12)
999	CLOSE(UNIT=20)
	STOP
	END
   