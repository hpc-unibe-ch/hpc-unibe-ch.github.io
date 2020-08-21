# Deleting Jobs

## Description

This page provides information on how to delete jobs.

## scancel

!!! types note ""
    Use the scancel command to delete active jobs

Syntax

```Bash
scancel [options] <jobid> ...
```

Common options

```Bash
--account		Restrict the scancel operation to jobs under this charge account
--jobname		Restrict the scancel operation to jobs with this job name
--partition		Restrict the scancel operation to jobs in this partition
--state			Restrict the scancel operation to jobs in this state
```

### Examples

Delete specific job:

```Bash
scancel 12345678
```

Delete all running jobs:

```Bash
scancel --state=R
```

