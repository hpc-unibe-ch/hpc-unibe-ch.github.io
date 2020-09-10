# Workspaces

## Description

This section describes the usage of Workspaces. In short: a Workspace provides group shared file spaces for temporary (SCRATCH) and persitent (project) data and applications. Permissions can be managed by the Workspace owner in a primary (read/write) and a secondary (read only) group. Furthermore, SLURM accounting will be based related to these Workspace. 
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

## HOME: 
[//]: # (TODO verify the default home size)
After a transition period, $HOME will be located under `/home/<userID>`, where `<userID>` is the campus account. $HOME is meant only for private and configuration data. Therefore it will be limited to 16GB. 
Snapshots provide possibility to recover accidentally modified or deleted data. 
Some application, by default, use the $HOME file system even for larger amount of data, e.g. user packages in Python or R. Often this can be redirected, e.g. using `--prefix ` option or in worse case using a symbolic link to a project directory. Get in touch with us if you need assistance.

## PROJECT: 
The **PROJECT** directories are the central persistance space for our HPC infrastructure. A Workspace could be of one the following free of charge sizes:

- S: **1 TB**, default size
- M: 5 TB for groups and
- L: 10 TB for data intensive projects with justification

Additional space can be purchased for **50CHF per TB per year** on the form 

[//]: # (TODO Link to extension form)

We have a file system of limited size available for all our users. 
To scale with our user demands, we need to charge extended storage requests.

The **PROJECT** directory is meant to host **all custom software and data** for the workspace group related scope, e.g. for a research group.

Snapshots and backups provide a possibility to recover accidentally modified or deleted data.

On special request and additional charges projects can ask for an independent fileset for elevated security requirements which also can enable backup on separated tapes.

## SCRATCH: 
Every project will have access to a short-term, huge capacity space (50TB, 5M files) with high-speed access. On special request this limits can be increased.
SCRATCH is meant as a temporary working directory and is located under `/storage/scratch`. 
Files older than 60 days are meant to be deleted automatically. 
No data recovery mechanisms are implemented on SCRATCH.
In case of reaching a of 60% occupancy of whole SCRATCH, short term actions are required, removing even younger data will be necessary, after user notification. 

## Members
Every Workspace has **two lists of members**:

- primary users are meant to have **read and write** access to all data in the workspace
- secondary users get **read only** access to the workspace

Thus, the **PROJECT** and **SCRATCH** space are accessible to all members of the both user lists above, but only the members of the primary list can write or modify data. 

Members can be any user with an Campus Account. To be able to access the HPCs, the accounts need to be activated, see [Accounts and Activation](account.md).

## Workspace management

A workspace can be requested by an UniBE research group lead

[//]: # (TODO provide link to the ServicePortal)

Therefore, the research group need to be registered using:

[//]: # (TODO provide link to the ServicePortal)

The research group lead will be the the workspace owner and therewith the responsible person especially for costly extensions. Additionally, a deputy can be defined, who can also manage the workspace
Responsible for a HPC project is a research group leader, who needs to apply for the project. Members could be research group members or any other combination of UniBE campus accounts. Project management responsibilities can be delegated to a person defined in the project application form, this includes:

- adding new members to primary or secondary group
- storage extension
- project live time extension


[//]: # (TODO what is the data live time)

The project can be modified by the project owner (research group lead) and the specified deputy using the form on the porta:

[//]: # (TODO provide link to the ServicePortal)

### Life time
We want to prevent dead, hanging workspaces. Therefore, a workspace has a default live time of one year. A notification will be send before the project expires. An extension can be requested any time for another year with few clicks in the service portal:

[//]: # (TODO provide link to the ServicePortal)


### SLURM: 
In general compute resources are shared between all UniBE users. 
A fairshare mechanism is implemented to provide a fair access to the available resources. 

[//]: # (TODO link to fairshare description)

In contrast to the previous implementation, the priorities are based on research group usage and shared between all projects related to these research groups. 

[//]: # (TODO how do we implement?)
