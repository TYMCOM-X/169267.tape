:EDINEW.LST
:TIME 500
CTE SETP EDITOR=EDITOR
TIME
DEL EDITST.TT,EDITST.TT1,EDITST.TT2,EDITST.TT3,0XX###.TMP /NOP
DEL EDITST.TT4,EDITST.TT5,EDITST.TT6,EDITST.TT7 /NOP
DEL EDITST.TT8,EDITST.TT9 /NOP
DEL EDITST.E10,EDITST.COM,EDIT1,EDIT2,TEMP,TEMP.FAI,TEMP.REL /NOP
EDITOR
A
LINE 1
LINE 2
LINE 3
LINE 4
LINE 5
LONG LINE 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 12345
TAB TEST
	1	2	3	4	5	6	7	8
END FIRST TAB TEST
BEGIN SECOND

TABS 4,7,10,13,16,19,22,25,28,31,34,37,40,43,46,49,52,55,58,61,64,67,70,73,76,79,82,85,88,91,94,97,100,103,106,109,112,115,118,121,124,127,130,133,136,139,142,145
TABS=
TABS
TABS=
TABS 5,10,15,20,25,30,35,40,60
TABS=
A
BEGIN SECOND INPUT
	1	2	3	4	5	6	7	8	9
END SECOND TEST

W EDIT1

W EDIT2

1I
NEW FIRST LINE

APPEND EDIT1

Q
Y

TYPE EDIT1
FIL EDIT1,EDIT2/SIZ/CRE
TYPE EDIT2
EDI
VER
A
        TYPE 3001
3001    FORMAT(' FIRST PASS EDITOR NEXT MOD'/)
        STOP
        END

W TEMP

Q
EXE TEMP
MOD TEMP
2E
FFSECOND
GO
EDI
A
LINE 1
FOO: MSG('HELLO$')
FOO  MSG('HELLO$')SECOND
TRY AGAIN
FOO: MSG('HELLO$')
FOO  MSG('HELLO$')FORTH
LINE LAST

W TEMP

W TEMP.FAI

Q

EDI
R TEMP
   :FOO:/
   :FOO:/
Q
EDI
R TEMP.FAI
   :FOO:/
   :FOO:/
Q
EDI
R TEMP
ONCOLON
   :FOO:/
   :FOO:/
1/
OFFCOLON
   :FOO:/
   :FOO:/
Q
EDI
A
RUN TEMPX

W 0XXSVC.TMP

1M
TEMP!
W 0XXEDT.TMP

1DEL
A
        TYPE 3001
3001    FORMAT(' TEMPCORE EDITOR TEST')
        TYPE 3002
3002    FORMAT(' PHASE ONE')
1       CONTINUE
        TYPE 3003
3003    FORMAT(' DID I GET HERE')
        CALL EXIT
        END

W TEMP

Q
EXE TEMP
MOD TEMP
   :1:/
.I
        STOP

GO TEMP

EDITOR
VER
2L
THIS TEXT IS IN BUFFER 2
1B
2B
3B
4B
5B
6B
7B
8B
9B
0B
1L
THIS TEXT IS IN BUFFER 1
 FOR NOW

1B
2B
3B
0B
3L
BUFF3
4L
BUFF4
5L
BUFF5
6L
BUFF6
7L
BUFF7
8L
BUFF8
9L
BUFF9

1B
2B
3B
4B
5B
6B
7B
8B
9B
0B
5L
NEW LINE 5
TRY TO SEE WHAT

1B
2B
3B
4B
5B
6B
7B
8B
9B
0B
0L
JUST ONE LINE

1B
2B
3B
4B
5B
6B
7B
8B
9B
0B
READ EDITST.T1
$=
FIND 'LL' AND NOT '3' ;1LOAD
$=
0B
1B
2B
A
1

Q
Y
TIME
EDITOR
VER
READ 5,15 EDITST.T1
WRITE
EDITST.TT

/
4 READ EDITST.TT
/
WRITE
EDITST.TT1

5,10 REPLACE 7,12 EDITST.TT1

CL
Y
R EDITST.BLI
PRINT
N
CL
Y
R EDITST.TT1
/
R EDITST.TT
PRINT
N
LINES 15
PAGE
N
PRINT
N
PAGE 5
N
1I
NOW FOR NEXT TEST OF THE JOIN COMMAND

1,10/
3JOIN
5JOIN
7JOIN
1,10/
$=
SPACING 3
FIND "E" AND NOT "12" PAGE 5
N
Q
Y
TIME
EDITOR
R EDITST.TT
R EDITST.TT1
FIND "LL" MARK 1
FIND "1" MARK 2
@1/
@2/
1,$ UNMARK 2
@1/
@2/
@1 CLEAR
"LL" MARK 2
1/
@2 INSERT
WHERE IS THE @2
FOUND YOU HERE ?

