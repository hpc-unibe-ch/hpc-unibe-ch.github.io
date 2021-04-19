Scratch - temporary file space

## Description

Scratch file space are meant for temporary data storage. Interim computational data should be located there. File and size quota is less restrictive. Every user can use up to **20TB** and **30M** files. There is **no snapshot** and **no backup** feature available. Furthermore, an **automatic deletion policy** is planned, deleting files which are older than **30 days**. 

Scratch file space can be accessed using the Workspace module and the `$SCRATCH` environment variable. 

```BASH
module load Workspace
cd $SCRATCH
```

For personal Scratch see [below](scratch.md#peronal-scratch)

## Workspace Scratch
Each Workspace has a `$SCRATCH` space with the same access permissions like the permanent Workspace directory (using primary and secondary groups). The Workspace can be accessed using `$SCRATCH` variable (after loading the Workspace module). It will point to `/storage/scratch/<researchGroupID>/<WorkspaceID>`. Please use `$SCRATCH` to access it. 

### personal Scratch

Users without a Workspace can also use "personal" Scratch. This space does need to be created initially:
```BASH
module load Workspace/home
mkdir $SCRATCH
cd $SCRATCH
```

Please note that this space is per default **no** private space. If you want to restrict access you can change permissions using:

```
chmod 700 $SCRATCH
```
