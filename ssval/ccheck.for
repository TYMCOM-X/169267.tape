C
C LUD/ACTG/CUD consistency check program - Version 1.1
C Date: 6/9/86       - Khanh nguyen
C
      PROGRAM CCHECK
      IMPLICIT INTEGER (A-Z)
      DOUBLE PRECISION FILRPT,LUDF,ACTF,LUDSF,ACTSF,DIFFL,TODAY,TOUTFL
      INTEGER UNAME(3),LUDKEY(4),ACTKEY(4),SYSTBL(100,3),SYSDWN(100,2)
      COMMON /TOUTBL/TOUT,TOUTFL/ACTBLK/ACPORT,ACTF/LUDBLK/LUDF/
     * RPTBLK/FILRPT,SYSNO,ASYST
      DATA LUDKEY,ACTKEY/'/KUXA1.12/R24',0,'/KUXA1.12/R30',0/
C
C Create TOUT filename and input system numbers
C
      TOUT= 5
      CALL GJOBNO(JOBNO)
      CALL GDATE(FILRPT)
      ENCODE(10,100,TOUTFL) FILRPT,JOBNO
100   FORMAT(A6,'.',A3)
      TYPE 110
110   FORMAT(/X,'LUD/ACTG/CUD CONSISTENCY CHECK - Ver 1.1')
      NSYS= 0
120   TYPE 130
130   FORMAT(/X,'System no.: ',$)
      ACCEPT *,SYSNO
      IF (SYSNO.LE.0) GO TO 160
      ASYST= FNDAST(SYSNO)
      IF (ASYST.NE.0) GO TO 150
      TYPE 140,SYSNO
140   FORMAT(X,'Illegal system number: ',I3)
      GO TO 120
150   NSYS= NSYS+1
      SYSTBL(NSYS,1)= SYSNO
      SYSTBL(NSYS,2)= ASYST
      SYSTBL(NSYS,3)= 0
      IF (NSYS.LT.100) GO TO 120
160   IF (NSYS.LE.0) CALL NEXIT
C     TYPE 165,JOBNO
C165  FORMAT(' Detach from frame ',A3)
C     CALL DETACH
      OPEN (UNIT=TOUT,FILE=TOUTFL,ACCESS='SEQOUT')
      CALL DATE(TODAY)
      CALL TIME(CTIME)
      WRITE(TOUT,170) TODAY,CTIME
170   FORMAT(/,'Date: ',A9,/,'Time: ',A5,//'LUD/ACTG/CUD ',
     *'CONSISTENCY CHECK - Ver 1.1')
      CLOSE (UNIT=TOUT)
      CALL BLDACT(ACPORT)
      DO 200II= 1,NSYS
      SYSNO= SYSTBL(II,1)
      CALL MAKFIL(ACTF,SYSNO,'ACT.FIL')
180   CALL GETACT(SYSNO,TOTACT,ACTANS,$190)
      IF (ACTANS.NE.7) GO TO 185
      SYSTBL(II,1)= -1
      GO TO 200
185   CALL SLEEPY(900)
      CALL BLDACT(ACPORT)               ! error, try again
      GO TO 180
190   CALL MAKFIL(ACTSF,SYSNO,'ACT.SRT')
      CALL SORT(ACTF,ACTSF,ACTKEY,MERR,PERR)
      IF ((MERR.NE.0).OR.(PERR.NE.0)) CALL SRTERR(MERR,PERR,$200)
      CALL TOTOUT(TOTACT,ACTF)
      CALL DELET(ACTF,IERR)
200   CONTINUE
      CALL ZAPC(ACPORT)
      OPEN (UNIT=TOUT,FILE=TOUTFL,ACCESS='APPEND')
      CALL TIME(CTIME)
      WRITE(TOUT,220) CTIME
220   FORMAT(/,A5,' - Accounting system finished.')
      CLOSE (UNIT=TOUT)
C
C Get all users from LUDs
C
225   CALL MTIME(STIME)
      DO 260II= 1,NSYS
      SYSNO= SYSTBL(II,1)
      ASYST= SYSTBL(II,2)
      IF (SYSNO.EQ.-1) GO TO 260
      CALL MAKFIL(LUDF,SYSNO,'LUD.FIL')
      GO TO (230,230,240) ASYST
