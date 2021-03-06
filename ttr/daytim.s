!   Array Storage ;

Preset!with "-Jan-","-Feb-","-Mar-","-Apr-","-May-","-Jun-",
	    "-Jul-","-Aug-","-Sep-","-Oct-","-Nov-","-Dec-";
Own Safe String  Array MNames[ 0:11 ];		! -names- of months  ;

Preset!with 31,28,31,30,31,30,31,31,30,31,30,31;
Own Safe Integer Array Months[ 0:11 ];		! days in each month ;

Preset!with 366,365,365,365;
Own Safe Integer Array Years[ 0:3 ];		! days in each year  ;


Simple String Procedure CV( Integer Val, Wid(0), Typ(0) );
! ----------------------------------------------------------------------;
!									;
!	CV		ConVert a value "Val" into a numeric string of	;
!			width "Wid" using the conversion method "Typ".	;
!			Solves the problem of setting and resetting	;
!			the width and digits parameters to GETformat	;
!			and SETformat over and over again.		;
!									;
! ----------------------------------------------------------------------;
begin "my own cvxxx"

    Integer Width, Digits;
    Own String Str;

    GetFormat( Width, Digits );
    SetFormat( Wid,0 );

    Str_ Case Typ of ( Cvs( Val ), Cvos( Val) );

    SetFormat( Width, Digits );
    Return( Str );

end "my own cvxxx";


Simple Integer Procedure UTDate( Integer Days, Minutes, Seconds );
! ----------------------------------------------------------------------;
!									;
!	UTDate		Routine to convert a standard Tymshare file	;
!			date into DEC universal date/time format.	;
!			Tymshare uses days since 01-Jan-64 and time	;
!			since midnight.  The universal date/time is	;
!			days since November 18,1858 in the left half	;
!			and fractions of a day in the right half.	;
!									;
! ----------------------------------------------------------------------;
Return( !Xwd( ( Days + 38394 ),
	      (((Minutes * 60) + Seconds ) lsh 18) div (60 * 60 * 24)) );



Simple String Procedure CvUDT( Integer DateTime; Reference Integer DD,MMM,YY,HH,MM,SS );
! ----------------------------------------------------------------------;
!									;
!	CvUDT		Routine to convert a date-time word with the	;
!			date as the number of days since Nov 18, 1858	;
!			in the left half, and the time as a fraction	;
!			of a day in the right half, into a string.	;
!									;
! ----------------------------------------------------------------------;
Return( !Xwd( ( Days + 38394 ),
	      (((Minutes * 60) + Seconds ) lsh 18) div (60 * 60 * 24)) );
begin "date time converter"
    Define OneDay = 1 lsh 18, ZoneOffset = OneDay div 24, ZeroDate = 38394;
    Integer Year, Month, Date, Time, Y, M, N;

    Year_ 1858;  Y_ 0;

    Time_ !Rh( DateTime );
    Date_ !Lh( DateTime );

    If ( TimeZone neq Z$GMT )
     then begin "Convert time zone"
	Time_ Time + ( TimeZone * ZoneOffset );
	If ( Time < 0 )
	 then begin
	    Time_ Time + OneDay;
	    Date_ Date - 1;
	 end
	 else If ( Time geq OneDay )
	       then begin
		  Time_ Time - OneDay;
		  Date_ Date + 1;
	       end;
     end "Convert time zone";

    While ( Years[ Y land '3 ] < Date )
     do begin
	Year_ Year + 1;
	Date_ Date - Years[ Y land '3 ];
	Y_ Y + 1;
     end;

    Month_ 0;
    For M_ 0 step 1 until 11
     do begin
	If ( M neq 1 )  or  ( Y land '3 )
	 then N_ Months[ M ]
	 else N_ Months[ M ] + 1;
	If ( N < Date )
	 then begin
	    Month_ Month + 1;
	    Date_  Date  - N;
	 end
	 else done;
     end;

    Return( Cv( Date, -2 ) & MNames[ Month ] & Cv( Year Mod 100, -2 ) &
	    " " & Cv( Time div 60, -2 ) & ":" & Cv( Time mod 60, -2 ) );

end "date time converter";

 