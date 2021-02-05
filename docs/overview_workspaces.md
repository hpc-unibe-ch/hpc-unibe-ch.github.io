# HPC Workspaces

## Description
The HPC Workspaces will provide a group shared environment, including shared storage with user-defined access groups, SLURM accounting, and tools. 

Each HPC Workspace belongs to a research group and need to be requested by the research group leader using the Service Portal. There Workspace properties, like membership, quota and duration can be controlled. 

!!! types note "EARLY ACCESS"
    If you are interested and want to get early access as beta-tester, please get in touch with us using the [Service Portal](https://serviceportal.unibe.ch/sp?id=sc_cat_item&sys_id=1d137767db54141078ed3e48229619a7) or write an [Email](mailto:hpc@id.unibe.ch)


## Properties
Workspace access is controlled using **two groups**, where any Campus Account can be set as a member by the Workspace owner and its deputy:

- primary group with **read/write** access and 
- secondary group with **read only** access

Further each Workspace has **two file spaces**, which can be accessed with the following variables:

- `$WORKSPACE`: permanent storage at `/storage/workspaces/<researchGroup>/<workspace>`
- `$SCRATCH`: temporary storage at `/storage/scratch/<researchGroup>/<workspace>`

Therefore, the `Workspace` module needs to be loaded. 

This module also provides access to:

- monitoring tools for quota and fair share
- user-friendly access to a custom software repositories, and support in building them for all architectures
- SLURM accounting on Workspaces and therewith fair share between research groups

## Motivation
HPC data is typically **shared data**. This could be sharing between: 

- students and supervisors, 
- researchers of a research group, 
- researchers of different institutes 

These data needs to be accessible even if people leave the team, without changing workflows. Additionally, data need to be shared in a read only fashion, e.g. to provide a database.
Furthermore, HPC data is usually processed with a set of custom software tools, which need to be easy accessible and shared between all the collaborators. 

## Advantages:
- group based storage access (data and software)
- enhanced collaborations between researchers, even across institutes
- user-friendly access control by Workspace managers on the UniBe Service Portal
- high bandwidth storage
- snapshots and backup
- temporary space with less restrictive quota
- research group based compute resource sharing
- in-line with other HPC centres

!!! types note "EARLY ACCESS"
    If you are interested and want to get early access as beta-tester, please get in touch with us using the [Service Portal](https://serviceportal.unibe.ch/sp?id=sc_cat_item&sys_id=1d137767db54141078ed3e48229619a7) or write an [Email](mailto:hpc@id.unibe.ch)
