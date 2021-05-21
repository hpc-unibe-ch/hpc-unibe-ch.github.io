# HPC Workspaces

## Description
The HPC Workspaces provide a group shared environment, including storage with user-defined access, SLURM accounting, and tools. 

A HPC Workspace belong to a research group and need to be requested by the research group leader, see [Workspace management](../hpc-workspaces/management.md). 

## Short Summary
Workspaces provide a collaborative environment with user defined access groups:

- a primary group with **read/write** access and 
- a secondary group with **read only** access

Each Workspace provide:

- permanent storage (`/storage/workspaces/<researchGroupID>/<workspaceID>`) 
- temporary storage (`/storage/scratch/<researchGroupID>/<workspaceID>`)
- user-friendly access to a custom software repositories and monitoring tools and
- SLURM accounting to that Workspace. Fair share between research groups.

## Usage
Please always load the Workspace module when using it, even if you only copy files into it. The module provides you with shortcuts (e.g. `$WORKSPACE`), the custom Software stack (if existing) and SLURM settings.

## Application

Workspaces need to be created by registered research group lead/managers, see [Workspace Application](../hpc-workspaces/management.md#application)

## More Details
For more details see: 

- [Workspace Introduction](../hpc-workspaces/workspaces.md), 
- [Workspace Software Environment](../hpc-workspaces/environment.md), and 
- [Workspace Monitoring](../hpc-workspaces/monitoring.md)
