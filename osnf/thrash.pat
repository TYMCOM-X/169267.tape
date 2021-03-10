:	Patch by:	Simon Wray & David Moncur (MDCSC)
:	NSR number:	
:	Version:	MBASE 2.01
:	Description:
: Patch to prevent MBASE thrashing during the Zap sequence 
:
PATCH(181191,1508,SWRAY,ZAPTOI+18,,6)
	J	PA1PTR,,
CONPATCH(PA1PTR,,12)
	LH	R2,SRDMAX,,
	STH	R2,SRDCNT,,
	J	ZAPRET,,
ENDPATCH(Avoid MBASE thrashing during Zap sequence)
    