# Quick Start

This section is intended as a brief introduction into HPC, especially to the present system UBELIX. 
This page is an summary, a hands-on introduction, which targets primarily users without prior knowledge in high-performance computing. However, basic Linux knowledge is a prerequisite. If you are not familiar with basic Linux commands, there are many beginner tutorials available online. 
After reading this page you will have composed and submitted your first job successfully to the cluster. Links are provided throughout the text to point you to more in-depth information on the topic.

## Cluster Rules

Before we start: as everywhere where people come together, a **common sense** is needed to allow for a good cooperation and to enable a positive HPC experience. Be always aware that you are working on a **shared system** where your behaviour could have a negative impact on the workflow of other users. Please find the list of the most important guidelines in our [**code of conduct**](code-of-conduct.md).

## Request an Account

Before you can start working on the HPCs, staff and students of the University of Bern must have their **Campus Account (CA)** registered for the HPCs. External researchers that collaborate with an institute of the University of Bern must apply for a CA through that institute. See [Accounts and Activation](../getting-Started/account.md) for more information getting access to UBELIX.

## HPC Workspace

Workspaces provide are a collaborative environment, including group based access to permanent and temporary storage, as well as group based compute resource accounting.
Research group leaders need to apply for an workspace, see [Workspace Management](../hpc-workspaces/management.md). 
For an introduction to HPC Workspaces see [Workspace Overview](../hpc-workspaces/workspaces.md)

## Login

To connect to the cluster, you must log in to a **login node** from **inside the university network** (e.g. from a workstation on the campus). If you want to connect from a remote location (e.g. from your computer at home) you must first establish a **VPN** connection to get access to the university network. To connect from a UNIX-like system (Linux, Mac OS X, MobaXterm on Windows) simply use a secure shell (SSH) to log in to a login node. There are four login nodes (submit[01-04].unibe.ch), you can pick any one:

```bash
# here we choose submit03.unibe.ch as our login node
ssh <user>@submit03.unibe.ch
```

## Welcome `$HOME`

After successful login to the cluster, your will find yourself in the directory `/storage/homefs/$USER`, where `$USER` is your Campus Account username.
This is your home directory and serves as the repository for your personal files, and configurations. 
You can reference your home directory by `~` or `$HOME`. 

Your home directory is located on a shared file system. Therefore, all files and directories are always available on all cluster nodes and must hence not be copied between those nodes. HOME directories have a daily snapshot and backup procedures.
Disk space is managed by [quotas](../file-system/quota.md). By default, each user has 1TB of disk space available. Keep your home directory clean by regularly deleting old data or by moving data to a private storage.

You can always print the current working directory using the `pwd` (present working directory) command:
```bash
pwd
/storage/homefs/<user>
```

## Copy Data

At some point, you will probably need to copy files between your local computer and the cluster. There are different ways to achieve this, depending on your local operating system (OS). To copy a file **from your local computer** running a UNIX-like OS use the secure copy command `scp` on your local workstation:

```bash
scp /path/to/file <user>@submit03.unibe.ch:/path/to/target_dir/
```

To copy a file from the cluster to your local computer running a UNIX-like OS also use the secure copy command `scp` on your local workstation:

```bash
scp <user>@submit03.unibe.ch:/path/to/file /path/to/target_dir/
```

More information about file transfer can be found on the page [File Transfer to/from UBELIX](../file-system/file-transfer.md).

## Use Software

On our HPCs you can make use of already pre-installed software or you can compile and install your own software. We use a module system to manage software packages, even different versions of the same software. This allows you to focus on getting your work done instead of compiling software. E.g. to get a list of all provided packages:

```bash
module avail
```

A package name can be added to list all packages containing that string. 

The `module spider` command encountering also results from the VitalIT software stack. 

!!! type info "Workspace software stacks"
    `module spider` or `module avail` will only find packages in a Workspace software stack if the `Workspace` module for that workspace is loaded

Furthermore, we are suggesting to work with so called toolchains. These are collections of modules build on top of each other. 
E.g. setting the environment for compiling an scientific application with math. libraries, OpenMPI and GCC, load:

