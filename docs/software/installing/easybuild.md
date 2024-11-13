# EasyBuild

[workspace]: ../../storage/index.md

Most pre-installed software in the UBELIX software stack is
installed through [EasyBuild](https://easybuild.io/). The central software
stack is kept as compact as possible to ease maintenance and to avoid user
confusion. E.g., packages for which users request special customisations will
never be installed in the central software stack.

This, however, does not mean that you manually compile all the software 
you need for your project on UBELIX. We have made it very easy to
install additional software in your home or workspace directories (where the
latter is a better choice as you can then share it with the other people in your
project). After installing, using the software requires not much more than loading a module
in exactly the same way as it would be in a central installation.

## Beginner's guide to installing software on UBELIX

*If you are new to EasyBuild and UBELIX, it might be a good idea to first read 
through this chapter once, and then start software installations.*

### EasyBuild recipes

EasyBuild installs software through recipes that give instructions to create a single
module that most of the time provides a single package.
It will also tell EasyBuild which other modules a package depends on,
so that these can also be installed automatically if needed (through their own EasyBuild recipes).

An EasyBuild build recipe is a file with a name that consists of different
components and ends with '.eb'. Consider, e.g., a build recipe for the software CDO:

```text
CDO-2.2.2-gompi-2023a.eb
```

The first part of the name, `CDO`, is the name of the package. The second
part of the name, `2.2.2` is the version of CDO, in this case the
2.2.2 release. 

The next part, `gompi-2023a`, denotes the so-called *toolchain*
used for the build. The most common EasyBuild toolchains on UBELIX are:

| Toolchain | packages |
| --------- | --------- |
| foss      | GCC, OpenMPI, OpenBLAS, FFTW, ScaLAPACK |
| intel     | Intel compiler, (GCC required), MKL, Intel MPI |
| gompi     | GCC, OpenMPI |
| iimpi     | Intel compiler, Intel MPI |


Some recipes also compute with a version suffix. Version suffixes are
typically used to distinguish different builds of the same package version, i.e,
a CUDA enabled version and a standard version.

EasyBuild build recipes are stored in repositories with a fixed directory 
structure. On UBELIX we already provide two such repositories,
one containing all the software that is installed in the central software
stack and one that contains EasyBuild recipes that users can install
themselves or use as a basis to make a customised installation of software.

### Preparation: Load Workspace and EasyBuild modules

In most cases a subdirectory in your `[Workspace][workspace]`
directory is the best location to install software as that directory
is shared with all users in your project so that everybody can use the software.
Therefore, EasyBuild will by default install software in `$WORKSPACE/EasyBuild`.
However, since this environment variable is empty, you need to load the
Workspace module to populate the variable:

```Bash
module load Workspace
```

Alternatively you can install software in your user home.

```Bash
module load Workspace_Home
```

!!! tip

    With the `Workspace`-module loaded you will also see the software that you have installed yourself
    when you do `module avail`. Also, `module spider` will also search those directories.


### Step 1: Load EasyBuild

The next step to install software in the directory you have just indicated, is
to load the `EasyBuild` module:

```bash
$ module load EasyBuild
```

If you want
more information about the full configuration of EasyBuild including the paths
were new software will be installed, you can execute

```bash
$ eb --show-config
```

EasyBuild is configured so that it searches in the user repository and the
default repository on the system. The current directory is not part of the default
search path but can be easily added with a command line option. By default,
EasyBuild will not install dependencies of a package and fail instead, if one or
more of the dependencies cannot be found, but that is also easily changed on
the command line.

### Step 2: Find a package and selecting the toolchain

EasyBuild has a large repository of available packages in different versions.
Available packages can be searched using the following command, here for the **CDO** package

```Bash
eb --search CDO
```

You will find that there are different versions of CDO and for different *toolchains* available (`gompi`, `iimpi`).

You can list all dependencies using:

```Bash
eb -Dr CDO-2.2.2-gompi-2023a.eb
```

Dependencies marked with `x` are already installed, the other dependencies will be installed if using the robot option.

### Step 3: Install the package

To show how to actually install a package, we continue with our
`CDO-2.2.2-gompi-2023a.eb` example.

After selecting the package installation recipe and the target software stack, the installation process can be submitted. 
With the following commands, SLURM job files will be created, and submitted to the compute nodes. There the packages are build and module files created. The general syntax is:
```Bash
eb-install-all [options] [easybuild options] <easyconfig>.eb
```
Additional SLURM arguments can be selected using the `--slurm-args` option, e.g. `--slurm-args='--account=xyz --time=00:10:00 --cpus-per-task'`. If specific architectures should be selected use e.g. `--arch='broadwell epyc2'`. After this options, EasyBuild arguments can be provided without prefix, e.g. `--robot`. 

For our example we can use the following command to generate the module on all
architectures:

```Bash
eb-install-all --robot CDO-2.2.2-gompi-2023a.eb
```

The job output is presented in the `eb_out.*` files, one for each architecture.

If the build could not be finished in the default time of 1h, the walltime can be extended using:

```Bash
eb-install-all --robot --slurm-args='--time=05:00:00' ...
```

!!! note "Note"
    Please check the end of the out file for the **COMPLETED: Installation ended successfully** statement.

When all jobs have finished, you can type `module avail` and you should see the

```text
CDO/2.2.2-gompi-2023a
```

module in the list. The `CDO/2.2.2-gompi-2023a` module can now be used just like
any other module on the system. To *use* the CDO module, you don't need to load `EasyBuild`.
That was only required for *installing* the package. 
All you need to do to use the CDO module we just installed is 

```bash
module load Workspace
module load CDO/2.2.2-gompi-2023a
```

### Some common problems

1.  **`module avail` does not show the module.**

    There are two possible causes for this.

    1.  Lmod builds a cache of all modules on the system. EasyBuild will clear the cache 
        so that it will be rebuilt after installing a software package and hence the 
        newly installed modules should be found. In rare cases, Lmod may be in a corrupt
        state. In those cases the best solution is to clear the cache (unless it happens
        right after running the `eb` command to install a module): 

        ```bash
        rm -rf ~/.lmod.d/.cache
        ```

        and to log out and log in again to start with a clean shell.

    2.  If the problem occurs later on, e.g., while running a job, then a common cause is that
        you have  not compiled the package for the currently active software stack.
        Please make sure to install software through the `eb-install-all`
        command to generate modules for all available architectures.


2.  **EasyBuild complains that some modules are already loaded.**

    EasyBuild prefers to work in a clean environment with no modules loaded that are installed via EasyBuild
    except for a very select list. It will complain if other modules are loaded (though only fail if a module
    for one of the packages that you try to install is already loaded).
    It is best to take this warning seriously and to install in a relatively clean shell,
    as otherwise the installation process may pick up software libraries that it should not have used.

## Advanced Usage: Adapting EasyConfigs

In the following description and example we update an existing old EasyConfig for newer versions. In our case we want to update the version of Relion, the toolchain, and dependent libraries it is build with. 

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
$ mv RELION-3.0.4-foss-2017b.eb RELION-3.1.2-foss-2023a.eb
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

toolchain = {'name': 'foss', 'version': '2023a'}   ### the foss toolchain version was 2020b before
toolchainopts = {'openmp': True}

source_urls = ['https://github.com/3dem/relion/archive']
sources = ['%(version)s.tar.gz']
checksums = ['2580d66088923a644bc7d3b02efd154b775a3ec3d010426f382bb3be5db9c98b']

builddependencies = [('CMake', '3.26.333]    ### was 3.9.5

dependencies = [
    ('X11', '20230603'),                     ### was 20171023
    ('FLTK', '1.3.8'),                       ### was 1.3.4
    ('LibTIFF', '4.5.0'),                    ### 4.0.9
    ('tbb', '2021.11.0'),                       ### 2018_U5
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
$ eb --force --inject-checksums sha256 RELION-3.1.2-foss-2023a.eb
```

- build the new package as described in [Installation](#installation) above, e.g.
```Bash
$ eb-install-all --robot RELION-3.1.2-foss-2023a.eb
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

### Running EasyBuild interactively on a compute node

The eb-install-all tool builds the packages directly on a compute node within a SLURM job. If this fails, an investigation step may be running directly on the node, without more control of the setup, e.g. build directories. Therefore, EasyBuild can be started directly in a session on the compute node. First, an interactive session is established on the compute node. For example building Relion in the `$HOME` on an epyc2 node using a local copy of the EasyConfig file:

```Bash
$ srun --pty --partition epyc2 bash
$ module load Workspace_Home EasyBuild
$ eb --tmpdir=$TMPDIR --robot RELION-3.1.3-fosscuda-2020b.eb
```

This may also be used when compiling **on** a specific GPU architecture. 

## Further reading

If you want to get more familiar with EasyBuild and develop your own EasyBuild
recipes, we suggest the following sources of information:

- [EasyBuild documentation](https://docs.easybuild.io/)
- [EasyBuild tutorials](https://tutorial.easybuild.io)
- The [EasyBuild YouTube channel](https://www.youtube.com/@easybuilders)
  contains recordings of a four-session tutorial
  given for the LUMI User Support Team by Kenneth Hoste (UGent), the lead developer
  of EasyBuild and Luca Marsella (CSCS)
    - [Part 1: Introduction](https://www.youtube.com/watch?v=JTRw8hqi6x0)
    - [Part 2: Using EasyBuild](https://www.youtube.com/watch?v=C3S8aCXrIMQ)
    - [Part 3: Advanced topics](https://www.youtube.com/watch?v=KbcvHa4uO1Y)
    - [Part 4: EasyBuild on Cray systems](https://www.youtube.com/watch?v=uRu7X_fJotA)
- EasyBuild recipies
    - [EasyBuilders repository](https://github.com/easybuilders/easybuild-easyconfigs/tree/develop/easybuild/easyconfigs),
      the repository of EasyConfig files that also come with EasyBuild.
    - [ComputeCanada repository](https://github.com/ComputeCanada/easybuild-easyconfigs)
    - [IT4Innovations repository](https://code.it4i.cz/sccs/easyconfigs-it4i)
    - [Fred Hutchinson Cancer Research Center repository](https://github.com/FredHutch/easybuild-life-sciences/tree/main/fh_easyconfigs)
    - [University of Antwerpen repository](https://github.com/hpcuantwerpen/UAntwerpen-easyconfigs)
    - [University of Leuven repository](https://github.com/hpcleuven/easybuild-easyconfigs/tree/master/easybuild/easyconfigs)
