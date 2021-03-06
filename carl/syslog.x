begin "SysLOG - System Message Logger"

  require "(sailib)sail.def"   source!file;
  require "(sailib)uuosym.def" source!file;
  require "(carl)esctrp.req"   source!file;
  require "(carl)logpkg.req"   source!file;
  require "(sailib)vmfile.req" source!file;
  require "(carl)daytim.req"   source!file;

  require '1 lsh 24 lor ( "@"-"@" ) lsh 18 lor '0 version;

define	PEEK(x) = { Calli( !bit(0) lor (x), calli!VPEEK ) }
,	Gettab( idx, tbl ) = {( calli( !xwd( idx, tbl ), calli!GETTAB ) )}
;

define LogDir = { (if memory[!jbDDT] then "(CARL)" else "(SRA)") };	! { "(SRA)" };

define Addit( x ) = { quick!code Aos x end };
define Subit( x ) = { quick!code Sos x end };

! globals ;

integer
	V,				! value ;
	OldZone,			! old time zone ;
	CTYChan,			! channel for file ;
	SaveCTY,			! saved CTY pointer value ;
	SysNum,				! system host number ;
	SysSlot, SysSize,		! file slot and size for data ;
	SleepTime,			! seconds to sleep between scans ;
	Phy!Memory,			! size of physical memory ;
	Mon!Memory,			! size of monitor memory ;
	Mon!Ports,			! maximum # ports on system ;
	Mon!Jobs,			! maximum # jobs for system ;
	SerialNumber;			! serial number this cpu ;

own integer lastC;			! last character seen ;

string  File.Name, OldCty;

define CtyPtr = 511+2+1;
safe integer array CTY[ -5:CtyPtr ];



own integer MyLen, MyPtr, MyChr;
own integer CtyP, CtyC, CtyH;

define LineLen = (64 * 40);	! constant length = 2560(*) ;
preset!with
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &

    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################" &
    "################################################################";
Own String array Line[0:0];


!	Initialization support
;

