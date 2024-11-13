# Job Dependencies

This pages describes the SLURM depencency feature. This feature is used when you need to chain jobs, due to dependencies. For example: 

- a preprocessing job with 1 core should be followed by a simulation with 40 cores. Results should be post processed with a single core job. 
- a post processing job should be submitted after all tasks of a job array are finished

## Usage
The follow-up job need to specify the dependency using the `sbatch` option `--dependency=<type>:<listOfJobIDs>`. 
The type can be `after`, `afterok`, `afterany`, `afternotok`, `aftercorr`, `expand`, `singleton`. (see `man sbatch` for more info). 

The underlying job (which this job depends on) need to be submitted first. The related job ID can be caught, by collecting the sbatch output with the `--parsable` option, e.g.

```Bash
jid_w01=$(sbatch --parsable job01.sh)
```
## Example

A pipeline should be build with:
- preparation: `job_prep.sh`
- 2 worker jobs (`job01.sh` and `job02.sh`) 
- if successfull: a collector job (`job_coll.sh`)
- otherwise: a handling the error job (`job_handle_err.sh`)
- The following script would submit all 3 job with respect to their dependencies. 

```Bash
jid_pre=$(sbatch --parsable job_prep.sh)
jid_w01=$(sbatch --parsable --dependency=afterok:${jid_pre} job01.sh)
jid_w02=$(sbatch --parsable --dependency=afterok:${jid_pre} job02.sh)
sbatch --dependency=afterok:${jid_w01}:${jid_w02} job_coll.sh
sbatch --dependency=afternotok:${jid_w01}:${jid_w02} job_handle_err.sh
```

## Dependency on array job

When specifying a dependency to an array job only one job ID need to be specified, no matter how many array tasks are included. 

Thus, a 100 task array job and a postprocessing job can be launched using:

```Bash
jid=$(sbatch --parsable --array=1-100 job_arr.sh)
sbatch --dependency=afterok:${jid} job_post.sh
```
Where the postprocessing job only runs if all 100 array task ended without error. 
