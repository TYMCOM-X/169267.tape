COMMON:
FRECOR[FCWDS*3
FILFND:
CRESP0+3/JRST PAT
PAT/POP P,T2
POP P,T1
JRST GIVCBR
PAT:
MAPIO:
MAPKN7+1/JRST PAT	
FILFND:
PAT/PUSHJ P,INSSPT
MAPIO:
SKIPA
JRST MAPKN7+2
PUSH P,T2
PUSHJ P,RELSAT
POP P,T2
AOS FCREQ
PUSHJ P,FCWAIT
SOS FCREQ
TLO T2,200000
JRST MAPKN2+1
PAT:
FILFND:
SPTRET-1/JRST PAT
PAT/AOS (P)
PUSHJ P,GIVCBR
JRST SPTRET
PAT:
CONFIG 2[Q+"/01/-"/00/
  