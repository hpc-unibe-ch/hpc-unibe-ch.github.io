# Singularity/Apptainer

[apptainer]: http://apptainer.org/docs/user/main/index.html
[conda-env]: https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#sharing-an-environment
[cotainr]: https://cotainr.readthedocs.io/en/stable/
[cotainr-conda-env]: https://cotainr.readthedocs.io/en/stable/user_guide/conda_env.html#conda-environments
[cotainr-usecases]: https://cotainr.readthedocs.io/en/stable/user_guide/index.html#use-cases
[dockerhub]: https://hub.docker.com/
[docker-wiki]: https://en.wikipedia.org/wiki/Docker_(software)
[mpich-abi]: https://www.mpich.org/abi/
[osu-benchmark]: https://mvapich.cse.ohio-state.edu/benchmarks/
[singularityce]: https://docs.sylabs.io/guides/latest/user-guide/
[singularity-def-file]: https://docs.sylabs.io/guides/latest/user-guide/definition_files.html
[tykky-cotainr-diff]: https://github.com/DeiC-HPC/cotainr/issues/37

[container-jobs]: ../../runjobs/scheduled-jobs/container-jobs.md
[container-wrapper]: ../installing/container-wrapper.md
[copying-files]: ../../firststeps/movingdata.md
[easybuild]: ../../software/installing/easybuild.md
[interconnect]: ../../hardware/network.md
[python-packages]: ../installing/python.md
[scratch]: ../../storage/scratch.md

We support [Apptainer][apptainer]/[Singularity][singularityce] containers as an
alternative way to bring your scientific application to UBELIX instead of
installing it using [EasyBuild][easybuild].

If you are familiar with [Docker containers][docker-wiki],
Apptainer containers are essentially the same thing, but are better
suited for multi-user HPC systems such as UBELIX. The main benefit of using a
container is that it provides an isolated software environment for each
application, which makes it easier to install and manage complex applications.

This page provides guidance on preparing your Apptainer containers
for use with UBELIX. Please consult the [container jobs page][container-jobs] for
guidance on running your container on UBELIX.

!!! note
    There are two major providers of the `apptainer` runtime, namely
    [Singularity CE][singularityce] and [Apptainer][apptainer], with the latter
    being a fork of the former. For most cases, these should be fully compatible.
    UBELIX provides a Apptainer runtime.

## Pulling container images from a registry

Apptainer allows pulling existing container images (Apptainer or Docker)
from container registries such as [DockerHub][dockerhub].
Pulling container images from registries can be done on
UBELIX. For instance, the Ubuntu image `ubuntu:22.04` can be pulled from
DockerHub with the following command:

```bash
$ apptainer pull docker://ubuntu:22.04
```

This will create the Apptainer image file `ubuntu_22.04.sif` in the directory
where the command was run. Once the image has been pulled, the container can be
run. Instructions for running the container may be found on the [container jobs
page][container-jobs].

!!! warning "Take care when pulling container images"
    Please take care to only use images uploaded from reputable sources as
    these images can easily be a source of security vulnerabilities or even
    contain malicious code.

!!! hint "Set cache directories when using Docker containers"
    When pulling or building from Docker containers using `apptainer`, the
    conversion can be quite heavy. You may need to use the [scratch filesystem][scratch] if
    the build does not succeed in the in-memory filesystem `/tmp`, i.e.
    Singularity cache directory, i.e.

    ```bash
    $ mkdir -p /scratch/network/users/$USER
    $ export APPTAINER_TMPDIR=/scratch/network/users/$USER
    $ export APPTAINER_CACHEDIR=/scratch/network/users/$USER
    ```

## Building Apptainer/Singularity SIF containers

As an example, consider building a container that is compatible with the
MPI stack on UBELIX.

!!! warning
    For optimally performing MPI-enabled containers, the application inside the container must be
    dynamically linked to an MPI version that is compatible
    with the host MPI.

The following [Singularity definition file][singularity-def-file]
`mpi_osu.def`, installs OpenMPI-4.1.5, which is compatible with the
Cray-MPICH found on UBELIX. That OpenMPI will be used to compile the [OSU
micro-benchmarks][osu-benchmark]. Finally, the OSU point to point bandwidth test
is set as the "runscript" of the image.

```bash
bootstrap: docker
from: ubuntu:22.04

%post
    # Install software
    apt-get update
    apt-get install -y file g++ gcc gfortran make gdb strace wget ca-certificates --no-install-recommends

    # Install OpenMPI
    wget -q https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.5.tar.gz
    tar xf openmpi-4.1.5.tar.gz
    cd openmpi-4.1.5
    ./configure --prefix=/usr/local
    make -j
    make install
    ldconfig

    # Build osu benchmarks
    wget -q http://mvapich.cse.ohio-state.edu/download/mvapich/osu-micro-benchmarks-5.3.2.tar.gz
    tar xf osu-micro-benchmarks-5.3.2.tar.gz
    cd osu-micro-benchmarks-5.3.2
    ./configure --prefix=/usr/local CC=$(which mpicc) CFLAGS=-O3
    make
    make install
    cd ..
    rm -rf osu-micro-benchmarks-5.3.2
    rm osu-micro-benchmarks-5.3.2.tar.gz

%runscript
    /usr/local/libexec/osu-micro-benchmarks/mpi/pt2pt/osu_bw
```

The image can be built with

```bash
$ apptainer build mpi_osu.sif mpi_osu.def
```

See the [container jobs MPI documentation
page](../../runjobs/scheduled-jobs/container-jobs.md#running-containerized-mpi-applications)
for instructions on running this `mpi_osu.sif` MPI container on UBELIX.