/
W EDITST.TT2

Q
EDI
VER
R EDITST.TT2
1L
FFOUND AN F1
2L
NO F FOUND THIS TIME1
ONRING 2
1,$/
Q
TIME
EDITOR
VER
A
LINE 1 IS HERE
LINE 2 IS HERE
LINE 3 IS HERE
LINE 4 IS HERE
2MOD
SFIRST PASS
.+1MODIFY
H MODIFY<LF> FAILS BUT M<LF> WORKS
.-1MODIFY
 THE UP ARROW DID NOT WORK BUT ONLY WITH THE NON-ABREVIATED
.-1MODIFY
THE UP ARROW FAILS
/
"FIRST","FAI"MODIFY
THIS IS LINE FEEDTHIS IS LINE FIRST
/
Q
Y
TIME
EDITOR
A
THE
QUICK
BROWN
FOX
JUMPED
OVER
THE 
LAZY
DOGS
BACK
LINE 1

1COPY1,10
16COPY 1,20
SUB
WHYEN
SUB
BECAUSEYN
1,30FIND "ECA"=Y
1B
2B
3B
4B
5B
6B
7B
8B
9B
0B
3,5/
3,5;4GET
1,10/
1B
2B
3B
4B
5B
6B
7B
8B
9B
0B
3,5;0GET
1,10/
1B
2B
3B
4B
5B
6B
7B
8B
9B
0B
QUIT
Y
TIME
EDITOR
A
THIS IS TEST TO SEE IF THE CONTROL CHARACTERS WORK CORRECTLY
FIRST A CONTROL A NEXT WORD
THE CONTROL B HAS ALREADY BEEN TESTED
NOW TRY CONTROL CAND 
THEN CONTROL D
BLANK LINE
NOW FOR THE CONTROL E IN THIS
BLANK LINE

/
EX
EDITST.TT3

TIME
MODIFY EDITST.TT3
A
DIFFER CONTROL G TILL LATER
CONTROL H INPUT NEXT CONTROL I
	1	2CONTROL K
BLANK LINE
CONTROL N WILL BE TRIED ON THE NEXT LINE
DE TRIED ON THE NEXT LINE
DHAVE USED CONTROL O

/
CHECKPOINT
EXIT EDITST.TT3

TIME
EDITOR
A
1
NOW FOR CRL Q

LINE 1
LINE 2
LINE 3
LINE 4
NOW FOR CRL Q 4 TIMES
.=
/
A
NOW RTRY AT CRL R TO SEE IF IT GOES
NOW RTRY AT CRL RNOWINSERT A CRL ELR
BLANK LINE
NOW FOR A LINE TO BE USED BY CRL S
NOW F ADD A LITTLE BIT TO THE LINE
UADD A BIT THEN CONT R
BLANK LINE

QUIT
Y
TIME
EDITOR
A
NOW FOR A TRY OF THE CONTROL U
SHOULD BE A COPY TO HERECONTROL V IS ALREADY USED
BUT WILL TRY ANY WAY
NOTE LAST LINE FOR ANOMILY
	
NOTE LINE FEED

.E

A
A LINE FOR THE CONTROL X
LFIRST LLSECOND L
LLCONTROL W
NOW CTL YMORE LINE

/
QUIT
Y
TIME
EDITOR
A
FINAL TEST IS THAT OF THE CONTROL P
SECOND LINE

2E
NOWSOL
/
A
I BELIEVE ALL AREAS OF CONTROL NOW TESTED

Q
Y
TIME
EDITOR
VER
A
ADD A VERY LONG LINE
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789


W EDITST.TT1

/
Q
TTY WIDTH 50
EDITOR
VER
R EDITST.TT1
/
Q
TTY WIDTH 60
EDITOR
VER
R EDITST.TT1
/
Q
TTY WIDTH 80
EDITOR
VER
R EDITST.TT1
/
Q
TIME
EDI
A
A-B

A-B
A-B
A-B
A-BC-D
A-B

A-B END
/W EDITST.TT1

Q
TYPE EDITST.TT1
EDI
A
ABCDE
FGHIJ
W EDITST.TT1

Q
TYPE EDITST.TT1
MOD EDITST.TT1
$/
READ EDITST.TT1
EX
TYPE EDITST.TT1
EDI
A
AB  CD  
AB  CD  
AB  CD  
AB  CD  
AB  CD  
AB  CD  
AB  CD  
AB  CD  
AB  CD  
4M