simple procedure SetZone;		! set timezone to GMT ;
begin
    own integer Zone;

    OldZone_ Zone_ Gettab( -1,!gtPRV );
    dpb( '20, point( 6,Zone,7 ) );
    calli( jp!nat lor Zone, calli!SETPRV );

end;
require SetZone initialization;


simple procedure SetMyLog;
SetLog( LogDir & "SysLOG."& TymDay( GetTDT )[4 for 3] );

require SetMyLog initialization;


! System initialization ;

simple procedure InitSystem;
begin "initialization"

!    Sys_ cvstr( Gettab( 0,!gtCNF )) & cvstr( Gettab( 1,!gtCNF )) &
!	 cvstr( Gettab( 2,!gtCNF )) & cvstr( Gettab( 3,!gtCNF )) &
!	 cvstr( Gettab( 4,!gtCNF ));
!    while ( length( Sys ) and ( Sys[inf for 1] = 0 ) )
!     do Sys_ Sys[1 to inf-1];

    SerialNumber_ Gettab( !cnSER, !gtCNF );
    SysNum_       Gettab( !cnSYS, !gtCNF );
    Mon!Jobs_     Gettab( !cnNJB, !gtCNF );
    Mon!Memory_   Gettab( !cnSIZ, !gtCNF ) div 512;
    Phy!Memory_   Gettab( !nsMMS, !gtNSW ) div 512;

    SleepTime_ 15;

    arrClr( Blockio ); arrClr( CharsIn ); arrClr( CharsOut );
    arrClr( cmph );    arrClr( cmp );
    arrClr( DDB );     arrClr( Unit );

    ! Initialize the function code to !sdSPY (or !sdMEM) function '10 ;
    JobCore[-3]_ JobStatus[-3]_ Blockio[-3]_ CharsIn[-3]_ CharsOut[-3]_
    cmph[-3]_ cmp[-3]_
							     '10;

    DDB[-3]_ !sdDDA;			! function to read DDBs ;
    Unit[-3]_ !bit(0) lor !sdUNI;	! function to read UDB ;

    ! Set the start address to the table address from !gtSLF ;

    JobCore[-2]_   Gettab(   '100, !gtSLF );	! pages,,UPT address ;
    JobStatus[-2]_ Gettab( !gtSTS, !gtSLF );	! job status ;
    Blockio[-2]_   Gettab( !gtBIO, !gtSLF );	! block io characters ;
    CharsIn[-2]_   Gettab( !gtCIN, !gtSLF );	! scnser chars in ;
    CharsOut[-2]_  Gettab( !gtCOT, !gtSLF );	! scnser chars out ;

    cmph[-2]_      Gettab( !gtMC2, !gtSLF );	! high microcycles ;
    cmp[-2]_       Gettab( !gtMC1, !gtSLF );	! low  microcycles ;

    Data[ r.SysId ]_
	(((Phy!Memory-1) lsh -5) lsh 28) lor ! physical memory in 16K increments ;
	( SerialNumber lsh 15 )  lor	! system APR serial number ;
	( SysNum )			! TYMNET host number ;

end "initialization";


! Information about the system
;

simple procedure System;
begin "system info"
    own integer Job, AllJob, AllCore, AllTTY;

    Data[ r.Daytime ]_ GetUDT;			! current day-time ;		! current time ;
    Data[ r.Uptime  ]_ Gettab( !nsUPT,!gtNSW );	! system uptime ;

    calli( !xwd( 128+3, location(cmph[-3]) ),      calli!SYSDVF );
    calli( !xwd( 128+3, location( cmp[-3]) ),      calli!SYSDVF );

    calli( !xwd( 128+3, location(JobStatus[-3]) ), calli!SYSDVF );
    calli( !xwd( 128+3, location(  JobCore[-3]) ), calli!SYSDVF );

    calli( !xwd( 128+3, location( Blockio[-3]) ),  calli!SYSDVF );
    calli( !xwd( 128+3, location( CharsIn[-3]) ),  calli!SYSDVF );
    calli( !xwd( 128+3, location(CharsOut[-3]) ),  calli!SYSDVF );

    AllJob_ AllCore_ 0;

    for Job_ 1 upto Mon!Jobs
     do begin "each job slot"

	if not( JobStatus[Job] land jb!jna )	! jna = 0 ? ;
	 then continue "each job slot";

	AllJob_ AllJob + 1;
	AllCore_ AllCore + ( !lh(JobCore[Job]) land '777 );

     end "each job slot";

    DDB[-2]_ AllTTY_ 0;			! start at the beginning ;
    do begin
	calli( !xwd( '1+1+3, location(DDB[-3]) ), calli!SYSDVF );
	if ( DDB[ -2 ] ) and
	    ( ( ( DDB[ 0 ] XOR cvSIX("TTY") ) lsh -18 ) = 0 ) and
	    ( DDB[ 1 ] lsh -30 )
	 then AllTTY_ AllTTY + 1;

    end until DDB[ -2 ] = 0;

    Data[ r.Usage   ]_ (AllJob lsh 27) lor (AllTTY lsh 18) lor AllCore;
    Data[ r.Mcy.h   ]_ cmph[0];		! high-order * 2.0^35 ;
    Data[ r.Mcy.l   ]_ cmp[0];		! remember ~400000 uCycles/Sec ;

    Data[ r.Base.i  ]_ CharsIn[0];	! scnser base chars in  ;
    Data[ r.Base.o  ]_ CharsOut[0];	! scnser base chars out ;
    Data[ r.Base.bio]_ Blockio[0];	! block-io 80 chars/buffer ;


  end "system info";

! Disk info
;

simple procedure Disk;
begin "install disk info"
    integer Drive, BPT;
    integer Free, Pages, URead, UWrite, MRead, MWrite, PRead, PWrite;

    Unit[-2]_ 0;			! start at the beginning ;

    Drive_ Free_ Pages_ URead_ UWrite_ MRead_ MWrite_ PRead_ PWrite_ 0;
    while ( true )
     do begin "every unit";

	calli( !xwd( UNITAL+1+3, location(Unit[-3]) ), calli!SYSDVF );

	if ( Unit[-2] = 0 )		! if this unit is blank ;
	 then done;			!  we are finished ;

	Free_   Free   + Unit[UNITAL];
	Pages_  Pages  + Unit[UNIPPU];
	URead_  URead  + Unit[UNIBRC]+Unit[UNIDRC];
	UWrite_ UWrite + Unit[UNIBWC]+Unit[UNIDWC];
	MRead_  MRead  + Unit[UNIMRC];
	MWrite_ MWrite + Unit[UNIMWC];
	PRead_  PRead  + Unit[UNIICT];
	PWrite_ PWrite + Unit[UNIOCT];

	BPT_ ldb( point( 8, Unit[UNICHR], 17 ) );
	Drive_ Drive + 1;	! increment drive for storage array ;

      end "every unit";

    Data[ r.Free      ]_ (Drive lsh 30) lor (BPT lsh 25) lor Free;
    Data[ r.User.i    ]_ URead;
    Data[ r.User.o    ]_ UWrite;
    Data[ r.Monitor.i ]_ MRead;
    Data[ r.Monitor.o ]_ MWrite;
    Data[ r.Paging.i  ]_ PRead;
    Data[ r.Paging.o  ]_ PWrite;

end "install disk info";


simple procedure DateLine;
begin "date line"
    own string Time;

    ! "hh:mm:ss<sp>"  ;
    Time_ TymDay( GetTDT )[11 for 8] & #sp;

    while length( Time )
     do idpb( lop( Time ), MyPtr );

    MyLen_ MyLen + 8+1;

end "date line";



simple string procedure CtyName;
return( CtyDir & "CTYLOG."& TymDay( GetTDT )[4 for 3] );



simple procedure CTYMessage( string Text );
begin "CTY message"
    string Str1,Str2;

    if ( 0 > CtyChan_ VMFile( CtyName, VM$Update lor VM$Append, 1, '377 ) )
     then return;

    Str1_ (Str2_ TymDay( GetTDT ))[11 for 8];

    VMText( CtyChan, crlf &
              Str1 & " -------------------------------------------------"&crlf&
              Str1 & " " & Str2[1 for 9] & #ht & Text & crlf &
	      Str1 & " -------------------------------------------------"&crlf&
	      crlf
	);

    VMFree( CtyChan );

end "CTY message";


simple procedure CTYrec;
begin "log to CTY"

    CTY[ -5 ]_ !bit(0) lor 6;		! SYSDVF function 6 ;
    CTY[ -4 ]_ cvSIX( "CTYBUF" );	! return cty log ;

    calli( !xwd( CtyPtr+1+5, location(CTY[-5]) ), calli!SYSDVF );
    if  ( CTY[ -2 ]       neq cvSIX( "CTYBUF" ) ) or
	( CTY[ CtyPtr-2 ] neq cvSIX( "CTYPTR" ) )
     then return;

    if ( SaveCTY = CtyH_ CTY[CtyPtr] )	! if they match ;
     then return;			!  nothing to do for now ;

    MyPtr_ !Xwd( '440700, memory[location(Line[0])] );
    MyLen_ 0;				! length of constant ;

    if not( V_ SaveCTY )		! any saved CTY pointer ;
     then begin "new cycle"
	if ( !rh( CtyH ) > '777 )	! no, have we wrapped? ;
	 then V_ CtyH - '1000		! yes, use oldest byte ;
	 else V_ point(7,memory[0],-1);	!  no, so init pointer ;
	lastC_ #lf;			! imagine previous LF! ;
     end "new cycle";

    if not kequ(CtyName,OldCty) 	! Name changes at first of the month ;
     then CtyMessage( "*** Start of Log File ***" );
    if ( 0 > CtyChan_ VMFile(OldCty_CtyName,VM$Update lor VM$Append, 1, '377))
     then return;


    CtyC_ 0;				! start with a clean slate ;
    CtyP_ V;				! make a working copy ;
    while ( CtyP neq CtyH )
     do start!code
	IBP	CtyP;			! position cursor ;
	Aos	CtyC;			! one char at a time ;
     end;

    if ( CtyC > '5000 )
     then CtyMessage( "*** Lost CTY data - buffer overwrite ***" );


    while ( V neq CtyH )		! look for a match ;
     do begin "proc chars"

	IBP( V );			! bump pointer for match ;
	if not( CtyC_ ldb( CtyP_ (V land lnot '777000)+location(CTY[0]) ) )
	 then continue;			! skip if null ;

	if ( lastC = #lf )		! after lf, remember to ;
	 then DateLine;			!  date-stamp each line ;

	idpb( lastC_ CtyC, MyPtr );	! deposit byte ;

	if ( (LineLen-30) geq MyLen_ MyLen + 1 )
	 then begin "overflow"
	    VMText( CtyChan, Line[0][1 for MyLen] );
	    MyPtr_ !xwd( '440700, memory[location(Line[0])] );
	    MyLen_ 0;			! reset counter ;
	 end "overflow";

     end "proc chars";

    VMText( CtyChan, Line[0][1 for MyLen] );
    VMFree( CtyChan );

    SaveCTY_ CtyH;			! remember where we are ;

end "log to CTY";


simple procedure MakeEntry;
begin "make an entry"

    TIM!_ false;			! clear timer flag ;
    SetTim( (if memory[!jbDDT]
	      then 1
	      else 15), 2 );		! set timer for next pass ;

    System;				! gather system data ;
    Disk;				! gather disk data ;
    SetMyLog;				! set proper logfile ;
    LogBin( Data );			! log binary data ;

end "make an entry";

! Top level logic
;

    if ( ( Gettab( -1, !gtLIC ) land ( LC!SY lor LC!OP lor LC!RC ) )
	 xor ( LC!SY lor LC!OP lor LC!RC )  )
     then usererr( 0,0,"Requires RC OP SY and HF", "x" );

    ExcIni;				! turn on escapes, time, ntq ;
    InitSystem;				! get initial system info ;
    MakeEntry;				! make entry and start clock ;

    OldCty_ CtyName;
    CtyMessage( "*** Begin Logging ***" );
! [JMS] At this point, we want to read SYS:CTYLOG.TMP, append its data ;
! (which COPYCR extracted from the crash), then delete SYS:CTYLOG.TMP. ;
!   CtyMessage( "*** End of Crash Dump Log ***" );
    SaveCTY_ 0;				! initialize pointer ;
    CTYrec;				! log any CTY activity ;

    while ( true )			! while system still running ;
     do begin "main loop"

	calli( !xwd( 1, 10 ), '72 );	! hiber for 10 seconds ;

	if ( TIM! )			! if timer went off ;
	 then MakeEntry;		!  log the entry ;

	CTYrec;				! log any CTY activity ;

	if ( NTQ! or ESC! )
	 then done "main loop";

     end "main loop";

    MakeEntry;				! make one last entry ;
    calli( OldZone, calli!SETPRV );	! reset time zone ;
    call(0,"EXIT");			! always exit, if NTQ! will LOGOUT ;

end "SysLOG - System Data Monitor";
    