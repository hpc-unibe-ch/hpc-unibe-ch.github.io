# Pre-Installed Software

## Description

This page contains a list of pre-installed software that is available for all UBELIX users. If you want to install custom software yourself, take a look [here](installing-custom-software.md). If you think that some missing software could be of general interest for the UBELIX community, you can ask us to install the software system wide. Since maintaining software is a lot of work, we will select carefully which software we will install globally.

## Environment Modules

To make certain versions of a software available, the user must first "load/add" the corresponding modulefile. Environment modules allow to maintain different versions of the same software by altering the shell environment variables (e.g. $PATH) accordingly. Each modulefile contains all information needed to configure the shell for a specific software.

## Toolchains

If you need to compile any application, we suggest to load a toolchain. There are various toolchains available, to list some:

Toolchain | packacges
--------- | ---------
GCC       | GCC compiler
gompi     | GCC, OpenMPI
gompic    | GCC, OpenMPI, CUDA
foss      | GCC, OpenMPI, OpenBLAS, FFTW, ScaLAPACK
fosscuda  | GCC, OpenMPI, OpenBLAS, FFTW, ScaLAPACK, CUDA
intel     | Intel compiler, (GCC required), MKL, Intel MPI
iompi     | Intel compiler, OpenMPI
iomkl     | Intel compiler, OpenMPI, MKL

> Note: this list is not meant to be complete but to give an idea of high level toolchains. 
>       you can list all available toolchains using `module avail` and see the containing packages using, e.g. `module show gompic`

### List all Available Modulefiles

