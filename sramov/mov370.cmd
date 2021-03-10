* MOVEUSR EXEC   06/03/78 RK
&REC = 0
&IF &INDEX NE 1 &DENSITY = 6250
&IF &INDEX EQ 1 &DENSITY = &1
&STACK
&READ ARGS
&BEGTYPE

      VERSION 3.0

&END
&CONTROL OFF
SET RDYMSG SMSG
&FSW = 0
TAPE REW
&FILNUM = 1
-START &STACK HT
ERASE TAPEXC EXEC ( NOTYPE
STATE SEERHS MODULE
&IF &RETCODE NE 0 &GOTO -FILEMIS
STATE TAPEXAPP MODULE
&IF &RETCODE NE 0 &GOTO -FILEMIS
&STACK RT
&CONTROL ERROR
&IF &INDEX LT 1 &TYPE USER NAME MUST BE GIVEN.
&IF &INDEX LT 1 &FILNUM = &FILNUM - 1
&IF &INDEX LT 1 &GOTO -ANOTH
&MDFILES = FILES
&DMPMDSK = 191
&IF &INDEX EQ 1 &GOTO -DUMP
&IF &2 EQ ALL &GOTO -ALLDUMP
&DMPMDSK = USER
&IF &2 EQ USER &GOTO -DUMP
&DMPMDSK = &2
&LNGT = &LENGTH &2
&IF &LNGT EQ 3 &GOTO -CHECK
&TYPE &2 DASD ADDRESS IS NOT 3 CHARS
&FILNUM = &FILNUM - 1
&GOTO -ANOTH
-CHECK &IF &INDEX EQ 2 &GOTO -DUMP
&IF &3 EQ FILES &MDFILES = &3
&IF &3 EQ FILES &GOTO -DUMP
&IF &3 EQ NOFILE &MDFILES = &3
&IF &3 EQ NOFILE &GOTO -DUMP
&TYPE &3 IS NOT A VALID OPTION.
&FILNUM = &FILNUM - 1
&GOTO -ANOTH
-DUMP &USR = &1
TAPEXAPP &CONTROL OFF
TAPEXAPP SET RDYMSG SMSG
TAPEXAPP &TYPE ******** -------- ********
TAPEXAPP &TYPE RESTORE TAPEXC EXEC TAPE FILE &FILNUM FOR &USR
&FILNUM2 = &FILNUM
TAPEXAPP RDUSR &USR USER
&IF &DMPMDSK EQ USER &GOTO -STA
TAPEXAPP &IF &LITERAL &RETCODE NE 0 &GOTO -NOTSET
&GOTO -STA2
-STA TAPEXAPP &IF &LITERAL &RETCODE EQ 0 &GOTO -SETUP
-STA2 TAPEXAPP &CONTROL ERROR
&IF &MDFILES EQ FILES &GOTO -USER4
TAPEXAPP &STACK LIFO QUIT
&STACK HT
RDUSR &USR ALL ( PW STACK
&IF &RETCODE EQ 0 &GOTO -RDOK
&FILNUM = &FILNUM - 1
&STACK RT
&TYPE RDUSR ERROR. USERNAME DOES NOT EXIST.
&GOTO -ANOTH
-RDOK &IPL = 0
&STACK RT
-LOOP &READ ARGS
&IF &1 EQ MDISK &GOTO -MDISK
&IF &1 EQ USER &GOTO -CHKUSR
&IF &DMPMDSK NE USER &GOTO -LOOP
&IF &1 EQ LINK &GOTO -LINK
&IF &1 EQ SPECIAL &GOTO -SPECIAL
&IF &1 EQ SPOOL &GOTO -SPOOL
&IF &1 EQ CONSOLE &GOTO -CONSOLE
&IF &1 EQ TZONE &GOTO -TZONE
&IF &1 EQ IPL &GOTO -IPL
&IF &1 EQ LICENSE &GOTO -LICENSE
&IF &1 EQ OPTION &GOTO -OPTION
&IF &1 EQ ACCOUNT &GOTO -ACCOUNT
-BADCARD &TYPE ( &1 ) CARD CANNOT BE HANDLED BY THIS PROGRAM.
-ABORT &TYPE USER &USR CANNOT BE MOVED BY THIS PROGRAM.
CONWAIT
DESBUF
&FILNUM = &FILNUM - 1
&GOTO -ANOTH
-CHKUSR &IF &DMPMDSK EQ USER &GOTO -USER
&GOTO -USER1
-LINK &DELFLG = 0
&IF &4 EQ 190 &DELFLG = 1
&IF &4 EQ 19E &DELFLG = 1
&IF &DELFLG NE 0 &IF &2 EQ CMS &IF &3 EQ &4 &IF &5 EQ RR &GOTO -LOOP
&IF &5 NE RR TAPEXAPP &STACK LIFO C &USR D &4 MODE &5
TAPEXAPP &STACK LIFO A &USR D &4 L &2 &3
&IF &DELFLG NE 0 TAPEXAPP &STACK LIFO D &USR D &4
&GOTO -LOOP
-MDISK &IF &DMPMDSK EQ USER &GOTO -MD2
&IF &DMPMDSK NE &2 &GOTO -LOOP
-MD2 &S = &SUBSTR &6 1 3
&IF &S EQ TYM &GOTO -LOOP2
&IF &S EQ C40 &GOTO -LOOP2
&IF &S EQ C41 &GOTO -LOOP2
&IF &S EQ V42 &GOTO -LOOP2
&IF &S EQ V43 &GOTO -LOOP2
-MD3 &TYPE MDISK &2 IS ON PACK &6 . IT IS A SPECIAL PACK OR A SPECIAL DASD
&TYPE AND WILL BE IGNORED.
&GOTO -LOOP
-LOOP2 &IF &2 EQ 190 &GOTO -MD3
&IF &2 EQ 19E &GOTO -MD3
&IF &INDEX GT 7 TAPEXAPP &STACK LIFO C &USR D &2 PA &8 &9 &10
&IF &2 NE 191 &GOTO -DISK191
TAPEXAPP &STACK LIFO YES
TAPEXAPP &STACK LIFO
TAPEXAPP &STACK LIFO PLEASE ENTER A MAIL ADDRESS.
-DISK191 TAPEXAPP &STACK LIFO A &USR D &2 M &5
&GOTO -LOOP
-SPECIAL &IF &3 NE TIMER &GOTO -BADCARD
TAPEXAPP &STACK LIFO A &USR D &2 TIMER
&GOTO -LOOP
-SPOOL &IF &2 EQ 00C &IF &3 EQ 2540 &IF &4 EQ R &GOTO -LOOP
&IF &2 EQ 00D &IF &3 EQ 2540 &IF &4 EQ P &GOTO -LOOP
&IF &2 EQ 00E &IF &3 EQ 1403 &GOTO -LOOP
* THIS IGNORES SPOOL CLASS
&GOTO -BADCARD
-CONSOLE &IF &2 EQ 009 &IF &3 EQ 3215 &GOTO -LOOP
* CAN BE CHANGED TO HANDLE CONSOLE AT 01F
&GOTO -BADCARD
-TZONE &TZ = &&INDEX
&IF &TZ EQ PST &TZ = PDT
&GOTO -LOOP
-IPL &IPL = 1
&IF &2 NE CMS TAPEXAPP &STACK LIFO C &USR IPL &2
&GOTO -LOOP
-LICENSE &IF &INDEX GT 3 &GOTO -REALLIC
&IF &INDEX EQ 3 &IF &2 NE TYMSHARE &GOTO -REALLIC
&IF &&INDEX EQ PREMIUM &GOTO -LOOP
-REALLIC &TYPE LICENSE &2 &3 &4 &5 FOR &USR MUST BE GIVEN
&TYPE BY SYSTEMS SUPPORT.
&GOTO -LOOP
-OPTION &IF &INDEX EQ 2 &IF &2 EQ PARMAUTO &GOTO -LOOP
&TYPE OPTIONS &2 &3 &4 &5 &6 MUST BE GIVEN BY SYSTEMS SUPPORT.
&GOTO -LOOP
-ACCOUNT &UUN = &2
&GAN = &3
&DIST = &4
&GOTO -LOOP
-USER &IF &4 NE 320K TAPEXAPP &STACK LIFO C &USR CORE &4
&IF &5 NE 1536K TAPEXAPP &STACK LIFO C &USR MAX &5
&X = &SUBSTR &6 1 1
&IF &X NE G &TYPE PRIVILEG CLASS &6 MUST BE GIVEN BY SYSTEMS SUPPORT.
&INT = EXT
&IF &6 NE G &INT = INT
TAPEXAPP &STACK LIFO A &USR U &UUN &GAN &DIST &TZ &INT 0
-USER1 TAPEXAPP USERDEF
TAPEXAPP &IF &LITERAL &RETCODE EQ 0 &GOTO -CONT7
&IF &DMPMDSK EQ USER TAPEXAPP TAPE FSF 1
&IF &DMPMDSK EQ USER &GOTO -USER3
EXEC SLINK &USR &DMPMDSK 291 M
&IF &RETCODE NE 0 &GOTO -LKERR
&STACK HT
SEERHS OFF
ACCESS 291 F
&IF &RETCODE NE 0 &GOTO -ACCERR
LIST * * F (EXEC
&IF &RETCODE NE 0 &GOTO -NOFILES
&STACK RT
-USER2 &IF &DMPMDSK EQ USER TAPEXAPP TAPE FSF 1
&IF &DMPMDSK NE USER TAPEXAPP TAPE FSF 2
-USER3
TAPEXAPP &TYPE USERDEF ERROR. SKIPPING FILES IF EXIST.
TAPEXAPP CONWAIT
TAPEXAPP DESBUF
TAPEXAPP &EXIT
&DMPMD2 = &DMPMDSK
TAPEXAPP -CONT7 &TYPE USER &USR &DMPMD2 SET UP.
TAPEXAPP &TYPE ******** -------- ********
-USER4 &IF &MDFILES NE FILES &GOTO -USER5
&STACK HT
EXEC SLINK &USR &DMPMDSK 291 M
&IF &RETCODE NE 0 &GOTO -LKERR
SEERHS OFF
ACCESS 291 F
&IF &RETCODE NE 0 &GOTO -ACCERR
LIST * * F (EXEC
&IF &RETCODE EQ 0 &GOTO -USER5
&STACK RT
&TYPE MDISK &USR &DMPMDSK HAS NO FILES.
&TYPE NOTHING WILL BE MOVED.
&FILNUM = &FILNUM - 1
&STACK HT
REL F
CP .DET 291
&GOTO -ANOTH
-USER5 &STACK RT
TAPEXAPP TAPE FSF 1
TAPEXAPP &GOTO -CONT
&DMPMD2 = &DMPMDSK
TAPEXAPP -SETUP &TYPE USER &USR &DMPMD2 WAS ALREADY SET UP. SKIP FILES.
&IF &DMPMDSK EQ USER TAPEXAPP TAPE FSF 1
&IF &DMPMDSK NE USER TAPEXAPP TAPE FSF 2
TAPEXAPP &EXIT
TAPEXAPP -NOTSET &TYPE USER &USR IS NOT SET UP. SKIP FILES.
TAPEXAPP TAPE FSF 2
TAPEXAPP &EXIT
TAPEXAPP -CONT
-DMPMDSK &IF &DMPMDSK EQ USER &GOTO -FINIS
&ERROR &CONTINUE
&CONTROL ERROR
&FILNUM = &FILNUM + 1
TAPEXAPP &TYPE ******** -------- ********
TAPEXAPP &TYPE RESTORE ALL FILES TAPE FILE &FILNUM FOR &USR &DMPMDSK
TAPEXAPP EXEC SLINK &USR &DMPMDSK 291 W
TAPEXAPP &IF &LITERAL &RETCODE NE 0 &GOTO -END
TAPEXAPP &CONTROL ERROR
TAPEXAPP ACCESS 291 F
TAPEXAPP TAPE LOAD * * F (NOPRINT 9TRACK DEN &DENSITY
TAPEXAPP &IF &LITERAL &RETCODE EQ 0 &GOTO -CONT8
TAPEXAPP &TYPE ERROR IN LOADING FILES FOR &USR &DMPMDSK
TAPEXAPP &TYPE RETURN CODE &LITERAL &RETCODE
TAPEXAPP TAPE REW
TAPEXAPP &TYPE TAPE REWIND EXECUTED
TAPEXAPP &TYPE YOU..... MUST REPOSIT -ION THE TAPE.
TAPEXAPP &STACK HT
TAPEXAPP REL F
TAPEXAPP CP .DET 291
TAPEXAPP &STACK RT
TAPEXAPP &EXIT
TAPEXAPP -CONT8
TAPEXAPP Q DISK F
TAPEXAPP REL F
TAPEXAPP CP .DET 291
TAPEXAPP &TYPE FILES RESTORED TO &USR &DMPMDSK
TAPEXAPP &TYPE ******** -------- ********
TAPEXAPP &EXIT
TAPEXAPP -END &TYPE CANNOT RESTORE FILES FOR &USR &DMPMDSK
TAPEXAPP &TYPE SOMEONE HAS WRITE ACCESS OR READ ACCESS OR DASD
TAPEXAPP &TYPE &DMPMDSK DOES NOT EXIT. SKIP FILES.
TAPEXAPP TAPE FSF 1
TAPEXAPP &EXIT
-FINIS FINIS TAPEXC EXEC
TAPE DUMP TAPEXC EXEC A ( NOPRINT 9TRACK DEN &DENSITY BLOCK 10
&IF &RETCODE EQ 0 &GOTO -CONT3
&TYPE RETURN CODE &RETCODE
&IF &DMPMDSK EQ USER &FILNUM = &FILNUM - 1
&IF &DMPMDSK NE USER &FILNUM = &FILNUM - 2
&IF &FILNUM NE 0 &GOTO -CONT4
TAPE REW
&GOTO -TDUMP
-CONT4 TAPE BSF 1
TAPE FSF 1
&GOTO -TDUMP
-CONT3 TAPE WTM
&DMPMD2 = &DMPMDSK
&TYPE ******** -------- ********
&TYPE DUMPED TAPEXC EXEC TAPE FILE &FILNUM2 FOR &USR &DMPMD2
&IF &DMPMDSK EQ USER &GOTO -ANOTH
TAPE DUMP * * F ( NOPRINT 9TRACK DEN &DENSITY BLOCK 10
&IF &RETCODE EQ 0 &GOTO -CONT2
&TYPE RETURN CODE &RETCODE
&FILNUM = &FILNUM - 2
&IF &FILNUM NE 0 &GOTO -CONT5
TAPE REW
&GOTO -TDUMP
-CONT5 TAPE BSF 2
TAPE FSF 1
&GOTO -TDUMP
-CONT2 TAPE WTM
&TYPE ******** -------- ********
&TYPE DUMPED ALL FILES TAPE FILE &FILNUM FOR &USR &DMPMDSK
Q DISK F
REL F
CP .DET 291
-ANOTH &STACK RT
&VARX = Y
&VARZ = N
&VARZZ = M
&VARZX = A
&IF &VARZX EQ &VARY &GOTO -ANOTH2
&BEGTYPE



ANOTHER USER?
&END
&READ VARS &ANOTHER
&VARY = &SUBSTR &ANOTHER 1 1
&IF &VARX EQ &VARY &GOTO -ANOTH2
&IF &VARZ EQ &VARY &GOTO -DONE
&IF &VARZZ EQ &VARY &GOTO -ANOTHM
&GOTO -ANOTH
-ANOTH2 &FILNUM = &FILNUM + 1
&IF &FSW NE 0 &GOTO -ANOT2A
&FSW = 1
&FNA = 0
&FEXT = 0
&FD = 0
&TYPE INPUT FILE NAME ?
&READ ARGS
&IF &INDEX EQ 0 &GOTO -ANOTH
&IF &INDEX LT 3 &3 = A
&IF &INDEX LT 2 &2 = DATA
&FNA = &1
&FEXT = &2
&FD = &3
&REC = 0
-ANOT2A &REC = &REC + 1
&STACK HT
DISKIO READ &FNA &FEXT &FD (FROM &REC FOR 1)
&STACK RT
&IF &RETCODE EQ 0 &GOTO -ANOT2B
&TYPE EOF ON INPUT
&FSW = 0
&VARY = X
&FILNUM = &FILNUM - 1
&GOTO -ANOTH
-ANOT2B &READ ARGS
&TYPE **** &1
&GOTO -START
-ANOTHM &FILNUM = &FILNUM + 1
&TYPE ENTER USERNAME AND OPTIONS?
&READ ARGS
&GOTO -START
-DONE &TYPE DONE.
TAPE WTM 5
-DETA
&TYPE ANOTHER TAPE?
&READ VARS &TA
&IF &TA EQ N &SKIP 3
&IF &TA NE Y &GOTO -DETA
TAPE RUN
&IF &TA EQ Y &EXIT
CP DETACH 181
&STACK HT
SEERHS ON
&STACK RT
&EXIT
-LKERR &STACK RT
&TYPE LINK PROBLEM WITH MDISK &USR &DMPMDSK
&TYPE RETURN CODE &RETCODE
&FILNUM = &FILNUM - 1
&STACK HT
REL F
CP .DET 291
&GOTO -ANOTH
-ACCERR &STACK RT
&TYPE ACCESS PROBLEM WITH MDISK &USR &DMPMDSK
&TYPE RETURN CODE &RETCODE
&FILNUM = &FILNUM - 1
&STACK HT
REL F
CP .DET 291
&GOTO -ANOTH
-NOFILES &STACK RT
&TYPE MDISK &USR &DMPMDSK HAS NO FILES.
&TYPE RETURN CODE &RETCODE
&STACK HT
REL F
CP .DET 291
&STACK RT
&TYPE USER INFO WILL BE MOVED.
&DMPMDSK = USER
&GOTO -USER2
-TDUMP &TYPE TAPE DUMP PROBLEM WITH MDISK &USR &DMPMDSK
&STACK HT
REL F
CP .DET 291
&GOTO -ANOTH
-ALLDUMP &USR = &1
&DMPMDSK = ALL
&MDFILES = NOFILE
&M1 = NONE
&M2 = NONE
&M3 = NONE
&M4 = NONE
&M5 = NONE
&M6 = NONE
&M7 = NONE
&M8 = NONE
&M9 = NONE
&M10 = NONE
&M11 = NONE
&M12 = NONE
&M13 = NONE
&M14 = NONE
&M15 = NONE
&M16 = NONE
&M17 = NONE
&M18 = NONE
&M19 = NONE
&M20 = NONE
&MDS = 0
TAPEXAPP &CONTROL OFF
TAPEXAPP SET RDYMSG SMSG
TAPEXAPP &TYPE ******** -------- ********
TAPEXAPP &TYPE RESTORE TAPEXC EXEC TAPE FILE &FILNUM FOR &USR
&FILNUM2 = &FILNUM
TAPEXAPP RDUSR &USR USER
-XSTA TAPEXAPP &IF &LITERAL &RETCODE EQ 0 &GOTO -XSETUP
-XSTA2 TAPEXAPP &CONTROL ERROR
TAPEXAPP &STACK LIFO QUIT
&STACK HT
RDUSR &USR ALL ( PW STACK
&IF &RETCODE EQ 0 &GOTO -XRDOK
&FILNUM = &FILNUM - 1
&STACK RT
&TYPE RDUSR ERROR. USERNAME DOES NOT EXIST.
&GOTO -ANOTH
-XRDOK &IPL = 0
&STACK RT
-XLOOP &READ ARGS
&IF &1 EQ MDISK &GOTO -XMDISK
&IF &1 EQ LINK &GOTO -XLINK
&IF &1 EQ SPECIAL &GOTO -XSPECIA
&IF &1 EQ SPOOL &GOTO -XSPOOL
&IF &1 EQ CONSOLE &GOTO -XCONSOL
&IF &1 EQ TZONE &GOTO -XTZONE
&IF &1 EQ IPL &GOTO -XIPL
&IF &1 EQ LICENSE &GOTO -XLICENS
&IF &1 EQ OPTION &GOTO -XOPTION
&IF &1 EQ ACCOUNT &GOTO -XACCOUN
&IF &1 EQ USER &GOTO -XUSER
-XBADCAR &TYPE ( &1 ) CARD CANNOT BE HANDLED BY THIS PROGRAM.
-XABORT &TYPE USER &USR CANNOT BE MOVED BY THIS PROGRAM.
CONWAIT
DESBUF
&FILNUM = &FILNUM - 1
&GOTO -ANOTH
-XLINK &DELFLG = 0
&IF &4 EQ 190 &DELFLG = 1
&IF &4 EQ 19E &DELFLG = 1
&IF &DELFLG NE 0 &IF &2 EQ CMS &IF &3 EQ &4 &IF &5 EQ RR &GOTO -XLOOP
&IF &5 NE RR TAPEXAPP &STACK LIFO C &USR D &4 MODE &5
TAPEXAPP &STACK LIFO A &USR D &4 L &2 &3
&IF &DELFLG NE 0 TAPEXAPP &STACK LIFO D &USR D &4
&GOTO -XLOOP
-XMDISK &MDS = &MDS + 1
&IF &MDS GT 20 &GOTO -MDSERR
&M&MDS = &2
&S = &SUBSTR &6 1 3
&IF &S EQ TYM &GOTO -XLOOP2
&IF &S EQ C40 &GOTO -XLOOP2
&IF &S EQ C41 &GOTO -XLOOP2
&IF &S EQ V42 &GOTO -XLOOP2
&IF &S EQ V43 &GOTO -XLOOP2
-XMD &M&MDS = NONE
&MDS = &MDS - 1
&TYPE MDISK &2 IS ON PACK &6 . IT IS A SPECIAL PACK OR A SPECIAL DASD
&TYPE AND WILL BE IGNORED.
&GOTO -XLOOP
-XLOOP2 &IF &2 EQ 190 &GOTO -XMD
&IF &2 EQ 19E &GOTO -XMD
&IF &INDEX GT 7 TAPEXAPP &STACK LIFO C &USR D &2 PA &8 &9 &10
&IF &2 NE 191 &GOTO -XDISK19
TAPEXAPP &STACK LIFO YES
TAPEXAPP &STACK LIFO
TAPEXAPP &STACK LIFO PLEASE ENTER A MAIL ADDRESS.
-XDISK19 TAPEXAPP &STACK LIFO A &USR D &2 M &5
&GOTO -XLOOP
-XSPECIA &IF &3 NE TIMER &GOTO -XBADCAR
TAPEXAPP &STACK LIFO A &USR D &2 TIMER
&GOTO -XLOOP
-XSPOOL &IF &2 EQ 00C &IF &3 EQ 2540 &IF &4 EQ R &GOTO -XLOOP
&IF &2 EQ 00D &IF &3 EQ 2540 &IF &4 EQ P &GOTO -XLOOP
&IF &2 EQ 00E &IF &3 EQ 1403 &GOTO -XLOOP
* THIS IGNORES SPOOL CLASS
&GOTO -XBADCAR
-XCONSOL &IF &2 EQ 009 &IF &3 EQ 3215 &GOTO -XLOOP
* CAN BE CHANGED TO HANDLE CONSOLE AT 01F
&GOTO -XBADCAR
-XTZONE &TZ = &&INDEX
&IF &TZ EQ PST &TZ = PDT
&GOTO -XLOOP
-XIPL &IPL = 1
&IF &2 NE CMS TAPEXAPP &STACK LIFO C &USR IPL &2
&GOTO -XLOOP
-XLICENS &IF &INDEX GT 3 &GOTO -XREALLI
&IF &INDEX EQ 3 &IF &2 NE TYMSHARE &GOTO -XREALLI
&IF &&INDEX EQ PREMIUM &GOTO -XLOOP
-XREALLI &TYPE LICENSE &2 &3 &4 &5 FOR &USR MUST BE GIVEN
&TYPE BY SYSTEMS SUPPORT.
&GOTO -XLOOP
-XOPTION &IF &INDEX EQ 2 &IF &2 EQ PARMAUTO &GOTO -XLOOP
&TYPE OPTIONS &2 &3 &4 &5 &6 MUST BE GIVEN BY SYSTEMS SUPPORT.
&GOTO -XLOOP
-XACCOUN &UUN = &2
&GAN = &3
&DIST = &4
&GOTO -XLOOP
-XUSER &IF &4 NE 320K TAPEXAPP &STACK LIFO C &USR CORE &4
&IF &5 NE 1536K TAPEXAPP &STACK LIFO C &USR MAX &5
&X = &SUBSTR &6 1 1
&IF &X NE G &TYPE PRIVILEG CLASS &6 MUST BE GIVEN BY SYSTEMS SUPPORT.
&INT = EXT
&IF &6 NE G &INT = INT
TAPEXAPP &STACK LIFO A &USR U &UUN &GAN &DIST &TZ &INT 0
-XUSER1 TAPEXAPP USERDEF
TAPEXAPP &IF &LITERAL &RETCODE EQ 0 &GOTO -XCONT7
&MDS = 0
&MDS8 = 0
&STACK HT
-TFSF &MDS = &MDS + 1
&MDS8 = &MDS8 + 1
&IF &M&MDS EQ NONE &GOTO -TFSDN
&DMPMDSK = &M&MDS
EXEC SLINK &USR &DMPMDSK 291 M
&IF &RETCODE EQ 0 &GOTO -XNEWH
&STACK RT
&TYPE RETURN CODE &RETCODE
&STACK HT
&GOTO -XLKERR
-XNEWH SEERHS OFF
ACCESS 291 F
&IF &RETCODE EQ 0 &GOTO -XNEWHH
&STACK RT
&TYPE RETURN CODE &RETCODE
&STACK HT
&GOTO -XACCERR
-XNEWHH LIST * * F (EXEC
&IF &RETCODE EQ 0 &GOTO -TFSF
&MDS8 = &MDS8 - 1
&GOTO -TFSF
-TFSDN &STACK RT
REL F
CP .DET 291
TAPEXAPP TAPE FSF &MDS8
TAPEXAPP &TYPE USERDEF ERROR. SKIPPING FILES IF EXIST.
TAPEXAPP CONWAIT
TAPEXAPP DESBUF
TAPEXAPP &EXIT
&DMPMD2 = &DMPMDSK
TAPEXAPP -XCONT7 &TYPE USER &USR SET UP.
TAPEXAPP &TYPE ******** -------- ********
-XUSER4 TAPEXAPP TAPE FSF 1
TAPEXAPP &GOTO -XCONT
&DMPMD2 = &DMPMDSK
TAPEXAPP -XSETUP &TYPE USER &USR &DMPMD2 WAS ALREADY SET UP. SKIP FILES.
TAPEXAPP TAPE FSF &MDS8
TAPEXAPP &EXIT
TAPEXAPP -XCONT
&FI3 = 0
&MDS = 0
&STACK HT
-XDMPMDS
&MDS = &MDS + 1
&IF &MDS GT 20 &GOTO -XFINIS
&IF &M&MDS EQ NONE &GOTO -XFINIS
&DMPMDSK = &M&MDS
EXEC SLINK &USR &DMPMDSK 291 M
&IF &RETCODE EQ 0 &GOTO -XDMP3
&STACK RT
&TYPE RETURN CODE &RETCODE
&STACK HT
&FILNUM = &FILNUM - &FI3
&GOTO -XLKERR
-XDMP3
SEERHS OFF
ACCESS 291 F
&IF &RETCODE EQ 0 &GOTO -XDMP4
&STACK RT
&TYPE RETURN CODE &RETCODE
&STACK HT
&FILNUM = &FILNUM - &FI3
&GOTO -XACCERR
-XDMP4 LIST * * F (EXEC
&IF &RETCODE NE 0 &GOTO -XDMPMDS
REL F
CP .DET 291
&ERROR &CONTINUE
&CONTROL ERROR
&FILNUM = &FILNUM + 1
&FI3 = &FI3 + 1
TAPEXAPP -TP&FI3
TAPEXAPP &TYPE ******** -------- ********
TAPEXAPP &TYPE RESTORE ALL FILES TAPE FILE &FILNUM FOR &USR &DMPMDSK
TAPEXAPP EXEC SLINK &USR &DMPMDSK 291 W
TAPEXAPP &IF &LITERAL &RETCODE NE 0 &GOTO -XEND
TAPEXAPP &CONTROL ERROR
TAPEXAPP ACCESS 291 F
TAPEXAPP TAPE LOAD * * F (NOPRINT 9TRACK DEN &DENSITY
TAPEXAPP &IF &LITERAL &RETCODE EQ 0 &GOTO -XMT&FI3
TAPEXAPP &TYPE ERROR IN LOADING FILES FOR &USR &DMPMDSK
TAPEXAPP &TYPE RETURN CODE &LITERAL &RETCODE
TAPEXAPP TAPE REW
TAPEXAPP &TYPE TAPE REWIND EXECUTED
TAPEXAPP &TYPE YOU..... MUST REPOSIT -ION THE TAPE.
TAPEXAPP &STACK HT
TAPEXAPP REL F
TAPEXAPP CP .DET 291
TAPEXAPP &STACK RT
TAPEXAPP &EXIT
TAPEXAPP -XMT&FI3
TAPEXAPP Q DISK F
TAPEXAPP REL F
TAPEXAPP CP .DET 291
TAPEXAPP &TYPE FILES RESTORED TO &USR &DMPMDSK
TAPEXAPP &TYPE ******** -------- ********
&FIX = &FI3 + 1
TAPEXAPP &GOTO -TP&FIX
&IF &FI3 NE 1 &GOTO -XDMPMDS
TAPEXAPP -XEND &TYPE CANNOT RESTORE FILES FOR &USR
TAPEXAPP &TYPE SOMEONE HAS WRITE ACCESS OR READ ACCESS OR DASD
TAPEXAPP &TYPE &DMPMDSK DOES NOT EXIT.
TAPEXAPP TAPE REW
TAPEXAPP &TYPE TAPE REWIND EXECUTED
TAPEXAPP &TYPE YOU... MUST REPOSIT -ION THE TAPE.
TAPEXAPP &STACK HT
TAPEXAPP REL F
TAPEXAPP CP .DET 291
TAPEXAPP &STACK RT
TAPEXAPP &EXIT
&GOTO -XDMPMDS
-XFINIS &STACK HT
REL F
CP .DET 291
&STACK RT
TAPEXAPP -TP&FIX &EXIT
&FILNUM = &FILNUM - &FI3
FINIS TAPEXC EXEC
TAPE DUMP TAPEXC EXEC A ( NOPRINT 9TRACK DEN &DENSITY BLOCK 10
&IF &RETCODE EQ 0 &GOTO -XCONT3
&TYPE RETURN CODE &RETCODE
&FILNUM = &FILNUM - 1
&IF &FILNUM NE 0 &GOTO -XCONT4
TAPE REW
&DMPMDSK = TAPEXC
&GOTO -XTDUMP
-XCONT4 TAPE BSF 1
TAPE FSF 1
&DMPMDSK = TAPEXC
&GOTO -XTDUMP
-XCONT3 TAPE WTM
&TYPE ******** -------- ********
&TYPE DUMPED TAPEXC EXEC TAPE FILE &FILNUM FOR &USR
&FILNUM5 = 2
&MDS = 0
&STACK HT
-XCONT7
REL F
CP .DET 291
&MDS = &MDS + 1
&IF &MDS GT 20 &GOTO -ANOTH
&IF &M&MDS EQ NONE &GOTO -ANOTH
&DMPMDSK = &M&MDS
EXEC SLINK &USR &DMPMDSK 291 M
&IF &RETCODE EQ 0 &GOTO -XCT3
&STACK RT
&TYPE RETURN CODE &RETCODE
&STACK HT
&IF &FILNUM GT &FILNUM5 &GOTO -XCT6
&IF &FILNUM EQ &FILNUM5 &GOTO -XCT6
TAPE REW
&GOTO -XLKERR
-XCT6
TAPE BSF &FILNUM5
TAPE FSF 1
&GOTO -XLKERR
-XCT3
SEERHS OFF
ACCESS 291 F
&IF &RETCODE EQ 0 &GOTO -XCT4
&STACK RT
&TYPE RETURN CODE &RETCODE
&STACK HT
&IF &FILNUM GT &FILNUM5 &GOTO -XCT5
&IF &FILNUM EQ &FILNUM5 &GOTO -XCT5
TAPE REW
&GOTO -XACCERR
-XCT5
TAPE BSF &FILNUM5
TAPE FSF 1
&GOTO -XACCERR
-XCT4
LIST * * F (EXEC
&IF &RETCODE NE 0 &GOTO -XCONT7
&FILNUM = &FILNUM + 1
&FILNUM5 = &FILNUM5 + 1
TAPE DUMP * * F ( NOPRINT 9TRACK DEN &DENSITY BLOCK 10
&IF &RETCODE EQ 0 &GOTO -XCONT2
&STACK RT
&TYPE RETURN CODE &RETCODE
&STACK HT
&FILN2 = &FILNUM5 - 1
&FILNUM = &FILNUM - &FILN2
&IF &FILNUM NE 0 &GOTO -XCONT5
TAPE REW
&GOTO -XTDUMP
-XCONT5 TAPE BSF &FILN2
TAPE FSF 1
&GOTO -XTDUMP
-XCONT2 TAPE WTM
&STACK RT
&TYPE ******** -------- ********
&TYPE DUMPED ALL FILES TAPE FILE &FILNUM FOR &USR &DMPMDSK
Q DISK F
REL F
CP .DET 291
&STACK HT
&GOTO -XCONT7
-XLKERR &STACK RT
&TYPE LINK PROBLEM WITH MDISK &USR &DMPMDSK
&FILNUM = &FILNUM - 1
&STACK HT
REL F
CP .DET 291
&GOTO -ANOTH
-XACCERR &STACK RT
&TYPE ACCESS PROBLEM WITH MDISK &USR &DMPMDSK
&FILNUM = &FILNUM - 1
&STACK HT
REL F
CP .DET 291
&GOTO -ANOTH
-XTDUMP &SRT
&TYPE TAPE DUMP PROBLEM WITH  &USR &DMPMDSK
&STACK HT
REL F
CP .DET 291
&GOTO -ANOTH
-MDSERR &TYPE MORE THAN 20 MDISKS CANNOT HANDLE.
&FILNUM = &FILNUM - 1
CONWAIT
DESBUF
&GOTO -ANOTH
-FILEMIS &STACK RT
&TYPE THE FILE: SEERHS MODULE OR TAPEXAPP MODULE IS MISSING.
&EXIT
   N}64