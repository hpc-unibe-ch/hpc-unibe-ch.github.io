# Installing Custom Software

## Description

UBELIX comes with a plethora of software pre-installed. 
And there are tools provided installing additional packages in the user/group space. The present **CustomRepo** and **Workspace modules** provide easy access even for multiple versions of the same Software package. 

This article describes a procedure for installing custom software stacks in your user/group space. An EasyBuild and a manual approach is presented.

!!! note "Note"
    You **cannot** use the package managers apt, dnf or yum for this, since these commands require root privileges to install software system wide. Instead you have to compile and install the software yourself. 

!!! note "Note"
    If you know that some missing software could be of general interest for a **wide community** on our machines, you can ask us to install the software system wide.

!!! note "Note"
    If you need further assistance in installing your software packages or optimizing for our machine architecture, get in touch with our support team.

The **LMOD module** system allows to enable software package by package. Thus, influences between different packages can be minimized. It even allows to have multiple versions of the same software product installed side by side. 


When possible we use [EasyBuild](https://easybuild.readthedocs.io/en/latest/) to provision software packages. 
EasyBuild is a software installation framework. Installation procedures are defined in so called EasyConfigs, including the location of the sources, dependencies, its versions, used environments, compile arguments, and more. 
These EasyConfigs are publicly available on [EasyBuild github repository](https://github.com/easybuilders/easybuild-easyconfigs) and can be downloaded used and if necessary adapted, e.g. for new versions.  

There are modules providing access to your user/group software stacks and assisting you with building packages into them. 

## Building Software packages
There are mainly two options to build a software package and its module:

- using **EasyBuild**, with an existing, an modified or a newly created EasyConfig
- performing **manual installation**, and creating a module file

Both methods are described in more details. Additionally, with the `Workspace` and `Workspace_Home` module such software stacks can be created in your user/group space.

## EasyBuild
For detailed instructions read the [EasyBuild article](EasyBuild.md).

If you are installing your own application you may want to consider to create an EasyConfig for it. Have a look in the [EasyBuild documentation](https://easybuild.readthedocs.io/en/latest/), examples on the [EasyBuild github](https://github.com/easybuilders/easybuild-easyconfigs/tree/develop/easybuild/easyconfigs). And if necessary ask our support team for assistance. 

## Python and R
You can use the Python/R package managers to install additional packages into your HOME/Workspace directory. Please see the [Anaconda/Python](Anaconda.md) and [R](r.md) pages.

## Manually compiling
There are very different ways of manually installing software packages, starting from just using a compiler, having a makefile, up to complex build systems. 
A few considerations need to kept in mind while building for our systems:

- Compilers: different compilers are available and can be loaded by modules. Toolchains bundle compiler with additionally libraries and tools, like MPI, FFTW, MKL. We advise to always use toolchains instead of compiler modules to eliminate a source of common errors. Furthermore, complex algorithms are optimised differently in the compilers. It is worthwhile to try and compare multiple toolchains. 
- CPU architectures: since there are different CPU architectures available, applications should be build for the targeted architecture. Often significant performance improvements can be obtained compiling for the correct instruction sets. Therefore, launch your build processes on the targeted architecture (i.e., *bdw* or *epyc2*).

One and probably the most used procedure is the GNU configure / make:

```Bash
tar xzvf some-software-0.1.tar.gz
cd some-software-0.1
./configure --prefix=/path/to/target/some-software/0.1
make
make install
make clean
```

!!! note "Note"
    Consider creating an Easyconfig if you already have a well tested procedure, see [EasyBuild](EasyBuild.md). 

`configure` is usually a complex shell script that gathers information about the system and prepares the compile process.  
With the `--prefix` option you can specify a base installation directory, where `make install` will install the files into subdirectories like `bin`, `lib`, `include`, etc. 

The make utility is what does the actual compiling and linking. 
If, for example, some additional libraries are missing on the system or not found in the expected location, the command will exit immediately. 

Detailed documentation can be found on the [GNU make documentation page](http://www.gnu.org/software/make/manual/make.html)
