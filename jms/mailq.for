C This reads a FINDIT log, looking for duplicate files
C The input file 'in.dat' must be sorted /r80/k54.6 with the format:
C(MAIL        :  74) QQ2571.XXX     2 25-Sep-90 15:30 BADQUV  ALL  RD  NO
C1234567890123456789012345678901234567890123456789012345678901234567890123
	open(unit=1,file='in.dat')
	open(unit=2,file='out.dat')
	open(unit=3,file='dup.dat')
	open(unit=4,file='tty:')
10	read(1,20,end=999) fil1,fil2,sum1,sum2
20	format(20x,a5,a5,23x,a3,a3)
	if (sum1.eq.old1 .and. sum2.eq.old2) goto 50
C This is not a duplicate of the previous checksum
	write(2,30) fil1,fil2
30	format(1x,a5,a5)
	old1=sum1
	old2=sum2
	iout=iout+1
	goto 10
C Found a file with a duplicate checksum
50	write(3,30) fil1,fil2
	idup=idup+1
	goto 10
C Summary at ten
999	write(4,998) iout,idup
998	format(' out.dat=',i,', dup.dat=',i)
	END
    