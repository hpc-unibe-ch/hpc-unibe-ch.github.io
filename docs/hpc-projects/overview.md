# HPC - Projects overview

## Motivation

In general, application data and custom software (later short called data) are used by multiple users, not necessarily from one institute, and not necessarily all persons from one institute. 
Furthermore, data is usually produced, stored, and processed in a group related manner. 
We use the term HPC projects, short **PROJECT**, which could be a shared workspace for a research group, a workspace for a collaboration between different research groups, or workspace for a specific research topic.
Thus the data is related to the project scope and not the user anymore. Therewith data stays accessible even if a user leaves the group.

Beside free computing resources, every user/group gets a certain amount of disk space free of charge to handle the computations on UniBE HPC infrastructure. This storage consists of high performance, parallel file systems, where some have additional recovery mechanisms.
We would like to scale with user demands, which only can be enabled by charging extended storage requests.

## short description
Every user gets: 

- a small private **HOME** directory for personal data, 
- has access to **SCRATCH** file system for temporary large data and 
- can apply for a shared group space, we call **PROJECT**. 
- The resources managed by **SLRUM** will be shared on basis of research groups.


## Advantages:
- sustainable data storage on file systems based on groups / projects
- enhanced collaborations between researchers, even across institutes
- storage with high bandwidth connection and backup
- temporary space with less restricted quota
- in-line with other HPC centers


## Setup in detail:

### HOME: 
[//]: # (TODO verify the default home size)
After a transition period, $HOME will be located under `/home/<userID>`, where `<userID>` is the campus account. $HOME is meant only for private and configuration data. Therefore it will be limited to 16GB. 
Snapshots provide possibility to recover accidentally modified or deleted data. 
Some application, by default, use the $HOME file system even for larger amount of data, e.g. user packages in Python or R. Often this can be redirected, e.g. using `--prefix ` option or in worse case using a symbolic link to a project directory. Get in touch with us if you need assistance.

### PROJECT: 
Projects are the central, group based, and therewith shared workspace for our HPC infrastructure. It can be requested using the ServicePortal request form.

[//]: # (TODO provide link to the application page)

Every project has **two lists of members**:

- primary users are meant to have **read and write** access to all data in the workspace
- secondary users get **read only** access to the workspace

The workspace is meant to host **all custom software and data** for the group related scope, e.g. for a research group. 

A project can be applied for the following disk space sizes free of charge:
- **1 TB**, default size
- 5 TB for groups and
- 10 TB for data intensive projects with justification

- Additional space can be purchased for **50CHF per TB per year** 

All projects are only accessible by the members of the above described user lists. Snapshots and backups provide possibility to recover accidentally modified or deleted data.

A project has a default live time of one year. A notification will be send before the project expires. A yearly extension can be requested in the service portal. 

[//]: # (TODO provide link to the ServicePortal)

Responsible for a HPC project is a research group leader, who needs to apply for the project. Members could be research group members or any other combination of UniBE campus accounts. Project management responsibilities can be delegated to a person defined in the project application form, this includes:
- adding new members to primary or secondary group
- storage extension
- project live time extension

### SCRATCH: 
Every project will have an access to a short-term huge capacity space with high-speed access. This is meant as temporary working directory. The data live time will be restricted to an order of month. No data recovery mechanisms are implemented on SCRATCH.

[//]: # (TODO what is the data live time)

### SLURM: 
In general compute resources are shared between all UniBE users. 
A fairshare mechanism is implemented to provide a fair access to the available resources. 

[//]: # (TODO link to fairshare description)

In contrast to the previous implementation, the priorities are based on research group usage and shared between all projects related to these research groups. 

[//]: # (TODO how do we implement?)
