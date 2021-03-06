:---------------------------------------------------------------------
: Patch name:  CANFRD                Product and Version:  CMH 1.07
:     Author:  BOB CARHART                  Organization:  NTD
:   Customer:  UKNET                        Date Written:  11/14/88
: Description of Problem:  PREVENT LOCKUP INCASE OF CANCEL FIELD READ FROM
: HOST
:---------------------------------------------------------------------

: MODIFIED BY: Phil Sneddon 05/05/89
:              This patch was using LHL instead of LB when accessing SCRELN,
:              consequently the RBT and SBT instructions were overshooting
:              the bit array CFRBIT which by the way was defined incorrectly.
:              It was defined as a HC and should have been HS.  This patch
:              was previously called CMH107.PA0
:
: MODIFIED BY: Julia Riddington  7th June 1989
:              If the circuit from the host is zapped the CFRBIT array is not
:              cleared.(Not all cancel field read sequences are followed by a
:              read sequence)
:              Patch addition ensures bit is cleared when a screen is released
:              back to the pool.
: MODIFIED BY: Chris Long  26th July 1989
:              Change 2 instructions that use symbolic names that reference 
:              the code conversions tables that may be changed via the TYMFILE
:     
:  
        LO      GBLDEF
        LO      ASIU
	LO	SSUB
 
        PATCH(881411,1800,NSC.B/CARHART,INPALT,,$006)
        JAL     R1,PA1PTR,,
        CONPATCH(PA1PTR,,$024)
        LB      R0,SCBBLK+SCRELN,R2,
        CHI     R0,20                 :20 OR GREATER IS OUT OF RANGE
        JLFS    .+8
        LIS     R4,1
        AHM     R4,CFERC1             :RECORD ERROR
        RBT     R0,CFRBIT
        JN      CTLRET,,
        LB      R0,SCBBLK+SCFLAG,R2,
        JR      R1
        CONPATCH(CTLIN3+$024,,$006)
        JAL     R1,PA1PTR,,
        CONPATCH(PA1PTR,,$030)
        JGFS    .+$00A
        SHI     R0,072                :lower case "R"
        J       $002,R1
        CHI     R0,07A                :lower case "Z" - cancel field read
        JN      CTLRET,,
        LB      R1,SCBBLK+SCRELN,R2,
        CHI     R1,20
        JLFS    .+8
        LIS     R4,1
        AHM     R4,CFERC2
        SBT     R1,CFRBIT
        J       CTLRET,,
 
	CONPATCH(V.SCRL+6,,$006)
	JAL	R3,PA1PTR,,
	CONPATCH(PA1PTR,,$00C)
	LB	R0,SCBBLK+SCRELN,R14,
	RBT	R0,CFRBIT
	JR	R3
 
        CONPATCH(PA0PTR,,(2*((NDEVM+$00F)/$010))+6)
CFRBIT  BS      2*((NDEVM+$00F)/$010)
CFERC1  HC      0
CFERC2  HC      0
        ENDPATCH(PROBLEM OF LOCKUP IN CASE OF CANCEL FIELD READ FROM HOST)
    