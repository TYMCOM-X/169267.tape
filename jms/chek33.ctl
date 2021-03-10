RUN (XEXEC)MINIT
;The following directories do not use system 32 as the master
RDIST TSUCOOP.33=(TSUCOOP)/MASTER:33/HOST:26,38/CHECK
RDIST TXSSUP.33=(TXSSUP)/MASTER:33/HOST:35/CHECK
RDIST NEW11.33=(NEW11)/MASTER:33/HOST:14,62,32/CHECK
;OLD11,CURR11,DOC11,TOOLS11,DERNST

;Directories which have not been duplicated yet
RDIST MONDOC.33=(MONDOC)/MASTER:32/HOST:33/CHECK
RDIST MPL.33=(MPL)/MASTER:32/HOST:33/CHECK
RDIST OSB.33=(OSB)/MASTER:32/HOST:33/CHECK
RDIST OSMAN.33=(OSMAN)/MASTER:32/HOST:33/CHECK
RDIST OSNF.33=(OSNF)/MASTER:32/HOST:33/CHECK
RDIST OSP.33=(OSP)/MASTER:32/HOST:33/CHECK
RDIST OSU.33=(OSU)*.SHR,(OSU)*.SAV/MASTER:32/HOST:33/CHECK
RDIST SUBMIT.33=(SUBMIT)/MASTER:32/HOST:33/CHECK
RDIST WRS.33=(WRS)/MASTER:32/HOST:33/CHECK
RDIST YEUX.33=(YEUX)*.SHR,(YEUX)*.LOW,(YEUX)*.SAV/MASTER:33/CHECK
RDIST SYSNEW.33=(SYSNEWS)/MASTER:32/HOST:33/CHECK
RDIST TBATLI.33=(TBATLIB)/MASTER:32/HOST:33/CHECK

;The following directories were identical as of 1-Feb-88
RDIST SAILIB.33=(SAILIB)/MASTER:32/HOST:33/CHECK
RDIST FLETCHERC.33=(FLETCHERC)/MASTER:32/HOST:33/CHECK
RDIST SPL.33=(SPL)/MASTER:32/HOST:33/CHECK
RDIST SPPOPER.33=(SPPOPER)/MASTER:32/HOST:33/CHECK
RDIST VUE.33=(VUE)/MASTER:32/HOST:33/CHECK
RDIST XEXEC.33=(XEXEC)/MASTER:32/HOST:33/CHECK

;Directories which are expected to be different
RDIST CARL.33=(CARL)/MASTER:32/HOST:33/CHECK
RDIST INFO.33=(INFO)/MASTER:32/HOST:33/CHECK
RDIST JMS.33=(JMS)/MASTER:17/HOST:33/CHECK
RDIST SYS.33=(SYS)/MASTER:32/HOST:33/CHECK
RDIST M33.33=(M33)/MASTER:32/HOST:33/CHECK

;Directories moved to system 33 (files deleted from system 32)
;BARTLETW,COBOLQA,DOCAIL,JAIL,KL10,KS2020,LINK10,NDT,PASNEW,PEAK,
;SAIL,SAILTEST,SPPARCH,SYSMAINT,TBAFTDEB,TNXAIL,TOOLS11,TXSDOC,TXSINFO,
;TXSTEST,TXSTEXT,XAIL,XCONSULT,YAMM

;Foreign directories
;TIIDEV,TYM5,TYMNET,UAS,UN1,UPL,UTIL,VALDEV,VALIDATE

;Unchecked names
;*1BATCH,*1KEN,*6NEWS,BAIGENT,BILLING10,BRING,BURRIESCIN,CNFE
;CRASH,CUD10,DANIELSR,DENCOFF,DERNST,DIAG,DIAG10C,DIAG10D,DNDUTIL
;DONAHUE,DRM,ENSS,F40,FRENCH,FTMAGNUM,FTSYS,FTSYSDOC,FTTBA,GKING
;LOADII,MAGNUM,MFICHE,MICROCYCLES,MOSSERJ,OPER,PERPOPER,PJ,PUB
;QALIBSYM,QASYS,RICHARDSON,RKLUTE,RMURPHY,SALTYRON,SMITHDE,SPOOL
;SPOOLING,SPUNKTEST,SRA,SRAFT,SRAMOV,SRATECH,SRAUTIL,SRAVAL,SSBACKUP
;SSEREP,SSINSTALL,SSPAMBIN,SSPAMSYM,SSVALSUP,TYMGRIPE
   