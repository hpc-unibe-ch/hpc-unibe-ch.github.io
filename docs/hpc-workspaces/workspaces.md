# Workspaces Introduction

!!! Attention
    <span style="color:red"><b>HPC Workspaces are discontinued and replaced by Research Storage shares. Registering new research groups is no longer possible. Existing HPC Workspaces can still be used.</b></span>

    To apply for a Research Storage share please use the following [link](https://intern.unibe.ch/dienstleistungen/informatik/dienstleistungen_der_informatikdienste/dienstleistungen___ressourcen/research_storage/index_ger.html)

## Description
The HPC Workspaces provide a group shared environment, including storage with user-defined access, SLURM accounting, and tools. 

An HPC Workspace belong to a research group and need to be requested by the research group leader, see [Workspace management](../hpc-workspaces/management.md). 

## Short Summary
Workspaces provide a collaborative environment with user defined access groups:

- a primary group with **read/write** access and 
- a secondary group with **read only** access

Each Workspace provide:

- permanent storage (`/storage/workspaces/<researchGroupID>/<workspaceID>`) 
- temporary storage (`/storage/scratch/<researchGroupID>/<workspaceID>`)
- user-friendly access to a custom software repositories and monitoring tools and
- SLURM accounting to that Workspace. Fair share between research groups.

!!! ATTENTION
    Please always load the `Workspace` module, even if only just copying files into it. The module corrects the `umask` and therewith the created file and directory permissions. 

    Furthermore, it is good practice to use `$WORKSPACE/file1` instead of absolute path `/path/to/Workspace/file1`

## Motivation
HPC data typically is shared data. This could be between students and supervisors, between researchers of a research group, or even between researchers of different institutes. These data needs to be accessible even if people leave the team. 
Furthermore, these data is usually processed with a set of custom software tools, which need to be easy accessible, share, between the collaborators. 

## Advantages
- group based storage access (data and software)
- enhanced collaborations between researchers, even across institutes
- user-friendly access control by Workspace managers
- high bandwidth storage and backup
- temporary space with less restricted quota
- research group based compute resource sharing

## Storage Access Permissions
**HOME** is meant to be a private space, mainly for configurational data. 
All **group oriented data** is meant to be located in a **HPC Workspace** directories:

- `/storage/workspaces/<researchGroupID>/<workspaceID>`  for permanent storage
- `/storage/scratch/` for temporary storage, see [File Systems](../file-system/filesystem-overview.md)

All files and directories in the group shared spaces are meant to stay with default permissions, like `-rw-rw-r--`: 

- read and write for owner and primary group members
- read only access for others. Since the Workspace directory itself is limited to primary and secondary group members using ACLs, secondary group members get read permissions. 

## Members
The Workspace owner can define a **deputy** who gets same permissions as owner, including booking at cost. 

Workspace permissions are managed with **two lists of members**:

- primary users, with **read and write** access to all data in the spaces, permission to account to that Workspace
- secondary users, with **read only** access

Thus, the **Workspace** and **SCRATCH** space are accessible to all members of the both lists of users, but only the members of the primary list can write or modify data. 

Members can be anyone with an active UniBE Campus Account.

The Workspace owner or its deputies can manage the lists using the Service Portal Workspace edit Form: [Service Portal -> Edit HPC Workspace](https://serviceportal.unibe.ch/sp?id=sc_cat_item&sys_id=da846d3c1b9f9810f32fdc6a9b4bcbbd&sysparm_category=6c6ba9631b88ac5023a5dd318b4bcb76)

## Backup
All data in the permanent space (`/storage/workspaces/`) is protected using daily snapshots and backups.

Scratch will not be protected by snapshots or backups.

## Quota

For default and actual **quota** information use `quota` tool. More details see [File System Quota](../file-system/quota.md).


## SLURM
Computational work is accounted to a Workspace account. Every workspace belongs to a research group. The freely available resources are shared between research groups. 

[//]: # (TODO link to fairshare description)

In contrast to the previous implementation, the priorities are based on research group usage and shared between all workspaces related to this research group. 

[//]: # (TODO how do we implement?)