6M
DAB  CD  
6M
DC
/
6M
DAB  CD  CAB  CD  
/Q
Y
EDI
A
AB  CD  
AB   D  C
AB  CD  
AB   D  C
AB  CD  
AB   D  
AB  CD  
AB   D  DEF
AB  CD  
AB  CD D
6M
CC
8M
C
8/
8M
C
8/
8M
CD  
8/
10M

6M

6/
/Q
Y
EDI
VER
A
LINE FOR TESTING FILE CHANGE

W EDITST.TT4

W EDITST.TT5

Q
MOD EDITST.TT4
$/
READ EDITST.TT5
EX

TYPE EDITST.TT4
TYPE EDITST.TT5
DEL EDITST.TT4,EDITST.TT5 /NOP
COPY EDITST.10E,EDITST.E10
EDI
A
LINE 1
NOW FOR INTERNAL CTL I	HERE
NOW FOR INTERNAL CTL I	HERE AGAIN

W EDITST.TT4

Q
EDI
VER
R EDITST.TT4
/
Q
EDI
VER
R EDITST.E10
Y
$=
/
Q
Y
MOD EDITST.E10
Y
VER
EXIT

COPY EDITST.10E,EDITST.E10
EDITOR
VER
R EDITST.E10
Y
EXIT EDITST.E10

COPY EDITST.10E,EDITST.E10
COPY EDITST.TT1,EDITST.TT4
EDI
VER
R EDITST.TT1
2,4WRITE EDITST.TT5

R EDITST.TT5
APPEND EDITST.TT4

R EDITST.TT4
$-10,$/
$=
R 2,5 EDITST.TT5
$=
Q
Y
EDITOR
R EDITST.TT1
'I',$PAGE
N
$=
.E

Q
Y
DEL EDITST.TT4,EDITST.TT5 /NOP
TIME
COPY EDITST.TT1,EDITST.TT4
MOD EDITST.TT4
1I
LINE 1
LINE 2

CHECKPOINT

1I
LINE 01
LINE 02

CHE

1,$/
1,$DEL
R EDITST.TT4
1,$/
Q
Y
TIME
EDI
VER
A
R EDITST.TT1
1L
EXTENSION OF L1
1E
1
1,3/
W EDITST.TT4

$=
./
APPEND EDITST.TT4

R EDITST.TT4
$=
COMMAND T

W EDITST.COM

Q
EDI
VER
COMMAND EDITST.COM
1,$/
Q
Y

EDI
VER
COMMAND
EDITST.COM
1,$/
Q
Y

EDI
VER
COMMAND EDITST.CM1
DEL EDITST.TT9 /NOP
TIME
EDI
VER
A
A FEW LINES
TO TEST THE
COMPARITIVE
EASE OF THE
SYSTEM MAKE

W EDITST.TT6

W EDITST.TT7

W EDITST.TT8

Q
MOD EDITST.TT6
VER
R EDITST.TT7
EXIT

CREATE EDITST.TT9

VER
R EDITST.TT7
R EDITST.TT8
EXIT

CREATE EDITST.TT9
N
CREATE EDITST.TT9
Y
A
FIRST APPENDED LINE
SECOND APPENDED LINE
THIRD APPENDED LINE
FOURTH APPENDED LINE


EXIT
EDI
VER
A
FIRST APPEND

./
A

./
Q
Y
TIME
EDITOR
V
DO EDITST.CM4
Q
Y
TIME
EDITOR
DO EDITST.CM3
EDITST.T3
1
QUIT
TYPE EDITST.CKM
DEL EDITST.CKM
TIME
EDITOR
A
THIS WILL BE A VERY LONG LINE WHEN I'M DONE! 6789012345678901234

.COP.
.COP.
.COP.
.J
.J
.J
.M
AN INSERT COMES HERE!!!DXYZ
./
Q
Y
TIME
MOD EDITST.T1
3M1
@1CL
3M1
@1D
N
Q
Y
TIME
MOD EDITST.T1
3,5M1
8M1
@1-1D
YYYNNYYYYN$=Q
Y
TIME
MOD EDITST.BLI
$=^43/._.-26/^^._Q

DEL EDITST.TT,EDITST.TT1,EDITST.TT2,EDITST.TT3,0XX###.TMP /NOP
DEL EDITST.TT4,EDITST.TT6,EDITST.TT7,EDITST.TT8,EDITST.TT9 /NOP
DEL EDITST.E10,EDITST.COM,EDIT1,EDIT2,TEMP,TEMP.FAI,TEMP.REL /NOP
TIME
R PERP
DATE
TOMORROW.
INSERT
0
33

EDIDIF.CMD
Q
TIME
 