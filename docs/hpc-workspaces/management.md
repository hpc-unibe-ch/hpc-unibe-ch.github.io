# Legacy Workspace management

!!! failure "Attention"
    <span style="color:red"><b>Legacy Workspaces (/storage/workspaces/) are discontinued and replaced by Research Storage shares (/storage/research). Existing Legacy Workspaces can still be used.</b></span>

    To apply for a Research Storage share please use the following [link](https://intern.unibe.ch/dienstleistungen/informatik/dienstleistungen_der_informatikdienste/dienstleistungen___ressourcen/research_storage/index_ger.html)

This article targets Legacy Workspace managers. It covers legacy workspace properties and modifications.

## Workspace Properties
### Ownership

An HPC Workspace can be only requested by a **research group leader**, who is responsible and accountable, since costly extensions can be added to the Workspace. 
Additionally, a **deputy** can be nominated, who also can manage the Workspace. Owners and deputies are called **Workspace managers**. 

!!! type note "Deputies"
    Deputies have the same privileges than the owner, up to purchasing costly resources without additional notification. 

If the workspace is meant to be for a **collaboration of researchers** from different research groups, you need to agree to one research group which is responsibilities and gets accounted for the resources. This research group leader need to request the workspace. 

### Member groups
Each Workspace has two member groups:

- primary users with **read and write** access and
- secondary users with **read only** access

Only members of the primary group can create and modify data, belonging to the Workspace, as well as submitting jobs to the Workspace account. The member lists are defined at Workspace application time and can be modified later. 

Members can be anyone with an UniBE Campus Account, but need to be registered for UBELIX usage, see [Account Activation](../getting-Started/account.md#account-activation).

### Quota
The quota per workspace is set at application time and additional storage can be added later.
See [costs page](../general/costs_investments.md#workspaces) for details.

### Availability
Abandoned, unused workspaces should be prevented by design. Therefore, an HPC Workspace has a default live time of one year. A notification will be send before the Workspace expiry. The Workspace expiry date can be changed at any time to any date within the next 365 days by any Workspace manager. 
[ServicePortal -> Shop -> HPC -> Edit HPC Workspace](https://serviceportal.unibe.ch/sp?id=sc_cat_item&sys_id=da846d3c1b9f9810f32fdc6a9b4bcbbd&sysparm_category=6c6ba9631b88ac5023a5dd318b4bcb76) -> Workspace Duration

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

## Investor QoS
Investors get elevated priviledges for specific queues. These are managed in so called Slurm QoS (Quality of Service). Where in the past the investors specified a list of users, who can use the QoS, in future Workspaces are able to manage the QoS on Workspace level. Therefore, you need to open a request to add an existing QoS to a (list of) Workspace(s). The membership managment is done within the Workspace. 

!!! type "Warning"
    Investor QoS are bind to SLURM accounts. Since personal SLURM accounts get deactivated when joining an HPC Workspace, the investor QoS need to get transfered. This process is not done automatically, please request the transfer using our [ServicePortal](https://serviceportal.unibe.ch/hpc)

## Import Bulk Users

The "Import Bulk Users" field provides the possibility to list a larger set of members for primary or secondary group without selecting them one by one. There the members need to be specified as a comma seperated list of Campus Accounts (not full names). 
Keep in mind: you need to specify the **full** list of members in these field. After leaving the field the upper primary/secondary member list will be replaced with this list.

## Permission Background

!!! type note ""
    This sections provides more advanced information about the implementation of the permission handling for both permission groups. Nevertheless, we strongly suggest to keep default permissions. `-rw-rw-r--` for files and `drwxrwxr-x` for directories. 

In Linux permissions are manged using: `user` (owner), `group` and `other`. `user` will always be the username creating the file/directory. In a Workspace the `group` will always be the Workspace primary group. This should (and this is default) get read/write permissions. The Workspace secondary group gets access to the Workspace main directory using ACLs. Then, within the Workspace these members acts as `other` and need to get read permissions. 

Thus a file:

``` Bash
-rw-rw-r--  2 user ws_group  4096 Jan 01 09:11 filename
```

can be modified by all members of the `ws_group` and read by everyone else (with access to that location, which is grated for secondary Workspace group members). And a file

```Bash
-rw-rw----  2 user ws_group  4096 Jan 01 09:11 filename2
```

can be modified by all members of the `ws_group`, but NOT read by anyone else (even not secondary Workspace group members).

Please, make sure that all your files and directories keep this permissions. In case of moving data from other locations, these could vary and can be corrected using:

```Bash
find /storage/workspace/<researchGroupID>/<workspaceID>/ \
\( -type f -exec chmod 664 {} \; \) , \
\( -type d -exec chmod 775 {} \; \)
```
