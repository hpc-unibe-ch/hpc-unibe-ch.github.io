# HPC software environment

[//]: # (TODO HPC modules, Env Variables, Easybuild, ...)
## Description

On UBELIX the default shell is Bash. With the operation system, a list of basic tools (mainly command line tools) are provided, including editors, file analyzing and manipulation tools, packing and transfer tools etc. This commands are accessible all the time. 

Other software packages (libraries and applications) are available via the **LMOD** (lua modules) modules. By the help of this tool a lot of different packages even in different versions can be provided, without unwanted influences. 

Furthermore, software stacks are provided one for each CPU architecture. These are loaded automatically on the related architecture, transparent to the user.

Additionally to our software stack, **VITAL-IT** provides a software stack targeting mainly bioinformatics users, see [Bioinformatics Software](#BioinformaticsSoftware).

## Basic concept

Many Linux settings are in environment variables. These include search paths for applications (`$PATH`) and libraries (`$LD_LIBRARY_PATH`). Adding or removing a directory to these lists, provides access or remove access to additional software. 

The **LMOD** modules are an user friendly way to search and manage software packages without dealing with complicated directory names.

In general every software package has its related module. When loading the module the software package **and** its dependencies get accessible. 

But let's do it step by step.

## List available Modules
There are various ways to search for a software package. You can list all currently available packages using:
```Bash
module avail
```

You can search for an packages ***starting*** with a specific string, e.g. all version of GCC:
```Bash
module avail GCC
```

Furthermore, the following command lists you all the modules containing a certain sub-string in the name, even in other software stacks, e.g.:
```Bash
module spider Assembler
```

In the example above all modules with the sub-string *Assembler* will be listed, in this case the ones from the Vital-It software stack. 

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
There are two basic toolchains which are build up on top of GCC and Intel:

| Toolchain | packages |
| --------- | --------- |
| GCC       | GCC compiler |
| gompi     | GCC, OpenMPI |
| gompic    | GCC, OpenMPI, CUDA |
| foss      | GCC, OpenMPI, OpenBLAS, FFTW, ScaLAPACK |
| fosscuda  | GCC, OpenMPI, OpenBLAS, FFTW, ScaLAPACK, CUDA |
| | |
| intel     | Intel compiler, (GCC required), MKL, Intel MPI |
| iompi     | Intel compiler, OpenMPI |
| iomkl     | Intel compiler, OpenMPI, MKL |

Furthermore, toolchains are provided in different versions and updated regularly.

When loading multiple packages, they should be based on the **same toolchain** and the **same version**.

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

## Bioinformatics Software

In co-operation with the [Vital-IT Group](http://www.vital-it.ch/) of the [SIB Swiss Institute of Bioinformatics](http://www.isb-sib.ch/), a large set of [bioinformatics software tools and databases](https://www.vital-it.ch/services/software) is available to the life science community.

To list all modulefiles provided by Vital-IT, you have to first load the `vital-it` module:

!!! types note ""
    Loading the vital-it modulefile automatically configures the environment to use specific versions of selected software, e.g. python v2.7.5, and gcc v4.9.1

```Bash
 $ module load vital-it && module avail
```

## Module User Collections

Working on different projects or with different types of task may require to load different sets of modules. These sets can be managed with the LMOD "user collection" feature. 

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

This will unload all other previously loaded modules beforehand. 

!!! types note ""
    This method is preferred against defining/loading a set of modules in Bash configuration like .bashrc.

More information can be found in the [LMOD documentation](https://lmod.readthedocs.io/en/latest/010_user.html#user-collections)

## Modules background

### Architectural software stacks

On our HPCs we use LMOD (Lua modules) to provide access to different software packages and different versions. Beside different packages and versions, we provide software stacks build for the different CPU architectures. This enables us to have the packages build e.g. with AVX2 for Broadwell CPUs, but also a version with only SSE4 for Ivybridge CPUs. These software stacks are completely transparent to the user and will be used automatically when loading a module on the related architecture. 

If you want to build your own software build for specific Hardware, we provide tools which help you, see [Installing Custom Software](installing-custom-software.md)

### Scientific Software Management

Our scientific software stack, available via module files are mainly build with EasyBuild. This tool helps us to install and maintain software packages and recycle existing installation procedures. There are plenty of install instructions available [EasyBuild/Easyconfigs](https://github.com/easybuilders/easybuild-easyconfigs), which can be installed also in the user space with low effort, see [Installing Custom Software](installing-custom-software.md)