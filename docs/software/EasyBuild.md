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
module load Workspace
module load EasyBuild
```

Therewith, our EasyBuild tools and EasyBuild itself are available. 

!!! Note "Note"
    Specify the WorkspaceID when loading the Workspace module. See module instructions

## Package Specification
EasyBuild has a large repository of available packages in different versions. 
You can use these specifications as is or download and modify the EasyConfigs (see below).

Available packages can be searched using the following command using the dry-run option `-D`, here for the **git** package

```Bash
eb -D --software=git
[...]
ERROR: No toolchain name specified, and more than one available: ['GCC', 'GCCcore', 'foss'].
```

As shown above there are versions for different *toolchains* available. You can select one and and try again, e.g. with `--toolchain-name=GCC`: 

```Bash
eb -D --software-name=git --toolchain-name=GCC
[...]
Dry run: printing build status of easyconfigs and dependencies
CFGS=/storage/software/generic.el7/software/EasyBuild/4.2.1/easybuild/easyconfigs
 * [ ] $CFGS/g/GCC/GCC-4.9.2.eb (module: GCC/4.9.2)
 * [ ] $CFGS/c/cURL/cURL-7.40.0-GCC-4.9.2.eb (module: cURL/7.40.0-GCC-4.9.2)
 * [ ] $CFGS/e/expat/expat-2.1.0-GCC-4.9.2.eb (module: expat/2.1.0-GCC-4.9.2)
 * [ ] $CFGS/g/gettext/gettext-0.19.4-GCC-4.9.2.eb (module: gettext/0.19.4-GCC-4.9.2)
 * [x] $CFGS/p/Perl/Perl-5.20.1-GCC-4.9.2-bare.eb (module: Perl/5.20.1-GCC-4.9.2-bare)
 * [ ] $CFGS/g/git/git-2.4.1-GCC-4.9.2.eb (module: git/2.4.1-GCC-4.9.2)
 [...]
```

As shown a list of dependencies is required, which may already be installed or need to be installed. 
Therefore, you can later use the option `--robot`, which will automatically also install all required dependencies.
Additional options, e.g. for selecting a specific software version can be found using `eb --help`.

!!! note "Note"
    The spelling and notation need to be exactly as used in the EasyBuild repository, e.g. searching for `GIT` will not find the package, but `git` does and otherwise, `fftw` will fail, while `FFTW` succeed. 

### Using EasyConfig files

If you did not found your desired version or you want to modify it, e.g. for using a more recent software version than available in the EasyBuild repository, you can download and change EasyConfigs, e.g. from [EasyConfig repository](https://github.com/easybuilders/easybuild-easyconfigs). These are text files specifying the software version, toolchain version, dependencies, compile arguments and more.
If you need more information see [EasyBuild documentation](https://easybuild.readthedocs.io/en/latest/), and if necessary ask our support team for assistance.

## Selecting a software stack
Depending on the package and its target usage one or more software stacks should be selected. Therefore, the installation command starts with one for the following command:

- all architectural software stacks: `eb-install-all `
- a specific architectural software stack (e.g. only targeting Broadwell nodes): `eb-install-all --archs='broadwell' ` OR
- generic software stack: `eb-install-generic `

## Installation
After selecting the package installation recipe and the target software stack, the installation process can be submitted. 
With the following commands, SLURM job files will be created, and submitted to the desired compute nodes. There the packages are build and module files created. The general syntax is: 
```Bash
eb_install_{all,generic} [options] [easybuild options] <easyconfig>.eb
```
Additional SLURM arguments can be selected using the `--slurm_args` option, e.g. `--slurm_args='--account=xyz --time=00:10:00 --cpus-per-task'`. If specific architectures should be selected use e.g. `--arch='broadwell ivy'`. After this options, EasyBuild arguments can be provided without prefix, e.g. `--robot`. 

Few examples:

- for **FFTW** in **all architectural** software stacks:
```Bash
eb-install-all --robot --software-name=git --toolchain-name=GCC
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

!!! note "Note"
    Please check the end of the out file for the **COMPLETED: Installation ended successfully** statement.

When finished you (and your collaborators) should be able to use use the software, by just loading the user/workspace related module and the module for the installed package. 
