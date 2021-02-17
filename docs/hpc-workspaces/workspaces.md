# Workspaces Introduction

!!! attention "under Construction"
	Workspaces are still in testing phase and not publicly available yet.
	This is preliminary information.
	Detailed information will follow soon.

## Description
This article introduces HPC workspaces with the main aspects.

A guidline for Workspace managers including **application** and modification can be found at [Workspace Managment](management.md). 

If you want to **join an existing Workspace**, please ask the Workspace owner or manager to add your account.

A HPC workspace consists of:

- 2 access groups, *read/write* and *read only*
- permanent and temporary storage
- Slurm accounting
- fair share on research group level

## Motivation
HPC data typically is shared data. This could be between students and supervisors, between researchers of a research group, or even between researchers of different institutes. These data needs to be accessible even if people leave the team. 
Furthermore, these data is usually processed with a set of custom software tools, which need to be easy accessible, share, between the collaborators. 

## Advantages:
- group based storage access (data and software)
- enhanced collaborations between researchers, even across institutes
- user-friendly access control by Workspace managers
- high bandwidth storage and backup
- temporary space with less restricted quota
- research group based compute resource sharing
- in-line with other HPC centres

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

The Workspace owner or its deputies can manage the lists using the Service Portal 

[//]: # (TODO: add SNOW link)

## Backup
All data in the permanent space (`/storage/workspaces/`) is protected using daily snapshots and backups

[//]: # (TODO daily Snapshots? daily backups?)

Scratch will not be protected. 

## Quota

For default and actual **quota** information see [File System Quota](../file-system/quota.md).


## SLURM: 
Computational work is accounted to a Workspace account. Every workspace belongs to a research group. The freely available resources are shared between research groups. 

[//]: # (TODO link to fairshare description)

In contrast to the previous implementation, the priorities are based on research group usage and shared between all workspaces related to this research group. 

[//]: # (TODO how do we implement?)