```bash
$ module load foss
$ module list 
module list

Currently Loaded Modules:
  1) GCCcore/9.3.0                      4) GCC/9.3.0                          7) libxml2/.2.9.10-GCCcore-9.3.0    (H)  10) UCX/1.8.0-GCCcore-9.3.0   13) gompi/2020a                  16) foss/2020a
  2) zlib/.1.2.11-GCCcore-9.3.0   (H)   5) numactl/2.0.13-GCCcore-9.3.0       8) libpciaccess/.0.16-GCCcore-9.3.0 (H)  11) OpenMPI/4.0.3-GCC-9.3.0   14) FFTW/3.3.8-gompi-2020a
  3) binutils/.2.34-GCCcore-9.3.0 (H)   6) XZ/.5.2.5-GCCcore-9.3.0      (H)   9) hwloc/2.2.0-GCCcore-9.3.0             12) OpenBLAS/0.3.9-GCC-9.3.0  15) ScaLAPACK/2.1.0-gompi-2020a

  Where:
   H:  Hidden Module
```

You can also specify version numbers there. 

!!! attention "Scope"
    The loaded version of a software is only active in your current session. If you open a new shell you are again using the default version of the software. Therefore, it is crucial to load the required modules from within your job script.

    But also keep in mind that the current environment will get forwarded into a job submitted from it. This may lead to conflicting versions of loaded modules and modules loaded in the script. 

With the module environment you can also easily install, maintain and provide software packages in your workspaces and share with your collaborators. 

The [Software](../software/hpc-modules.md) section is dedicated to this topic. More information can be found there.

!!! type notes ""
    Managing different working environments can be done with "Meta Modules" or user collections, see [Environment Definitions](../software/hpc-modules.md#environment-definitions)

## Hello World

Doing useful computations consists of running commands that work on data and generate a result. These computations are resource-intensive. That is what
the compute nodes are there for. These over 300 servers do the heavy lifting as soon as resources are free for you. Currently you are on a submit server
also known as login node. This server is for preparing the computations, i.e. downloading data, writing a job script, prepare some data etc. But
**you are not allowed to run computations on login nodes** as those servers are quite a weak machines that you are sharing with others. So, you have to bring the
computations to the compute nodes - by generating a job script and sending it to the cluster.

!!! hint "Working interactively on a compute node"
    When developing stuff it's often useful to have short iterations of try-error. Therefore it's also possible to work
    interactively on a compute node for a certain amount of time without having to send jobs to the cluster and wait until
    they finish just to see it didn't work. See [Interactive Jobs](../slurm/interactive-jobs.md) for more information about this topic.


It's now time for your first job script. To do some work on the cluster, you require certain resources (e.g. CPUs and memory) and a description of the computations to be done. A job consists of instructions to the scheduler in the form of option flags, and statements that describe the actual tasks. Let's start with the instructions to the scheduler:

```Bash
#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1GB

# Put your code below this line
...
```

The first line makes sure that the file is executed using the bash shell. The remaining lines are option flags used by the `sbatch` command. The page [Jobs Submission](../slurm/submission.md) outlines the most important options of `sbatch`.

Now, let's write a simple "hello, world"-task:

```Bash
...
# Put your code below this line
module load Workspace_Home
mkdir -p $SCRATCH/my_first_job
cd $SCRATCH/my_first_job
echo "Hello, UBELIX from node $(hostname)" > hello.txt
```

After loading the Workspace module, we create a new directory 'my_first_job' within our "personal" SCRATCH directory. The variable **`$SCRATCH`** expands to `/storage/scratch/users/<user>`. Then, we change directory to the newly created directory. In the third line we print the line `Hello, UBELIX from node <hostname_of_the_executing_node>` and redirect the output to a file named `hello.txt`. The expression `$(hostname)` means, run the command hostname and put its output here. Save the content to a file named `first.sh`.

The complete job script looks like this:

```Bash
#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1GB

# Put your code below this line
module load Workspace_Home
mkdir -p $SCRATCH/my_first_job
cd $SCRATCH/my_first_job
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
There are various options for different types of jobs provided in the scheduler. See sections [Array Jobs](../slurm/array-jobs.md), [GPUs](../slurm/gpus.md), and [Interactive Jobs](../slurm/interactive-jobs.md) for more information

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
is pending. In this example, the job has to wait for at least one other job with higher priority. See here for a list of other reasons why a job might be pending.

You can always list all your active (pending or running) jobs with squeue:

```bash
squeue --user=testuser
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

Further information on on job monitoring you find on page [Monitoring Jobs](../slurm/monitoring-jobs.md). Furthermore, in the *Job handling* section you find additional information about [Investigating a Job Failure](../slurm/investigating-job-failure.md) and [Check-pointing](../slurm/checkpointing.md). 



## Training Courses

[Data Science Lap (DSL))](https://www.dsl.unibe.ch) regularly conducts introductory and advanced courses on Linux, UBELIX and other topics. Details outlined on [their pages](https://www.dsl.unibe.ch)

