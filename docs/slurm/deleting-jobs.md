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

`scancel` can be restricted to a subset of jobs, using the following options with the related value, e.g:

```Bash
-u, --user $USER    jobs of current user
-A, --account 		jobs under this charge account
-n, --jobname		jobs with this job name
-p, --partition		jobs in this partition
-t, --state			jobs in this state
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

Delete all of your jobs:

```Bash
scancel --user $USER
```
