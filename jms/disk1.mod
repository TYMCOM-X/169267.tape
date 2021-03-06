


                    Marketing Opportunities Document

                                 for

                         DISK RECOVERY UTILITIES

                   Detection of File Structure Problems.










Originator:
Joe Smith   ________________________________            Date:________
Maintenance Software Developer





Approvals:

Craig Fletcher _____________________________            Date:________
Manager
Author: Joe Smith
McDonnell Douglas Field Service Co
2560 N. First St, (M/S-D21)
San Jose, CA 95161
Date:   16-Sep-88
Status: MDISC Sensitive
        ===============




1.0 Introduction:

    The purpose of this document is to describe the sanity checks that
must be added to the GP7 system so that it can detect a corrupted file
system and report the corruption before any further damage is done to
user's files.

    The file system as a whole is comprised of all disks that are
expected to be on-line during normal operations.  Verifying the entire
file system requires that the individual file structures be verified
separately, and that the links from the system to the individual file
structures are intact.  The term "file" here applies to any on-disk
object.


2.0 Mandatory Checks:

    These checks are performed when the system is booted or when
mounting a new file structure.  They need to be an integral part of the
operating system.

    Any disk that does not pass these consistency checks must be flagged
as unusable until fixed.  As long as the "system disk" is OK, there is
no excuse for crashing the system if a "user disk" is unusable.  In
particular, if an unformatted or uninitialized disk happens to be
on-line when the system is booted, that disk must be reported on the
console and the boot process continued.

  2.1  Read and verify the home block or boot record of each disk.
       The home block or boot record must contain a self-identifying code
       (signature) and should have a checksum or other means of doing a
       self-consistency check.

    2.1a  For partitioned disks, verify that each cylinder belongs
          properly accounted for.  There must not be any unexpected
          overlaps or gaps.

    2.1b  For multi-unit disk structures, verify that one unit claims to
	  be the first in that structure, one unit claims to be last,
          and that all intervening units are present with no duplicates.

    2.1c  For shadow disks, verify that both the primary and secondary
	  disks are present and point to each other.  Take special note
	  if the secondary disk is marked as in the process of being
	  brought up to date with respect to the primary disk.


Page 1 of 3
  2.2  Read and verify pointers to the root directory and allocation
       table on each file structure.  (Each partition is a separate file
       structure, a multi-unit disk structure is treated as a single file
       structure, and shadow disks are combined with their primaries to
       be a single file structure.)

    2.2a  Using the pointer to the root directory, verify that it is the
          root directory.

    2.2b  Using the pointer to the allocation table, verify that the
	  contents of the allocation table are reasonable for that size
          of disk.


3.0  Once-only checks:

    As the system is being booted, certain critical resources must be
located.  Since the optional checks (described in the next section) have
not been done, all pointers and directory entries must be explicitly
double checked.  The system must take care to validity check all data
read from the disk before using it.  This includes locating the
non-resident portions of the operating system and any programs required
to implement the optional checks.  Critical objects and type handlers
must be verified before use.


4.0  Optional Checks:

    The checks in this section are to be made whenever the file system
is suspected of being damaged.  The routines required to implement these
checks do not have to be part of the operating system kernel, however
they do require that no users be allowed write access to the structure
being checked.

  4.1  Determine whether the allocation table is trustworthy or needs to
       be completely rebuilt.  The consequences of a bad allocatation
       table are:

    4.1a  Blocks marked "in use" but not part of any file.
          This eats up usable disk storage, a minor problem.

    4.1b  Two or more file headers claim the same block.
          This can be a security violation, and leads to problems when
          the block is released to the free list.

    4.1c  Blocks part of a file but not marked "in use".
          The system will assume that the block can be allocated to a
          second file, resulting in problem "b" above.

    4.1d  Lost chains of of free blocks.
          This is the same as problem "a" above.


Page 2 of 3
       If any block that is part of the allocation table gets a read
       error, then the whole table is suspect and must be rebuilt.
       Errors in the directory blocks may also be catastrophic to the
       allocation table.

  4.2  If the allocation table must be rebuilt, all currently used
       blocks must be located and accounted for.

    4.2a  Starting with the root directory, recursively process each
          directory until every file on the file structure has been found.

    4.2b  Each file header must be read to locate the blocks allocated
          to the file.  The block numbers need to be validated before
	  they are marked in use.

    4.2c  After all files have been found, the remaining blocks are put
          in the allocation table, marked as not in use.

  4.3  All files that have problems must be logged at the collection
       point and logged in the event log.  Any file error that may be
       hardware related must be recorded in the error log.

  4.4  If any critical resource (object) is damaged, the system should
       stop so as to not cause any further damage.  The operator should
       have the option to tell the system to try to recover as best it
       can, to restart using a redundant (shadow) disk, or to call for
       assistance.


5.0  Maintenance Software:

    Standalone software capable of reading and writing absolute blocks
on disk will be required to do file structure repair.  This software
will be available only to qualified systems support people, and be
invoked when needed to recover file system integrity without a lengthy
system rebuild.  It should be included in the kernel's initial boot
image to handle the widest range of contingencies.  The actual
specification of such software is to be described in a separate MOD.












MDISC Sensitive:  This document is for MDFSCO use only.






Page 3 of 3

      