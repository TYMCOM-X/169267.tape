:	Patch by:	D Moncur (MDCSC)
:	NSR number:	
:	Version:	MBASE 2.01
:	Description:
: Patch to provide a Done routine specially for DOZPAK. 
: The current Done routine ZAPTOI loops until any queued ZAPs clear,
: which could be forever if the Spirit Bus has already wrapped up.
: DOZPAK requires a ZAP sent to ISIS as soon as the ZAK which it sends
: to the Spirit Bus is known to have arrived. The fact that the Done routine
: has been entered is adequate proof of this.
:
PATCH(270392,1355,DMONCUR,DOZPAK+38,,4)
	LA	R2,ZAKSNT	: SRDONE routine to send ZAP to ISIS
CONPATCH(PA1PTR,,40)
ZAKSNT	STM	R10,PRSSAV,,
	LHI	R2,ZAPTSP	: Flag 'Spirit received a ZAP'
	SBT 	R2,PSTFLG,R15
	LHI	R2,ZAPTIS	
	TBT	R2,PSTFLG,R15	
	JN	ZAKRET		: Exit if ZAP already sent to ISIS
	SBT	R2,PSTFLG,R15	: Flag 'ZAP sent to ISIS'
	L	R14,BUFSAV,R15
	JAL	R13,QBPOUT	: Queue ZAP to ISIS
	LHI	R2,ZAPFIS
	TBT	R2,PSTFLG,R15
	JEFS	ZAKRET		: Exit if no ZAP received from ISIS
	LB	R11,PORT,R15
	JAL	R13,CMPLZP	: Complete the wrapup of ZAP from ISIS
ZAKRET	LM	R10,PRSSAV,,
	JR	R13
ENDPATCH(SRDONE to send ZAP to ISIS after ZAK sent to Spirit)
 