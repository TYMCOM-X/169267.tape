File 1)	DSK:RDIST.WRS	created: 0152 28-JUN-87
File 2)	DSK:RDIST.SAI	created: 1643 10-JUL-87

1)1	require "(SAILIB)SAIL.DEF" source!file;
****
2)1	require '1 lsh 24 lor '002 version;	comment version 1(2);
2)	require "(SAILIB)SAIL.DEF" source!file;
**************
1)1	require "ARGS.REQ" source!file;
1)	require "AUXLIB.REQ" source!file;
1)	require "(MPL)UUOSYM.SAI" source!file;
****
2)1	require "(WRS)ARGS.REQ" source!file;
2)	require "(WRS)AUXLIB.REQ" source!file;
2)	require "(MPL)UUOSYM.SAI" source!file;
**************
1)	item LISTONLY;
1)	string item LOGFILE;
1)	string item NAMES;
1)	item CHECK;
1)	string item HOSTS;
1)	integer item RETRIES;
1)	integer item TIMEOUT;
1)	item TRACE;
1)	string item USER;
1)	item VERBOSE;
1)	set AllFiles;
1)	string MASTER;
****
2)	string item LOGFILE;
2)	string item NAMES;
2)	        item CHECK;
2)	 string item HOSTS;
2)	        item LISTONLY;
2)	 string item MASTER;
2)	integer item RETRIES;
2)	integer item TIMEOUT;
2)	        item TRACE;
2)	 string item USER;
2)	        item VERBOSE;
2)	set AllFiles;
**************
1)3		while 0 < i_wordin(chan) do
1)		    if i land '1000000000 then
****
2)3		while -1 neq i_wordin(chan) do		! Stop at -1, not 1B0;
2)		    if i land '1000000000 then
**************
1)3		    	HostTab[h_h+1] _ i land '777777;
****
2)3				! The master system should be excluded here;
2)		    	HostTab[h_h+1] _ i land '777777;
**************
1)5	    auxOut( "SET LOGOUT"& #lf& "TTY NO CRLF"& #lf );
1)	    return( true );
****
2)5	    ! Send one CR for "project code" and another for "attach to job?";
2)	    auxOut( #cr& #cr& "SET LOGOUT"& #cr& "TTY NO CRLF"& #cr );
2)	    return( true );
**************
1)6	    auxOut( "R(SPL)FINDIT"&#lf );
1)	    auxSync( #lf& "Find file: " );
****
2)6	    auxOut( "R(SPL)FINDIT"&#cr );
2)	    auxSync( #lf& "Find file: " );
**************
1)6	    auxOut( NAMES&#lf );
1)	    auxSync( #lf );
****
2)6	    auxOut( NAMES&#cr );
2)	    auxSync( #lf );
**************
1)7	    S := S[1 to 14]& "*"& S[19 to 30]& ","& S[1 to 30];
1)	    cprint( TEL.COM, scan( S, noBlank, !SKIP! ), crlf );
****
2)7	    S := S[1 to 14]& datum(MASTER)& S[19 to 30]& ","& S[1 to 30];
2)	    cprint( TEL.COM, scan( S, noBlank, !SKIP! ), crlf );
**************
1)8	    Login( USER, cvd(MASTER) );
1)	    Findit( NAMES, Build );
****
2)8	    Login( USER, cvd(datum(MASTER)) );
2)	    Findit( NAMES, Build );
**************
1)10	    MASTER := cvs(calli(!xwd(!CNSYS,!GTCNF),calli!GETTAB));
1)	    datum(RETRIES) := 5;
****
2)10	    datum(MASTER) := cvs(calli(!xwd(!CNSYS,!GTCNF),calli!GETTAB));
2)	    datum(RETRIES) := 5;
**************
1)10		{CHECK,HOSTS,LISTONLY,RETRIES,TIMEOUT,TRACE,USER,VERBOSE},
1)		ARGS );
****
2)10		{CHECK,HOSTS,LISTONLY,MASTER,RETRIES,TIMEOUT,TRACE,USER,VERBOSE},
2)		ARGS );
**************
1)10		print( "Master host: ", MASTER, crlf );
1)		BuildDataBase( datum(USER), datum(NAMES) );
****
2)10		print( "Master host: ", datum(MASTER), crlf );
2)		BuildDataBase( datum(USER), datum(NAMES) );
**************
   