[slurm-quickstart]: ../../runjobs/scheduled-jobs/slurm-quickstart.md
[slurm-doc]: https://slurm.schedmd.com/documentation.html
[slurm-man]: https://slurm.schedmd.com/man_index.html
[slurm-sbatch]: https://slurm.schedmd.com/sbatch.html
[gpu-jobs]: ../scheduled-jobs/gpus.md

# Submitting Jobs

This page covers submitting Slurm batch jobs on UBELIX.
If you are not already familiar with Slurm, you should read the [Slurm
quickstart][slurm-quickstart] guide which covers the basics. You can also refer
to the Slurm [documentation][slurm-doc] or [manual pages][slurm-man], in
particular the page about [sbatch][slurm-sbatch].

## Resource Allocation

Every job submission starts with a resources allocation (nodes, cores, memory). An allocation is requested for a specific amount of time, and can be created using the `salloc`, `sbatch` commands. Whereas `salloc` and `sbatch` only create resource allocations, `srun` launches parallel tasks within such a resource allocation.

## Performance considerations

**It is crucial to specify a more or less accurate runtime for your job.**
Requesting too little will result in job timeout, while requesting too much will have a negative impact on job start time and job throughput: Jobs with a shorter runtime have a greater chance to benefit from being backfilled and may therefore start earlier.

**It is crucial to request the correct amount of memory for your job.**
Requesting too little memory will result in job abortion. Requesting too much memory is a waste of resources that could otherwise be allocated to other jobs.

**It is crucial to request the correct amount of cores and tasks for your job.**
Requesting the correct amount of cores and tasks for your job is necessary for
optimal job performance. To efficiently to this you need to understand the
characteristics of your application:

- Is it a serial application that can only use one core? <br>
  Use `--ntasks=1 / --cpus-per-task=1`.
- Is is able to run on a single machine using multiple cores? <br>
  Use `--ntasks=1 / --cpus-per-task=X`.
- Or does it support execution on multiple machines with MPI? <br>
  Use `--ntasks=X / --cpus-per-task=1`.

!!! tip "Job arrays"
    Submit series of jobs (collection of similar jobs) as *array jobs* instead of one by one. This is crucial for backfilling performance and hence job throughput. Instead of submitting the same job repeatedly. See [Array jobs](../scheduled-jobs/throughput.md).

## Common Slurm options

Here is an overview of some of the most commonly used Slurm options.

### Basic job specification

| <div style="width:120px">Option</div> | Description |
| --------------|----------------------------------------------------------|
| `--time`      | Set a limit on the total run time of the job allocation. Format: `dd-hh:mm:ss` |
| `--account`   | Charge resources used by this job to specified project   |
| `--partition` | Request a specific partition for the resource allocation |
| `--qos`        | Specify "Quality of Service". This can be used to change job limits, e.g. for long jobs or short jobs with large resources. See [Partition/QoS page](../partitions.md) |
| `--job-name`   | Specify a job name. Example: `--job-name="Simple Matlab"` | |
| `--output`     | Redirect **standard output**. *All directories specified in the path must exist before the job starts!* By default stderr and stdout are merged into a file `slurm-%j.out`, where `%j` is the job allocation number. Example: `--output=myCal_%j.out` |
|`--error`      | Redirect **standard error**. *All directories specified in the path must exist before the job starts!* By default stderr and stdout are merged into a file `slurm-%j.out`, where `%j` is the job allocation number. Example: `--output=myCal_%j.err` |
| `--mail-user`  | Mail address to contact job owner. **Must be a valid unibe email address, if used!** Example:`--mail-user=foo.bar@unibe.ch` |
| `--mail-type`  | When to notify a job owner: `none`, `all`, `begin`, `end`, `fail`, `requeue`, `array_tasks`. Example: `--mail-type=end,fail` |


### Request CPU cores

| Option            | Description                              |
| ------------------|------------------------------------------|
| `--cpus-per-task` | Set the number of cores per task         |

### Request memory

| Option            | Description                            |
| ------------------|----------------------------------------|
| `--mem`           | Set the memory per node. Note: Try to use `--mem-per-cpu` or `--mem-per-gpu` instead. |
| `--mem-per-cpu`   | Set the memory per allocated CPU cores. Example: `--mem-per-cpu=2G` |
| `--mem-per-gpu`   | Set the memory per allocated GPU. Example: `--mem-per-gpu=2G` |

### Request GPUs

| Option            | Description                                              |
| ------------------|----------------------------------------------------------|
| `--gpus`          | Set the total number of GPUs to be allocated for the job |
| `--gpus-per-node` | Set the number of GPUs per node                          |
| `--gpus-per-task` | Set the number of GPUs per task                          |

For details on how to request GPU resources on UBELIX, please see the [GPUs][gpu-jobs] page.

### Specify tasks distribution (MPI)

| Option                | Description                                 |
| ----------------------|---------------------------------------------|
| `--nodes`             | Number of nodes to be allocated to the job  |
| `--ntasks`            | Set the maximum number of tasks (MPI ranks) |
| `--ntasks-per-node`   | Set the number of tasks per node            |
| `--ntasks-per-socket` | Set the number of tasks on each node        |
| `--ntasks-per-core`   | Set the maximum number of task on each core |

## sbatch
The `sbatch` command is used to submit a job script for later execution. It is the most common way to submit a job to the cluster due to its reusability. Slurm options are usually embedded in a job script prefixed by `#SBATCH` directives. Slurm options specified as command line options overwrite corresponding options embedded in the job script

Syntax

```Bash
sbatch [options] script [args...]
```

### Job Script

