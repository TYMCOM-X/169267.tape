      OPEN(UNIT=20,FILE='REQUES.DIR',MODE='IMAGE')
      N= 0
      WRITE(20)N
      N= "200000562525
      DO 10I= 1,1000
      WRITE(20)N
10    CONTINUE
      N= 0
      DO 20I= 1001,8191
      WRITE(20)N
20    CONTINUE
      STOP
      END
    