:LOGFILE RDIST.LOG
:$MAIL=$FALSE
; Step 1: Compare (EBUS:33) with :25 and :54.  Update if needed.
; Step 2: Compare (TYMNET:25) with (TYMNET:33) and compare
;         (TYM5:54) with (TYM5:33).  Any differences will have
;         to be resolved manually.      /Joe Smith
RUN (XEXEC)MINIT
MASQUE EBUS
:COM RDIST1
:COM RDIST2

    