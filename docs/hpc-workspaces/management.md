# Workspace management

!!! attention "under Construction"
    Workspaces are still in testing phase and not publicly available yet. 
    This is preliminary information.
    Detailed information will follow soon.

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

Members can be anyone with an UniBE Campus Account.

### Free Of Charge Quota
Every **research group** has **10TB** free of charge quota. This can be used within one or more Workspaces. The amount used per Workspace is set at application time and can be changed later within the limitation. 

### Additional Storage
Additional storage can be purchased for 50CHF per TB per year. 
On the application or modification form an quota upper limit can be set. Accounted will be the actual usage. Therefore, the actual usage is monitored and twice a day. The average value of all data points is used for accounting. 

### Availability
Storage is a limited and expensive resource. Abandoned, unused workspaces should be prevented by design. Therefore, a workspace has a default live time of one year. A notification will be send before the Workspace expiry. The Workspace expiry date can be changed at any time to any date within the next 365 days by any Workspace manager. 

[//]: # (TODO provide link to the ServicePortal)

## Application
### Prerequisite
The research group need to be registered first on the Service Portal once: [Service Portal -> Register Research Group](https://serviceportal.unibe.ch/sp?id=sc_cat_item&sys_id=3dd760551b0f145023a5dd318b4bcbe5&sysparm_category=6c6ba9631b88ac5023a5dd318b4bcb76)

The request need to be verified manually. This may take some time. 

### Application Form
A HPC Workspace can (only) be requested by a registered research group lead/manager using the ServicePortal application form:

[Service Portal -> Create HPC Workspace](https://serviceportal.unibe.ch/sp?id=sc_cat_item&sys_id=259743301b8bd05023a5dd318b4bcba5&sysparm_category=6c6ba9631b88ac5023a5dd318b4bcb76)

The following information are required:

- Workspace ID (max. 20 characters)
- Workspace Name
- Workspace Description
- registered research group (see prerequisites)
- Deputy (permissions for managing the Workspace) (optional)
- Free Quota (see above)
- additional Storage (optional): an upper limit of quota, where the actual quota will be charged. When selected this requires a valid cost center for accounting. 
- Cost Center (necessary when requesting Additional Storage)
- primary group members
- secondary group members (optional)
member lists can be selected one by one or as a comma separated list of Campus accounts (see "Import Bulk User" in form)

[//]: # (TODO remove when fixed)

!!! type note "Notification"
    After requesting the Workspace creation, a notification will be send. The content with "data point not found" may be confusing, but still your request is successfully submitted. 

[//]: # (TODO remove note after changing to IAM-Tool)

!!! type note "processing time"
The Workspace creation for now relies on a automatic process which is running every 3h between 6:00 and 18:00. In future this will change and be instantaneous. 

## Workspace modifications

After creation, owners and deputies can modify Workspace properties using the Service Portal Form:

[Service Portal -> Edit HPC Workspace](https://serviceportal.unibe.ch/sp?id=sc_cat_item&sys_id=da846d3c1b9f9810f32fdc6a9b4bcbbd&sysparm_category=6c6ba9631b88ac5023a5dd318b4bcb76)

Properties to change are:
- adding/removing members to/from primary and secondary group
- storage extension
- Workspace live time extension
- Workspace closure (so far you need to "deactivate" AND THEN "delete" the workspace)

!!! type "Note"
    During the processing of a modification no other modification can be requested. The Workspace is even not visible in the ServicePortal for that time. 
    Most modification will be processed within few minutes, but adding non-free-of-charge features like additional storage, need human approval, which may delay the process. 
    The Workspace itself (file storage and Slurm, etc.) will not be interrupted by a change. 
