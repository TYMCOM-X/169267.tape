:LOGFILE TECO.LOG
CTEST SETPROC MACRO=(FTSYS)REXMAC,LOADER=(FTSYS)LINKER
COMPILE TECO.ERR=TECERR.MAC
LOAD TECO.MAC/CREF
SSAVE TECO 6K
CROSS
DIRECT TEC???.*/YESTERDAY
  