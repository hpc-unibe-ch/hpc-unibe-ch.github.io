# Deleting Jobs

Sometimes you'll need to delete pending or even running jobs.
Use the `scancel` command to delete active jobs.

## scancel

Syntax

```Bash
scancel [options] <jobid> ...
```

`scancel` can be restricted to a subset of jobs, using the following options with the related value, e.g:

```Bash
--me                jobs of current user
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
scancel --me
```
