        INTEGER A(20,15)
        OPEN (UNIT=20,FILE='LUNAR.DAT')
        DO 100I= 1,20
        READ(20,10)(A(I,J),J= 1,14)
10      FORMAT(14I4)
100     CONTINUE
        DO 200I= 1,20
        A(I,15)= 0
        DO 200J= 2,14
200     A(I,15)= A(I,15) + A(I,J)
        DO 300I= 1,20
        TYPE 20,(A(I,J),J= 1,15)
20      FORMAT(X,15I4)
300     CONTINUE
        STOP
        END
 