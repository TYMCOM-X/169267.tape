        INTEGER BLOCK(128)
        OPEN (UNIT=7,DEVICE= 'DSK',FILE='(SYS)DUL.SYS',ACCESS='SEQIN',
     *        RECORD SIZE= 128)
10      READ (7)BLOCK
        I = 1
20      IF (I.GT.126) GO TO 100
        IF (BLOCK(I).LT.0) GO TO 100
        TYPE 30,BLOCK(I),BLOCK(I+1),BLOCK(I+2)
30      FORMAT(3O15)
        GO TO 20
100     GO TO 10
300     CONTINUE
        CLOSE (UNIT= 7)
        STOP
        END
  