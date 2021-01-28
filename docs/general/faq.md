# FAQ

## Description

This page provides a collection of frequently asked questions.

## File System Restructure
### Is my HOME already migrated?
You can check using the command `pwd`. 
The location in the new file system is: `/storage/homefs/$USER`, where `$USER` is your user name. 

## Where can I get a Workspace?
You can join an existing Workspace by asking the Workspace managers. These will be your research group manager (and a deputy). New Workspaces can only be created by a research group manager, see (Application)[../hpc-workspaces/management.md#application]

## How much will a Workspace cost?
Workspaces are free of charge. Every research group has 10TB disk space free of charge, which can be used in multiple Workspaces. 
If necessary, additional storage can be purchased per Workspace, where only the acctual usage will be charged. 

## What if my HOME is full?
We consider research data to be shared sooner or later. And we aim to support and enhance collaboration and therewith group shared spaces. 
Ask your research group manager to add you to an existing Workspace or create a new one. 
There will be no quota increase for HOME directories. 

## What if our 10TB free of charge research group quota is full?
Your Research group manager or a registered deputy can apply for an additional quota. Only actual used quota will be charged. 

## Where should I put my data?
We distinguish the folloing types of data:

| data type | suggested target |
| :--- | :--- |
| private configurational data, e.g. SSH keys | HOME |
| temporary (weeks to month) application input/output data | SCRATCH |
| persistant application input/results, meant to be shared (somewhen) | Workspace |
| applications, meant to be shared (somewhen) | Workspace |



## SLURM
### Why is my job still pending?

!!! types note ""
    The REASON column of the _squeue_ output gives you a hint why your job is not running.

**(Resources)**  
The job is waiting for resources to become available so that the jobs resource request can be fulfilled.

**(Priority)**  
The job is not allowed to run because at least one higher prioritized job is waiting for resources.

**(Dependency)**  
The job is waiting for another job to finish first (--dependency=... option).

**(DependencyNeverSatisfied)**  
The job is waiting for a dependency that can never be satisfied. Such a job will remain pending forever. Please cancel such jobs.

**(QOSMaxCpuPerUserLimit)**  
The job is not allowed to start because your currently running jobs consume all allowed CPU resources for your user in a specific partition. Wait for jobs to finish.

**(AssocGrpCpuLimit)**  
dito.

**(AssocGrpJobsLimit)**  
The job is not allowed to start because you have reached the maximum of allowed running jobs for your user in a specific partition. Wait for jobs to finish.

**(ReqNodeNotAvail, UnavailableNodes:...)**  
Some node required by the job is currently not available. The node may currently be in use, reserved for another job, in an advanced reservation, DOWN, DRAINED, or not responding.**Most probably there is an active reservation for all nodes due to an upcoming maintenance downtime (see output of** scontrol show reservation) **and your job is not able to finish before the start of the downtime. Another reason why you should specify the duration of a job (--time) as accurately as possible. Your job will start after the downtime has finished.** You can list all active reservations using _scontrol show reservation_.


### Why can't I submit further jobs?

!!! types note ""
    _sbatch: error: Batch job submission failed: Job violates accounting/QOS policy (job submit limit, user's size and/or time limits)_


... means that you have reached the maximum of allowed jobs to be submitted to a specific partition.

### Job in state FAILED although job completed successfully

Slurm captures the return value of the batch script/last command and reports this value as the completion status of the job/job step. Slurm indicates status FAILED if the value captured is non-zero.

The following simplified example illustrates the issue:

**simple.c**

```Bash
#include <unistd.h>
#include <stdio.h>
int main (int argc, char *argv[]) {
  char hostname[128];
  gethostname(hostname, sizeof(hostname));
  printf("%s says: Hello World.\n", hostname);
}
```

**job.sh**

```Bash
#!/bin/bash
# Slurm options
#SBATCH --mail-user=foo@bar.unibe.ch
#SBATCH --mail-type=END
#SBATCH --job-name="Simple Hello World"
#SBATCH --time=00:05:00
#SBATCH --nodes=1
# Put your code below this line
./simple
```

```Bash
bash$ sbatch job.sh
Submitted batch job 104
```

Although the job finished successfully...

**slurm-104.out**

```Bash
knlnode02.ubelix.unibe.ch says: Hello World.
```

...Slurm reports job FAILED:

```Bash
bash$ sacct -j 104
       JobID    JobName  Partition    Account  AllocCPUS      State ExitCode
------------ ---------- ---------- ---------- ---------- ---------- --------
104          Simple He+        all                     1     FAILED     45:0
104.batch         batch                                1     FAILED     45:0
```


Problem: The exit code of the job is the exit status of batch script (job.sh) which in turn returns the exit status of the last command executed (simple) which in turn returns the return value of the last statement (printf()). Since printf() returns the number of characters printed (45), the exit code of the batch script is non-zero and consequently Slurm reports job FAILED although the job produces the desired output.

Solution: Explicitly return a value:

```Bash
#include <unistd.h>
#include <stdio.h>
int main (int argc, char *argv[]) {
  char hostname[128];
  int n;
  gethostname(hostname, sizeof(hostname));
  // If successful, the total number of characters written is returned. On failure, a negative number is returned.
  n = printf("%s says: Hello World.\n", hostname);
  if (n < 0)
    return 1;
  return 0;
}
```

```Bash
bash$ sacct -j 105
       JobID    JobName  Partition    Account  AllocCPUS      State ExitCode
------------ ---------- ---------- ---------- ---------- ---------- --------
105          Simple He+        all                     1  COMPLETED      0:0
105.batch         batch                                1  COMPLETED      0:0
```



