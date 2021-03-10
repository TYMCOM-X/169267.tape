:PARAMETERS NODE=ND0350,CMD=DIR
:$MAIL=$FALSE
SYSNO
PJOB
DAYTIME
; This CTL file rebuilds the BND file for an EBUS gateway.
; The following files must exist:
DIR (EBUS)EBUS02.O02
DIR \NODE\.TYM,\NODE\.T01,\NODE\.CMD,\NODE\.C00,\NODE\.C01,\NODE\.T03,\NODE\.C03
DIR GGISIS.LTD,GGXRAY.LTD

; Create the ISIS Kernel from NDxxxx.TYM
R (SYS)NONAD
;X\NODE\.CMD

; Create the node code for slot 0 from NDxxxx.TYM
R (SYS)NONAD
;X\NODE\.C00

; Create the Engine code that runs in Slot 1 from NDxxxx.T01
; Note that the 68K code in slot 2 is the same in all bases.
R (SYS)NONAD
;X\NODE\.C01

; Create the gateway code for slot 3.
R (SYS)NONAD
;X\NODE\.C03

; Build BND file.
R (SYS)MERLIN
\NODE\.BND=\NODE\.NIB,\NODE\.N00,\NODE\.N01,(EBUS)EBUS02.O02/S,\NODE\.N03

; The NIB files are not needed and can be deleted.
\CMD\ \NODE\.NIB,\NODE\.N00,\NODE\.N01,\NODE\.N03
R (SYS)CKSUM
\NODE\.*

; End of EBUSGW.CTL
DIR \NODE\.BND
    