
  IF    VHRSUP

        LO      OSCAN
        LO      BSUB
        LO      GBLDEF
        LO      CBKDEF

PATCH(880519,1200,J/MCKIERNAN,NPOHIN,,06)
        J       PA1PTR,,                : 
CONPATCH(PA1PTR,,044)
        LB      R6,LUCTAB+LUCVHR,R11,   :GET VHR STATE
        THI     R6,LUVHRF               :VHR FUNCTION?
        JE      NPOHI3                  :JUMP IF NOT
        LHL     R12,LUCTAB+LUCDCB,R11,  :GET DCBLKS
        BBL     R3,DCBLKS+DCBLBA,R12,   :GET HEAD OF LOGON BUFFER CHAIN
        JE      NPOHI3                  :SKIP IF EMPTY
        LHI     R6,RLOSCC-PSEG          :GET LOGON MODE
        CLH     R6,LUCTAB+LUOCPR,R11,   :IS IT IN RIGHT STATE?
        JNFS    NPOHI3                  :NO, SKIP
        JAL     R6,DLODBB,,             :ELSE, RELEASE LOGON BUFFERS
        XR      R3,R3
        BBST    R3,DCBLKS+DCBLBA,R12,   :CLEAR HEAD OF LOGON BUFFER CHAIN
NPOHI3
        JAL     R6,GTOCMD,,             :FETCH OUTPUT CMD
        J       NPOHIN+06,,             : 
CONPATCH(NPOHCL,,06)
        J       PA1PTR,,                : 
CONPATCH(PA1PTR,,044)
        LB      R6,LUCTAB+LUCVHR,R11,   :GET VHR STATE
        THI     R6,LUVHRF               :VHR FUNCTION?
        JE      NPOHC5                  :JUMP IF NOT
        LHL     R12,LUCTAB+LUCDCB,R11,  :GET DCBLKS
        BBL     R3,DCBLKS+DCBLBA,R12,   :GET HEAD OF LOGON BUFFER CHAIN
        JE      NPOHC5                  :SKIP IF EMPTY
        LHI     R6,RLOSCC-PSEG          :GET LOGON MODE
        CLH     R6,LUCTAB+LUOCPR,R11,   :IS IT IN RIGHT STATE?
        JNFS    NPOHC5                  :NO, SKIP
        JAL     R6,DLODBB,,             :ELSE, RELEASE LOGON BUFFERS
        XR      R3,R3
        BBST    R3,DCBLKS+DCBLBA,R12,   :CLEAR HEAD OF LOGON BUFFER CHAIN
NPOHC5
        JAL     R6,GTOCMD,,             :FETCH OUTPUT CMD
        J       NPOHCL+06,,             : 
ENDPATCH( Release VHR login buffers when entering DETACHED mode )

        FO      OSCAN
        FO      BSUB
        FO      GBLDEF
        FO      CBKDEF

  EI

 