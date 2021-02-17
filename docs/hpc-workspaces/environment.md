# HPC Workspace Data and Software Tools

!!! attention "under Construction"
    Workspaces are still in testing phase and not publicly available yet.
    This is prelimnary information.
    Detailed information will follow soon.

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
Beside, a set of software packages we provide for our different CPU architecture, the Workspace module provides tools to install custom software stacks within your Workspace. 
Especially with easybuild shortcuts are provided to install and use custom software stacks easily build for all architectures. 

For installing packages with EasyBuild, see [Easybuild description](../software/EasyBuild.md). 
Manual package can also be installed in the similar manner. Adding a Modulefile provides the users to load packages as used to. Please see [Installing Custom Software](../software/installing-custom-software.md). 

As a result all users of the Workspace can use the software packages by loading the Workspace module and the software product module. 
