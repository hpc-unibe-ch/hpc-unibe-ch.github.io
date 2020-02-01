# Investigating a Job Failure

## Description

This page provides some useful information on investigating a job failure.

!!! types caution ""
    It is important to collect error/output messages either by writing such information to the default location or by specifying specific locations using the --error/–output option. Do not redirect the error/output stream to /dev/null unless you know what you are doing. Error and output messages are the starting point for investigating a job failure.

A job may fail due to a hardware failure on a node involved in the computation, a failure of a Slurm daemon, exceeding a resource limit, or a software specific error. The most common causes are exceeding resource limits and software-specific errors which we will discuss here.

## Exceeding Resource Limits

Each partition limits the maximal allowed runtime of a job and provides default values for the estimated job runtime and memory usage per core. A job should request appropriate values for those resources using the --time and --mem-per-core options. A job is killed if one of these limits is exceeded. In both cases, the error file provides appropriate information:

Time limit:

```Bash
(...)
slurmstepd: error: *** JOB 41239 ON fnode01 CANCELLED AT 2016-11-30T11:22:57 DUE TO TIME LIMIT ***
(...)
``````

Memory limit:

```Bash
(...)
slurmstepd: error: Job 41176 exceeded memory limit (3940736 > 2068480), being killed
slurmstepd: error: Exceeded job memory limit
slurmstepd: error: *** JOB 41176 ON fnode01 CANCELLED AT 2016-11-30T10:21:37 ***
(...)
```

## Software Errors

The exit code of a job is captured by Slurm and saved as part of the job record. For sbatch jobs the exit code of the batch script is captured. For srun, the exit code will be the return value of the executed command. Any non-zero exit code is considered a job failure, and results in job state of FAILED. When a signal was responsible for a job/step termination, the signal number will also be captured, and displayed after the exit code (separated by a colon).

Depending on the execution order of the commands in the batch script, it is possible that a specific command fails but the batch script will return zero indicating success. Consider the following simplified example:


**fail.R**
```Bash
var<-sq(1,1000000000)
```

**job.sbatch**
```Bash
#!/bin/bash
# Slurm options
#SBATCH --mail-user=nico.faerber@id.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --job-name="Simple Example"
#SBATCH --time=00:05:00
#SBATCH --mem-per-cpu=2G

# Put your code below this line
R CMD BATCH --vanilla fail.R
echo "Script finished"
```

The exit code and state wrongly indicates that the job finished successfully:

```Bash
$ sbatch job_slurm.sh
Submitted batch job 41585
 
$ sacct -j 41585
       JobID    JobName  Partition    Account  AllocCPUS      State ExitCode
------------ ---------- ---------- ---------- ---------- ---------- --------
41585        Simple E +        all         id          1  COMPLETED      0:0
41585.batch       batch                    id          1  COMPLETED      0:0
```

Only the R-specific output file shows the error:

**fail.Rout**
```Bash
(...)
> var<-sq(1,1000000000)
Error: could not find function "sq"
Execution halted
```

You can bypass this problem by exiting with a proper exit code as soon as the command failed:

**jobsbatch**

```Bash
#!/bin/bash
# Slurm options
#SBATCH --mail-user=nico.faerber@id.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --job-name="Simple Example"
#SBATCH --time=00:05:00
#SBATCH --mem-per-cpu=2G

# Put your code below this line
R CMD BATCH --vanilla fail.R || exit 91
echo "Script finished"
```

Now, the exit code and state matches the true outcome:

```Bash
$ sbatch job_slurm.sh
Submitted batch job 41925

$ sacct -j 41925
       JobID    JobName  Partition    Account  AllocCPUS      State ExitCode
------------ ---------- ---------- ---------- ---------- ---------- --------
41925        Simple E +        all         id          1     FAILED     91:0
41925.batch       batch                    id          1     FAILED     91:0
```

!!! types note ""
    Always check application-specifc output files for error messages.


