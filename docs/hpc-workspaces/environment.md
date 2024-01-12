# HPC Workspace Data and Software Tools

## Description
HPC Workspace modules provides support for user-friendly file system access, custom software stacks in HPC Workspaces, and SLURM accounting. 
The module can also be used to set up HOME for a custom software stack. 

Furthermore, there are modules provided to load a working Workspace and additionally a software stacks from another Workspace, see [Additional software stacks](#additional-software-stacks)

## Workspace module
The Workspace module adjust the environment to work in a specific HPC Workspace. 
```
module load Workspace
```
sets the following environment variables ([Shortcuts](#shortcuts)) and [Software stacks](#software-stacks)

There are the following possibilities:

- you belong to **no** Workspace: load `module load Workspace_Home` to use your software stack in your HOME directory and set `$WORKSPACE` and `$SCRATCH` variables to your private directories.
- you belong to **one** Workspace: this Workspace gets loaded when `module load Workspace`
- you belong to multiple Workspaces: you need to specify the Workspace to load using the variable `$HPC_WORKSPACE`. If not specified, the module presents the possible options, e.g.:
    ```
    $ module load Workspace
    Workspaces are available:
        HPC_SW_test, hpc_training, 
    Please select and load ONE of the following:
        HPC_WORKSPACE=HPC_SW_test module load Workspace
        HPC_WORKSPACE=hpc_training module load Workspace
    ```
    - Thus you load a specific Workspace using:
    ```
    HPC_WORKSPACE=<WorkspaceName> module load Workspace
    ```
There are also ways to load an additional Workspace for an additional software stack, see [Additional Software Stacks](#additional-software-stacks) below.

### Shortcuts
The workspace module provides the following variables:

|  <div style="width:180px">Variable</div> | Function |
| -------- | -------- |
| `$WORKSPACE` | full path to the Workspace. Thus, you can access the workspace using: `cd $WORKSPACE` |
| `$SCRATCH`  | full path to the Workspace SCRATCH directory. Thus you can access it using: `cd $SCRATCH` |

### SLURM Account
by loading the `Workspace` module by default the Workspace account is selected. Thus all jobs submitted without a specified `--account` will be submitted to this Workspace account.

### Additional Settings
the module provides the following settings for a more user-friendly usage of applications. You may not need to use them directly, but tools like SLURM, Singularity, Python, and R will use them. 

|  <div style="width:180px">Variable</div> | Function |
| -------- | -------- |
| `$SBATCH_ACCOUNT` <br> `$SLURM_ACCOUNT` <br> `$SALLOC_ACCOUNT` | sets the SLURM account to the Workspace account. Thus all submitted jobs with that module are accounted to the Workspace account automatically. No need to set it in the sbatch script |
| `$SINGULARITY_BINDPATH` | using singularity, the Workspace directory will be bind into the container without manual specification. The `WORKSPACE` variable as well as the `SCRATCH` variable will also be ported into the container. Thus, you can specify locations with `$WORKSPACE` or `$SCRATCH` within the container. | 
| `$PYTHONPATH` | if `Python` or `Anaconda` is loaded beforehand, it is set to: `$WORKSPACE/PyPackages/lib/pythonXXX/site-packages` where `XXX` is the Python major and minor version. And also add the `bin` directory to `$PATH`. |
| `$PYTHONPACKAGEPATH` | if `Python` or `Anaconda` is loaded beforehand, it is set to: `$WORKSPACE/PyPackages`. This can be used for e.g. `pip install --prefix $PYTHONPACKAGEPATH` |
| `$CONDA_ENVS_PATH` | therewith conda environments can be created and shared within the Workspace |
| `$R_LIBS` | therewith additional R packages can be installed and searched in the shared Workspace. The directory need to be created first. See [R page](../software/r.md#installing-packages) |

### Software stacks

Beside, a set of software packages we provide for our different CPU architecture, the Workspace module provides tools to install custom software stacks within your Workspace. 
Especially with EasyBuild shortcuts are provided to install and use custom software stacks easily build for all architectures. 

For installing packages with EasyBuild, see [EasyBuild description](../software/EasyBuild.md). 
Manual package can also be installed in the similar manner. Adding a Modulefile provides the users to load packages as used to. Please see [Installing Custom Software](../software/installing-custom-software.md). 

As a result all users of the Workspace can use the software packages by loading the Workspace module and the software product module. 

### Python packages
The Workspace module provides support to install and use Python packages in a shared manner, by installing them into the Workspace. 

!!! note "First load Python/Anaconda3" 
    Python or Anaconda3 module need to be loaded before loading the Workspace module, since variables to be set depend on Python version.
    Workspace module can also be reloaded, e.g.:
    ```
    HPC_WORKSPACE=HPC_SW_test module load Workspace
    module load Anaconda3
    module load Workspace
    ```

### Conda environments
The Workspace module provides support for creating and using conda environments in the shared Workspace. See [Anaconda Conda environments](../software/Anaconda.md#conda-environments).

### R packages
The Workspace module provides support for installing and using additional R packages in the shared Workspace. Thus a package once installed by one user can be used by all Workspace members. See [R installing packages](../software/r.md#installing-packages).

### UMASK
The Workspace module sets the umask to 002. Thus files and directories get group-writeable, e.g.:
```Bash
-rw-rw-r-- 1 user group 0 Mar 15 15:15 /path/to/file
```

### Additional Software Stacks

The module `Workspace_SW_only` provide the access to a software stack of an HPC Workspace `B` while working in an HPC Workspace `A`. 

This could be that a common software stack is provided for multiple (data) Workspaces or that you are trying software packages in your `HOME`

As an example you could load:

```Bash
HPC_WORKSPACE=A module load Workspace
HPC_WORKSPACE=B module load Workspace_SW_only
```

When you want to load packages from your `HOME` while working in `A`, you can 

```Bash
HPC_WORKSPACE=$HOME module load Workspace_SW_only
HPC_WORKSPACE=A module load Workspace
```

!!! type note ""
    Note that the variable `HPC_WORKSPACE` is cleared after each loading of a `Workspace*`module. The currently loaded Workspace names are stored in `$HPC_WORKSPACE_LOADED` for the Workspace module and `$HPC_WORKSPACE_SW_ONLY` for the Workspace_SW_only module. 

### Reloading

The Workspace modules are configured to "remember" the selected Workspace you once loaded in the current session, even after unload the Workspace module. Therefore, environment variables are set in the current session, `$HPC_WORKSPACE` for the `Workspace` module, and `$HPC_WORKSPACE_SW_ONLY` for the `Workspace_SW_only` module. 

If you belong to multiple Workspaces and you want to list the available Workspaces you need to `unset HPC_WORKSPACE` before loading the `Workspace` module. If you already know the name, you can switch into another Workspace (here Workspace `foo`) by:

```Bash
module unload Workspace
HPC_WORKSPACE=foo module load Workspace
```

When you are creating a new module, there are cases where you need to reload a Workspace module, e.g. for a Python packages. This can be obtained using e.g. the following lua modulefile syntax:

```lua
if mode() == 'load' then
  if not ( isloaded("Python") ) then
    load("Python")
    if ( isloaded("Workspace") ) then
        load("Workspace")
    end
    if ( isloaded("Workspace_SW_only") ) then
        load("Workspace_SW_only")
    end
    if ( isloaded("Workspace_HOME") ) then
        load("Workspace_HOME")
    end
  end
end
```

Assuming we want to create a module for an additional Python package. In this example we not only verify that `Python` is loaded, but also that the Workspace Python settings (incl. `PYTHONPATH` and `PYTHONPACKAGEPATH`) are set properly by reloading the Workspace module. 
