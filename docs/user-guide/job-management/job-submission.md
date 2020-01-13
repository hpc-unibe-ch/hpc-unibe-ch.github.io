# Job Submission

## Description
This section describes the interaction with the resource manager. The subchapters contain information about submitting jobs to the cluster, monitoring active jobs and retrieving useful information about resource usage.

A cluster is a set of connected computers that work together to solve computational tasks (user jobs) and presents itself to the user as a single system. For the resources of a cluster (e.g. CPUs, GPUs, memory) to be used efficiently, a resource manager (also called workload manager or batch-queuing system) is vital. While there are many different resource managers available, the resource manager of choice on UBELIX is [SLURM](https://slurm.schedmd.com). After submitting a job to the cluster, SLURM will try to fulfill the job's resource request by allocating resources to the job. If the requested resources are already available, the job can start immediately. Otherwise, the start of the job is delayed (pending) until enough resources are available. SLURM allows you to monitor active (pending, running) jobs and to retrieve statistics about finished jobs e.g. (peak CPU usage). The subchapters describe individual aspects of SLURM.

This page describes the job submission process with Slurm.

!!! types caution ""
    It is important to collect error/output messages either by writing such information to the default location or by specifying specific locations using the --error/–output option. Do not redirect the error/output stream to /dev/null unless you know what you are doing. Error and output messages are the starting point for investigating a job failure.

!!! types caution ""
    For backfilling performance and hence to maximize job throughput it is crucial to submit array jobs (collection of similar jobs) instead of submitting the same job repeatedly.

!!! types note ""
    We provide a partition containing EL6 nodes called *el6legacy* until December 2018. This partition should only be used as a last resort. You should migrate your code to EL7 as quickly as possible. If you submit jobs to the *el6legacy* partition use the SLURM option **--export=NONE** (#SBATCH --export=NONE) to not propagate any environment variables to the launched application.


## Resource Allocation

Every job submission starts with a resources allocation (nodes, cores, memory). An allocation is valid for a specific amount of time, and can be created using the salloc, sbatch or srun commands. Whereas salloc and sbatch only create resource allocations, srun launches parallel tasks within such a resource allocation, or implicitly creates an allocation if not started within one. **The usual procedure is to combine resource requests and task execution (job steps) in a single batch script (job script) and then submit the script using the sbatch command.**

!!! types note ""
    Most command options support a short form as well as a long form (e.g. -u <username>, and --user=<username>). Because few options only support the long form, we will consistently use the long form throughout this documentation.

!!! types note ""
    Some options have default values if not specified: The *--time* option has partition-specific default values (see *scontrol show partition <partname>*). The *--mem-per-cpu* option has a global default value of 2048MB.

!!! types note ""
    The default partition is the *all* partition. To select another partition one must use the *--partition* option, e.g. *--partition=long*.

!!! types caution "Important information for investors regarding account selection"
    Investors have two different accounts for accounting purposes. The investor account (increased privileges) is used automatically when using the *empi* partition (--partition=empi). To use another partition, the user must explicitly select the group account (e.g --account=dcb). To display your accounts, use: *sacctmgr show assoc where user=<username> format=user,account%20,partition.*


###sbatch
The *sbatch* command is used to submit a job script for later execution. It is the most common way to submit a job to the cluster due to its reusability. Slurm options are usually embedded in a job script prefixed by '#SBATCH' directives. Slurm options specified as command line options overwrite corresponding options embedded in the job script

Syntax

```Bash
sbatch [options] script [args...]
```

###<small>**Job Script**</small>

Usually a job script consists of two parts. The first part is optional but highly recommended:

* Slurm-specific options used by the scheduler to manage the resources (e.g. memory) and configure the job environment
* Job-specific shell commands

The job script acts as a wrapper for your actual job. Command-line options can still be used to overwrite embedded options.

!!! types note ""
    Although you can specify all Slurm options on the command-line, we encourage you, for clarity and reusability, to embed Slurm options in the job script

!!! types note ""
    You can find a template for a job script under /storage/software/workshop/slurm_template.sh. Copy the template to your home directory and adapt it to your needs: cp /gpfs/software/workshop/job_script_template.sh $HOME

###<small>**Options**</small>

| Option      | Description        | Example       | Default Value       |
|-------------|--------------------|---------------|---------------------|
|--mail-user  | Mail address to contact job owner. **Must specify a valid email address!** | --mail-user=foo.bar@baz.unibe.ch |  |
|--mail-type  | When to notify a job owner: _none, all, begin, end, fail, requeue, array_tasks_ | --mail-type=end,fail | |
|--account    | Which account to charge. Regular users don't need to specify this option. For users with enhanced privileges on the _empi_ partition, see [here](https://docs.id.unibe.ch/ubelix/job-management-with-slurm/job-submission#JobSubmission-RequestinganAccount)| | The users default account. |
|--job-name   | Specify a job name | --job-name="Simple Matlab" | |
|--time       | Expected runtime of the job. Format: dd-hh:mm:ss | --time=12:00:00 <br> --time=2-06:00:00  | Partition-specific, see _scontrol show partition <partname>_ |
|--mem-per-cpu| Minimum memory required per allocated CPU in megabytes. Different units can be specified using the suffix [K\|M\|G] | --mem-per-cpu=2G | 2048 MB |
|--tmp        | Specify the amount of disk space that must be available on the compute node(s). The local scratch space for the job is referenced by the variable _TMPDIR_. Default units are megabytes. Different units can be specified using the suffix [K\|M\|G\|T]. | --tmp=8G <br>--tmp=2048 | |
|--ntasks     | Number of tasks (processes). Used for MPI jobs that may run distributed on multiple compute nodes | --ntasks=4 | 1 or to match --nodes, --tasks-per-node if specified |
|--nodes      | Request a certain number of nodes | --nodes=2 | 1 or to match --ntasks, --tasks-per-node if specified
|--ntasks-per-node | Specifies how many tasks will run on each allocated node. Meant to be used with _--nodes_. If used with the _--ntasks_ option, the _--ntasks_ option will take precedence and the _--ntasks-per-node_ will be treated as a maximum count of tasks per node.| --ntasks-per-node=2 | |
|--cpus-per-task | Number of CPUs per taks (threads). Used for shared memory jobs that run locally on a single compute node | --cpus-per-task=4 | 1 |
|--array      | Submit an array job. Use "%" to specify the max number of tasks allowed to run concurrently. | --array=1,4,16-32:4 <br> --array=1-100%20 | |
|--workdir    | Set the current working directory. All relative paths used in the job script are relative to this directory | |The directory from where the sbatch command was executed|
|--output     | Redirect standard output. **All directories specified in the path must exist before the job starts!** | | By default stderr and stdout are connected to the same file slurm-%j.out, where '%j' is replaced with the job allocation number. |
|--error      | Redirect standard error. **All directories specified in the path must exist before the job starts!** | | By default stderr and stdout are connected to the same file slurm-%j.out, where '%j' is replaced with the job allocation number. |
|--partition  | **The "all" partition is the default partition. A different partition must be requested with the --partition option!** | --partition=long <br> --partition=el6legacy | Default partition: all |
|--dependency | Defer the start of this job until the specified dependencies have been satisfied. See _man sbatch_ for a description of all valid dependency types | --dependency=afterany:11908 | |
|--hold       | Submit job in hold state. Job is not allowed to run until explicitly released | | |
|--immediate  | Only submit the job if all requested resources are immediately available | | |
|--exclusive  | Use the compute node(s) exclusively, i.e. do not share nodes with other jobs. **CAUTION: Only use this option if you are an experienced user, and you really understand the implications of this feature. If used improperly, the use of this option can lead to a massive waste of computational resources** | | |
|--constraint | Request nodes with certain features. This option allows you to request a homogeneous pool of nodes for you MPI job | --constraint=ivy (all, long partition) <br> --constraint=sandy (all partition only) <br> --constraint=broadwell (all, empi partition) | |
|--parsable   | Print the job id only | | Default output: "Submitted batch job <jobid>" |
|--test-only  | Validate the batch script and return the estimated start time considering the current cluster state

###<small>**Example**</small>

jobs.sh
```Bash
#!/bin/bash
#SBATCH --mail-type=none
#SBATCH --job-name="Serial example"
#SBATCH --time=00:10:00
#SBATCH --mem-per-cpu=4G

# Your code below this line
./calc_mat.sh
```

Submit the job script:

```Batch
sbatch job.sh
Submitted batch job 30215045
```

!!! types note ""
    See below for more examples

###<small>**salloc**</small>

The _salloc_ command is used to allocate resources (e.g. nodes), possibly with a set of constraints (e.g. number of processor per node) for later utilization. It is typically used to allocate resources and spawn a shell, in which the _srun_ command is used to launch parallel tasks.

Syntax
```Bash
salloc [options] [<command> [args...]]
```

Example
```Bash
bash$ salloc -N 2 sh
salloc: Granted job allocation 247
sh$ module load openmpi/1.10.2-gcc
sh$ srun --mpi=pmi2 mpi_hello_world
Hello, World.  I am 1 of 2 running on knlnode03.ubelix.unibe.ch
Hello, World.  I am 0 of 2 running on knlnode02.ubelix.unibe.ch
sh$ exit
salloc: Relinquishing job allocation 247
```

###<small>**srun**</small>

The _srun_ command creates job steps. One or multiple _srun_ invocations are usually used from within an existing resource allocation. Thereby, a job step can utilize all resources allocated to the job, or utilize only a subset of the resource allocation. Multiple job steps can run sequentially in the order defined in the batch script or run in parallel, but can together never utilize more resources than provided by the allocation.


!!! types danger ""
    Do not submit a job script using _srun_. Embedded Slurm options (#SBATCH) are not parsed by _srun_.


Syntax
```Batch
srun [options] executable [args...]
```

###<small>**When do I use srun in my job script?**</small>

Use _srun_ in your job script to

* start MPI tasks
* run multiple jobs (serial or parallel jobs) simultaneously within an allocation

**Example**
Run MPI task:

```Bash
#!/bin/bash
#SBATCH --mail-type=none
#SBATCH --job-name="Open MPI example"
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=16
#SBATCH --mem-per-cpu=2G
#SBATCH --time=06:00:00

# Your code below this line
module load openmpi/1.10.2-gcc
srun --mpi=pmi2 mpi_bin
```

Run two jobs simultaneously:

```Bash
#!/bin/bash
#SBATCH --mail-type=none
#SBATCH --job-name="Open MPI example"
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=2
#SBATCH --mem-per-cpu=2G
#SBATCH --time=06:00:00

# Your code below this line
# Each job should run on a different node and starts two processes on that node:
srun --nodes=1 --ntasks=2 job01.sh &
srun --nodes=1 --ntasks=2 job02.sh &
# Wait for both commands to finish. This is important when running bash commands in the background (using &)!
wait
```

## Requesting a Partition (Queue)

The default partition is the 'all' partition. If you do not explicitly request a partition, your job will run in the default partition. To request a different partition, you must use the --partition option:

```Bash
#SBATCH --partition=long
```

See [here](../../overview.html#cluster-partitions-queues-and-their-compute-nodes)  for a list of availalble partitions.


## Requesting an Account

Accounts are used for accounting purposes. Every user has a default account that is used unless a different account is specified using the --account option. Regular users only have a single account and can thus not request a different account. The default account for regular user is named after their group (e.g. dcb):

```Bash
$ sacctmgr show user foo
      User   Def Acct     Admin
---------- ---------- ---------
       foo        bar      None
```

!!! type note ""
    The remaining information provided in this section applies only to users with enhanced privileges on the _empi_ partition.

Users with enhanced privileges have an additional account for the _empi_ partition. This additional account is set as their default account, which means they don't have to specify an account when submitting to the _empi_ partition (--partition=_empi_), but must specify their "group account" (--account=<group>) for submitting to any other partition (e.g _all_). If a wrong account/partition combination is requested, you will experience the following error message:

```Bash
sbatch: error: Batch job submission failed: Invalid account or account/partition combination specified
```

###<small>**Example**</small>

Here are some examples on the usage of the --account and --partition options.

Regular users:

```Bash
Submit to the "all" partition:
No options required!

Submit to any other partition:
--partition=<partname> e.g. --partition=empi
```

Users with enhanced privileges on the _empi_ partition:

```Bash
Submit to the "all" partition:
--account=<grpname> e.g. --account=dcb
 
Submit to the "empi" partition:
--partition=empi
 
Submit to any other partition:
--account=<grpname> e.g. --account=dcb
--partition=<partname> e.g. --partition=long
```

##Parallel Jobs

A parallel job either runs on multiple CPU cores on a single compute node, or on multiple CPU cores distributed over multiple compute nodes. With Slurm you can request tasks, and CPUs per task. A task corresponds to a process that may be made up of multiple threads (CPUs per task). Different tasks of a job allocation may run on different compute nodes, while all threads that belong to a certain process execute on the same node. **For shared memory jobs (SMP, parallel jobs that run on a single compute node) one would request a single task and a certain number of CPUs for that task:**

```Bash
#SBATCH --cpus-per-task=16
```

**For MPI jobs (parallel jobs that may be distributed over multiple compute nodes) one would request a certain number of tasks and certain number of nodes:**

```Bash
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=16
```

!!! type danger ""
    The requested node,task, and CPU resources must match! For example, you cannot request one node (--nodes=1) and more tasks (--ntasks-per-node) than CPU cores are available on a single node in the partition. In such a case you will experience an error message: **sbatch: error: Batch job submission failed: Requested node configuration is not available.**

###<small>**Open MPI**</small>
Open MPI was compiled with Slurm support, which means that you do not have to specify the number of processes and the execution hosts using the -np and the -hostfile options. Slurm will automatically provide this information to mpirun based on the allocated tasks:

```Bash
#!/bin/bash
#SBATCH --mail-user=foo.bar@baz.unibe.ch
(...)
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=16

module load openmpi/1.10.2-gcc
mpirun <options> <binary>
```


## Environment Variables

Slurm sets various environment variables available in the context of the job script. Some are set based on the requested resources for the job.


| Environment Variable   | Set By Option   | Description   |
|------------------------|-----------------|---------------|
|SLURM_JOB_NAME          | --job-name      | Name of the job |
|SLURM_ARRAY_JOB_ID      |                 | ID of your job |
|SLURM_ARRAY_TASK_ID     | --array         | ID of the current array task |
|SLURM_ARRAY_TASK_MAX    | --array         | Job array's maximum ID (index) number |
|SLURM_ARRAY_TASK_MIN    | --array         | Job array's minimum ID (index) number |
|SLURM_ARRAY_TASK_STEP   | --array         | Job array's index step size |
|SLURM_NTASKS            | --ntasks        | Same as -n, --ntasks |
|SLURM_NTASKS_PER_NODE   | --ntasks-per-node	| Number of tasks requested per node.  Only set if the --ntasks-per-node option is specified |
|SLURM_CPUS_PER_TASK     | --cpus-per-task | Number of cpus requested per task.  Only set if the --cpus-per-task option is specified |
|TMPDIR                  |                 | References the disk space for the job on the local scratch


## Job Examples

### Sequential Job

Running a Single Job Step

```Bash
#!/bin/bash
#SBATCH --mail-user=foo.bar@baz.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --job-name="Serial Job"
#SBATCH --time=04:00:00

# Your code below this line
echo "I'm on host:"
hostname
echo "Environment variables:"
env
```

###<small>**Parallel Jobs**</small>

**Shared Memory Jobs (e.g. OpenMP)**

SMP parallelization is based upon dynamically created threads (fork and join) that share memory on a single node. The key request is "--cpus-per-task". To run N threads in parallel, we request N CPUs on the node (--cpus-per-task=N). OpenMP is not slurm-aware, you need to specify "export OMP_NUM_THREADS=..." in your submission script! Thereby OMP_NUM_THREADS (max number of thread spawned by your program) must correspond the number of cores requested. As an example, consider the following job script:

```Bash
#!/bin/bash
#SBATCH --mail-user=foo.bar@baz.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --job-name="SMP Job"
#SBATCH --mem-per-cpu=2G
#SBATCH --cpus-per-task=16
#SBATCH --time=04:00:00

# Your code below this line
# set OMP_NUM_THREADS to the number of --cpus-per-task that we requested
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
./my_binary
```

!!! type danger ""
    For optimal resource management, notably to prevent oversubscribing the compute node, setting the correct number of threads is crucial. The assignment OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK will ensure that your program does not spawn more threads than requested.

**MPI Jobs (e.g. Open MPI)**

MPI parallelization is based upon processes (local or distributed) that communicate by passing messages. Since they don't rely on shared memory those processes can be distributed among several compute nodes.
Use the option --ntasks to request a certain number of tasks (processes) that can be distributed over multiple nodes:

```Bash
#!/bin/bash
#SBATCH --mail-user=foo.bar@baz.unibe.ch
#SBATCH --mail-type=end
#SBATCH --job-name="MPI Job"
#SBATCH --mem-per-cpu=2G
#SBATCH --ntasks=8
#SBATCH --time=04:00:00

# Your code below this line
# First set the environment for using Open MPI
module load openmpi/1.10.2-gcc
srun --mpi=pmi2 ./my_binary # or, mpirun ./my_binary
```

On the 'empi' partition you must use all CPUs provided by a node (20 CPUs). For example to run an OMPI job on 80 CPUs, do:

```Bash
#!/bin/bash
#SBATCH --mail-user=foo.bar@baz.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --job-name="MPI Job"
#SBATCH --mem-per-cpu=2G
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=20
#SBATCH --time=12:00:00

# Your code below this line
# First set the environment for using Open MPI
module load openmpi/1.10.2-gcc
srun --mpi=pmi2 ./my_binary # or, mpirun ./my_binary
```


## Performance considerations

### Job Throughput

**It is crucial to specify a more or less accurate runtime for your job.**  
Requesting too little will result in job abortion, while requesting too much will have a negative impact on job start time and job throughput: Firstly, jobs with a shorter runtime have a greater chance to benefit from being backfilled between long running jobs and may therefore start earlier if resources are scarce. Secondly, a short running job may still start when a scheduled downtime is getting closer while long running jobs won't start because they are not guaranteed to finish before the start of the downtime.

**It is crucial to request the correct amount of cores for your job.**  
Requesting cores that your job cannot utilize is a waste of resources that could otherwise be allocated to other jobs. Hence, jobs that theoretically could run have to wait for the resources to become available. For potential consequences of requesting too less cores on job performance, see below.

**It is crucial to request the correct amount of memory for your job.**  
Requesting too little memory will result in job abortion. Requesting too much memory is a waste of resources that could otherwise be allocated to other jobs.

### Job Performance/Runtime

**It is crucial to request the correct amount of cores for your job.**  
For parallel jobs (shared memory, MPI, hybrid) requesting less cores than processes/threads are spawned by the job will lead to potentially overbooked compute nodes. This is because your job will nevertheless spawn the required number of processes/threads (use a certain number of cores) while to the scheduler it appears that some of the utilized resources are still available, and thus the scheduler will allocate those resources to other jobs. Although under certain circumstances it might make sense to share cores among multiple processes/threads, the above reasoning should be considered as a general guideline, especially for unexperienced user.


Related pages:
:    [Deleting Jobs](deleting-jpbs.html)
:    [Job Submission](job-submission.html)
:    Monitoring Jobs

