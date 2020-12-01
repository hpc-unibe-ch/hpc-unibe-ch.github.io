# HPC Workspace Data and Software Tools

## Description
The Workspace module provide support for userfriendly file system access, custom software stacks in HPC Workspaces, and SLURM accounting. 

## Workspace module
The Workspace modules automatically detects available Workspaces. If you have access to just one, this one gets loaded. If you have access to multiple workspaces the following presents you the list of available Workspaces:
```
module load workspace
```

If you are member of more than one workspace, you can directly select and load a workspace using

```
export HPC_WORKSPACE=WorkspaceName; module load Workspace
```

!!! note "Note"
    If you have **multiple Workspaces** and **prevent exporting** the environment to the compute node (`export SBATCH_EXPORT=NONE`), you need to **set `HPC_WORKSPACE`** also in you batch script together with the module load statement.

### Shortcuts
The workspace module provides the following variables:

| Variable | Function |
| -------- | -------- |
| WORKSPACE| full path to the Workspace. Thus, you can access the workspace using: `cd $WORKSPACE` |
| SCRATCH  | full path to the Workspace SCRATCH diretory. Thus you can access it using: `cd $SCRATCH` |
| SBATCH_ACCOUNT | sets the SLURM account to the Workspace account. Thus all submitted jobs with that module are accounted to the Workspace account automatically. No need to set it in the sbatch script |

### Software stacks
With the Workspace module we provide a easy and reprducible way to install a custom software stack in your `$Workspace/Software` directory. Since we have different hardware (CPU) architectures, we provide tools for building software specifically for them using EasyBuild. 
Load the Workspace module as describled above and follow the [Easybuild description](../software/installing-custom-software.md#using-easybuild)

