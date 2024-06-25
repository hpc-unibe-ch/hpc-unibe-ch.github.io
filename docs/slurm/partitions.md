# SLURM partition and QOS

UBELIX provides different CPU and GPU architectures. These are generally structured in partitions and further tunable by "Quality of Service" (QoS).

## Partitions
There are the currently 3 partitions:

| Partition | job type | CPU / GPU | node / GPU memory | local Scratch |
| --------- | -------- | ---------- | ---------------- | ------------- |
|**epyc2 (default)** | single and multi-core |AMD Epyc2 2x64 cores | 1TB | 1TB |
| bdw | full nodes only (x*20cores) | Intel Broadwell 2x10 cores | 156GB | 1TB |
| gpu | GPU <br> (8 GPUs per node, <br> varying CPUs) | Nvidia GTX 1080 Ti <br> Nvidia RTX 3090 <br> Nvidia Tesla P100 <br> Nvidia A100 | 11GB <br> 24GB <br> 12GB <br> 80GB | 800GB <br> 1.92TB <br> 800GB <br> 1.92TB |

The **current usage** can be listed on the [UBELIX status page](https://www.ubelix.hpc.unibe.ch)

## QoS
Within these partitions, **QoS** are used to distinguish different job limits.
In each partition there is a default QoS. Each QoS has specific
limits that can be viewed directly on the cluster:

```bash
sacctmgr show qos format=name%20,maxwall,maxsubmitpu,maxtrespu%80
```

|       | Description |
| ----- | ----------- |
| Name | Name of the QOS. |
| MaxWall | Maximum wall clock time each job is able to use. MaxWall format is `<min>` or `<hr>:<min>:<sec>` or `<days>-<hr>:<min>:<sec>`. |
| MaxSubmitPU | Maximum number of jobs pending or running state at any time per user.
| MaxTRESPU | Maximum number of TRES (i.e cpu, mem, nodes, GPUs, etc) each user is able to use. You can see the list of available resources by running `sacctmgr show tres`. |

Note, that you might not have access to all of the QoS shown in the output. To
see for which QoS your account has valid associations you can use:

```bash
sacctmgr show assoc where user=$USER format=account,partition,qos%80
```

### Investor QoS
Investors get pseudo-exclusive access to certain resources. The membership to these investor qos is managed by the investor or their deputy. Membership changes need to be communicated to the HPC team.

As an example, the members of an GPU investor, submit jobs with:
```Bash
module load Workspace         # use the Workspace account
sbatch --partition=gpu-invest job.sh
```

!!! note "Preemptable"
    The resources dedicated to investors can be used by non-investing users too.
    A certain amount of CPUs/GPUs are "reserved" in the investor partitions. But if not used, jobs with the QOS `job_gpu_preemptable` can run on these resources. But beware that preemptable jobs may be terminated by investor jobs at any time! Therefore use the qos `job_gpu_preemptable` only if your job supports checkpointing or restarts.
