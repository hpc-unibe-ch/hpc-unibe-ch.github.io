# File Systems Overview

## HOME: 
`$HOME` directories are located under `/home/$USER`, where `$USER` is the campus account. `$HOME` is limited to maximum `1TB` and is meant for private and configuration data. There is no data sharing workflow considerred for `$HOME`. If you want to share data with collaborators please ask your research group leader to request a HPC Workspace. 
Reqular Snapshots provide possibility to recover accidentally modified or deleted data. 
Some application, by default, use the `$HOME` file system even for larger amount of data, e.g. user packages in Python or R. Often this can be redirected, e.g. using `--prefix ` option or in worse case using a symbolic link to a project directory. Get in touch with us if you need assistance.

## Workspaces
In HPC Workspaces access is defined in two user defined access groups. A primary read/write group is meant to be the data owner, while a secondary has only read access. The sizes of these spaces are managed by the Workspace owners. Beside a free of charge quota, the space can be extended with costs. 

For more details see [Workspace management](../hpc-workspaces/management.md)


## SCRATCH
SCRATCH is a temporary space with less restrictive limitations in size, but more restrictive limitation in time. 
There is no snapshot or backup service implemented in that space.

### Quota

!!! attention "under Construction"
    detailed information will follow soon

[//]: <> (TODO fill)
### Cleaning Policy

!!! attention "under Construction"
    detailed information will follow soon
[//]: <> (TODO fill)
