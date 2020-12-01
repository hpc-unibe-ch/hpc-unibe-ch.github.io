# HPC Workspaces

## Description
The HPC Workspaces provide a group shared environment, including storage with user-defined access, SLURM accounting, and tools. 

A HPC Workspace belong to a research group and need to be requested by the research group leader, see [Worksapce management](../hpc-workspaces/management.md). 

## Short Summary
Workspaces consits of permantent (`/storage/workspaces/<researchGroupID>/<workspaceID>`) and temporary (`/storage/scratch/<researchGroupID>/<workspaceID>`). 
Permissions are managed using a primary (read/write) and a secondary (read only) group. Computational work is accounted to the Workspace SLURM account. 

## More Details
For more details see: 

- [Workspace Introduction](../hpc-workspaces/workspaces.md), 
- [Workspace Software Environment](../hpc-workspaces/environment.md), and 
- [Workspace Monitoring](../hpc-workspaces/monitoring.md)