```Bash
$ module avail

--------------------------------------------------------------------------------------- /software.el7/modulefiles/all ----------------------------------------------------------------------------------------
   Advisor/2018_update3                     foss/2017a                                iccifort/2017.4.196-GCC-6.4.0-2.28                        numactl/2.0.11-GCC-5.4.0-2.26
   Autotools/20150215-GCC-5.4.0-2.26        foss/2017b                                iccifort/2018.1.163-GCC-6.4.0-2.28                        numactl/2.0.11-GCC-6.3.0-2.27
   Autotools/20150215-GCCcore-6.3.0         foss/2018a                                iccifort/2018.3.222-GCC-7.3.0-2.30                 (D)    numactl/2.0.11-GCCcore-6.4.0
   Autotools/20170619-GCCcore-6.4.0         foss/2018b                                ICU/61.1-GCCcore-6.4.0                                    numactl/2.0.11-GCCcore-7.3.0
   Autotools/20180311-GCCcore-7.3.0         foss/2019a                         (D)    IDL/8.6                                                   numactl/2.0.12-GCCcore-8.2.0                             (D)
   Autotools/20180311-GCCcore-8.2.0  (D)    fosscuda/2019a                            iimpi/2017b                                               OpenBLAS/0.2.18-GCC-5.4.0-2.26-LAPACK-3.6.1
   Boost/1.66.0-foss-2018a                  Gaussian/g09.D01                          iimpi/2018a                                               OpenBLAS/0.2.19-GCC-6.3.0-2.27-LAPACK-3.7.0
   CMake/3.9.1-GCCcore-6.4.0                Gaussian/g16.A03                   (D)    iimpi/2018b                                        (D)    OpenBLAS/0.2.20-GCC-6.4.0-2.28
   CMake/3.9.5-GCCcore-6.4.0                GCC/5.4.0-2.26                            imkl/2017.3.196-iimpi-2017b                               OpenBLAS/0.3.1-GCC-7.3.0-2.30
   CMake/3.10.2-GCCcore-6.4.0               GCC/6.3.0-2.27                            imkl/2017.3.196-iompi-2017b                               OpenBLAS/0.3.5-GCC-8.2.0-2.31.1                          (D)
   CMake/3.11.1-GCCcore-6.4.0               GCC/6.4.0-2.28                            imkl/2018.1.163-iimpi-2018a                               OpenMPI/1.10.3-GCC-5.4.0-2.26
   CMake/3.11.4-GCCcore-7.3.0        (D)    GCC/7.3.0-2.30                            imkl/2018.1.163-iompi-2018a                               OpenMPI/2.0.2-GCC-6.3.0-2.27
   CUDA/8.0.61                              GCC/8.2.0-2.31.1                   (D)    imkl/2018.3.222-iimpi-2018b                               OpenMPI/2.1.1-GCC-6.4.0-2.28
   CUDA/9.0.176                             GCCcore/5.4.0                             imkl/2018.3.222-iompi-2018b                        (D)    OpenMPI/2.1.1-iccifort-2017.4.196-GCC-6.4.0-2.28
   CUDA/9.1.85                              GCCcore/6.3.0                             impi/2017.3.196-iccifort-2017.4.196-GCC-6.4.0-2.28        OpenMPI/2.1.2-GCC-6.4.0-2.28
   CUDA/9.2.88                              GCCcore/6.4.0                             impi/2018.1.163-iccifort-2018.1.163-GCC-6.4.0-2.28        OpenMPI/2.1.2-iccifort-2018.1.163-GCC-6.4.0-2.28
   CUDA/10.1.105-GCC-8.2.0-2.31.1    (D)    GCCcore/7.3.0                             impi/2018.3.222-iccifort-2018.3.222-GCC-7.3.0-2.30 (D)    OpenMPI/3.1.1-GCC-7.3.0-2.30
   cuDNN/6.0-CUDA-8.0.61                    GCCcore/8.2.0                      (D)    Inspector/2018_update3                                    OpenMPI/3.1.1-iccifort-2018.3.222-GCC-7.3.0-2.30
   cuDNN/7.0.5-CUDA-9.0.176                 gcccuda/2019a                             intel/2017b                                               OpenMPI/3.1.3-GCC-8.2.0-2.31.1
   cuDNN/7.0.5-CUDA-9.1.85                  GEOS/3.6.2-foss-2018a-Python-3.6.4        intel/2018a                                               OpenMPI/3.1.3-gcccuda-2019a                              (D)
   cuDNN/7.1.4-CUDA-9.2.88                  git-lfs/2.4.2                             intel/2018b                                        (D)    Perl/5.26.1-GCCcore-6.4.0
   cuDNN/7.6.0.64-gcccuda-2019a      (D)    GMP/6.1.2-GCCcore-6.4.0                   iomkl/2017b                                               PGI/17.10-GCC-6.4.0-2.28
   cURL/7.58.0-GCCcore-6.4.0                gompi/2016b                               iomkl/2018a                                               PGI/18.4-GCC-6.4.0-2.28
   cURL/7.60.0-GCCcore-7.3.0         (D)    gompi/2017a                               iomkl/2018b                                        (D)    PGI/19.4-GCC-8.2.0-2.31.1                                (D)
   Doxygen/1.8.13-GCCcore-6.4.0             gompi/2017b                               iompi/2017b                                               Python/2.7.14-foss-2018a
   Doxygen/1.8.14-GCCcore-7.3.0      (D)    gompi/2018a                               iompi/2018a                                               Python/2.7.14-GCCcore-6.4.0-bare
   EasyBuild/3.6.1                          gompi/2018b                               iompi/2018b                                        (D)    Python/3.6.4-foss-2018a                                  (D)
   EasyBuild/3.6.2                          gompi/2019a                        (D)    itac/2018.3.022                                           R/3.4.4-foss-2018a-X11-20180131
   EasyBuild/3.7.1                          gompic/2019a                              Java/1.7.0_60                                             ScaLAPACK/2.0.2-gompi-2016b-OpenBLAS-0.2.18-LAPACK-3.6.1
   EasyBuild/3.9.1                   (D)    GSL/2.4-GCCcore-6.4.0                     Java/1.7.0_80                                             ScaLAPACK/2.0.2-gompi-2017a-OpenBLAS-0.2.19-LAPACK-3.7.0
   FFTW/3.3.4-gompi-2016b                   HDF5/1.10.1-foss-2018a                    Java/1.8.0_121                                            ScaLAPACK/2.0.2-gompi-2017b-OpenBLAS-0.2.20
   FFTW/3.3.6-gompi-2017a                   HDF5/1.10.2-foss-2018b             (D)    Java/1.8.0_152                                            ScaLAPACK/2.0.2-gompi-2018a-OpenBLAS-0.2.20
   FFTW/3.3.6-gompi-2017b                   help2man/1.47.4-GCCcore-6.3.0             Java/1.8.0_162                                     (D)    ScaLAPACK/2.0.2-gompi-2018b-OpenBLAS-0.3.1
   FFTW/3.3.7-gompi-2018a                   help2man/1.47.4-GCCcore-6.4.0             libsndfile/1.0.28-GCCcore-6.4.0                           ScaLAPACK/2.0.2-gompi-2019a-OpenBLAS-0.3.5
   FFTW/3.3.7-intel-2017b                   help2man/1.47.4-GCCcore-7.3.0             LLVM/5.0.1-GCCcore-6.4.0                                  ScaLAPACK/2.0.2-gompic-2019a-OpenBLAS-0.3.5              (D)
   FFTW/3.3.7-intel-2018a                   help2man/1.47.4                           Mako/1.0.7-foss-2018a-Python-2.7.14                       SQLite/3.20.1-GCCcore-6.4.0
   FFTW/3.3.7-iomkl-2018a                   help2man/1.47.7-GCCcore-8.2.0      (D)    MATLAB/2016b                                              SQLite/3.21.0-GCCcore-6.4.0                              (D)
   FFTW/3.3.8-gompi-2018b                   hwloc/1.11.3-GCC-5.4.0-2.26               MATLAB/2017b                                              tmux/2.7
   FFTW/3.3.8-gompi-2019a                   hwloc/1.11.5-GCC-6.3.0-2.27               MATLAB/2018b                                       (D)    UDUNITS/2.2.26-foss-2018a
   FFTW/3.3.8-gompic-2019a                  hwloc/1.11.7-GCCcore-6.4.0                netCDF/4.6.0-foss-2018a                                   vital-it/7
   FFTW/3.3.8-intel-2018b                   hwloc/1.11.8-GCCcore-6.4.0                netCDF/4.6.1-foss-2018b                            (D)    VTune/2018_update3
   FFTW/3.3.8-iomkl-2018b            (D)    hwloc/1.11.10-GCCcore-7.3.0               nettle/3.4-foss-2018a                                     X11/20180131-GCCcore-6.4.0
   foss/2016b                               hwloc/1.11.11-GCCcore-8.2.0        (D)    NLopt/2.4.2-foss-2018a

  Where:
   D:  Default Module

Use "module spider" to find all possible modules.
Use "module keyword key1 key2 ..." to search for all possible modules matching any of the "keys".
```

