# Workspace management

## Description
This article targets Workspace managers. It covers applications, Workspace properties, up to modifications and suggested usage of Workspaces.

## Workspace Intention
Workspaces are group shared resources. This group could be for example:

- whole research group working together on shared data and software packages
- student(s) an their supervisor
- collaborating researchers from different research groups/institutes
- sub-group within the research group, which requires data separation

## Workspace Properties
### Ownership
HPC Workspaces manage compute and storage resources. Especially the freely available resources are meant to be shared between participating research groups. Therefore, the Workspaces belong to a beforehand registered research group.

A HPC Workspace can be only requested by a **research group leader**, who responsible and accountable, since costly extensions can be added to the Workspace. 
Additionally, a **deputy** can be nominated, who also can manage the Workspace (see [Workspace Modification](#modification)). 
**Note:** Deputies have the same privileges than the owner and can also purchase costly resources without additional notification. Owners and deputies are called Workspace managers. 

If the workspace is meant to be for a **collaboration of researchers** from different research groups, you need to agree to one research group which is responsibilities and gets accounted for the resources. This research group leader need to request the workspace. 

### Members
Each Workspace has two member groups:

- primary users with read and write access and
- secondary users with read only access

Only members of the primary group can create and modify data, belonging to the Workspace, as well as submitting jobs to the Workspace account. The member lists are defined at Workspace application time and can be modified later. 

### Free Of Charge Quota
Every **research group** has **10TB** free of charge quota within one or more workspaces. The amount used per Workspace is set at application time and can be changed later within the limitation.s 

### Additional Storage
Additional storage can be purchased for 50CHF per TB per year. 
On the application or modification form an quota upper limit can be set. Accounted will be the actual usage. Therefore, the actual usage is monitored and twice a day. The average value of all data points is used for accounting. 

### Availability
Storage is a limited and expensive resource. Abandoned, unused workspaces should be prevented by design. Therefore, a workspace has a default live time of one year. A notification will be send before the Workspace expiry. The Workspace expiry date can be changed at any time to any date within the next 365 days by any Workspace manager. 

[//]: # (TODO provide link to the ServicePortal)

## Application
### Prerequisite
This research group need to be registered first, see

[//]: # (TODO provide link to the ServicePortal)

If the workspace 



### Application Form
A HPC Workspace can be requested by a research group lead using the ServicePortal application form:

[//]: # (TODO provide link to the ServicePortal)

The following information are required:
- registered research group (see prerequisites)
- Workspace abbreviation, this will be used as code in the file system and SLURM
- Workspace name
- Workspace description

## Modification
Responsible for a HPC project is a research group leader, who needs to apply for the project. Members could be research group members or any other combination of UniBE campus accounts. Project management responsibilities can be delegated to a person defined in the project application form, this includes:

- adding new members to primary or secondary group
- storage extension
- project live time extension

The project can be modified by the project owner (research group lead) and the specified deputy using the form on the portal:

[//]: # (TODO provide link to the ServicePortal)





