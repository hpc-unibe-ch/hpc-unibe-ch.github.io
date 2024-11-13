# Preemption

Slurm supports job preemption, the act of "stopping" jobs to let a *high-priority* job run.
On UBELIX we use the Slurm preemption feature to allow the usage of idle
resources on the investor partitions. This allows us to achieve a higher cluster
utilization and increase the throughput. In our standard configuration the preempted job(s) are requeued and started using other resources.

## Preemptable QoS

Idle investor resources can be used by jobs with the QOS `job_gpu_preemptable`. However, these preemptable jobs may be terminated by investor jobs at any time! The qos `job_gpu_preemptable` is especially suitable to jobs that support automatic checkpointing or restarts.

To submit a preemptable job request the `gpu-invest` partition and the QoS
`job_gpu_preemptable`:

```bash
#!/bin/bash
#SBATCH --job-name="Preemptable Job example"
#SBATCH --time=02:00:00

#SBATCH --partition=gpu-invest
#SBATCH --qos=job_gpu_preemptable

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=1G
#SBATCH --gres=gpu/rtx4090:1

# Your code below this line
```
