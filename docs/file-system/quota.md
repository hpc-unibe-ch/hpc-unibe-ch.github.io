# File System Quota

## Description

This page contains information about quota limits on the parallel file system. Quotas are enabled to control the file system usage.

!!! types info "migration change"
    Previously HOME directories had limits of 3 TB per user, file quota limits of 2 million files. In some cases this was extended. The previous HOME quota will kept active until the Workspace introduction phase is finished. 

!!! types warning " Job abortion"
    Jobs will fail if no more disk space can be allocated, or if no more files can be created because the respective quota hard limit is exceeded 

## Quotas

| space | quota | file quota | backup | expiration |
| ----- | ----- | ---------- | ------ | ---------- |
| HOME | 1TB | 1M | yes | - |
| WORKSPACE | free: up to 10TB per research group[^QpRG] | 1M per TB | yes | 1 year[^WSdur] |
| SCRATCH | 30TB[^user] | 10M[^user] | no | 1 month[^pol] |

[^QpRG]: Each research group can use up to 10TB of free disk storage in multiple Workspaces free of charge. Quota increase can be purchased, see [Workspace Management](../hpc-workspaces/management.md#additional-storage). 
[^WSdur]: Workspaces are meant to be active directories and no archive. Workspace are active by default for one year. The duration can every time be extended to "current date plus one year". 
[^user]: Scratch quota is currently implemented per user
[^pol]: There is a automatic removal policy planned, but not implemented yet


## Display quota information

A quota tool is delivered with the Workspace module:

```Bash
$ quota
UniBE Workspace Quota report
============================
                    :  used (GB)(   %), quota (GB) |  files used(   %),      quota
==================================================================================
HOME                :        420( 41%),       1024 |      773425( 77%),    1000000
Workspace1          :        101(  1%),      10240 |           3(  0%),   10000000
```
Furthermore, there is a more detailed version using the `-l` or `--long` option
```Bash
$ quota -l
UniBE Workspace Quota report
============================
                    : free quota,  used (GB)(   %), quota (GB) |  files used(   %),      quota | start date(1), average quota(2)
================================================================================================================================
HOME                :        all,        421( 41%),       1024 |      796058( 79%),    1000000 |              ,
Workspace1          :          5,        101(  1%),      10240 |           4(  0%),   10000000 |    2021-02-25,           7.5833

(1) accounting period start date, The date from which the average usage is computed.
(2) file space average quota (not files), calculated by the average of messured values in the actual accounting period.
```

In the last example the workspace `Workspace1` has `5TB` of free quota, and a total of `10TB` of quota (`5TB` additional storage requested). The `start date` defines the start of the accounting period and the average quota is computed as average over all datapoints starting from `start date`. 

!!! types note "data gathering"

    - Workspaces: Workspace quota information is gathered twice a day. Thus the presented data may not completely represent the current state.
    - HOME: values presented are actual values directly from the file system

Note: the coloring of the relative values is green (<70%), yellow (70% < x < 90%), red (>90%).

## advanced quota method

The following `mmlsquota` command present you actual values from the file system. 
For `$HOME`:

```Bash
$ mmlsquota --block-size=G -u $USER rs_gpfs:svc_homefs
                         Block Limits                                               |     File Limits
Filesystem Fileset    type             KB      quota      limit   in_doubt    grace |    files   quota    limit in_doubt    grace  Remarks
rs_gpfs    svc_homefs USR       444181792 1073741824 1073741824    6072144     none |   815985 1000000  1000000     2462     none
```

!!! types attention "migration change"
    If your HOME is not yet migrated, you can check your quota on the old file system using: `$mmlsquota  gpfs`. The quota limits for the institute directories can be gathered using: `mmlsquota -g id --block-size T`, for the institute `id`.


The `--block-size` option specify the unit {K , M, G, T} in which the numbers of blocks are displayed:

```Bash
mmlsquota --block-size=G -j workspace1 rs_gpfs
                         Block Limits                                    |     File Limits
Filesystem type             GB      quota      limit   in_doubt    grace |    files   quota    limit in_doubt    grace  Remarks
rs_gpfs    FILESET          57      10240      11264          0     none |        5 10000000 11000000        0     none
```

The output shows the quotas for a worspace called `Workspace1`. The quotas are set to a soft limit of 10240 GB, and a hard limit of 11264 GB. 57 GB is currently allocated to the workspace. An in_doubt value greater than zero means that the quota system has not yet been updated as to whether the space that is in doubt is still available or not. 

If the user/workspace exceeds the soft limit, the grace period will be set to one week. If usage is not reduced to a level below the soft limit during that time, the quota system interprets the soft limit as the hard limit and no further allocation is allowed. The user(s) can reset this condition by reducing usage enough to fall below the soft limit. The maximum amount of disk space the workspace/user can accumulate during the grace period is defined by the hard limit. The same information is also displayed for the file limits (number of files).

## Request Higher Quota Limits

!!! types info "clean before ask"
    Make sure to clean up your directories before requesting additional storage space. 

There will be no quota increase for HOME directories. Additional storage for workspaces can be requested by the workspace owner or the deputy, see [Workspace Management](../hpc-workspaces/management.md#additional-storage)

