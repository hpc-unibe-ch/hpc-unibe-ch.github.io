# Quick Start

This section is intended as a brief introduction into the UBELIX workflow.
This page is an summary, a hands-on introduction, which targets primarily users without prior knowledge in high-performance computing. However, basic Linux knowledge is a prerequisite. If you are not familiar with basic Linux commands, there are many beginner tutorials available online.
After reading this page you will have composed and submitted your first job successfully to the cluster. Links are provided throughout the text to point you to more in-depth information on the topic.

## Prerequisites

In order to follow these steps you have succefully managed to:

- login to the UBELIX cluster shell via `ssh`or the web interface
- copy data from/to the UBELIX cluster via `scp/rsync` or the web interface

## Use Software

On UBELIX you can make use of already pre-installed software or you can compile and install your own software. We use a module system to manage software packages, even different versions of the same software. This allows you to focus on getting your work done instead of compiling software. E.g. to get a list of all provided packages:

```bash
module avail
```

!!! type info "Workspace software stacks"
    `module spider` or `module avail` will only find packages in a Workspace software stack if the `Workspace` module for that workspace is loaded

Furthermore, we suggest to work with so called toolchains. These are collections of modules build on top of each other. 

To set the environment for a scientific application with Python, load:

```bash
$ module load Anaconda3
$ eval "$(conda shell.bash hook)"
```

To set the environment for compiling a scientific application with math libraries, OpenMPI and GCC, load:

```bash
$ module load foss
$ module list

Currently Loaded Modules:
  1) GCCcore/12.3.0                          9) OpenSSL/1.1                      17) OpenBLAS/0.3.23-GCC-12.3.0
  2) binutils/.2.40-GCCcore-12.3.0     (H)  10) UCX/1.14.1-GCCcore-12.3.0        18) FlexiBLAS/3.3.1-GCC-12.3.0
  3) GCC/12.3.0                             11) libfabric/1.18.0-GCCcore-12.3.0  19) FFTW/3.3.10-GCC-12.3.0
  4) numactl/2.0.16-GCCcore-12.3.0          12) zlib/1.2.13-GCCcore-12.3.0       20) gompi/2023a
  5) XZ/.5.4.2-GCCcore-12.3.0          (H)  13) libevent/2.1.12-GCCcore-12.3.0   21) FFTW.MPI/3.3.10-gompi-2023a
  6) libxml2/.2.11.4-GCCcore-12.3.0    (H)  14) PMIx/4.2.4-GCCcore-12.3.0        22) ScaLAPACK/2.2.0-gompi-2023a-fb
  7) libpciaccess/.0.17-GCCcore-12.3.0 (H)  15) UCC/1.2.0-GCCcore-12.3.0         23) foss/2023a
  8) hwloc/2.9.1-GCCcore-12.3.0             16) OpenMPI/4.1.5-GCC-12.3.0

  Where:
   H:  Hidden Module

```

!!! attention "Scope"
    The loaded version of a software is only active in your current session. If you open a new shell you are again using the default version of the software. Therefore, it is crucial to load the required modules from within your job script.

    But also keep in mind that the current environment will get forwarded into a job submitted from it. This may lead to conflicting versions of loaded modules and modules loaded in the script. 

The [Software](../software/index.md) section is dedicated to this topic. More information can be found there.

## Hello World

Currently you are on a submit server also known as login node. This server is for preparing the computations, i.e. downloading data, writing a job script, prepare some data etc. But **you are not allowed to run computations on login nodes**! So, you have to bring the computations to the compute nodes - by generating a job script and sending it to the cluster.

!!! hint "Working interactively on a compute node"
    When developing stuff it's often useful to have short iterations of try-error. Therefore it's also possible to work
    interactively on a compute node without having to send jobs to the cluster and wait until
    they finish just to see it didn't work. See [Interactive Jobs](../runjobs/scheduled-jobs/interactive.md) for more information about this topic.

