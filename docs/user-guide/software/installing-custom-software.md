# Installing Custom Software

## Description

UBELIX comes with a plethora of software pre-installed. 
You can find a list of already available software using the command `module avail`. The module environment is described [here](pre-installed-software.md). 
If needed, every user can install custom software within his space, which is described in the following using Easybuild or the manual approach..

> Note: You cannot use the packet management utility yum for this, since this command requires root privileges to install software system wide. 
> Instead you have to compile and install the software yourself. 

If you think that some missing software could be of general interest for the UBELIX community, you can ask us to install the software system wide. 
Since maintaining software is a lot of work, we will select carefully which software we will install globally.

### Modules
On UBELIX we use the Lmod module system which allows users to enable software package by package. 
The module system allows us to have multiple versions of the same software product installed as well as preventing unwanted influences between software packages.

### EasyBuild
When possible we use [EasyBuild](https://easybuild.readthedocs.io/en/latest/) to provision software packages. 
Easyconfigs are used to describe the whole build process, including the location of the sources, dependencies and its versions, the used environment, compile arguments, etc. 
These Easyconfigs are publicly available [here](https://github.com/easybuilders/easybuild-easyconfigs). 

Users mainly have two options, building the software package by performing all the steps manually (see example down below) or using the EasyBuild.

## Using EasyBuild
For EasyBuild we provide a setup which lets you create an own software stack in private or group shared space. 
By loading the following module you can build and software packages in the following spaces:

| module | software location | accessiblity |
|--------|-------------------|--------------|
|`CustomRepo/user`| `$HOME` | private to you |
|`CustomRepo/project`| `/storage/research/<projectID>/share` | project based, with collaborators |
|`CustomRepo/institute`| `/home/ubelix/<instituteID>/share` | all institute members |

> Note: The project module requires an environment variable `CUSTOM_REPO_PROJECT_ID` to be set to the project ID.

The prepared setup will handle installation directories for EasyBuild (for software package and module file), and provides easy access later on, for you and you collaborators.

Furthermore, we provide an easybuils wrapper (called `eb-install-all`) to build for all available CPU architectures. Therewith you have always the correct version available. The `CustomRepo` module also takes care to use the correct version when launching on the compute node later on. 
Additionally, we provide another wrapper (`eb-install-generic`) which installs architecture independent packages like python scripts into a separate location. This location is also available using the `CustomRepo` module.
The synatax is: `eb_install_{all,generic} [options] [easybuild options] <easyconfig>.eb`
You can provide additional slurm arguments to both wrappers, e.g. `--slurm_args='--account=xyz --time=00:10:00'` and if necessary, you can specify specific architectures to build on, e.g. `--arch='broadwell' if you only need the broadwell version. After this options, easybuild arguments can be provided like `--robot` (please use slurm arguments first). 

As an **example** the package Relion can be **build in group space** `/storage/research/id_test/share` using:

```Bash
# setup the environment
export CUSTOM_REPO_PROJECT_ID=id_test    # only necessary for CustomRepo/project
module load EasyBuild
module load CustomRepo/project

# check for existing Easyconfigs:
eb -D -S petsc
== found valid index for /storage/software/generic.el7/software/EasyBuild/4.3.2/easybuild/easyconfigs, so using it...
CFGS1=/storage/software/generic.el7/software/EasyBuild/4.3.2/easybuild/easyconfigs
...
 * $CFGS1/p/PETSc/PETSc-3.12.4-foss-2020a-Python-3.8.2.eb
...
 * $CFGS1/p/PETSc/PETSc-3.12.4-intel-2020a-Python-3.8.2.eb
...
# then you can choose the version you prefer, e.g. foss toolchain with GNU compiler
# installation for all different CPU architectures
eb-install-all --slurm_args='--time=00:10:00' --robot PETSc-3.12.4-foss-2020a-Python-3.8.2.eb
```

> Note: The `--robot` option advice EasyBuild to additionally install all required depencencies, if related easyconfigs can be found on the system.

> If you need, you can download the easyconfigs from specified location or the internet and modify them to your needs. 

To **use** these package **any user** who has access to the space (e.g. project collaborators) can use in their batch scripts:

```Bash
#SBATCH 
export CUSTOM_REPO_PROJECT_ID=id_test    # only necessary for CustomRepo/project
module load CustomRepo/project
module load RELION/3.0_beta.2018.08.02
#srun <executable>
```

> Note: If you only have one project you can define the `$CUSTOM_REPO_PROJECT_ID` in your `~/.bashrc` to have it permanently defined.

## Manually compiling
With Linux, you typically compile, link, and install a program like this:

```Bash
tar xzvf some-software-0.1.tar.gz
cd some-software-0.1
./configure --prefix=$HOME/my_custom_software/some-software
make
make install
make clean
```

`configure` is usually a complex shell script that gathers information about your system and makes sure that everything needed for compiling the program is available. 
It may also create a Makefile that is used by the `make` command. 
With the `--prefix` option you can specify a base directory, relative to which `make install` will install the files. 
The make utility is what does the actual compiling and linking. 
If for example some additional library is missing on the system or not found in the expected location, the command will normally exit immediately. 
`make install` puts the compiled files in the proper directories (e.g. `$HOME/my_custom_software/some-software/bin`, `$HOME/my_custom_software/some-software/lib`, ...). 
`make clean` cleans up temporary files that were generated during the compiling and linking stage.
GNU make documentation (advanced): [http://www.gnu.org/software/make/manual/make.html](http://www.gnu.org/software/make/manual/make.html)

### Providing packages
You can use the `CustomRepo` setup to easily provide access to the packages to you and you collaborators.
After loading one of the `CustomRepo` module (see above) you can install your package under `$EASYBUILD_PREFIX` for specific architectures or `$EASYBUILD_PREFIX/../generic` and place your modulefiles e.g. at `$EASYBUILD_PREFIX/../generic/modulefiles/all`. Therewith you just need to load the `CustomRepo` module to access your software products. 

