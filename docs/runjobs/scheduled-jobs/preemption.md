# Preemption

Slurm supports job preemption, the act of "stopping" jobs to let a *high-priority* job run.
On UBELIX we use the Slurm preemption feature to allow the usage of idle
resources on our partitions for free. This allows us to achieve a higher cluster
utilization and increase the throughput. In our standard configuration the preempted job(s) are requeued and started using other resources.

## Preemptable QoS

The resources dedicated to investors as well as the resources in the epyc2
partition can be used for free in the gratis account when resources are idle.
These idle resources can be used by jobs with the QOS `job_cpu_preemptable` and `job_gpu_preemptable` for CPU and GPU jobs respectively. In order to use `job_cpu_preemptable` and `job_gpu_preemptable` efficiently, jobs should support automatic checkpointing or restarts.

**Important**: *preemptable* jobs may be terminated by paygo or investor jobs at any time! 

If the job has been terminated to free resources for the paygo or investor jobs, the *preemptable* job is rescheduled in the queue.

### job_gpu_preemptable
To submit a preemptable GPU job request the `gpu-invest` partition and the QoS
`job_gpu_preemptable`:

```bash
#!/bin/bash
#------------------------
#SBATCH --account=gratis
#------------------------
#SBATCH --partition=gpu-invest
#SBATCH --qos=job_gpu_preemptable

#SBATCH --job-name="Preemptable Job example"
#SBATCH --time=02:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=1G
#SBATCH --gres=gpu/rtx4090:1

# Your code below this line
```

### job_cpu_preemptable

To submit a preemptable CPU job request the `cpu-invest` partition and the QoS
`job_cpu_preemptable`:

```bash
#!/bin/bash
#------------------------
#SBATCH --account=gratis
#------------------------
#SBATCH --partition=cpu-invest
#SBATCH --qos=job_cpu_preemptable

#SBATCH --job-name="Preemptable Job example"
#SBATCH --time=02:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=1G

# Your code below this line
```

By default, jobs that are preempted are resubmitted automatically.
If this is undesirable for you, use the following option to enable that the job, if preempted,
won't be re-queued but canceled instead: `#SBATCH --no-requeue`
