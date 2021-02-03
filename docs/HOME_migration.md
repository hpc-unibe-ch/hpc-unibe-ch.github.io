# File System Restructure
We are restructuring our file systems to update our hardware and improve collaboration between users. 

There will be following stages:

1. HOME migration to new file system
2. introduction of **Workspaces**
3. Permission changes and quota reduction of HOME directories

!!! danger "DECLUTTERING"
    Migration **performance** depends on the **file space**, but also on the **amount of files**. Therefore, please delete unnecessary data and pack files when possible:

    - Remove obsolete data: ```rm -r unnec_data```
    - Pack data not needed in a short to midterm into tar archives:
    ```tar -zcf archive.tar.gz foo bar``` # where foo and bar are files.
    - remove obsolete custom installed packages, e.g. old Python packages:
    ```rm -r $HOME/.local/lib/python*/site-packages/*```

## HOME migration

!!! types note "new users"
    HOMEs of recently added users are **already** in the new location. You can verify: `pwd` result starts with `/storage/homefs`.

HOME directories will be migrated to `/storage/homefs/$USER` in our newer and larger SpectrumScale file system. In future, these home directories are meant to be private only, without any sharing. 
As you may noticed, there will be no institute directory in the structure anymore. See subsection [Temporary File Sharing](#temporary_file_sharing).

The migration will be performed one-by-one institute. Users are notified before actual migration. When migration is finished `$HOME` points to `/storage/homefs/$USER` and there will be a file `MIGRATED` in your HOME. 

**IMPORTANT:** please also read section [Quota and permission changes](#quota_and_permission_changes) below.

## Introducing HPC Workspaces
In a second step HPC Workspaces will be introduced, enabling collaborative work in group shared file spaces. Currently they are in Alpha testing stage. 

HPC Workspaces consists of:

 - persistent **WORKSPACE** storage (with Snapshots and Backup), 
 - temporary **SCRATCH** storage (no recovery features, but less restrictive), 
 - a **primary group** with read/write access, 
 - a **secondary group** with read only access and 
 - group based **SLURM accounting**. 

Workspaces will be created by a research group manager using the Service Portal, where also quotas, members, and more can be managed. 
Each research group will have 10TB persitant disc space free of charge. Which can be used in one or more Workspaces. Additional storage can be purchased. 
More detailed information will follow soon. 

!!! types note "Beta tester welcome"
    If you are interested in becomming a Beta tester for HPC Workspaces, write a notice in a Service Portal request or an [email](mailto:hpc@id.unibe.ch) 

### SLURM accounting
With the introduction of Workspaces we are changing our resource sharing scheme. The free of charge resources will then be shared between research groups not institutes anymore. 
More detailed information will follow soon. 

## Quota and permission changes
At the end of the transition the HOME directories are closed to be a private space and the quota will be set to max 1TB and 1M files. Furthermore, the temporary institute sharing directories will be removed. 


## Temporary File Sharing
During this transition phase, data can be shared using a temporary institute share directory: `/storage/homefs/<institute>`. 
With the upcoming Workspaces we provide access to the Workspaces using an environment variable which points to a selected Workspace. 

For consistency you can already use the `$WORKSPACE` variable after loading `module load institute`. Which then points to the mentioned temporary insitute sharing directory. Keep in mind the subdirectory structure in the sharing directories. 

