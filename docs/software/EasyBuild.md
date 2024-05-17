# EasyBuild

## Description
EasyBuild can install software packages including the related modules. The location will be controlled using our modules, e.g. the `Workspace` module, see [Installing Custom Software](installing-custom-software.md).
On top of the usual EasyBuild framework we added some extensions which allows you to build for specific architectures or a generic software stack in your user/group space. 
Therefore, use the `eb` command to search and try and the `eb-install-all` command to install the package. 

The following steps need are necessary:

- load modules
- find the package specification
- decide the desired software stack
- run EasyBuild installation using `eb-install-all`

## Modules
Depending if you want to install the package in user or a group space you need to load the related module and the `EasyBuild` module, e.g.:

```Bash
module load Workspace  ### if you want to install into your HOME use module load Workspace_Home
module load EasyBuild
```

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

**Select one**, here `GATK-4.1.8.1-GCCcore-9.3.0-Java-1.8.eb` is chosen.

Alternatively, the packages can be listed or selected using the package name and target toolchain and version:

```Bash
eb --software-name=GATK --toolchain-name=GCC --toolchain-version=9.3.0
```

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

You can use the directly selected EasyConfig or if necessary copy and adapt it.
EasyConfig files are text files specifying the software version, toolchain version, dependencies, compile arguments and more.
If you need more information see [EasyBuild documentation](https://easybuild.readthedocs.io/en/latest/), and if necessary ask our support team for assistance.

## Meta module and Toolchains
Modules specify related dependencies, which gets loaded with that module. These dependencies may have further dependencies.

The chain of dependencies is called toolchain. For example:

- `GCC` consists of `GCCcore` and `binutils`
- `gompi` consists of `GCC` and `OpenMPI`
- `foss` consists of `gompi`, `OpenBLAS`, `FFTW` and `ScaLAPACK`

Within a toolchain the versions of the utilized libraries should be consistent. Thus, building a new package with `foss/2020b` and `PyTorch` should rely on a PyTorch version build with the same versions of the underlying libraries. Thus e.g. `PyTorch-1.9.0-foss-2020b.eb` is also build with `foss/2020b` as well as the `Python/3.8.6`. The latter one is build with `GCCcore/10.2.0` which is part of `foss/2020b`. 

## Selecting a software stack
Depending on the package and its target usage one or more software stacks should be selected. Therefore, the installation command starts with one for the following command:

- all architectural software stacks: `eb-install-all `
- a specific architectural software stack (e.g. only targeting Broadwell nodes): `eb-install-all --archs='broadwell' ` OR

## Installation
After selecting the package installation recipe and the target software stack, the installation process can be submitted. 
With the following commands, SLURM job files will be created, and submitted to the desired compute nodes. There the packages are build and module files created. The general syntax is: 
```Bash
eb-install-all [options] [easybuild options] <easyconfig>.eb
```
Additional SLURM arguments can be selected using the `--slurm-args` option, e.g. `--slurm-args='--account=xyz --time=00:10:00 --cpus-per-task'`. If specific architectures should be selected use e.g. `--arch='broadwell ivy'`. After this options, EasyBuild arguments can be provided without prefix, e.g. `--robot`. 

Few examples:

- for a **selected** or **custom** EasyConfig and all missing dependencies in **all architectural** software stacks (here we go with the above selected GATK):
```Bash
eb-install-all --robot GATK-4.1.8.1-GCCcore-9.3.0-Java-1.8.eb
```
- only in the **Broadwell and Login** software stack installing **FFTW** in GCC toolchain (newest version):
```Bash
eb-install-all --robot --archs='login broadwell' --software-name=FFTW --toolchain-name=GCC
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

## Adapting EasyConfigs
in the following description and example we update an existing old EasyConfig for newer versions. In our case we want to update the version of Relion, the toolchain, and dependent libraries it is build with. 

- setup EasyBuild environment
```
module load EasyBuild
module load Workspace   ### OR Workspace_Home
```

- find a suitable easyconfig
```
$ eb --search Relion 
```
alternatively you may find easyconfigs online, e.g. [https://github.com/easybuilders/easybuild-easyconfigs](https://github.com/easybuilders/easybuild-easyconfigs)

- copy the easyconfig into a working directory (here `.`)
```
$ cp $EBROOTEASYBUILD/easybuild/easyconfigs/r/RELION/RELION-3.0.4-foss-2017b.eb .
```

- rename to the targeted versions (here newer relion, newer toolchain)
```
$ mv RELION-3.0.4-foss-2017b.eb RELION-3.1.2-foss-2020b.eb
```

- find the new versions of toolchain and libraries
    - all installed version of a package can be listed using `module avail package`, e.g. `module avail foss`
    - available easyconfigs of non-installed packages can be listed using `eb --search package`. If there is a targeted version available, you can just define that dependency version in the above easyconfig and EasyBuild will find and use it. 

- update the versions settings in the file
    - package version, the toolchain version, and all related libraries
    - Keep in mind that toolchain versions need to match (see [toolchains](#meta-module-and-toolchains) above)
```Lua
easyblock = 'CMakeMake'

name = 'RELION'
version = '3.1.2'                            #### The Relion version was '3.0.4' before

homepage = 'http://www2.mrc-lmb.cam.ac.uk/relion/index.php/Main_Page'
description = """RELION (for REgularised LIkelihood OptimisatioN, pronounce rely-on) is a stand-alone computer
 program that employs an empirical Bayesian approach to refinement of (multiple) 3D reconstructions or 2D class
 averages in electron cryo-microscopy (cryo-EM)."""

toolchain = {'name': 'foss', 'version': '2020b'}   ### the foss toolchain version was 2020b before
toolchainopts = {'openmp': True}

source_urls = ['https://github.com/3dem/relion/archive']
sources = ['%(version)s.tar.gz']
checksums = ['2580d66088923a644bc7d3b02efd154b775a3ec3d010426f382bb3be5db9c98b']

builddependencies = [('CMake', '3.18.4')]    ### was 3.9.5

dependencies = [
    ('X11', '20201008'),                     ### was 20171023
    ('FLTK', '1.3.5'),                       ### was 1.3.4
    ('LibTIFF', '4.1.0'),                    ### 4.0.9
    ('tbb', '2020.3'),                       ### 2018_U5
]

configopts = "-DCMAKE_SHARED_LINKER_FLAGS='-lpthread'  -DMPI_INCLUDE_PATH=$EBROOTOPENMPI/include "
configopts += "-DMPI_C_COMPILER=$EBROOTOPENMPI/bin/mpicc -DMPI_CXX_COMPILER=$EBROOTOPENMPI/bin/mpicxx "
configopts += "-DCUDA=OFF -DCudaTexture=OFF "
configopts += "-DALTCPU=ON -DFORCE_OWN_TBB=OFF "

sanity_check_paths = {
    'files': ['bin/relion'],
    'dirs': []
}

moduleclass = 'bio'
```

- update the checksum (if package version is changed)
The downloaded source packages are typically checked with SHA256 checksums. When we change to a different source code versio, the checksum changes too. And need to be updated.
```Bash
$ eb --force --inject-checksums sha256 RELION-3.1.2-foss-2020b.eb
```

- build the new package as described in [Installation](#installation) above, e.g.
```Bash
$ eb-install-all --robot RELION-3.1.2-foss-2020b.eb
```

## Tips and tricks

Even if EasyBuild tries to simplify the installation process, not always EasyConfigs are Build without issues. There can be several types of issues. Starting form issues in finding exiting packages up to compilation issues. 

### More information

In the EasyBuild output `eb_out.*` files are issues summarized. Often more details are required. There are more detailed log files created in the temporary directory. 
On the compute nodes they are deleted at the end of the job, but on the login node (epyc2) they are kept. The location is mentioned near the end of the output and typically is after `Results of the build can be found in the log file`.

### Lock directories

EasyBuild has a procedure to prevent building the same package (same version, same software stack) using lock files. If `eb-install-*` crashes **due to time limit**, the lock files are not removed properly. Therewith the next time you start `eb-install-*` for that package a message like will be presented at the end of the output:

```Bash
ERROR: Build of /path/to/easyconfig.eb failed (err: 'build failed (first 300 chars): Lock /path/to/.locks/packageVersion.lock already exists, aborting!')
```
In that moment the lock file should be already removed and the process can finally be started successfully again. 

### Hidden Modules

Sometimes packages are not defined consistently. On UBELIX many packages are provided as hidden modules. This keeps the list nice and tidy. Nevertheless, if a package (or worse one of its dependency) is looking for an existing packages, but it is not mentioned to be hidden, it will not find and need to rebuild again. 

Hidden packages can be searched using `module --show-hidden avail <PackageXYZ>`. If existing as hidden and the target package or dependency does not define it as hidden, EasyBuild can be advised to treat it as hidden using the `--hide-deps` option. E.g. for binutils, gettext and Mesa, the command would look like:

```Bash
$ eb-install-all --hide-deps=binutils,gettext,Mesa <PackageXYZ>
```

### Directly on the compute node

The eb-install-all tool builds the packages directly on a compute node. The node type can be limited/specified by using the option `--archs=<type>` (see `eb-install-all --help`). 

If this fails, an investigation step may be running directly on the node, without more control of the setup, e.g. build directories. Therefore, EasyBuild can be started directly in a session on the compute node. First, an interactive session is established on the compute node. For example building Relion in the `$HOME` on an epyc2 node using a local copy of the EasyConfig file:

```Bash
$ srun --pty --partition epyc2 bash
$ module load Workspace_Home EasyBuild
$ eb --tmpdir=$TMPDIR --robot --hide-deps=binutils,gettext,Mesa RELION-3.1.3-fosscuda-2020b.eb
```

This may also be used when compiling **on** a specific GPU architecture. 
