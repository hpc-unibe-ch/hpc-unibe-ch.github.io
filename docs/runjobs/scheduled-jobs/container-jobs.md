[singularityce]: https://docs.sylabs.io/guides/latest/user-guide/
[apptainer]: http://apptainer.org/docs/user/main/index.html
[mpich-abi]: https://www.mpich.org/abi/
[permedcoe-mpi]: https://permedcoe.github.io/mpi-in-container
[easybuild-install]: ../../software/installing/easybuild.md
[containers-install]: ../../software/containers/apptainer.md
[data-storage-options]: ../../storage/index.md

# Container jobs

UBELIX provides access to a `apptainer` runtime for running applications in
software containers. Currently, there are two major providers of the
`apptainer/singularity` runtime, namely [Singularity CE][singularityce] and
[Apptainer][apptainer], with the latter being a fork of the former. For most
cases, these should be fully compatible.
No modules need to be loaded to use `apptainer` on UBELIX. You can
always check the version of apptainer using the command `apptainer
--version`.

See the [Apptainer containers install page][containers-install] for
details about creating UBELIX compatible software containers.

## The basics of running a container on UBELIX

Applications in a container may be run by combining Slurm commands with
Singularity commands, e.g., to get the version of Ubuntu running in a container
stored as "ubuntu_22.04.sif", we may use `srun` to execute the `apptainer`
container

```bash
$ srun --partition=<partition> --account=<account> apptainer exec ubuntu_22.04.sif cat /etc/os-release
```

which prints something along the lines of

```text
PRETTY_NAME="Ubuntu 22.04.1 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.1 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Binding network file systems in the container

By default, the [network file system partitions][data-storage-options], such as
`/scratch` or `/storage` are not accessible from the within the container. To
make them available, they need to be explicitly bound by passing the
`-B/--bind` command line option to `apptainer exec/run`. For instance

```bash
$ srun --partition=<partition> --account=<project_name> apptainer exec -B /scratch/<path_to_project> ubuntu_21.04.sif ls /scratch/<path_to_project>
```

!!! warning
    Since project folder paths like `/scratch/`
    are symlinks on UBELIX, you must bind these full
    paths to make them available in the container. Simply binding `/scratch`
    will not work.

## Running containerized MPI applications

Running MPI applications in a container requires that you either bind the host
MPI (the MPI stack provided as part of UBELIX or install a UBELIX compatible MPI stack in the container.

### Using the host MPI

To properly make use of UBELIX high-speed network, it is necessary to
mount a few host system directories inside the container and set
`LD_LIBRARY_PATH` so that the necessary dynamic libraries are available at run
time. This way, the UBELIX MPI stack replaces the MPI installed in the container image.

Details of this approach will be made available in the future.

### Using the container MPI

MPI applications can also be run using an MPI stack installed in the container.
To do so, Slurm needs to be instructed to use the PMI-2 process management
interface by passing `--mpi=pmi2` to `srun`, e.g.

```bash
$ srun --partition=<partition> --mpi=pmi2 --nodes=2 apptainer run mpi_osu.sif
```

which produces an output along the lines of

```text
# OSU MPI Bandwidth Test v5.3.2
# Size      Bandwidth (MB/s)
1                       0.50
2                       1.61
4                       3.57
8                       6.54
16                      9.65
32                     18.04
64                     35.27
128                    67.76
256                    91.12
512                   221.09
1024                  278.88
2048                  471.54
4096                  917.02
8192                 1160.74
16384                1223.41
32768                1397.97
65536                1452.23
131072               2373.07
262144               2104.56
524288               2316.71
1048576              2478.30
2097152              2481.68
4194304              2380.51
```

Note that this approach gives lower bandwidths, especially for the larger
message sizes, than is the case when using the UBELIX MPI. In general, the
performance obtained from using the container MPI might be low compared
to the results obtained when using the host's MPI. For a more in-depth
discussion about MPI in containers, we suggest that you read this
[introduction to MPI in containers][permedcoe-mpi].
