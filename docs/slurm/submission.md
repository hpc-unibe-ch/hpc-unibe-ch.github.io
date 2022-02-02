# Job Submission

## Description
This section describes the interaction with the resource manager. The subchapters contain information about submitting jobs to the cluster, monitoring active jobs and retrieving useful information about resource usage.

A cluster is a set of connected computers that work together to solve computational tasks (user jobs) and presents itself to the user as a single system. For the resources of a cluster (e.g. CPUs, GPUs, memory) to be used efficiently, a resource manager (also called workload manager or batch-queuing system) is vital. While there are many different resource managers available, the resource manager of choice on UBELIX is [SLURM](https://slurm.schedmd.com). After submitting a job to the cluster, SLURM will try to fulfill the job's resource request by allocating resources to the job. If the requested resources are already available, the job can start immediately. Otherwise, the start of the job is delayed (pending) until enough resources are available. SLURM allows you to monitor active (pending, running) jobs and to retrieve statistics about finished jobs e.g. (peak CPU usage). The subchapters describe individual aspects of SLURM.

This page describes the job submission process with Slurm.

!!! types caution "keep output"
    It is important to collect error/output messages either by writing such information to the default location or by specifying specific locations using the `--error`/`-–output` option. Do not redirect the error/output stream to /dev/null unless you know what you are doing. Error and output messages are the starting point for investigating a job failure.

!!! types caution "job series"
    Submit series of jobs (collection of similar jobs) as *array jobs* instead of one by one. This is crucial for backfilling performance and hence job throughput. instead of submitting the same job repeatedly. See [Array jobs](array-jobs.md)

### Simple Example

Batch sbmission script, `jobs.sh`:
```Bash
#!/bin/bash
#SBATCH --job-name="First example"
#SBATCH --time=00:10:00
#SBATCH --mem-per-cpu=1G

# Your code below this line
module load Python
srun python3 script.py
```

Submit the job script:

```Batch
sbatch job.sh
Submitted batch job 30215045
```

!!! types note ""
    See below for more examples


## Resource Allocation

Every job submission starts with a resources allocation (nodes, cores, memory). An allocation is valid for a specific amount of time, and can be created using the `salloc`, `sbatch` or `srun` commands. Whereas `salloc` and `sbatch` only create resource allocations, `srun` launches parallel tasks within such a resource allocation, or implicitly creates an allocation if not started within one. **The usual procedure is to combine resource requests and task execution (job steps) in a single batch script (job script) and then submit the script using the `sbatch` command.**

!!! types note ""
    Most command options support a short form as well as a long form (e.g. `-u <username>`, and `--user=<username>`). Because few options only support the long form, we will consistently use the long form throughout this documentation.

!!! types note ""
    Some options have default values if not specified: The `--time` option has partition-specific default values (see `scontrol show partition <partname>`). The `--mem-per-cpu` option has a global default value of 2048MB.

!!! types note ""
    The default partition is *epyc2*. To select another partition one must use the `--partition` option, e.g. `--partition=gpu`.

###sbatch
The `sbatch` command is used to submit a job script for later execution. It is the most common way to submit a job to the cluster due to its reusability. Slurm options are usually embedded in a job script prefixed by `#SBATCH` directives. Slurm options specified as command line options overwrite corresponding options embedded in the job script

Syntax

```Bash
sbatch [options] script [args...]
```

#### Job Script

Usually a job script consists of two parts. The first part is optional but highly recommended:

* Slurm-specific options used by the scheduler to manage the resources (e.g. memory) and configure the job environment
* Job-specific shell commands

The job script acts as a wrapper for your actual job. Command-line options can still be used to overwrite embedded options.

!!! types note ""
    Although you can specify all Slurm options on the command-line, we encourage you, for clarity and reusability, to embed Slurm options in the job script

#### Options

| <div style="width:120px">Option</div> | Description | <div style="width:180px">Example</div> |
|-------------|--------------------|---------------|
|`--job-name`   | Specify a job name | `--job-name="Simple Matlab"` | |
|`--time`       | Expected runtime of the job. Format: dd-hh:mm:ss | `--time=12:00:00` <br> `--time=2-06:00:00`  | Partition-specific, see `scontrol show partition <partname>` |
|`--ntasks`     | Number of tasks (processes). Used for MPI jobs that may run distributed on multiple compute nodes | `--ntasks=4` |
|`--nodes`      | Request a certain number of nodes | `--nodes=2` |
|`--ntasks-per-node` | Specifies how many tasks will run on each allocated node. Meant to be used with `--nodes`. If used with the `--ntasks` option, the `--ntasks` option will take precedence and the `--ntasks-per-node` will be treated as a maximum count of tasks per node.| `--ntasks-per-node=2` |
|`--cpus-per-task` | Number of CPUs per task (threads). Used for shared memory jobs that run locally on a single compute node. Default is `1` | `--cpus-per-task=4` |
|`--mem-per-cpu`| Minimum memory required per allocated CPU in megabytes. Different units can be specified using the suffix [K\|M\|G]. Default 2048 MB | `--mem-per-cpu=2G` |
|`--output`     | Redirect **standard output**. *All directories specified in the path must exist before the job starts!* By default stderr and stdout are merged into a file `slurm-%j.out`, where `%j` is the job allocation number. | `--output=myCal_%j.out` |
|`--error`      | Redirect **standard error**. *All directories specified in the path must exist before the job starts!* By default stderr and stdout are merged into a file `slurm-%j.out`, where `%j` is the job allocation number. | `--output=myCal_%j.err` |
|`--partition`  | Select a different partition with different hardware. See [Partition/QoS page](partitions.md). Default: `epyc2` | `--partition=bdw` <br> `--partition=gpu` |
|`--qos`        | Specify "Quality of Service". This can be used to change job limits, e.g. for long jobs or short jobs with large resources. See [Partition/QoS page](partitions.md)
|`--tmp`        | Specify the amount of disk space that must be available on the compute node(s). The local scratch space for the job is referenced by the variable `$TMPDIR`. Default units are megabytes. Different units can be specified using the suffix [K\|M\|G\|T]. | `--tmp=8G` |
|`--mail-user`  | Mail address to contact job owner. <br> **Must be a valid email address, if used!** | `--mail-user=foo.bar@unibe.ch` |
|`--mail-type`  | When to notify a job owner: `none`, `all`, `begin`, `end`, `fail`, `requeue`, `array_tasks` | `--mail-type=end,fail` |
|`--array`      | Submit an array job. Specify the used indices and use "%" to specify the max number of tasks allowed to run concurrently. | `--array=1,4,16-32:4` <br> `--array=1-100%20` |
|`--chdir`      | Set the working directory of the batch script to directory before it is executed. The path can be specified as full path or relative path to the directory where the command is executed. Environment variables are not supported. | `--chdir=subdir1` |
|`--dependency` | Defer the start of this job until the specified dependencies have been satisfied. See `man sbatch` for a description of all valid dependency types | `--dependency=afterok:11908` |
|`--immediate`  | Only submit the job if all requested resources are immediately available | | |
|`--exclusive`  | Use the compute node(s) exclusively, i.e. do not share nodes with other jobs. **CAUTION: Only use this option if you are an experienced user, and you really understand the implications of this feature. If used improperly, the use of this option can lead to a massive waste of computational resources** | | |
|`--test-only`  | Validate the batch script and return the estimated start time considering the current cluster state
|`--account`    | Specifies account to charge. Please use `Workspace` module to select Workspace account. Regular users don't need to specify this option. |

#### salloc

The `salloc` command is used to allocate resources (e.g. nodes), possibly with a set of constraints (e.g. number of processor per node) for later utilization. It is typically used to allocate resources and spawn a shell, in which the `srun` command is used to launch parallel tasks.

Syntax
```Bash
salloc [options] [<command> [args...]]
```

Example
```Bash
bash$ salloc -N 2 -t 10
salloc: Granted job allocation 247
bash$ module load foss
bash$ srun ./mpi_hello_world
Hello, World.  I am 1 of 2 running on knlnode03.ubelix.unibe.ch
Hello, World.  I am 0 of 2 running on knlnode02.ubelix.unibe.ch
bash$ exit
salloc: Relinquishing job allocation 247
```

#### srun

The `srun` command creates job steps. One or multiple `srun` invocations are usually used from within an existing resource allocation. Thereby, a job step can utilize all resources allocated to the job, or utilize only a subset of the resource allocation. Multiple job steps can run sequentially in the order defined in the batch script or run in parallel, but can together never utilize more resources than provided by the allocation.


!!! types danger ""
    Do not submit a job script using `srun`. Embedded Slurm options (`#SBATCH`) are not parsed by `srun`.


Syntax
```Batch
srun [options] executable [args...]
```

#### When do I use srun in my job script?

Use `srun` in your job script for all main executables, especially if these are:

* MPI applications
* multiple job tasks (serial or parallel jobs) simultaneously within an allocation

**Example**
Run MPI task:

```Bash
#!/bin/bash
#SBATCH --job-name="Open MPI example"
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=20
#SBATCH --mem-per-cpu=2G
#SBATCH --time=06:00:00

# Your code below this line
module load foss
srun ./mpi_app.exe
```

Run two jobs simultaneously:

```Bash
#!/bin/bash
#SBATCH --job-name="Open MPI example"
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=4

# Your code below this line
# run 2 threaded applications side-by-side
srun --tasks=1 --cpus-per-task=4 ./app1 inp1.dat &
srun --tasks=1 --cpus-per-task=4 ./app2 inp2.dat &
wait
# wait: Wait for both background commands to finish. This is important when running bash commands in the background (using &)! Otherwise, the job ends immediately. 
```

Please run series of similar tasks as job array. See [Array Jobs](array-jobs.md)

## Requesting a Partition / QoS (Queue)

Per default jobs are submitted to the `epyc2` partition and the default QoS `job_epyc2`. 
The partition option can be used to request different hardware, e.b. `gpu` partition. And the QoS can be used to run in a specific queue, e.g. `job_gpu_debug`:

```Bash
#SBATCH --partition=gpu --qos=job_gpu_debug
```

See [Partitions / QoS](partitions.md) for a list of available partitions and QoS and its specifications.


## Accounts

By default a user has a "private" account. When belonging to a Workspace your private account gets deactivated and you can submit with the Workspace account. We strongly suggest to use the Workspace module (`module load Workspace`), which automatically sets the Workspace account for you. 
If really necessary, the can be selected by the `--account` option. 

If a wrong account/partition combination is requested, you will experience the following error message:

```Bash
sbatch: error: Batch job submission failed: Invalid account or account/partition combination specified
```

If you did not specified `--account`, and belong to a Workspace, please load the Workspace module fist.

##Parallel Jobs

A parallel job requires multiple compute cores. These could be within one node or across the machine in multiple nodes. We distinguish following types:

- **shared memory jobs**: SMP, parallel jobs that run on a single compute node. The executable is called once. Within the execution (OMP) threads are spawned and merged. 
```Bash
#SBATCH --ntasks=1           # default value
#SBATCH --cpus-per-task=4
```

- **MPI jobs**: parallel jobs that may be distributed over multiple compute nodes. Each task starts the executable. Within the application different workflows need to be defined for the different tasks. The tasks can communicate using Message Passing Interface (MPI). A job with 40 tasks:
```Bash
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=20
```

- **hybrid**: jobs using a combination of MPI tasks and (OMP) threads. 
```Bash
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=5
#SBATCH --cpus-per-task=4
```

!!! type danger ""
    The requested node,task, and CPU resources must match! For example, you cannot request one node (`--nodes=1`) and more tasks (`--ntasks-per-node`) than CPU cores are available on a single node in the partition. In such a case you will experience an error message: 
    ```Bash
    sbatch: error: Batch job submission failed: Requested node configuration is not available.
    ```

!!! note "parallel launcher"
    Parallel applications, esp. MPI, need a launcher to setup the environment. We strongly suggest to use `srun` instead of mpirun. 

## Environment Variables

Slurm sets various environment variables available in the context of the job script. Some are set based on the requested resources for the job.


| Environment Variable   | Set By Option   | Description   |
|------------------------|-----------------|---------------|
|`SLURM_JOB_NAME`          | `--job-name`      | Name of the job |
|`SLURM_ARRAY_JOB_ID`      |                 | ID of your job |
|`SLURM_ARRAY_TASK_ID`     | `--array`         | ID of the current array task |
|`SLURM_ARRAY_TASK_MAX`    | `--array`         | Job array's maximum ID (index) number |
|`SLURM_ARRAY_TASK_MIN`    | `--array`         | Job array's minimum ID (index) number |
|`SLURM_ARRAY_TASK_STEP`   | `--array`         | Job array's index step size |
|`SLURM_NTASKS`            | `--ntasks`        | Same as `-n`, `--ntasks` |
|`SLURM_NTASKS_PER_NODE`   | `--ntasks-per-node`	| Number of tasks requested per node.  Only set if the `--ntasks-per-node` option is specified |
|`SLURM_CPUS_PER_TASK`     | `--cpus-per-task` | Number of cpus requested per task.  Only set if the `--cpus-per-task` option is specified |
|`TMPDIR`                  |                 | References the disk space for the job on the local scratch |


For the full list, see `man sbatch`

## Job Examples

### Sequential Job

Running a serial job with email notification in case of error (1 task is default value):

```Bash
#!/bin/bash
#SBATCH --mail-user=foo.bar@baz.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --job-name="Serial Job"
#SBATCH --time=04:00:00

# Your code below this line
echo "I'm on host: $HOSTNAME"
```

### Parallel Jobs

**Shared Memory Jobs (e.g. OpenMP)**

SMP parallelization is based upon dynamically created threads (fork and join) that share memory on a single node. The key request is `--cpus-per-task`. To run N threads in parallel, we request N CPUs on the node (`--cpus-per-task=N`). 

```Bash
#!/bin/bash
#SBATCH --mail-user=foo.bar@baz.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --job-name="SMP Job"
#SBATCH --mem-per-cpu=2G
#SBATCH --cpus-per-task=16
#SBATCH --time=04:00:00

# Your code below this line
srun ./my_binary
```

**MPI Jobs (e.g. Open MPI)**

MPI parallelization is based upon processes (local or distributed) that communicate by passing messages. Since they don't rely on shared memory those processes can be distributed among several compute nodes.
Use the option `--ntasks` to request a certain number of tasks (processes) that can be distributed over multiple nodes:

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
module load foss
srun ./my_binary
```

On the 'bdw' partition you must use all CPUs provided by a node (20 CPUs). For example to run an OMPI job on 80 CPUs, do:

```Bash
#!/bin/bash
#SBATCH --mail-user=foo.bar@baz.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --job-name="MPI Job"
#SBATCH --mem-per-cpu=2G
#SBATCH --nodes=4     ## or --ntasks=80
#SBATCH --ntasks-per-node=20
#SBATCH --time=12:00:00

# Your code below this line
module load foss
srun ./my_binary
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
For parallel jobs (shared memory, MPI, hybrid) requesting less cores than processes/threads are spawned by the job will lead to potentially overbooked compute nodes. This is because your job will nevertheless spawn the required number of processes/threads (use a certain number of cores) while to the scheduler it appears that some of the utilized resources are still available, and thus the scheduler will allocate those resources to other jobs. Although under certain circumstances it might make sense to share cores among multiple processes/threads, the above reasoning should be considered as a general guideline, especially for inexperienced user.

## Advanced settings

### EXPORT=NONE
By default the environment from the session, where the job is submitted is forwarded into the job environment. As a result all loaded modules and environment variables present during submit time are also present during run time. 

To start from a clean environment the environment forwarding can be prevented. Therefore, we have to keep in mind the 2 stages. First, after submission the job script is launched on a compute node. Second, the parallel tasks are launched using srun. We want to preserve the environment forwarding from within the job script to the parallel tasks. 
Using just the option `sbatch --export=none` or the environment variable `SBATCH_EXPORT=NONE` will prevent the forwarding in both cases. 
Therewith, issues may occur, like dynamically linked binaries do not find libraries (e.g. `executable.xyz: error while loading shared libraries: libgfortran.so.5: cannot open shared object file: No such file or directory`).

Thus we suggest to set:

```
export SBATCH_EXPORT=NONE
export SLURM_EXPORT_ENV=ALL
```
This will provide you with a clean environment during job launch and forward the environment set in the job script to the parallel tasks. 
This is necessary to have e.g. LD_LIBRARY_PATH set correctly for dynamically linked binaries. 
