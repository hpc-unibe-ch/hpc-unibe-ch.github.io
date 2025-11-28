[slurm]: https://slurm.schedmd.com/
[slurmlearning]: http://slurmlearning.deic.dk/
[partitions]: ../../runjobs/partitions.md
[batch-jobs]: ../../runjobs/scheduled-jobs/submission.md

# Slurm quickstart

A HPC cluster is made up of a number of compute nodes, which consist of one or
more processors, memory and in the case of the GPU nodes, GPUs.
The resource manager allocates these computing resources to the user. This is achieved
through the submission of jobs by the user. A job describes the computing
resources required to run application(s) and how to run it. UBELIX uses
[Slurm][slurm] as job scheduler and resource manager.

## Slurm commands overview

In the following, you will learn how to submit your job using the [Slurm
Workload Manager][slurm]. The following quickstart will
introduce you to the basics of interacting with Slurm.
If you would like to play around with Slurm in a
sandboxed environment before submitting real jobs on UBELIX, we highly recommend
that you try the interactive [SlurmLearning tutorial][slurmlearning].

The main commands for using Slurm are summarized in the table below.

| Command   | Description                                                 |
| --------- | ----------------------------------------------------------- |
| `sbatch`  | Submit a batch script                                       |
| `srun`    | Run a parallel job(step)                                    |
| `squeue`  | View information about jobs in the scheduling queue         |
| `scancel` | Signal or cancel jobs, job arrays or job steps              |
| `sinfo`   | View information about nodes and partitions                 |

### Creating a batch script

The most common type of job is a batch job. They are submitted to the
scheduler using a batch job script and the `sbatch` command.

A batch job script is a text file containing information about the job
to be run: Explicitly, the amount of computing resource and the tasks that must be executed.

A batch script is summarized by the following steps:

- the interpreter to use for the execution of the script: bash
- directives that define the job options: resources, run time, ...
- setting up the environment: prepare input, environment variables, ...
- run the application

As an example, let's look at this batch job script:

=== "gratis account"
    ```bash
    #!/bin/bash
    #------------------------
    #SBATCH --account=gratis
    #------------------------
    #SBATCH --job-name="Simple Python example"
    #SBATCH --time=02:00:00
    #SBATCH --ntasks=1
    #SBATCH --cpus-per-task=8
    #SBATCH --mem-per-cpu=1G
    #SBATCH --partition=epyc2
    
    # Your code below this line
    module load Anaconda3
    eval "$(conda shell.bash hook)"
    
    python3 script.py
    ```

=== "paygo account"
    ```bash
    #!/bin/bash
    #------------------------
    #SBATCH --account=paygo
    #SBATCH --wckey=<wckey>
    #------------------------
    #SBATCH --job-name="Simple Python example"
    #SBATCH --time=02:00:00
    #SBATCH --ntasks=1
    #SBATCH --cpus-per-task=8
    #SBATCH --mem-per-cpu=1G
    #SBATCH --partition=epyc2
    
    # Your code below this line
    module load Anaconda3
    eval "$(conda shell.bash hook)"
    
    python3 script.py
    ```

=== "invest account"
    ```bash
    #!/bin/bash
    #------------------------
    #SBATCH --account=invest
    #SBATCH --qos=job_icpu-<investor>
    #------------------------
    #SBATCH --job-name="Simple Python example"
    #SBATCH --time=02:00:00
    #SBATCH --ntasks=1
    #SBATCH --cpus-per-task=8
    #SBATCH --mem-per-cpu=1G
    #SBATCH --partition=epyc2
    
    # Your code below this line
    module load Anaconda3
    eval "$(conda shell.bash hook)"
    
    python3 script.py
    ```
=== "teaching account"
    ```bash
    #!/bin/bash
    #------------------------
    #SBATCH --account=teaching
    #SBATCH --reservation=<reservation>
    #------------------------
    #SBATCH --job-name="Simple Python example"
    #SBATCH --time=02:00:00
    #SBATCH --ntasks=1
    #SBATCH --cpus-per-task=8
    #SBATCH --mem-per-cpu=1G
    #SBATCH --partition=epyc2
    
    # Your code below this line
    module load Anaconda3
    eval "$(conda shell.bash hook)"
    
    python3 script.py
    ```

In the previous example, the first line `#!/bin/bash` specifies that the script
should be interpreted as a bash script.

The lines starting with `#SBATCH` are directives for the workload manager.
These have the general syntax

```bash
#SBATCH option_name=argument
```

Now that we have introduced this syntax, we can go through the directives one
by one. The first directive is

