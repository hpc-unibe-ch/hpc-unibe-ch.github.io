# Workspace storage

## Description



## HOME: 
[//]: # (TODO verify the default home size)
After a transition period, `$HOME` will be located under `/home/<userID>`, where `<userID>` is the campus account. `$HOME` is meant only for private and configuration data. Therefore it will be limited to 16GB. 
Snapshots provide possibility to recover accidentally modified or deleted data. 
Some application, by default, use the `$HOME` file system even for larger amount of data, e.g. user packages in Python or R. Often this can be redirected, e.g. using `--prefix ` option or in worse case using a symbolic link to a project directory. Get in touch with us if you need assistance.

## Workspace: 
The Workspace directories are the central persistance space for our HPC infrastructure. A Workspace could be of one the following free of charge sizes:

- S: **1 TB**, default size
- M: 5 TB for groups and
- L: 10 TB for data intensive projects with justification

Additional space can be purchased for **50CHF per TB per year** on the form 

[//]: # (TODO Link to extension form)

We have a file system of limited size available for all our users. 
To scale with our user demands, we need to charge extended storage requests.

The **Workspace** directory is meant to host **all custom software and data** for the workspace group related scope, e.g. for a research group.

Snapshots and backups provide a possibility to recover accidentally modified or deleted data.

On special request and additional charges projects can ask for an independent fileset for elevated security requirements which also can enable backup on separated tapes.

## SCRATCH: 
Every workspace will have a group shared, short-term, huge capacity space (50TB, 5M files) with high-speed access. On special request this limits can be increased.
SCRATCH is meant as a temporary working directory and is located under `/storage/scratch`. 
Files older than 60 days are meant to be deleted automatically. 
No data recovery mechanisms are implemented on SCRATCH.
In case of reaching a of 60% occupancy of whole SCRATCH, short term actions are required, removing even younger data will be necessary, after user notification. 

