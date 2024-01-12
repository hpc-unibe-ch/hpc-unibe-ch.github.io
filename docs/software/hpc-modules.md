# HPC software environment

[//]: # (TODO HPC modules, Env Variables, Easybuild, ...)
## Description

With the operation system, a list of basic tools (mainly command line tools) are provided, including editors, file analyzing and manipulation tools, packing and transfer tools etc. These commands are accessible all the time. Other software packages (libraries and applications) are available through software modules. Using modules, a lot of different packages even in different versions can be provided, without unwanted influences.

## Basic concept

Many Linux settings are in environment variables. These include search paths for applications (`$PATH`) and libraries (`$LD_LIBRARY_PATH`). Adding or removing a directory to these lists, provides access or remove access to additional software. 

Our software modules are an user friendly way to search and manage software packages without dealing with complicated directory names.

In general every software package has its related module. When loading the module the software package **and** its dependencies get accessible. 

But let's do it step by step.

## Find available Modules
You can search for an packages or module containing a specific string using `module spider`, e.g. to find all versions of GCC:
```Bash
module spider GCC
```

You can list all currently available packages using:
```Bash
module avail
```
Beware, this list is very long! It may be more useful to use `module spider` instead.

## Load/Add a Modules

Loading a module will provide access to the software package and it will additionally load all required dependencies.

```Bash
module load OpenMPI/3.1.3-GCC-8.2.0-2.31.1
```

or equivalently:

```Bash
$ module add OpenMPI/3.1.3-GCC-8.2.0-2.31.1
```

This will provide access to OpenMPI, but also to GCC and other libraries. With this principle it is verified that the library versions are loaded, which were used to build the package. 

## List all Loaded Modules

You can list the currently loaded modules using 

```Bash
$ module list

Currently Loaded Modules:
  1) GCCcore/8.2.0
  2) zlib/.1.2.11-GCCcore-8.2.0       (H)
  3) binutils/.2.31.1-GCCcore-8.2.0   (H)
  4) GCC/8.2.0-2.31.1
  5) numactl/2.0.12-GCCcore-8.2.0
  6) XZ/.5.2.4-GCCcore-8.2.0          (H)
  7) libxml2/.2.9.8-GCCcore-8.2.0     (H)
  8) libpciaccess/.0.14-GCCcore-8.2.0 (H)
  9) hwloc/1.11.11-GCCcore-8.2.0
 10) OpenMPI/3.1.3-GCC-8.2.0-2.31.1

  Where:
   H:  Hidden Module
```

## Toolchains / version consistency

When loading **multiple modules** it is strongly suggested to stay within **one toolchain version**.

A toolchain is a set of modules all building on top of each other. The related packages and versions can be listed with the command above. 
There are two basic toolchains families: 

| Toolchain | packages |
| --------- | --------- |
| foss      | GCC, OpenMPI, OpenBLAS, FFTW, ScaLAPACK |
| intel     | Intel compiler, (GCC required), MKL, Intel MPI |

Furthermore, toolchains are provided in different versions and updated regularly.

The two main toolchains foss and intel are subdivided into sub-toolchains that belong to the same family:

| Family | Subtoolchains |
| --------- | --------- |
| foss     | GCC, gompi |
| intel     | iompi, iomkl |

When loading multiple packages, they should be based on the **same toolchain** (or at least the same toolchain family) and the **same version**.

In the following are two examples where `netCDF` and `FFTW` should be loaded, but the based toolchains and versions do not match. 

### Problematic example: different toolchains

```
module load netCDF/4.7.3-gompi-2019b
module load FFTW/3.3.8-intel-2019b
```
NetCDF is loaded in the `gompi` toolchain, including OpenMPI. `FFTW` is loaded in the `intel` toolchain, including `iimpi` (IntelMPI). Beside other, now **two different MPI** implementation are loaded. We cannot verify that each package uses the MPI library it is build with. In best case this leads to errors during run time. In worse case results are incorrect. 

### Problematic example: toolchain versions

```
$ module load netCDF/4.7.4-gompi-2020b
$ module load FFTW/3.3.7-gompi-2018a

The following have been reloaded with a version change:
  1) GCC/10.2.0 => GCC/6.4.0-2.28                                      5) gompi/2020b => gompi/2018a
  2) GCCcore/10.2.0 => GCCcore/6.4.0                                   6) hwloc/2.2.0-GCCcore-10.2.0 => hwloc/1.11.8-GCCcore-6.4.0
  3) OpenMPI/4.0.5-GCC-10.2.0 => OpenMPI/2.1.2-GCC-6.4.0-2.28          7) numactl/2.0.13-GCCcore-10.2.0 => numactl/2.0.11-GCCcore-6.4.0
  4) binutils/.2.35-GCCcore-10.2.0 => binutils/.2.28-GCCcore-6.4.0
```

LMOD already notes the version changes. In this case, netCDF build with 2020a version will utilize libraries of 2018a. If interfaces have changed, **errors may occur**.

## Unload/remove Modules

To prevent unwanted influences between software packages, it is advisable to keep the loaded software stack small and clean. 

Certain modules can be unloaded using:

```Bash
$ module unload OpenMPI/3.1.3-GCC-8.2.0-2.31.1
```
or equivalently:

```Bash
$ module rm OpenMPI/3.1.3-GCC-8.2.0-2.31.1
```

!!! types note ""
    This will only unload the specified module. 
    Dependencies stay loaded, which were automatically loaded when loading the specified modulefile. 
    A clean environment can be obtained with purge (see below).

## Purge all Modules

All currently loaded modules an be unloaded using:

```Bash
$ module purge
```


## Show information

Most modules provide a short description which software package they contain and a link to the homepage, as well as information about the changes of environment undertaken. From short to full detail:

```Bash
$ module whatis OpenMPI
```

```Bash
$ module help OpenMPI
```

```Bash
$ module show OpenMPI
```

## Environment definitions

Working on different projects or with different types of task may require to load different sets of modules. 

There are two ways of providing a user environment setups, e.g. for development, production, post processing etc., a custom module (also for Workspaces) or a module user collections (per user). 

!!! type warning ""
    Adding module load into `.bashrc` may lead to issues. If you diverge from this "default" environment and additionally load conflicting modules, e.g. form another toolchain. 

### Module User Collections

Sets of modules can be stored and reloaded in LMOD using the "user collection" feature. 

As an example, a set of module for development consiting of SciPy-bundle and netCDF should be stored under the name ***devel***. Further module lists can be managed in the same way (here lists for ***test*** and ***prod*** already exist). 

```Bash
$ module load SciPy-bundle netCDF
$ module save devel
Saved current collection of modules to: "devel"
$ module savelist
Named collection list :
  1) devel  2) test  3) prod
```
Therewith the set of modules can be loaded using:

```Bash
$ module restore devel
```

This will unload **all** other previously loaded modules beforehand and then load the set specified in the collection. 

!!! types note ""
    This method is preferred against defining/loading a set of modules in Bash configuration like .bashrc.

More information can be found in the [LMOD documentation](https://lmod.readthedocs.io/en/latest/010_user.html#user-collections)

### Custom Modules

A so called "Meta Module" can be used to specify a set of modules. Additionally, environment variables can be defined. These custom modules can be placed in the custom software stack, e.g. in a Workspace. Thus default working environments could be defined for the users that workspace. You may want to decide if you want to specify the environment with all versions of the modules (advisable), or always the latest versions (no version specified). 

The modules can be placed into `$WORKSPACE/modulefiles/$NAME/$VERSION.lua`.

#### Example: Lua module for development environment
Here an environment is defined using foss and netCDF of version 2021a. Additionally an environment variable `WS_ENV` is set to `devel`. 
Therefore, a file `$WORKSPACE/modulefiles/WS_devel/2021a.lua` is created with the following content:

```Lua
whatis([==[Description: Workspace XXX development environment]==])
if not ( isloaded("foss/2021a") ) then
    load("foss/2021a")
end
if not ( isloaded("netCDF/4.8.0-gompi-2021a") ) then
    load("netCDF/4.8.0-gompi-2021a")
end
setenv("WS_ENV", "devel")
setenv("CFLAGS", "-DNDEBUG")
```

The all workspace members can load this environment using:

```Bash
module purge   ### better start with a clean environment
module load Workspace WS_devel
```