230   CALL GTLUD(SYSNO,ASYST,TOTLUD,IFLAG,$250)
240   CALL G3LUD(SYSNO,TOTLUD,IFLAG,$250)
250   IF (IFLAG.EQ.0) GO TO 260
      SYSTBL(II,3)= IFLAG
      CALL MAKFIL(LUDSF,SYSNO,'LUD.SRT')
      CALL SORT(LUDF,LUDSF,LUDKEY,MERR,PERR)
      IF ((MERR.NE.0).OR.(PERR.NE.0)) CALL SRTERR(MERR,PERR,$260)
      CALL TOTOUT(TOTLUD,LUDF)
      CALL DELET(LUDF,IERR)
      CALL MAKFIL(ACTSF,SYSNO,'ACT.SRT')
      CALL MAKFIL(DIFFL,SYSNO,'DIF.FIL')
      CALL CKLDAC(LUDSF,ACTSF,DIFFL)
260   CONTINUE
C
C check all users against the CUD.
C
      DO 270II= 1,NSYS
      IF (SYSTBL(II,3).EQ.1) GO TO 275
270   CONTINUE
      GO TO 805
275   CALL BLDCUD(CDPORT)
      DO 800II= 1,NSYS
      SYSNO= SYSTBL(II,1)
      ASYST= SYSTBL(II,2)
      IF (SYSNO.EQ.-1) GO TO 800
      IF (SYSTBL(II,3).EQ.0) GO TO 800
      OPEN (UNIT=TOUT,FILE=TOUTFL,ACCESS='APPEND')
      CALL TIME(CTIME)
      WRITE(TOUT,280) CTIME,SYSNO
280   FORMAT(/,A5,' - Check system ',I3)
      CLOSE (UNIT=TOUT)
      CALL MAKFIL(DIFFL,SYSNO,'DIF.FIL')
      OPEN (UNIT=20,FILE=DIFFL,ACCESS='SEQIN',ERR=690)
      CALL MAKFIL(FILRPT,SYSNO,'OUT   ')
      TOTACT= 0
300   READ(20,310,END=710) UNAME,ACTGAN,ACTUUN,LUDGAN,LUDUUN,CID,NF
310   FORMAT(2A5,A2,4O6,I6,I1)
      TOTACT= TOTACT+NF/4
320   CALL GETCUD(CDPORT,UNAME,CUDGAN,CUDUUN,CUDANS)
      IF (CUDANS) 330,360,380
330   OPEN (UNIT=TOUT,FILE=TOUTFL,ACCESS='APPEND')
      CALL TIME(CTIME)
      WRITE(TOUT,340) CTIME,UNAME
340   FORMAT(A5,' - CUD circuit zapped during get MUD data for ',3A5)
350   CALL ZAPC(-1)
      CLOSE (UNIT=TOUT)
      CALL BLDCUD(CDPORT)
      GO TO 320
360   OPEN (UNIT=TOUT,FILE=TOUTFL,ACCESS='APPEND')
      CALL TIME(CTIME)
      WRITE(TOUT,370) CTIME,UNAME
370   FORMAT(A5,' - Terminator from CUD is not 40. Username: ',2A5,A2)
      GO TO 350
380   GO TO (410,400) CUDANS
      OPEN (UNIT=TOUT,FILE=TOUTFL,ACCESS='APPEND')
      CALL TIME(CTIME)
      WRITE(TOUT,390) CTIME,CUDANS,UNAME
390   FORMAT(A5,' - Error (',O3,') during get MUD data for ',2A5,A2)
      GO TO 350
400   CUDANS= 0
410   NF= NF+CUDANS
      GO TO (430,450,490,510,550,580,600) NF
430   OPEN (UNIT=TOUT,FILE=TOUTFL,ACCESS='APPEND')
      WRITE(TOUT,440) NF,UNAME
440   FORMAT('Illegal code: ',I2,' - Username: ',2A5,A2)
      GO TO 300
450   CALL OPNRPT(22)
      WRITE(22,460) UNAME
460   FORMAT(/,2A5,A2,' in LUD, but not in ACTG and CUD.')
      CALL STRING(LUDGAN,8,LUDF)
      CALL STRING(LUDUUN,8,ACTF)
      WRITE(22,470) LUDF,ACTF
470   FORMAT('GAN: ',A6,/,'UUN: ',A6)
      GO TO 680
490   CALL OPNRPT(22)
      WRITE(22,500) UNAME
500   FORMAT(/,2A5,A2,' in LUD and CUD, but not in ACTG.')
      CALL CHKNUM('GAN:','LUD:','CUD:',LUDGAN,CUDGAN)
      CALL CHKNUM('UUN:','LUD:','CUD:',LUDUUN,CUDUUN)
      GO TO 680
510   CALL OPNRPT(22)
      WRITE(22,520) UNAME
520   FORMAT(/,2A5,A2,' in ACTG, but not in LUD and CUD.')
      CALL STRING(CID,10,ACTF)
      WRITE(22,530) ACTF
