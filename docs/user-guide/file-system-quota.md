# File System Quota

## Description

This page contains information about quota limits on the GPFS. Quotas are enabled to control the file system usage.

!!! types note "Default Quota Limits"
    For each user, the default block quota limit is 3 TB, and the default file quota limit is 2 million files

## User Quota

!!! types warning " Job abortion"
    Jobs will fail if no more disk space can be allocated, or if no more files can be created because the respective quota hard limit is exceeded 

You can display the user quota information with the mmlsquota command. It will inform you about quota limits (block quota and file quota) and the current usage on the filesystem:  


```Bash
$ mmlsquota
                         Block Limits                                    |     File Limits
Filesystem type             KB      quota      limit   in_doubt    grace |    files   quota    limit in_doubt    grace  Remarks
gpfs       USR        28292096 3221225472 4294967296          0     none |   136704 2000000  3000000        0     none
```

Add the --block-size option to specify the unit (K , M, G, T) in which the number of blocks is displayed:

```Bash
$ mmlsquota --block-size=G
                         Block Limits                                    |     File Limits
Filesystem type             GB      quota      limit   in_doubt    grace |    files   quota    limit in_doubt    grace  Remarks
gpfs       USR              27       3072       4096          0     none |   136704 2000000  3000000        0     none
```

The output shows the quotas in the file system GPFS for the user who issued the command. The quotas are set to a soft limit of 3072 GB, and a hard limit of 4096 GB. 27 GB is currently allocated to the user. An in_doubt value greater than zero means that the quota system has not yet been updated as to whether the space that is in doubt is still available or not. If the user exceeds the soft limit, the grace period will be set to one week.

If usage is not reduced to a level below the soft limit during that time, the quota system interprets the soft limit as the hard limit and no further allocation is allowed. The user can reset this condition by reducing usage enough to fall below the soft limit. The maximum amount of disk space the user can accumulate during the grace period is defined by the hard limit. The same information is also displayed for the file limits (number of files).

## Group Quota

You can display the the group quota of your own group using the -g option:

```Bash
$ mmlsquota -g id --block-size T
Disk quotas for group id (gid 1001):
                         Block Limits                                    |     File Limits
Filesystem type             TB      quota      limit   in_doubt    grace |    files   quota    limit in_doubt    grace  Remarks
gpfs       GRP               1         15         16          0     none |  2232666 10000000 12000000        0     none
```

## Request Higher Quota Limits

!!! types info ""
    Make sure to clean up your home directory before requesting additional storage space

 You can request an increase of the block- and/or file quota by writing to [hpc-support@id.unibe.ch](mailto:hpc-support@id.unibe.ch)

 Related pages:
:     [File Transfer from/to UBELIX](file-transfer.html)



