                                    TYMNET
                       PRIVATE NETWORK SYSTEMS ANALYSIS
                                  JULY 1988
HOST: F22
===============================================================================
TRUS: Prime-Time Tru's down by 1 million from June's total.
      Non-Prime Tru's up by 150k.
      New user ATFGEN (Rourke McCusker) used 170k NPT trus.
      user FIRNNET tru usage was half of its June total.
      and users ANZNET,DIALNET & FIRNNET all had higher NPT trus
      and less PT trus than June.

CPU : Average CPU up by 3.5%. CPU reached 100% only once on July 13 at 6:34.

PGS : 37k pages were used in July: 
      NSCCODE (+10K), HSBCNET (+6K), UL6CODE (+4K), HOLD (+5K)

HOST: F26
===============================================================================
TRUS: Prime-Time Tru's up 1 million from June.                        
      Non-Prime Tru's up 1 million.                                
         week ending 7/22: user ATFGEN = 200K NPT Trus
         week ending 7/29: user TECHTRAIN = 1.5 million PT Trus

CPU : Average CPU up by .5%, system reached 100% on the following dates:
        7/8 6:30-8:30 > user BILLTEMP program CPAS1
        7/11 12:08-13:18 > user DAUERBACH program NAD had 5 jobs
        simultaneously running, user ATFGEN program PCOM.
        7/28 16:35-17:05 > user TECHTRAIN program CPAS1.
        7/29 7:26-8:06 > user TECHTRAIN program CPAS1.

PGS : 41k pages were used in July:
      VACODE (+13K), BILLING10 (+5K), BETATEST (+4K), UKNET (+5K),
      SCJNET (+4K), C03DEV (+4K) and user SWBNET gave back 12k pages.

HOST: D31
===============================================================================
TRUS: Prime-Time Tru's down 700k from June.
      Non-Prime Time Tru's down by 600k.
        week ending 7/29 user BLARKIN was highest PT user (246k Trus)

CPU : Average CPU down by 1.7%, system reached 100% twice:
      7/28 14:44-15:04 > user BLARKIN program NAD
      7/29  7:47- 8:07 > user BLARKIN program NAD, user TECHTRAIN program CPAS1.

PGS : 5k pages were used in July, system low on free storage.       
      VACODE (+12K), BETATEST (+4K), UKNET (+4K), and the users who
      reduced their directories were: YBERGLUND (-5K), USGSCODE (-4K),
      UKGEN (-3K)

HOST: D37
===============================================================================
TRUS: Prime-Time Tru's down 1 million from June.
      Non-Prime Tru's up 300k.
      week ending 7/8 user CASGEN was top PT user (600k Trus)

CPU : Average CPU down by .2%, system ran at 100% CPU all day long
      on 7/1 the user was CASGEN program NAD, and on 7/13 from 12:33 to
      13:54 user INTRESG program NAD (3 jobs), system ran at 100% CPU
      at other times but lasting under 10 minutes.

PGS : 34k pages were used in July:
      HSBCNET (+11K), NSCCODE (+6K), ANZNET (+4K), BETATEST (+4K)
   