530   FORMAT('CID: ',A6)
      CALL STRING(ACTGAN,8,ACTF)
      CALL STRING(ACTUUN,8,LUDF)
      WRITE(22,470) ACTF,LUDF
      GO TO 680
550   CALL OPNRPT(22)
      WRITE(22,560) UNAME
560   FORMAT(/,2A5,A2,' in ACTG and CUD, but not in LUD.')
      CALL CHKNUM('GAN:','ACTG:','CUD:',ACTGAN,CUDGAN)
      CALL CHKNUM('UUN:','ACTG:','CUD:',ACTUUN,CUDUUN)
      GO TO 680
580   CALL OPNRPT(22)
      WRITE(22,590) UNAME
590   FORMAT(/,2A5,A2,' in ACTG and LUD, but not in CUD.')
      CALL CHKNUM('GAN:','ACTG:','LUD:',ACTGAN,LUDGAN)
      CALL CHKNUM('UUN:','ACTG:','LUD:',ACTUUN,LUDUUN)
      GO TO 680
600   IF (LUDGAN.NE.ACTGAN) GO TO 610
      IF (LUDGAN.EQ.CUDGAN) GO TO 640
610   CALL OPNRPT(22)
      WRITE(22,620) UNAME
620   FORMAT(/,'Mismatch GAN: ',2A5,A2)
      CALL STRING(CUDGAN,8,ACTF)
      CALL STRING(LUDGAN,8,LUDF)
      CALL STRING(ACTGAN,8,ACTSF)
      WRITE(22,630) ACTF,ACTSF,LUDF
630   FORMAT('CUD:  ',A6,/,'ACTG: ',A6,/,'LUD:  ',A6)
      CLOSE (UNIT=22)
640   IF (LUDUUN.NE.ACTUUN) GO TO 650
      IF (LUDUUN.EQ.CUDUUN) GO TO 300
650   CALL OPNRPT(22)
      WRITE(22,660) UNAME
660   FORMAT(/,'Mismatch UUN: ',2A5,A2)
      CALL STRING(CUDUUN,8,ACTF)
      CALL STRING(ACTUUN,8,ACTSF)
      CALL STRING(LUDUUN,8,LUDF)
      WRITE(22,630) ACTF,ACTSF,LUDF
680   CLOSE (UNIT=22)
      GO TO 300
690   OPEN (UNIT=TOUT,FILE=TOUTFL,ACCESS='APPEND')
      CALL TIME(CTIME)
      WRITE(TOUT,700) CTIME,DIFFL
700   FORMAT(A5,' - Cannot open file ',A10)
      GO TO 740
710   CLOSE (UNIT=20,DISPOSE='DELETE')
      OPEN (UNIT=22,FILE=FILRPT,ACCESS='SEQIN',ERR=730)
      CLOSE (UNIT=22)
      CALL OPNFIL(22,FILRPT,'APPEND',$730)
      CALL STRING(TOTACT,10,ACTF)
      WRITE(22,720) ACTF
720   FORMAT(/,'Number of users in ACTG for this system: ',A5,/,'EOJ')
      CLOSE (UNIT=22)
730   OPEN (UNIT=TOUT,FILE=TOUTFL,ACCESS='APPEND')
740   CALL TIME(CTIME)
      WRITE(TOUT,750) CTIME,SYSNO
750   FORMAT(A5,' - System ',I3,' finished.')
      CLOSE (UNIT=TOUT)
800   CONTINUE
805   CALL ZAPC(-1)
      CALL MTIME(ETIME)
      DTIME= ETIME-STIME
      DWNCNT= 0
      DO 810II= 1,NSYS
      IF (SYSTBL(II,1).EQ.-1) GO TO 810
      IF (SYSTBL(II,3).NE.0) GO TO 810
      DWNCNT= DWNCNT+1
      SYSDWN(DWNCNT,1)= SYSTBL(II,1)
      SYSDWN(DWNCNT,2)= SYSTBL(II,2)
810   CONTINUE
      IF (DWNCNT.EQ.0) GO TO 900
      NSYS= DWNCNT
      DO 820II= 1,NSYS
      SYSTBL(II,1)= SYSDWN(II,1)
      SYSTBL(II,2)= SYSDWN(II,2)
      SYSTBL(II,3)= 0
820   CONTINUE
      IF (DTIME.LT.0) GO TO 900
      IF (DTIME.GT.900) GO TO 225
      CALL MTIME(ETIME)
      DTIME= 900-MOD(ETIME,900)
      CALL SLEEPY(DTIME)
      GO TO 225
900   STOP
      END
   