#### Bioinformatics Software

In co-operation with the [Vital-IT Group](http://www.vital-it.ch/) of the [SIB Swiss Institute of Bioinformatics](http://www.isb-sib.ch/), a large set of [bioinformatics software tools and databases](https://www.vital-it.ch/services/software) is available to the life science community.

To also list all modulefiles provided by Vital-IT, you have to first load the vital-it modulefile:

!!! types note ""
    Loading the vital-it modulefile automatically configures the environment to use specific versions of selected software, e.g. python v2.7.5, and gcc v4.9.1

```Bash
 $ module load vital-it && module avail

---------------------------------------------------------------------------------------------- /software/module ----------------------------------------------------------------------------------------------
   Blast/blast/latest                                                       SequenceAnalysis/primer3/2.3.7                                        UHTS/Analysis/mummer/4.0.0beta1           (D)
   Blast/blast/2.2.26                                                (D)    SequenceAnalysis/PrimerDesign/iPCR/1.0                                UHTS/Analysis/NanoOK/1.2.6
   Blast/ncbi-blast/latest                                                  SequenceAnalysis/ProtoGene/4.2.2                                      UHTS/Analysis/nanoraw/0.5
   Blast/ncbi-blast/2.2.31+                                                 SequenceAnalysis/readseq/2.1.30                                       UHTS/Analysis/oncodrivefm/1.0.3

   (...)

   SequenceAnalysis/OrthologyAnalysis/OMA/2.1.1                             UHTS/Analysis/msprime/0.7.0                                           Utility/rpy2/2.9.1                        (D)
   SequenceAnalysis/orthomclSoftware/2.0.9                                  UHTS/Analysis/MultiQC/1.3                                             Utility/Solver/SoPlex/4.0.0
   SequenceAnalysis/patsearch/1                                             UHTS/Analysis/MultiQC/1.7                                      (D)    Utility/Tarql/1.1
   SequenceAnalysis/pftools/2.3.4                                           UHTS/Analysis/mummer/3.9.4alpha                                       Utility/UCSC-utils/359
   SequenceAnalysis/pftools/2.3.5.d                                  (D)    UHTS/Analysis/mummer/4.0.0beta

--------------------------------------------------------------------------------------- /software.el7/modulefiles/all ----------------------------------------------------------------------------------------
   Advisor/2018_update3                     foss/2017a                                iccifort/2017.4.196-GCC-6.4.0-2.28                        numactl/2.0.11-GCC-5.4.0-2.26
   Autotools/20150215-GCC-5.4.0-2.26        foss/2017b                                iccifort/2018.1.163-GCC-6.4.0-2.28                        numactl/2.0.11-GCC-6.3.0-2.27
   Autotools/20150215-GCCcore-6.3.0         foss/2018a                                iccifort/2018.3.222-GCC-7.3.0-2.30                 (D)    numactl/2.0.11-GCCcore-6.4.0
   Autotools/20170619-GCCcore-6.4.0         foss/2018b                                ICU/61.1-GCCcore-6.4.0                                    numactl/2.0.11-GCCcore-7.3.0
   Autotools/20180311-GCCcore-7.3.0         foss/2019a                         (D)    IDL/8.6                                                   numactl/2.0.12-GCCcore-8.2.0                             (D)
   Autotools/20180311-GCCcore-8.2.0  (D)    fosscuda/2019a                            iimpi/2017b                                               OpenBLAS/0.2.18-GCC-5.4.0-2.26-LAPACK-3.6.1
   Boost/1.66.0-foss-2018a                  Gaussian/g09.D01                          iimpi/2018a                                               OpenBLAS/0.2.19-GCC-6.3.0-2.27-LAPACK-3.7.0
   CMake/3.9.1-GCCcore-6.4.0                Gaussian/g16.A03                   (D)    iimpi/2018b                                        (D)    OpenBLAS/0.2.20-GCC-6.4.0-2.28
   CMake/3.9.5-GCCcore-6.4.0                GCC/5.4.0-2.26                            imkl/2017.3.196-iimpi-2017b                               OpenBLAS/0.3.1-GCC-7.3.0-2.30
   CMake/3.10.2-GCCcore-6.4.0               GCC/6.3.0-2.27                            imkl/2017.3.196-iompi-2017b                               OpenBLAS/0.3.5-GCC-8.2.0-2.31.1                          (D)
   CMake/3.11.1-GCCcore-6.4.0               GCC/6.4.0-2.28                            imkl/2018.1.163-iimpi-2018a                               OpenMPI/1.10.3-GCC-5.4.0-2.26
   CMake/3.11.4-GCCcore-7.3.0        (D)    GCC/7.3.0-2.30                            imkl/2018.1.163-iompi-2018a                               OpenMPI/2.0.2-GCC-6.3.0-2.27
   CUDA/8.0.61                              GCC/8.2.0-2.31.1                   (D)    imkl/2018.3.222-iimpi-2018b                               OpenMPI/2.1.1-GCC-6.4.0-2.28
   CUDA/9.0.176                             GCCcore/5.4.0                             imkl/2018.3.222-iompi-2018b                        (D)    OpenMPI/2.1.1-iccifort-2017.4.196-GCC-6.4.0-2.28
   CUDA/9.1.85                              GCCcore/6.3.0                             impi/2017.3.196-iccifort-2017.4.196-GCC-6.4.0-2.28        OpenMPI/2.1.2-GCC-6.4.0-2.28
   CUDA/9.2.88                              GCCcore/6.4.0                             impi/2018.1.163-iccifort-2018.1.163-GCC-6.4.0-2.28        OpenMPI/2.1.2-iccifort-2018.1.163-GCC-6.4.0-2.28
   CUDA/10.1.105-GCC-8.2.0-2.31.1    (D)    GCCcore/7.3.0                             impi/2018.3.222-iccifort-2018.3.222-GCC-7.3.0-2.30 (D)    OpenMPI/3.1.1-GCC-7.3.0-2.30
   cuDNN/6.0-CUDA-8.0.61                    GCCcore/8.2.0                      (D)    Inspector/2018_update3                                    OpenMPI/3.1.1-iccifort-2018.3.222-GCC-7.3.0-2.30
   cuDNN/7.0.5-CUDA-9.0.176                 gcccuda/2019a                             intel/2017b                                               OpenMPI/3.1.3-GCC-8.2.0-2.31.1
   cuDNN/7.0.5-CUDA-9.1.85                  GEOS/3.6.2-foss-2018a-Python-3.6.4        intel/2018a                                               OpenMPI/3.1.3-gcccuda-2019a                              (D)
   cuDNN/7.1.4-CUDA-9.2.88                  git-lfs/2.4.2                             intel/2018b                                        (D)    Perl/5.26.1-GCCcore-6.4.0
   cuDNN/7.6.0.64-gcccuda-2019a      (D)    GMP/6.1.2-GCCcore-6.4.0                   iomkl/2017b                                               PGI/17.10-GCC-6.4.0-2.28
   cURL/7.58.0-GCCcore-6.4.0                gompi/2016b                               iomkl/2018a                                               PGI/18.4-GCC-6.4.0-2.28
   cURL/7.60.0-GCCcore-7.3.0         (D)    gompi/2017a                               iomkl/2018b                                        (D)    PGI/19.4-GCC-8.2.0-2.31.1                                (D)
   Doxygen/1.8.13-GCCcore-6.4.0             gompi/2017b                               iompi/2017b                                               Python/2.7.14-foss-2018a
   Doxygen/1.8.14-GCCcore-7.3.0      (D)    gompi/2018a                               iompi/2018a                                               Python/2.7.14-GCCcore-6.4.0-bare
   EasyBuild/3.6.1                          gompi/2018b                               iompi/2018b                                        (D)    Python/3.6.4-foss-2018a                                  (D)
   EasyBuild/3.6.2                          gompi/2019a                        (D)    itac/2018.3.022                                           R/3.4.4-foss-2018a-X11-20180131
   EasyBuild/3.7.1                          gompic/2019a                              Java/1.7.0_60                                             ScaLAPACK/2.0.2-gompi-2016b-OpenBLAS-0.2.18-LAPACK-3.6.1
   EasyBuild/3.9.1                   (D)    GSL/2.4-GCCcore-6.4.0                     Java/1.7.0_80                                             ScaLAPACK/2.0.2-gompi-2017a-OpenBLAS-0.2.19-LAPACK-3.7.0
   FFTW/3.3.4-gompi-2016b                   HDF5/1.10.1-foss-2018a                    Java/1.8.0_121                                            ScaLAPACK/2.0.2-gompi-2017b-OpenBLAS-0.2.20
   FFTW/3.3.6-gompi-2017a                   HDF5/1.10.2-foss-2018b             (D)    Java/1.8.0_152                                            ScaLAPACK/2.0.2-gompi-2018a-OpenBLAS-0.2.20
   FFTW/3.3.6-gompi-2017b                   help2man/1.47.4-GCCcore-6.3.0             Java/1.8.0_162                                     (D)    ScaLAPACK/2.0.2-gompi-2018b-OpenBLAS-0.3.1
   FFTW/3.3.7-gompi-2018a                   help2man/1.47.4-GCCcore-6.4.0             libsndfile/1.0.28-GCCcore-6.4.0                           ScaLAPACK/2.0.2-gompi-2019a-OpenBLAS-0.3.5
   FFTW/3.3.7-intel-2017b                   help2man/1.47.4-GCCcore-7.3.0             LLVM/5.0.1-GCCcore-6.4.0                                  ScaLAPACK/2.0.2-gompic-2019a-OpenBLAS-0.3.5              (D)
   FFTW/3.3.7-intel-2018a                   help2man/1.47.4                           Mako/1.0.7-foss-2018a-Python-2.7.14                       SQLite/3.20.1-GCCcore-6.4.0
   FFTW/3.3.7-iomkl-2018a                   help2man/1.47.7-GCCcore-8.2.0      (D)    MATLAB/2016b                                              SQLite/3.21.0-GCCcore-6.4.0                              (D)
   FFTW/3.3.8-gompi-2018b                   hwloc/1.11.3-GCC-5.4.0-2.26               MATLAB/2017b                                              tmux/2.7
   FFTW/3.3.8-gompi-2019a                   hwloc/1.11.5-GCC-6.3.0-2.27               MATLAB/2018b                                       (D)    UDUNITS/2.2.26-foss-2018a
   FFTW/3.3.8-gompic-2019a                  hwloc/1.11.7-GCCcore-6.4.0                netCDF/4.6.0-foss-2018a                                   vital-it/7                                               (L)
   FFTW/3.3.8-intel-2018b                   hwloc/1.11.8-GCCcore-6.4.0                netCDF/4.6.1-foss-2018b                            (D)    VTune/2018_update3
   FFTW/3.3.8-iomkl-2018b            (D)    hwloc/1.11.10-GCCcore-7.3.0               nettle/3.4-foss-2018a                                     X11/20180131-GCCcore-6.4.0
   foss/2016b                               hwloc/1.11.11-GCCcore-8.2.0        (D)    NLopt/2.4.2-foss-2018a

  Where:
   L:  Module is loaded
   D:  Default Module

Use "module spider" to find all possible modules.
Use "module keyword key1 key2 ..." to search for all possible modules matching any of the "keys".
```

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

