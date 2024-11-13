[lmod-docs]: https://lmod.readthedocs.io/en/latest/

# Software Environment

Software on UBELIX can be accessed through modules. With the help of the `module`
command, you will be able to load and unload the desired compilers, tools and
libraries.

Software modules allow you to control which software and versions are available
in your environment. Modules contain the necessary information to allow you to
run a particular application or provide you access to a particular library so
that

- different versions of a software package can be provided.
- you can easily switch to different versions without having to explicitly
  specify different paths.
- you don't have to deal with dependent modules, they are loaded at the same
  time as the software.

## The `module` command

Modules are managed by the `module` command:

```bash
$ module <sub-command> <module-name>
```

where the _sub-command_ indicates the operation you want to perform. The
_sub-command_ is followed by the name of the module on which you want to perform
the operation.

| Sub-command      | Description                                          |
| -----------------|------------------------------------------------------|
| `spider`         | Search for modules and display help                  |
| `keyword`, `key` | Search for modules based on keywords                 |
| `avail`, `av`    | List available modules                               |
| `whatis`         | Display short information about modules              |
| `help`           | Print the help message of a module                   |
| `list`           | List the currently modules loaded                    |
| `load`, `add`    | Load a module                                        |
| `unload`         | Remove a module from your environment                |
| `purge`          | Unload all modules from your environment             |
| `show`           | Show the commands in the module's definition file    |

## Finding modules

Lmod is a hierarchical module system. It distinguishes between installed modules
and available modules. Installed modules are all modules that are installed on
the system. Available modules are all modules that can be loaded directly at
that time without first loading other modules. The available modules are often
only a subset of the installed modules. However, Lmod can tell you for each
installed module what steps you must take to also make it available so that
you can load it. Therefore, the commands for finding modules are so important.

Some modules may also provide multiple software packages or extensions. Lmod can
also search for these.


### module spider

The basic command to search for software on UBELIX is `module spider`.
It has three levels, producing different outputs:

 1. `module spider` without further arguments will produce a list of all
    installed software and show some basic information about those packages.
    Some packages may have an `(E)` behind their name and will appear in blue
    (in the default color scheme) which means that they are part of a different
    package. The following levels of `module spider` will then tell you how to
    find which module(s) to load.

    Note that `module spider` will also search in packages that are hidden from
    being displayed. These packages can be loaded and used. However, we hide them
    either because they are not useful to regular users or because we think that
    they will rarely or never be directly loaded by a user and want to avoid
    overloading the module display.

 2. `module spider <name of package>` will search for the specific package. This
    can be the name of a module, but it will also search some other information
    that can be included in the modules. The search is case-insensitive, e.g.

    ```bash
    $ module spider netcdf
    ```

    will show something along the lines of

    ```text
    ------------------------------------------------------------------------------------------------------------------------------------
         netCDF:
    ------------------------------------------------------------------------------------------------------------------------------------
        Description:
          NetCDF (network Common Data Form) is a set of software libraries and machine-independent data formats that support the
          creation, access, and sharing of array-oriented scientific data.

         Versions:
            netCDF/4.8.0-gompi-2021a
            netCDF/4.9.0-gompi-2022a
            netCDF/4.9.2-gompi-2023a
            netCDF/4.9.2-iimpi-2023a

    ------------------------------------------------------------------------------------------------------------------------------------
      For detailed information about a specific "netCDF" package (including how to load the modules) use the module's full name.
    ```

    (abbreviated output) so even though the capitalization of the name was wrong, it can tell us that
    there are multiple versions of the netCDF library. The `gompi-xxxx` and
    `iimpi-xxxx`
    tell that the difference is the compiler that was used to install the
    library. This is important as it is risky to combine modules
    compiled with different compilers.

    In some cases, if there is no ambiguity, `module spider` will
    already produce help about the package.

 3. `module spider <module name>/<version>` will show more help information
    about the package, including information on which other modules need to be
    loaded to be able to load the package, e.g.

    ```bash
    $ module spider git/2.41.0-GCCcore-12.3.0-nodocs
    ```

    will return

    ```text
    ------------------------------------------------------------------------------------------------------------------------------------
      git: git/2.41.0-GCCcore-12.3.0-nodocs
    ------------------------------------------------------------------------------------------------------------------------------------
        Description:
          Git is a free and open source distributed version control system designed to handle everything from small to very large
          projects with speed and efficiency.


        This module can be loaded directly: module load git/2.41.0-GCCcore-12.3.0-nodocs

        Help:
          Description
          ===========
          Git is a free and open source distributed version control system designed
          to handle everything from small to very large projects with speed and efficiency.


          More information
          ================
           - Homepage: https://git-scm.com

    ```