To do some work on the cluster, you require certain resources (e.g. CPUs and memory) and a description of the computations to be done. A job consists of instructions to the scheduler in the form of option flags, and statements that describe the actual tasks. Let's start with the instructions to the scheduler:

```Bash
#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1GB

# Put your code below this line
...
```

The first line makes sure that the file is executed using the bash shell. The remaining lines are option flags used by the `sbatch` command. The page [Jobs Submission](../runjobs/scheduled-jobs/submission.md) outlines the most important options of `sbatch`.

Now, let's write a simple "hello, world"-task:

```Bash
...
# Put your code below this line
module load Workspace_Home
echo "Hello, UBELIX from node $(hostname)" > hello.txt
```

After loading the Workspace module, we print the line `Hello, UBELIX from node <hostname_of_the_executing_node>` and redirect the output to a file named `hello.txt`. The expression `$(hostname)` means, run the command `hostname` and put its output here. Save the content to a file named `first.sh`.

The complete job script looks like this:

```Bash
#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1GB

# Put your code below this line
module load Workspace_Home
echo "Hello, UBELIX from node $(hostname)" > hello.txt
```

## Schedule Your Job

We can now submit our first job to the scheduler. The scheduler will then provide the requested resources to the job. If all requested resources are already available, then your job can start immediately. Otherwise your job will wait until enough resources are available. We submit our job to the scheduler using the `sbatch` command:

```bash 
sbatch first.sh
```
```bash
Submitted batch job 32490640
```
If the job is submitted successfully, the command outputs a job-ID with which you can refer to your job later on.
There are various options for different types of jobs provided in the scheduler. See sections [Array Jobs](../runjobs/scheduled-jobs/throughput.md), [GPUs](../runjobs/scheduled-jobs/gpus.md), and [Interactive Jobs](../runjobs/scheduled-jobs/interactive.md) for more information

## Monitor Your Job

You can inspect the state of our active jobs (running or pending) with the squeue command:

```bash
squeue --job=32490640
```
```no-highlight
      JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
   32490640     epyc2    job01 testuser  R       0:22      1 bnode23
```

Here you can see that the job 'job01' with job-ID 32490640 is in state RUNNING (R).
The job is running in the 'epyc2' partition (default partition) on bnode23 for 22 seconds.
It is also possible that the job can not start immediately after submitting it to SLURM
because the requested resources are not yet available. In this case, the output could
look like this:

```bash
squeue --job=32490640
```
```no-highlight
       JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
    32490640     epyc2    job01 testuser PD       0:00      1 (Priority)
```

Here you can see that the job is in state PENDING (PD) and a reason why the job
is pending. In this example, the job has to wait for at least one other job with higher priority. 

You can always list all your active (pending or running) jobs with squeue:

```bash
squeue --me
```
```no-highlight
      JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
   34651451     epyc2 slurm.sh  testuser PD       0:00      2 (Priority)
   34651453     epyc2 slurm.sh  testuser PD       0:00      2 (Priority)
   29143227     epyc2     Rjob  testuser PD       0:00      4 (JobHeldUser)
   37856328       bdw   mpi.sh  testuser  R       4:38      2 anode[012-014]
   32634559       bdw  fast.sh  testuser  R    2:52:37      1 anode12
   32634558       bdw  fast.sh  testuser  R    3:00:54      1 anode14
   32634554       bdw  fast.sh  testuser  R    4:11:26      1 anode08
   32633556       bdw  fast.sh  testuser  R    4:36:10      1 anode08
```

Further information on on job monitoring you find on page [Monitoring Jobs](../runjobs/scheduled-jobs/monitoring-jobs.md). Furthermore, in the *Job handling* section you find additional information about [Investigating a Job Failure](../runjobs/scheduled-jobs/investigating-job-failure.md) and [Check-pointing](../runjobs/scheduled-jobs/checkpointing.md). 
