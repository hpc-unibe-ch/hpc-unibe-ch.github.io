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

## Introducing HPC Workspaces
HPC Workspaces are group shared places. See [HPC Workspace Documentation](hpc-workspaces/workspaces.md)


## Temporary space to share data
HOMEs are meant to be private spaces. Data sharing is enabled using flexible group based [HPC Workspaces](hpc-workspaces/workspaces.md). 
The institute based directories `/home/ubelix/<instituteID>/shared` were provided using tools similar to Workspaces:
```
module load CustomRepo/ws_inst
cd $WORKSPACE
```

With Workspace and migrated data your workflow can still use the environment variable `WORKSPACE`, which point to **your** Workspace directory. Keep in mind the subdirectory structure in the previous **shared** directories. 

!!! attention "shared directory cleaning"
    In June, the institute `shared` directories will be removed. **You** will have more than a month to migrate your data to a Workspace. 

## Quota and permission changes
Finally, beginning of June HOME directories will be restricted to be a private space and the quota will be set to max. 1TB and 1M files. Furthermore, the temporary institute sharing directories will be removed. 
Starting with this change the HOME Snapshot and Backup will be activated and the `umask` will be by default 002. 