### module avail

The `module avail` command is used to show only available modules, i.e., modules
that can be loaded directly without first loading other modules. It can be used
in two ways:

 1. Without a further argument, it will show an often lengthy list of all
    available modules. Some modules will be marked with `(D)` which means that
    they are the default module that would be loaded should you load the module
    using only its name.

 2. With the name of a module (or a part of the name), it will show all modules
    that match that (part of) a name:

    ```bash
    $ module avail netcdf
    ```

    will show something along the lines of

    ```text
    ----------------------------------------------------- /software.9/modulefiles/data -----------------------------------------------------
       netCDF-C++4/4.3.1-gompi-2023a           netCDF-Fortran/4.6.1-iimpi-2023a (D)    netCDF/4.9.2-gompi-2023a
       netCDF-C++4/4.3.1-iimpi-2023a    (D)    netCDF/4.8.0-gompi-2021a                netCDF/4.9.2-iimpi-2023a (D)
       netCDF-Fortran/4.6.1-gompi-2023a        netCDF/4.9.0-gompi-2022a

      Where:
       D:  Default Module

    ```

## Loading and unloading modules

Loading and unloading modules in Lmod is very similar to other module systems.
Also, note that only *available* modules can be loaded with the commands below.
Some *installed* modules may only become *available* after first loading other
modules as discussed above.

To load a module, use the `module load` command. For example, to load the 
FFTW library, use:

```bash
$ module load FFTW
```

This command will load the default version of the module. If the software you
loaded has dependencies, they will be loaded in your environment at the same
time.

To load a specific version of the module, you need to specify it after the name
of the module:

```bash
$ module load FFTW/3.3.10-GCC-12.3.0
```

To unload a module from your environment, use the `unload` sub-command
followed by the name of the module you want to remove.

```
$ module unload FFTTW
```

In most cases multiple `module load` or `module unload` commands can be combined
in a single `module load` or `module unload` command.

You can also remove all loaded modules from your environment by using the
`purge` sub-command.

```bash
$ module purge
```

## Listing loaded modules

You can list currently loaded modules using

```Bash
$ module list
```

## Workspace modules

Workspace modules provide support for user-friendly file system access and custom software stacks in HPC Workspaces.

```
module load Workspace
```

The workspace module provides the following variables:

|  <div style="width:180px">Variable</div> | Function |
| -------- | -------- |
| `$WORKSPACE` | full path to the Workspace. Thus, you can access the workspace using: `cd $WORKSPACE` |
| `$SCRATCH`  | full path to the Workspace SCRATCH directory. Thus you can access it using: `cd $SCRATCH` |

The Workspace module provides tools to install custom software within your Workspace. See our [EasyBuild](../software/installing/easybuild.md) documentation for details on how to install software modules for all users of a Workspace. Workspace software modules can be accessed by loading the Workspace module and the software product module.

The workspace module will also modify the following environment variables: 

