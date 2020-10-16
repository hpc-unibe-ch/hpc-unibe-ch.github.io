# Workspaces

## Description

This section describes the usage of Workspaces. 
In short: a Workspace provides group shared file spaces for temporary data and software. Permissions can be managed by the Workspace managers and are organized in a primary (read/write) and a secondary (read only) group. Furthermore, SLURM accounting will be based related to these Workspace. 
A Workspace can be requested using the ServicePortal request form:

[//]: # (TODO provide link to the application page)

## Motivation

In general, application data and custom software (later short called data) are used by multiple users, not necessarily from one institute, and not necessarily all persons from one institute. 
Furthermore, data is usually produced, stored, and processed in a group related manner. 
We use the term HPC workspaces, which could be a shared space for a research group, a sub group within the a research group or a collaboration between different research groups.
Thus the data is related to this workspace scope and not the user anymore. Therewith data stays available even if a member leaves the group.


## Advantages:
- sustainable data storage on file systems based on groups / projects
- enhanced collaborations between researchers, even across institutes
- storage with high bandwidth connection and backup
- temporary space with less restricted quota
- in-line with other HPC centers

## Storage
Every Workspace has a group shared space for permanent data (on `/storage/workspace`) and a group shared space for temporary data (`/storage/scratch`). 
For more details see [Workspace storage](../hpc-workspaces/storage.md)

## Members
Every Workspace has **two lists of members**:

- primary users are meant to have **read and write** access to all data in the workspace
- secondary users get **read only** access to the workspace

Thus, the **Workspace** and **SCRATCH** space are accessible to all members of the both user lists above, but only the members of the primary list can write or modify data. 

Members can be any user with an Campus Account. To be able to access the HPCs, the accounts need to be activated, see [Accounts and Activation](account.md).

## SLURM: 
In general, compute resources are shared between all UniBE research groups and users. 
A fairshare mechanism is implemented to provide a fair access to the available resources. 

[//]: # (TODO link to fairshare description)

In contrast to the previous implementation, the priorities are based on research group usage and shared between all projects related to these research groups. 

[//]: # (TODO how do we implement?)
