 "\ Patches for the P035/E monitor. \

 "\ LUD.PAT, 19-Sep-89, patch #1 for P035/E, JMS \
 "\ Follow the link to the overflow blocks in the LUD correctly. \
FILUUO:
USRUSI+5/MOVEI T2,1(T2)
BLKLNK+4/SOJL P1,LUDER1
BLKLNK+5/SOJA T2,USRUSI
COMMON:
PATMAP[Q+200000,,0
CONFIG+1T/ CONFIG+2T/"/-1/
   