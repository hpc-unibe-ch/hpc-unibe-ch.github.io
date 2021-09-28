# Investigating a Job Failure

## Description

Not always jobs execute successfully. There are a list of reasons jobs or applications stop or crash. 
The most common causes are:

- exceeding resource limits and 
- software-specific errors 

Here, discussed are ways to gather information, aspects of avoiding misleading information and aspects of common issues. 

!!! types caution ""
    It is important to collect error/output messages either by writing such information to the default location or by specifying specific locations using the `--error`/`--output` option. Do not redirect the error/output stream to /dev/null unless you know what you are doing. Error and output messages are the starting point for investigating a job failure.


## Exceeding Resource Limits

Each partition defines maximum and default limits for runtime and memory usage. 
Within the job specification the current limits can be defined within the ranges. 
For better scheduling, the job requirements should be estimated and the limits should be adapted to the needs. The lower the limits the better SLURM can find a spot. 
Furthermore, the less resource overhead is specified the less resources are wasted, e.g. for memory. 

If a job exceeds the runtime or memory limit, it will get killed by SLURM. 

## Error Information

In both cases, the error file provides appropriate information:

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
#SBATCH --mail-user=mustermann@unibe.ch
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


