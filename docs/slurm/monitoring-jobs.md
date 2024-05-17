# Monitoring Jobs

This page provides information about monitoring user jobs.

Different Slurm commands provide information about jobs/job steps on different levels. The command `squeue` provides high-level information about jobs in the Slurm scheduling queue (state information, allocated resources, runtime, ...). The command `sstat` provides detailed usage information about running jobs, and `sacct` provides accounting information about active and completed (past) jobs. The command `scontrol` provides even more detailed information about jobs and job steps.

!!! tip "Configuration"
    The output format of most commands is highly configurable to your needs. Look for the _--format_ or _--Format_ options.

## squeue

!!! tip note "Monitoring your jobs"
    Use the `squeue --me` command to get a high-level overview of all your active (running and pending) jobs in the cluster.


Syntax

```Bash
 squeue [options]
```

 Common options

```Bash
--user=<user[,user[,...]]>          Request jobs from a comma separated list of users. 
--jobs=<job_id[,job_id[,...]]>      Request specific jobs to be displayed
--partition=<part[,part[,...]]>     Request jobs to be displayed from a comma separated list of partitions
--states=<state[,state[,...]]>      Display jobs in specific states. Comma separated list or "all". Default: "PD,R,CG"
```

The default output format is as follows:

```Bash
JOBID PARTITION NAME USER ST TIME NODES NODELIST(REASON)
```

where

```Bash
JOBID              Job or step ID. For array jobs, the job ID format will be of the form <job_id>_<index>
PARTITION          Partition of the job/step
NAME               Name of the job/step
USER               Owner of the job/step
ST                 State of the job/step. See below for a description of the most common states
TIME               Time used by the job/step. Format is days-hours:minutes:seconds
                   (days,hours only printed as needed)
NODES              Number of nodes allocated to the job or the minimum amount of nodes required
                   by a pending job
NODELIST(REASON)   For pending jobs: Reason why pending. For failed jobs: Reason why failed.
                   For all other job states: List of allocated nodes. See below for a list of the most
                   common reason codes
```

See the man page for more information: `man squeue`

### Job States

During its lifetime, a job passes through several states:

```Bash
PD                 Pending. Job is waiting for resource allocation
R                  Running. Job has an allocation and is running
S                  Suspended. Execution has been suspended and resources have been released for other jobs
CA                 Cancelled. Job was explicitly cancelled by the user or the system administrator
CG                 Completing. Job is in the process of completing. Some processes on some nodes may still be active
CD                 Completed. Job has terminated all processes on all nodes with an exit code of zero
F                  Failed. Job has terminated with non-zero exit code or other failure condition
```

### Why is my job still pending?

!!! tip "Finding a REASON"
    The REASON column of the `squeue --me` output gives you a hint why your job is not running.

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

Some node required by the job is currently not available. The node may currently be in use, reserved for another job, in an advanced reservation, DOWN, DRAINED, or not responding. **Most probably there is an active reservation for all nodes due to an upcoming maintenance downtime and your job is not able to finish before the start of the downtime. Another reason why you should specify the duration of a job (--time) as accurately as possible. Your job will start after the downtime has finished.** You can list all active reservations using `scontrol show reservation`.

### Why can't I submit further jobs?


    _sbatch: error: Batch job submission failed: Job violates accounting/QOS policy (job submit limit, user's size and/or time limits)

... indicates that you have reached the maximum of allowed jobs to be submitted to a specific partition.

### Examples

List all currently running jobs of user foo:

```Bash
squeue --user=foo --states=PD,R
```

List all currently running jobs of user _foo_ in partition _bar_:

```Bash
squeue --user=foo --partition=bar --states=R
```

## scontrol

Use the `scontrol` command to show more detailed information about a job

Syntax

```Bash
 scontrol [options] [command]
```

### Examples

Show detailed information about job with ID 500:

```Bash
scontrol show jobid 500
```

Show even more detailed information about job with ID 500 (including the jobscript):

```Bash
scontrol -dd show jobid 500
```

## sacct

Use the `sacct` command to query information about past jobs

Syntax

```Bash
 sacct [options]
```

Common options

```Bash
--endtime=end_time            Select jobs in any state before the specified time.
--starttime=start_time        Select jobs in any state after the specified time.
--state=state[,state[,...]]   Select jobs based on their state during the time period given.
                              By default, the start and end time will be the current time
                              when the --state option is specified, and hence only currently
                              running jobs will be displayed.
```