```bash
#SBATCH --account=gratis
```

This sets the Slurm account to be used. The `gratis` account is the default account for all users.
It is free to use and restricted in resources. Every user has access to the gratis account, which never incurs costs.
For details on other accounts please refer to the [Accounts / Partitions / QoS
section](../partitions.md).

Depending on the selected account, there might be additional required
directives. Since someone must have given you access to
an account with extra directives, we assume that person has told you about the
significance of the extra directives. So the next directive we'll cover here is:

```bash
#SBATCH --job-name=exampleJob
```

which sets the name of the job. It can be used to identify a job in the queue
and other listings.

The remaining lines specify the resources needed for the job. The first one is
the **maximum** time your job can run. If your job exceeds the time limit, it
is terminated regardless of whether it has finished or not.

```bash
#SBATCH --time=02:00:00
```

The time format is ``hh:mm:ss`` (or `d-hh:mm:ss` where `d` is the number of
days). Therefore, in our example, the time limit is 2 hours.

The next four lines of the script describe the computing resources that the job
will need to run

```bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=1G
```

In this instance, we request one task (process) to be run on one node. A task
corresponds to a process. 8 CPU cores is requested for the one task as well as 1 GiB of memory should be
allocated to each cpu of the job.

The next line defines the [Slurm partition][partitions] to which the job will
be submitted. Slurm partitions are (possibly overlapping) groups of nodes with
similar resources or associated limits. In our example, the job doesn't use a
any special resources and will fit perfectly onto the `epyc2` partition.

```bash
#SBATCH --partition=epyc2
```

Now that the needed resources for the job have been defined, the next step is
to set up the environment. For example, copy input data from your home
directory to the scratch file system or export environment variables.

```bash
module load Anaconda3
eval "$(conda shell.bash hook)"
```

In our example, we load a Anaconda module so that the `python` application is available
to the batch job. Finally, with everything set up, we can launch our program
using the `python3` command.

```bash
python3 script.py
```

More details may be found on the dedicated [batch jobs][batch-jobs] page.

### Submit a batch job

To submit the job script we just created, we use the `sbatch` command.
The general syntax can be condensed as

```bash
$ sbatch [options] job_script [job_script_arguments ...]
```

The available options are the same as the one you use in the batch script:
`sbatch --time=01:00:00` in the command line and `#SBATCH --time=01:00:00` in a batch
script are equivalent. The command line value takes precedence if the same
option is present both on the command line and as a directive in a script.

For the moment, let's limit ourselves to the most common way to use the
`sbatch`: passing the name of the batch script which contains the submission
options.

```bash
$ sbatch myjob.sh
Submitted batch job 123456
```

The `sbatch` command returns immediately. If the job is successfully
submitted, the command prints out the ID number of the job.

More details may be found on the dedicated [batch jobs][batch-jobs] page.

### Examine the queue

Once you have submitted your batch script, it won't necessarily run immediately.
It may wait in the queue of pending jobs for some time before its required
resources become available. To view your jobs in the queue, use the `squeue` command.

```bash
$ squeue
  JOBID PARTITION     NAME     USER    ST       TIME  NODES NODELIST(REASON)
 123456     epyc2 Simple P ubelix_usr  PD       0:00      1 (Priority)
```

The output shows the state of your job in the `ST` column. In our case, the job
is pending (`PD`). The last column indicates the reason why the job isn't
running: `Priority`. This indicates that your job is queued behind a higher
priority job. One other possible reason can be that your job is waiting for
resources to become available. In such a case, the value in the `REASON` column
will be `Resources`.

Let's look at the information that will be shown if your job is running:

```bash
$ squeue --me
  JOBID PARTITION     NAME     USER    ST       TIME  NODES NODELIST(REASON)
 123456     epyc2 Simple P ubelix_usr  R        0:00      1 bnode001
```

The `ST` column will now display a `R` value (for `RUNNING`). The `TIME` column
will represent the time your job has been running. The list of nodes on which
your job is executing is given in the last column of the output.

### Cancelling a job

Sometimes things just don't go as planned. If your job doesn't run as expected,
you may need to cancel your job. This can be achieved using the `scancel`
command which takes the job ID of the job to cancel.

```bash
$ scancel <jobid>
```

The job ID can be obtained from the output of the `sbatch` command when
submitting your job or by using `squeue`. The `scancel` command applies to
either a pending job waiting in the queue or to an already running job. In the
first case, the job will simply be removed from the queue while in the latter,
the execution will be stopped.
