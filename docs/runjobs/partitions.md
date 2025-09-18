# SLURM partition and QOS

UBELIX provides different CPU and GPU architectures. These are generally structured in partitions and further tunable by "Quality of Service" (QoS).

## Partitions
We are currently operating the following partitions:

| Partition | job type | CPU / GPU | node / GPU memory | local Scratch |
| --------- | -------- | ---------- | ---------------- | ------------- |
|**epyc2 (default)** | single and multi-core |AMD Epyc2 2x64 cores <br> AMD Epyc4 2x96 cores | 1TB <br> 1.5TB | 1TB |
| bdw | full nodes only (x*20cores) | Intel Broadwell 2x10 cores | 156GB | 1TB |
| gpu | GPU <br> (8 GPUs per node, <br> varying CPUs) | Nvidia RTX 3090 <br> Nvidia RTX 4090 <br> Nvidia A100 <br> Nvidia H100 <br> Nvidia H200 | 24GB <br> 24GB <br> 80GB <br> 96GB <br> 141GB |  1.92TB <br> 1.92TB <br> 1.92TB <br> 1.92TB <br> 1.92TB|
| gpu-invest | GPU | *see gpu partition* |  | |
| icpu-*investor* | single and multi-core | *see epyc2 partition* |  | |

The **current usage** can be listed on the [UBELIX status page](https://www.ubelix.hpc.unibe.ch)

## QoS
Within these partitions, **QoS** are used to distinguish different job limits.
Each QoS has a specific purpose, e.g. to allow quick debug jobs to schedule
faster than regular jobs.

The following QoS are defined on UBELIX:

| QoS             | Time limit | Max Jobs | Partitions | Description |
| --------------- | ---------- | -------- | ---------- | ----------- |
| job_cpu         | 96 hours   | 20000    | epyc2,bdw  | This is the default CPU qos. It's used for all general computing. |
| job_cpu_long    | 16 days    | 50       | epyc2,bdw  | This CPU qos is used for very long jobs. *Note:* Checkpointing is recommended! |
| job_cpu_debug   | 20 min     | 1        | epyc2,bdw  | This CPU qos is used for quick debug jobs (max 10 cores) |
| job_gpu         | 24 hours   |          | gpu        | This is the default GPU qos. It's used for general GPU computing. |
| job_gpu_debug   | 20 min     | 1        | gpu        | This GPU qos is used for quick debug jobs on GPUs (max 1 GPU). |
| job_gpu_preemptable | 24 hours |        | gpu-invest | This GPU qos is used to request idle investor GPU resources. See the note below for details! |
| job_gpu_*investor* |         |          | gpu-invest | These GPU qos are used by investors to request their GPU resources. |
| job_interactive | 8 hours    | 1        | all        | This qos is used for interactive CPU/GPU jobs (i.e, OnDemand). Jobs are assigned higher priority to start quickly. |
| job_icpu-*investor* |        |          | icpu-*investor*  | These CPU qos are used by investors to request their CPU resources. |

Some QoS have more specific resource limits associated to them, e.g. the number
of GPUs that can be requested per user. These limits can be viewed using the
`sqos` command:

```
sqos -h
Usage: ./sqos [partition_name | qos_name]

If a partition name is given, it retrieves all QoS associated with that partition as per slurm.conf.
If a QoS name is given, it displays the details for that specific QoS.
Without arguments, the script shows all QoS for the current user.

Examples:
  sqos                   # Show all QoS for the current user
  sqos partition_name    # Show QoS for the specified partition
  sqos qos_name          # Show details for the specified QoS
```


### Investor QoS
Investors get pseudo-exclusive access to their invested resources. The membership to these investor qos is managed by the investor or their deputy. Membership changes need to be communicated to the HPC team. For details on investing in UBELIX see [Costs and Investments](../costs_investments.md).


### Preemptable QoS

The resources dedicated to investors can be used by non-investing users too.
Idle investor resources can be used by jobs with the QOS `job_gpu_preemptable`. However, these preemptable jobs may be terminated by investor jobs at any time! If the job has been terminated to free resources for the investor, the preemptable job is rescheduled in the queue. This makes the qos `job_gpu_preemptable` especially suitable to jobs that support automatic checkpointing or restarts.
