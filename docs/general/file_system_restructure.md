# File System Restructure

we are restructuring our file system and the intended usage of it. Therewith we want to improve the long-term user experience on our HPC systems, especially for collaborating groups of users. 

# Overview
## HOME migration
HOME directories will migrate from the small GPFS to our newer and larger SpectrumScale file system. The new location will be in `/storage/homefs/$USER`. The final quote in the new location will be 1TB per user. Furthermore, these home directiries are meant to be completely private. There will be no permission change to grant access to anyone else. 

Data which is meant to be shared, need to be located in a Workspace permanent or temporary directory. 

!!! types note "new users"
    recently added user HOME directories are **already** in the target location. You can check using the command `pwd`. If the result starts with `/storage/homefs` your HOME is aleady in the ne location.


!!! types warning "data cleaning"
    Please clean up your HOME directory and remove all unnecessary data, pack files, not needed in the next time to *.tar archives. And sort to temporary job data, which should be moved to temporary space SCRATCH. This will also help you in the next step.

## Introduction HPC-Workspaces 
Workspaces enable collaborative work on our HPC machines. 

HPC-Workspaces consisting of:
 - persistent **WORKSPACE** storage (with Snapshots and Backup), 
 - temporary **SCRATCH** storage (no recovery features, but less restrictive), 
 - a **primary group** with read/write access, 
 - a **secondary group** with read only access and 
 - group based **SLURM accounting**. 

Workspace can be created and are managed by a research group manager using the Service Portal, see (Application)[../hpc-workspaces/management.md#application].
Each research group has 10TB of persitant disc space free of charge, which can be used in one or more Workspaces. Additional storage can be purchased. 

## SLURM accounting
With this restructure and using research group information, we are changing our SLURM sharing scheme. 
The free of charge resources will now be shared between research groups not institutes. 

