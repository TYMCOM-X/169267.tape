:LOGFILE FNDBAD.LOG
COPY (SYS)JQUEUE.SYS,(SYS)JQUEUE.OLD
DAYTIM
RUN (MPL)FNDBAD
FNDBAD.RPT
DECLARE ALL RD RD FNDBAD.RPT
MAKE (OPER)ACCESS.MSG
ERFNDBAD.RPT A A <SNFS; 0L T K>EX
DECLARE ALL RD RD (OPER)ACCESS.MSG
TYPE (OPER)ACCESS.MSG
CORE
PJOB
DAYTIM
   