# File Systems Overview

## Home directories:
`$HOME` directories are located under `/storage/home/$USER`, where `$USER` is the campus account. `$HOME` is limited to maximum `1TB` and is meant for private and configuration data. Regular Snapshots provide possibility to recover accidentally modified or deleted data.

Sharing data with other cluster users is not supported for `$HOME`. If you want to share data with collaborators please ask your research group leader to request an HPC Workspace.

## Workspaces

Workspaces are located under `/storage/research` and `/storage/workspaces`. The
space in each workspace is controlled individually by the quota of the
corresponding research storage share. Similar to user home directories,
workspaces are protected by regular snapshots to recover accidentally modified
or deleted data.

## Scratch
SCRATCH (`/storage/scratch`) is a temporary space with less restrictive limitations in size, but more restrictive limitation in time. There is no snapshot or backup service implemented in that space. Furthermore an automatic cleaning policy is implemented.
