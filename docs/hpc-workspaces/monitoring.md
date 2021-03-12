# HPC Workspace Monitoring Tools

!!! attention "under Construction"
    Workspaces are still in testing phase and not publicly available yet.
    This is prelimnary information.
    Detailed information will follow soon.

## Description
Workspaces are consting of different features. Depending on the feature you can check settings using:

| Feature | tool | permission |
|---------|------|------------|
| Storage | call `quota` on a ubelix login node, see [Quota Tool](../file-system/quota.md#display-quota-information), accounting information using `quota -l` | everyone belonging to the Workspace |
| prim./sec. group membership | [Service Portal -> Edit HPC Workspace](https://serviceportal.unibe.ch/sp?id=sc_cat_item&sys_id=da846d3c1b9f9810f32fdc6a9b4bcbbd&sysparm_category=6c6ba9631b88ac5023a5dd318b4bcb76) | Workspace owner and deputy |
| SLURM fair share | still under construction | everyone belonging to the Workspace |

[//]: # (TODO add fair share note)

The properties can be changed from the Workspace managers:

[Service Portal -> Edit HPC Workspace](https://serviceportal.unibe.ch/sp?id=sc_cat_item&sys_id=da846d3c1b9f9810f32fdc6a9b4bcbbd&sysparm_category=6c6ba9631b88ac5023a5dd318b4bcb76)
