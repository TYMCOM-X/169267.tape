:	Patch by:	D Moncur (MDCSC)
:	NSR number:	
:	Version:	MBASE 2.01
:	Description:
: Patch to ensure that the Leave Transparency Mode cct signal is sent to ISIS.
: LTM is sent to MBASE by IOP as part of the Pegasus-originated wrapup
: sequence. Unlike the Yellow Ball (Gobbler) and ZAP which follow it,
: the LTM is deferred if the previous output operation was incomplete.
: This patch gives the LTM the same status as YB and ZAP so that the wrapup
: process can complete regardless of what happened previously.
: This addresses the 1541.146 Port Hangs at Travis Perkins
:
PATCH(110592,1207,DMONCUR,DOWRIT+22,,6)
	J 	PA1PTR,,
CONPATCH(PA1PTR,,14)
	CLB	R2,GOBMSG,R3	: Gobbler ?
	JE	DOWT02		: Send it
	CLB	R2,LTMMSG,R3	: Leave Transparency Mode ?
	JE	DOWT02		: Send it
	J	DOWT05		: Else defer it
ENDPATCH(DOWRIT to forward LTM to ISIS during wrapup)
  