!!! example "Sneak Peek: A simple Python example"

    Create sbmission script, `python_job.sh` allocating 8CPUs, 8GB memory for 1hour:
    ```Bash
    #!/bin/bash
    #SBATCH --job-name="Simple Python example"
    #SBATCH --time=01:00:00
    #SBATCH --mem-per-cpu=1G
    #SBATCH --cpus-per-task=8

    # Your code below this line
    module load Anaconda3
    eval "$(conda shell.bash hook)"
    python3 script.py
    ```

    Submit the job script:

    ```Batch
    sbatch python_job.sh
    Submitted batch job 30215045
    ```

    See below for more details and background information.

A batch script is summarized by the following steps:

- the interpreter to use for the execution of the script: bash
- directives that define the job options: resources, run time, ...
- setting up the environment: prepare input, environment variables, ...
- run the application

The job script acts as a wrapper for your actual job.
The first line is generally `#!/bin/bash` and specifies that the script
should be interpreted as a bash script.

The lines starting with `#SBATCH` are directives for the workload manager.
These have the general syntax

```bash
#SBATCH option_name=argument
```

The available options are shown above and are the same as the one you use on the command line:
`sbatch --time=01:00:00` in the command line and `#SBATCH --time=01:00:00` in a batch
script are equivalent. The command line value takes precedence if the same
option is present both on the command line and as a directive in a script.


## salloc

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

## srun

The `srun` command creates job steps. One or multiple `srun` invocations are usually used from within an existing resource allocation. Thereby, a job step can utilize all resources allocated to the job, or utilize only a subset of the resource allocation. Multiple job steps can run sequentially in the order defined in the batch script or run in parallel, but can together never utilize more resources than provided by the allocation.


!!! danger "Warning"
    Do not submit a job script using `srun` directly. Always create an allocation with `salloc` or embed it in a script submitted with `sbatch`.


Syntax
```Batch
srun [options] executable [args...]
```

Use `srun` in your job script for executables if these are:

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
#SBATCH --job-name="Simultaneous example"
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=4

# Your code below this line
# run 2 threaded applications side-by-side
srun --tasks=1 --cpus-per-task=4 ./app1 inp1.dat &
srun --tasks=1 --cpus-per-task=4 ./app2 inp2.dat &
wait
# wait: Wait for both background commands to finish. This is important when running bash commands in the background (using &)! Otherwise, the job ends immediately.
```

Please run series of similar tasks as job array. See [Array Jobs](../scheduled-jobs/throughput.md).

## Requesting a Partition / QoS

Per default jobs are submitted to the `epyc2` partition and the default QoS `job_cpu`.
The partition option can be used to request different hardware, e.g. `gpu` partition. And the QoS can be used to run in a specific queue, e.g. `job_gpu_debug`:

```Bash
#SBATCH --partition=gpu
#SBATCH --qos=job_gpu_debug
```

See [Partitions / QoS](../partitions.md) for a list of available partitions and QoS and its specifications.

## Job Examples

### Sequential Job

Running a serial job with email notification in case of error (1 task is default value):

```Bash
#!/bin/bash
#SBATCH --mail-user=foo.bar@unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --job-name="Serial Job"
#SBATCH --time=00:10:00

# Your code below this line
echo "I'm on host: $HOSTNAME"
```

### Parallel Jobs

**Shared Memory Jobs (e.g. OpenMP)**

SMP parallelization is based upon dynamically created threads (fork and join) that share memory on a single node. The key request is `--cpus-per-task`. To run N threads in parallel, we request N CPUs on the node (`--cpus-per-task=N`). 

```Bash
#!/bin/bash
#SBATCH --mail-user=foo.bar@unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --job-name="SMP Job"
#SBATCH --mem-per-cpu=2G
#SBATCH --cpus-per-task=16
#SBATCH --time=01:00:00

# Your code below this line
srun ./my_binary
```

**MPI Jobs (e.g. Open MPI)**

MPI parallelization is based upon processes (local or distributed) that communicate by passing messages. Since they don't rely on shared memory those processes can be distributed among several compute nodes.
Use the option `--ntasks` to request a certain number of tasks (processes) that can be distributed over multiple nodes:

```Bash
#!/bin/bash
#SBATCH --mail-user=foo.bar@unibe.ch
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

### GPU Jobs

For information on how to run GPU jobs on UBELIX, please see the [GPUs][gpu-jobs] page.

## Automatic requeuing

The UBELIX Slurm configuration has **automatic requeuing** of jobs upon node
failure **enabled**. It means that if a node fails, your job will be
automatically resubmitted to the queue and will have the same job ID and
possibly truncate the previous output. Here are some important parameters you
can use to alter the default behavior.

- you can disable automatic requeuing using the `--no-requeue` option
- you can avoid your output file being truncated in case of requeuing by using
  the `--open-mode=append` option

If you want to perform specific operations in your batch script when a job has
been requeued, you can check the value of the `SLURM_RESTART_COUNT` variable.
The value of this variable will be `0` if it is the first time the job is run.
If the job has been restarted, the value will be the number of times the
job has been restarted.

## Common error messages

Below are some common error messages you may get when your job submission
fails.

### Job violates accounting/QOS policy

The complete error message is:

```text
sbatch: error: AssocMaxSubmitJobLimit
sbatch: error: Batch job submission failed: Job violates accounting/QOS policy (job submit limit, user's size and/or time limits)
```

The most common causes are:

- your project has already used all of its allocated compute resources.
- job script is missing the `--account` parameter.
- your project has exceeded the limit for the number of simultaneous jobs, either
  running or queuing. Note that Slurm counts each job within an array job as a
  separate job.

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
