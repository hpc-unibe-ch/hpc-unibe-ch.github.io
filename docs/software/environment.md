# HPC software environment

[//]: # (TODO HPC modules, Env Variables, Easybuild, ...)
## Description

On our HPCs we provide a Linux bash environment. 
The Basic Linux commands are immediately available while more elevated software packages need to be loaded. 
For managing the your environment and accessing software products we use the **module** tool Lmod. 
This enables you to modular activate and deactivate software packages in your current shell session. 

### Load/Add a Modulefile

```Bash
module load OpenMPI/3.1.3-GCC-8.2.0-2.31.1
```

or equivalently:

```Bash
$ module add OpenMPI/3.1.3-GCC-8.2.0-2.31.1
```


### List all Loaded Modulefiles

```Bash
$ module list

Currently Loaded Modules:
  1) GCCcore/8.2.0                    3) binutils/.2.31.1-GCCcore-8.2.0 (H)   5) numactl/2.0.12-GCCcore-8.2.0       7) libxml2/.2.9.8-GCCcore-8.2.0     (H)   9) hwloc/1.11.11-GCCcore-8.2.0
  2) zlib/.1.2.11-GCCcore-8.2.0 (H)   4) GCC/8.2.0-2.31.1                     6) XZ/.5.2.4-GCCcore-8.2.0      (H)   8) libpciaccess/.0.14-GCCcore-8.2.0 (H)  10) OpenMPI/3.1.3-GCC-8.2.0-2.31.1

  Where:
   H:  Hidden Module
```

### Unload/remove a Modulefile

!!! types note ""
    This will only unload the specified modulefile, but not the dependencies that where automatically loaded when loading the specified modulefile (see purge below).

```Bash
$ module unload OpenMPI/3.1.3-GCC-8.2.0-2.31.1
```
or equivalently:

```Bash
$ module rm OpenMPI/3.1.3-GCC-8.2.0-2.31.1
```

### Purge all Modulefiles

!!! types note ""
    This will unload all previously loaded modulefiles.

```Bash
$ module purge
```



