# File System Quota

This page contains information about quota limits on the parallel file system. Quotas are enabled to control the file system usage.

!!! types warning " Job abortion"
    Jobs will fail if no more disk space can be allocated, or if no more files can be created because the respective quota hard limit is exceeded

## Quotas

| space | quota | file quota | backup | expiration |
| ----- | ----- | ---------- | ------ | ---------- |
| HOME | 1TB | 1M | yes | - |
| WORKSPACE | at least 5TB | 1M per TB | yes | - |
| SCRATCH | 30TB[^user] | 10M[^user] | no | 1 month |

[^user]: Scratch quota is currently implemented per user

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
SCR_usr             :        all,        269(  0%),      30720 |          22(  0%),   10000000 |              ,
Workspace1          :          5,        101(  1%),      10240 |           4(  0%),   10000000 |    2021-02-25,           7.5833

(0) space names starting with "SCR_" refer to the personal (usr) or Workspace SCRATCH quota.
(1) accounting period start date, The date from which the average usage is computed.
(2) file space average quota (not files), calculated by the average of messured values in the actual accounting period.
```

In the last example the workspace `Workspace1` has `5TB` of free quota, and a total of `10TB` of quota (`5TB` additional storage requested). The `start date` defines the start of the accounting period and the average quota is computed as average over all datapoints starting from `start date`. 
Furthermore, the SCRATCH quota is presented starting with `SCR_`, where `SCR_usr` is your personal SCRATCH quota and `SCR_` plus Workspace name the group quota of the Workspace group in the scratch fileset. Workspace SCRATCH quota is only presented if a quota is set and the `quota -l` option selected.

!!! info "Data updates"

    - Workspaces: Workspace quota information is gathered twice a day. Thus the presented data may not completely represent the current state.
    - HOME and SCRATCH: values presented are actual values directly gathered from the file system
