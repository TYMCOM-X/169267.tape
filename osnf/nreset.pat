:	Patch by:	D Moncur (MDCSC)
:	NSR number:	
:	Version:	MBASE 2.01
:	Description:
: Patch to avoid reset when flow control is turned on and off rapidly,
: causing Flow-control flag to be flipped after PST queued.
:
PATCH(090591,1221,DMONCUR,CP00+6,,6)
	J	CPRET
ENDPATCH(Avoid RESET during Flow Control)
   