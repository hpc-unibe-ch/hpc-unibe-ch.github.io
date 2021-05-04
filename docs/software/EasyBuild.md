# EasyBuild

## Description
EasyBuild can install software packages including the related modules. The location will be controlled using our modules, e.g. the `Workspace` module, see [Installing Custom Software](installing-custom-software.md).
On top of the usual EasyBuild framework we added some extensions which allows you to build for specific architectures or a generic software stack in your user/group space. 
Therefore, use the `eb` command to search and try and the `eb-install-all` or `eb-install-generic` command to install the package. 

The following steps need are necessary:

- load modules
- find the package specification
- decide the desired software stack
- run EasyBuild installation using `eb-install-all` or `eb-install-generic`

## Modules
Depending if you want to install the package in user or a group space you need to load the related module and the `EasyBuild` module, e.g.:

```Bash
module load Workspace  ### if you want to install into your HOME use Workspace/home
module load EasyBuild
```

Therewith, our EasyBuild tools and EasyBuild itself are available. 

!!! Note "Note"
    Specify the WorkspaceID when loading the Workspace module. See module instructions

## Package Specification
EasyBuild has a large repository of available packages in different versions. 
You can use these specifications as is or copy/download and modify the EasyConfigs (see below).

Available packages can be searched using the following command, here for the **gatk** package

```Bash
eb --search gatk
[...]
eb --search gatk
== found valid index for /storage/software/generic.el7/software/EasyBuild/4.3.3/easybuild/easyconfigs, so using it...
 * /storage/software/generic.el7/software/EasyBuild/4.3.3/easybuild/easyconfigs/g/GATK/GATK-1.0.5083.eb
...
 * /storage/software/generic.el7/software/EasyBuild/4.3.3/easybuild/easyconfigs/g/GATK/GATK-4.0.1.2-Java-1.8.eb
...
 * /storage/software/generic.el7/software/EasyBuild/4.3.3/easybuild/easyconfigs/g/GATK/GATK-4.0.12.0-foss-2018b-Python-3.6.6.eb
...
 * /storage/software/generic.el7/software/EasyBuild/4.3.3/easybuild/easyconfigs/g/GATK/GATK-4.0.4.0-intel-2018a-Python-3.6.4.eb
 * /storage/software/generic.el7/software/EasyBuild/4.3.3/easybuild/easyconfigs/g/GATK/GATK-4.0.5.1-foss-2018a-Python-3.6.4.eb
...
 * /storage/software/generic.el7/software/EasyBuild/4.3.3/easybuild/easyconfigs/g/GATK/GATK-4.0.8.1-foss-2018b-Python-2.7.15.eb
...
 * /storage/software/generic.el7/software/EasyBuild/4.3.3/easybuild/easyconfigs/g/GATK/GATK-4.1.8.1-GCCcore-9.3.0-Java-1.8.eb
```

As shown above there are different versions of GATK and for different *toolchains* available (`foss`, `intel`, `GCCcore`). 
**Select one** 

You can list all dependencies using:

```Bash
eb -Dr /storage/software/generic.el7/software/EasyBuild/4.3.3/easybuild/easyconfigs/g/GATK/GATK-4.1.8.1-GCCcore-9.3.0-Java-1.8.eb
...
Dry run: printing build status of easyconfigs and dependencies
CFGS=/storage/software/generic.el7/software/EasyBuild/4.3.3/easybuild/easyconfigs
 * [ ] $CFGS/j/Java/Java-1.8.0_281.eb (module: Java/1.8.0_281)
... 
 * [x] $CFGS/p/Python/Python-2.7.18-GCCcore-9.3.0.eb (module: Python/2.7.18-GCCcore-9.3.0)
 * [ ] $CFGS/g/GATK/GATK-4.1.8.1-GCCcore-9.3.0-Java-1.8.eb (module: GATK/4.1.8.1-GCCcore-9.3.0-Java-1.8)
```

Dependencies marked with `x` are already installed, the other dependencies will be installed if using the robot option.

Additional options, e.g. for selecting a specific software version can be found using `eb --help`.

### Using EasyConfig files

You can use the directy selected easyconfig or if necessary copy and adapt it.
easyconfig files are text files specifying the software version, toolchain version, dependencies, compile arguments and more.
If you need more information see [EasyBuild documentation](https://easybuild.readthedocs.io/en/latest/), and if necessary ask our support team for assistance.

## Selecting a software stack
Depending on the package and its target usage one or more software stacks should be selected. Therefore, the installation command starts with one for the following command:

- all architectural software stacks: `eb-install-all `
- a specific architectural software stack (e.g. only targeting Broadwell nodes): `eb-install-all --archs='broadwell' ` OR
- generic software stack: `eb-install-generic `, CPU architecture independent, like `git`

## Installation
After selecting the package installation recipe and the target software stack, the installation process can be submitted. 
With the following commands, SLURM job files will be created, and submitted to the desired compute nodes. There the packages are build and module files created. The general syntax is: 
```Bash
eb_install_{all,generic} [options] [easybuild options] <easyconfig>.eb
```
Additional SLURM arguments can be selected using the `--slurm-args` option, e.g. `--slurm-args='--account=xyz --time=00:10:00 --cpus-per-task'`. If specific architectures should be selected use e.g. `--arch='broadwell ivy'`. After this options, EasyBuild arguments can be provided without prefix, e.g. `--robot`. 

Few examples:

- for **FFTW** in **all architectural** software stacks:
```Bash
eb-install-all --robot --software-name=FFTW --toolchain-name=GCC
```
- for **git** in the **generic** software stack:
```Bash
eb-install-generic --robot --software-name=git --toolchain-name=GCC
```
- for a custom EasyConfig **myApp.eb** only in the **Broadwell and Ivybridge** software stack:
```Bash
eb-install-all --archs='ivy broadwell' --robot myApp.eb
```

This will need time to get scheduled and processed. 
The job output is presented in the `eb_out.*` files, one for each architecture. 

If the build could not be finished in the default time of 1h, the walltime can be extended using:

```Bash
eb-install-all --robot --slurm-args='--time=05:00:00' ...
```

!!! note "Note"
    Please check the end of the out file for the **COMPLETED: Installation ended successfully** statement.

When finished you (and your collaborators) should be able to use use the software, by just loading the user/workspace related module and the module for the installed package. 