|  <div style="width:180px">Variable</div> | Function |
| -------- | -------- |
| `$APPTAINER_BINDPATH` | using singularity, the Workspace directory will be bind into the container without manual specification. The `WORKSPACE` variable as well as the `SCRATCH` variable will also be ported into the container. Thus, you can specify locations with `$WORKSPACE` or `$SCRATCH` within the container. | 
| `$PYTHONPATH` | if `Python` or `Anaconda` is loaded beforehand, it is set to: `$WORKSPACE/PyPackages/lib/pythonXXX/site-packages` where `XXX` is the Python major and minor version. And also add the `bin` directory to `$PATH`. |
| `$PYTHONPACKAGEPATH` | if `Python` or `Anaconda` is loaded beforehand, it is set to: `$WORKSPACE/PyPackages`. This can be used for e.g. `pip install --prefix $PYTHONPACKAGEPATH` |
| `$CONDA_ENVS_PATH` | used to create conda environments shared within the Workspace |
| `$R_LIBS` | used to install additional R packages in the shared Workspace. The directory need to be created first. See [R page](installing/r.md#installing-r-packages-into-a-shared-workspace)|


!!! note "umask"

    The Workspace module sets the umask to 002. Thus files and directories get group-writeable, e.g.:
    ```Bash
    -rw-rw-r-- 1 user group 0 Mar 15 15:15 /path/to/file
    ```

!!! tip "Special Workspaces"

    The special module  `Workspace_Home` can be used to setup your `$HOME`
    directory as a personal workspace.

    The special module `Workspace_SW_only` can be used to provide the access to a software stack of an HPC Workspace `B` while working in an HPC Workspace `A`:

    ```Bash
    HPC_WORKSPACE=A module load Workspace
    HPC_WORKSPACE=B module load Workspace_SW_only
    ```

    When you want to load packages from your `$HOME` workspace while working in `A`, use

    ```Bash
    HPC_WORKSPACE=$HOME module load Workspace_SW_only
    HPC_WORKSPACE=A module load Workspace
    ```

!!! type note ""
    Note that the variable `HPC_WORKSPACE` is cleared after each loading of a `Workspace*`module. The currently loaded Workspace names are stored in `$HPC_WORKSPACE_LOADED` for the Workspace module and `$HPC_WORKSPACE_SW_ONLY` for the Workspace_SW_only module.


## Toolchains

A toolchain is a set of modules all building on top of each other.
Toolchains are provided in different versions and updated typically
once a year. The UBELIX team will only support the three most recent toolchain
versions available.

The two main toolchains foss and intel are subdivided into sub-toolchains that belong to the same family.

| Toolchain | packages |
| --------- | --------- |
| foss      | GCC, OpenMPI, OpenBLAS, FFTW, ScaLAPACK |
| intel     | Intel compiler, (GCC required), MKL, Intel MPI |


| Family | Subtoolchains |
| --------- | --------- |
| foss     | GCC, gompi |
| intel     | iompi, iomkl |

!!! tip "Matching toolchain and version"

    When loading multiple modules, they should be based on the same toolchain (or at least the same toolchain family) and the same version.

    Use `module list` to show loaded modules and verify matching versions!

## Saving your environment

Sometimes, if you frequently use multiple modules together, it might be useful
to save your environment as a module collection.

A collection can be created using `save` sub-command.

```bash
$ module save <collection-name>
```

Your saved collections can be listed using the `savelist` sub-command.

```bash
$ module savelist
```

Of course, the main interest of a collection is that you can load all the
modules it contains in one command. This is done using the `restore`
sub-command.

```bash
$ module restore <collection-name>
```

More options to manage collections of modules can be found by running `module
help` or in the [Lmod User Manual][lmod-docs].

## Pre-installed software

This a (incomplete) list of the pre-installed software available on UBELIX.

### Toolchains / Compilers

| Name | Version(s) |
| ---- | ---------- |
| foss | 2021a, 2021b, 2022a, 2022b, 2023a |
| intel | 2021a, 2021b, 2022a, 2022b, 2023a |
| | |
| PGI | 19.4 |
| NAGfor | 6.2.14 |
| NVHPC | 23.7 (CUDA/12.1.1) |

### GPU Compiler / Tools

| Name | Version(s) |
| ---- | ---------- |
| CUDA | 11.8.0, 12.1.1, 12.2.0 |
| cuDNN | 8.7.0 (CUDA 11.8.0), 8.9.2 (CUDA 12.1.1 / 12.2.0) |

### Ecosystems

| Name | Version(s) |
| ---- | ---------- |
| Anaconda3 | 2023.09-0, 2024.02-1 |
| R | 4.2.1 |
| MATLAB | R2023b |

### Scientific libraries

| Name | Version(s) |
| ---- | ---------- |
| GDAL | 3.7.1 |
| GEOS | 3.12.0 |
| GMP  | 6.2.1 |
| GSL  | 2.7 |
| HDF5 | 1.14.0 |
| netCDF | 4.9.2 |
| netCDF-C++4 | 4.3.1 |
| netCDF-Fortran | 4.6.1 |

### Scientific software
| Name | Version(s) |
| ---- | ---------- |
| Bowtie2 | 2.4.4 |
| BLAST | 2.2.26 |
| canu | 2.2 |
| CDO | 2.1.1, 2.2.2 |
| Clustal-Omega | 1.2.4 |
| CP2K | 2023.1 |
| cutadapt | 3.4 |
| GROMACS | 2023.3 |
| MEGAHIT | 1.2.9 |
| Nextflow | 23.04.2 |
| NCO | 5.1.9 |
| ORCA | 5.0.3 |
| RAxML | 8.2.12 |
| RSEM | 1.3.3 |
| RSeQC | 4.0.0 |
| Subread | 2.0.3 |
| SMRT-Link | 13.1.0 |
| prokka | 1.14.5 |

### Visualization

| Name | Version(s) |
| ---- | ---------- |
| ncview | 2.1.8 |
| ParaView | 5.11.2 |
