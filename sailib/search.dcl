0010�	external record!class fsm ( integer state0, state );
0020�	
  0030�	external record!pointer (fsm) procedure makFsm( integer array equivs;
   0040�				reference record!pointer (any!class) find );
0050�	
  0060�	external record!pointer (any!class) procedure useFsm(
    0070�				record!pointer (fsm) state;
  0080�				reference integer count, bytepointer );
0090�	
  0100�	external record!pointer (any!class) procedure useFst(
    0110�				record!pointer (fsm) state;
  0120�				reference string datastr );
  0130�	
  0140�	external record!pointer (fsm) procedure mksfsm( integer array equivs;
                            0150�			reference set targetSet; boolean usePnames(FALSE) );
   0160�	
  0170�	external set procedure ussFsm( record!pointer (fsm) state;
    0180�				reference integer count, bytepointer );
0190�	
  0200�	external set procedure ussFss( record!pointer (fsm) state;
    0210�				reference string datastr );
  