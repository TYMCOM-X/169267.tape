        IMPLICIT INTEGER (A-Z)
        DOUBLE PRECISION SUUN
10      READ(20,100,END=90)SUUN
        CALL CVTSTR(SUUN,UUN)
        TYPE 200,SUUN,UUN
        GO TO 10
90      CLOSE (UNIT=20)
        STOP
100     FORMAT(A6)
200     FORMAT(T5,A6,'*   *',O8)
        END
  