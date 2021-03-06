From: Paul Krumviede <PKrumv@F33.Tymnet> 
Date: Mon, 2 May 88 18:09:38 PDT 
To: Joe Smith <JMS@F29> 
Subject: EBUS and time 

Joe,
  Ron and I were a bit curious about the simultaneous crashes of the PDP-10s
in Dallas, and noticed that the base on all the machines that were crashed
by the EBUS had been up a bit over 41 days, which is about the resolution of
31 bits of FASTC.  It looks like the half-second logic in the EBUS saw that
FASTC wrapped, and we then got bit by the nature of signed arithmetic on a
68010.  The EBUS decided that a half-second had passed, looked for a key,
etc.  I guess I should change the branch to something other than BLT...
  I hope this resolves the problem.  Ron commented that this was real
familiar.  So we can get about 41 days 10 hours 12 minutes 20 seconds on
a base.

paul
  