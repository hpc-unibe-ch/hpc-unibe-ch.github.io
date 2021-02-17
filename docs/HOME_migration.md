# File System Restructure
We are restructuring our file systems to update our hardware and improve collaboration between users. 

There will be following stages:

1. HOME migration to new file system
2. introduction of **Workspaces**
3. Permission changes and quota reduction of HOME directories

!!! attention "DECLUTTERING"
    Migration **performance** depends on the **file space**, but also on the **amount of files**. Therefore, please delete unnecessary data and pack files when possible:

    - Remove obsolete data: ```rm -r unnec_data```
    - Pack data not needed in a short to midterm into tar archives:
    ```tar -zcf archive.tar.gz foo bar``` # where foo and bar are files.
    - remove obsolete custom installed packages, e.g. old Python packages:
    ```rm -r $HOME/.local/lib/python*/site-packages/*```

## HOME migration

!!! types note "new users"
    HOMEs of recently added and new users are **already** in the new location. You can verify using `pwd`, result starts with `/storage/homefs`.

HOME directories will be migrated to `/storage/homefs/$USER` in our newer and larger SpectrumScale file system. In future, these HOME directories are meant to be private only, without any sharing opportunity. 
As you may noticed, there will be no institute directory in the structure anymore. See subsection [Temporary File Sharing](#temporary_file_sharing).

The migration will be performed institute by institute. Users are notified before and after actual migration. When migration is finished `$HOME` will point to `/storage/homefs/$USER`. 

**IMPORTANT:** please also read section [Quota and permission changes](#quota_and_permission_changes) below.

## Temporary space to share data
In future HOMEs are meant to be private spaces. Data sharing will be enabled using flexible group based HPC Workspaces (see below). In the meantime time institute based directories `/home/ubelix/<instituteID>/shared` can be used for sharing. To simplify the upcoming transition to workspaces you can already access the institute spaces using the similar workflow you will do later:
```
module load CustomRepo/ws_inst
cd $WORKSPACE
```

Later the module name will change, but the environment variable `WORKSPACE` will point to **your** Workspace directory. Keep in mind the subdirectory structure in the **shared** directories. 

!!! attention "shared directory cleaning"
    After the migration/ Workspace introduction the institute `shared` directories will be removed. You will have more than a month to migrate your data to a Workspace. 

## Introducing HPC Workspaces
In a second step HPC Workspaces will be introduced, enabling collaborative work in group shared file spaces. Currently they are in Alpha testing stage. 

HPC Workspaces consists of:

 - persistent **WORKSPACE** storage (with Snapshots and Backup), 
 - temporary **SCRATCH** storage (no recovery features, but less restrictive), 
 - a **primary group** with read/write access, 
 - a **secondary group** with read only access and 
 - group based **SLURM accounting**. 

There will be tools for easy access the directories using `$WORKSPACE` and `$SCRATCH` variable as well as reporting quota and fair share. 

Workspaces will be created by a research group manager using the Service Portal, where also quotas, members, and more can be managed. 
Each research group will have 10TB persistent disc space free of charge. Which can be used in one or more Workspaces. Additional storage can be purchased. 
More detailed information will follow soon. 

!!! types note "Beta tester welcome"
    Interested in becoming a Workspace Beta user? Get in touch with us using a [Service Portal request](https://serviceportal.unibe.ch/sp?id=sc_cat_item&sys_id=1d137767db54141078ed3e48229619a7) or drop an [email](mailto:hpc@id.unibe.ch).

### SLURM accounting
With the introduction of Workspaces we are changing our resource sharing scheme. The free of charge resources will then be shared between research groups not institutes any more. 
More detailed information will follow soon. 

## Quota and permission changes
At the end of the transition the HOME directories are closed to be a private space and the quota will be set to max. 1TB and 1M files. Furthermore, the temporary institute sharing directories will be removed. 

## Backup and Snapshots
All Workspaces will have Snapshots and Backup enabled. 
**HOME**s will get these features **after** the migration/ Workspace introduction period, due to performance reasons. 
