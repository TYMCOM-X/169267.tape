File 1)	DSK:SYSDAT.A	created: 1300 08-SEP-88
File 2)	DSK:SYSDAT.SAI	created: 1404 26-SEP-88

1)1	  require '2 lsh 24 lor ( "@"-"@" ) lsh 18 lor '20 version;
1)	define	PEEK(x) = { Calli( !bit(0) lor (x), calli!VPEEK ) }
****
2)1	  require '2 lsh 24 lor ( "@"-"@" ) lsh 18 lor '21 version;
2)	define	PEEK(x) = { Calli( !bit(0) lor (x), calli!VPEEK ) }
**************
1)5		( (Phy!Memory - 1) lsh 23 ) lor	! physical memory in 16K increments ;
1)		( SerialNumber     lsh 15 ) lor	! system APR serial number ;
1)		( SysNum )			! TYMNET host number ;
****
2)5		(((Phy!Memory-1) lsh -5) lsh 28) lor ! physical memory in 16K increment s ;
2)		( SerialNumber lsh 15 )  lor	! system APR serial number ;
2)		( SysNum )			! TYMNET host number ;
**************
