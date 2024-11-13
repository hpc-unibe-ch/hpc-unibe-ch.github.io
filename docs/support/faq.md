# FAQ

This page provides a collection of frequently asked questions.

## File system

### What if my HOME is full?
If you reached your quota, you will get strange warning about not being able to write temporary files etc. You can check your quota using the `quota` command. To resolve the situation you can follow these strategies:

1. Decluttering: Check for unnecessary data. This could be:

  - temporary computational data, like already post processed output files
  - duplicated data
  - unused application packages, e.g. Python packages in `$HOME/.local/lib/python*/site-packages/*`

2. Pack and archive: The HPC storage is a high performance parallel storage and not meant to be an archive. Data not used in the short to midterm should be packed and moved to an archive storage. 

In general, we consider data on our HPC systems as research data. Further we consider research data to be shared sooner or later. And we aim to support and enhance collaborations. Therefore, we introduce group shared spaces, called HPC Workspaces.
Ask your research group manager to add you to an existing Workspace or create a new one. 
There will be no quota increase for HOME directories. 

## Workspaces

### I need access to a HPC Workspace. Who do I need to ask?

HPC Workspaces are managed by the group manager/leader. Therewith you need to ask them to add you to the primary or secondary group.

### I need to share data with my colleges. What can I do?
HPC Workspaces are meant to host shared data. See [HPC Workspaces](../storage/index.md).

## Software issues

### Why the system is complaining about not finding an existing module?

There are cases modules could not be found. This could be that the modules is not exiting in the target software stack, it could be hidden, or a version inconsistency.

#### hidden modules
Some modules are provided as hidden modules to keep the presented software stack nice and clean. Hidden modules can be listed using `module --show-hidden avail`.

#### software stack inconstency
It is strongly suggested to not mix different toolchains like foss or intel. Additionally, it is advised to stay with one version of a toolchain, e.g. foss/2023a and its dependency versions, e.g. GCC/12.3.0.

## Environment issues

### I modified my bashrc, but its not doing what I expect, how can I debug that bash script?
The bashrc can be debugged as all other bash scripts, using 

- `set -x` at the beginning of the script. This will print **all** commands executed on screen, including all subcommand also included in called scripts and tools
- print statements, e.g. `echo "DEBUG: variable PATH=$PATH"`

These should provide a good indication where the script diverge from your expectation. 

## Job issues
### Why is my job still pending?

!!! tip
    The REASON column of the `squeue` output gives you a hint why your job is not running.

**(Resources)**
The job is waiting for resources to become available so that the jobs resource request can be fulfilled.

**(Priority)**
The job is not allowed to run because at least one higher prioritized job is waiting for resources.

**(Dependency)**
The job is waiting for another job to finish first (`--dependency=... option`).

**(DependencyNeverSatisfied)**
The job is waiting for a dependency that can never be satisfied. Such a job will remain pending forever. Please cancel such jobs.

**(QOSMaxCpuPerUserLimit)**
The job is not allowed to start because your currently running jobs consume all allowed CPU resources for your user in a specific partition. Wait for jobs to finish.

**(AssocGrpCpuLimit)**
dito.

**(AssocGrpJobsLimit)**
The job is not allowed to start because you have reached the maximum of allowed running jobs for your user in a specific partition. Wait for jobs to finish.

**(ReqNodeNotAvail, UnavailableNodes:...)**  
Some node required by the job is currently not available. The node may currently be in use, reserved for another job, in an advanced reservation, `DOWN`, `DRAINED`, or not responding.**Most probably there is an active reservation for all nodes due to an upcoming maintenance downtime (see output of** `scontrol show reservation`) **and your job is not able to finish before the start of the downtime. Another reason why you should specify the duration of a job (--time) as accurately as possible. Your job will start after the downtime has finished.** You can list all active reservations using `scontrol show reservation`.

### Why can't I submit further jobs?

`sbatch: error: Batch job submission failed: Job violates accounting/QOS policy (job submit limit, user's size and/or time limits)`

... indicates that you have reached the maximum of allowed jobs to be submitted to a specific partition.

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



