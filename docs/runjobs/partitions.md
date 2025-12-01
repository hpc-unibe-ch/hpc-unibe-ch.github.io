# Accounts, Partitions and QoS

UBELIX provides computing resources at different levels, organized in accounts. Additionally different CPU and GPU architectures are structured in partitions. The combination of accounts and partitions is further controlled by "Quality of Service" (QoS).

## Accounts

There are four types of accounts, each with different resource access and cost implications:

- **gratis Account**
  The default account for all users. It is free to use and restricted in resources. Every user has access to the gratis account, which never incurs costs.

      ```bash
      #SBATCH --account=gratis
      ```

- **paygo Account**
  The "pay as you go" account is available to users who are members of cost-enabled research projects. When submitting jobs with this account, users must specify a valid project identifier ("wckey") for accounting. Costs are generated at job submission based on actual resource usage.
  
  **Note:** You may use the `swckeys`-tool to see a list of all available wckeys

      ```bash
      #SBATCH --account=paygo
      #SBATCH --wckey=<PROJECT>
      ```

- **invest Account**
  The investor account distinguishes between free resources (gratis) and resources funded by investment. This account is available to users associated with a UBELIX investment. Jobs submitted under this account do not generate costs at submission; all costs are prepaid through the investment.

      ```bash
      #SBATCH --account=invest
      ```

- **teaching Account**
	This account is used for reservations that are created for teaching. When submitting jobs with this accounts, users must specify a valid reservation for scheduling. No costs are generated when using the teaching account.

      ```bash
      #SBATCH --account=teaching
      #SBATCH --reservation=<RESERVATION>
      ```

## Partitions
We are currently operating the following partitions:

| Partition | job type | CPU / GPU | node / GPU memory | local Scratch |
| --------- | -------- | ---------- | ---------------- | ------------- |
|**epyc2 (default)** | single and multi-core |AMD Epyc2 2x64 cores <br> AMD Epyc4 2x96 cores | 1TB <br> 1.5TB | 1TB |
| bdw | full nodes only (x*20cores) | Intel Broadwell 2x10 cores | 156GB | 1TB |
| gpu | GPU <br> (8 GPUs per node, <br> varying CPUs) | Nvidia RTX 3090 <br> Nvidia RTX 4090 <br> Nvidia A100 <br> Nvidia H100 <br> Nvidia H200 | 24GB <br> 24GB <br> 80GB <br> 96GB <br> 141GB |  1.92TB <br> 1.92TB <br> 1.92TB <br> 1.92TB <br> 1.92TB|
| gpu-invest | GPU | *see gpu partition* |  | |
| cpu-invest | single and multi-core | *see epyc2 partition* |  | |
| teaching | CPU & GPU | *see epyc2 and gpu partitions* |  | |

The **current usage** can be listed on the [UBELIX status page](https://www.ubelix.hpc.unibe.ch)

## QoS
Within these partitions, **QoS** are used for access control and to distinguish different job limits.
Each QoS has a specific purpose, e.g. to allow quick debug jobs to schedule faster than regular jobs.
Depending on the account, the following QoS are defined on UBELIX:

### gratis
| **QOS**             | **Account** | **Partition**  | **Time limit** | **Description**|
| ------------------- | ----------- | ---------------| -------------- | --------------------------------------------------------|
| job_gratis          | gratis      | bdw,epyc2,gpu  | 96 hours       | This is the default qos on the gratis account. It is avialable for CPU and GPU jobs.
| job_debug           | gratis      | bdw,epyc2,gpu  | 20 min         | This CPU/GPU qos is used for quick debug jobs. |
| job_gpu_preemptable | gratis      | gpu-invest     | 24 hours       | This GPU qos is used to request idle investor GPU resources for free. See the note below for details! |
| job_cpu_preemptable | gratis      | cpu-invest     | 24 hours       | This CPU qos is used to request idle investor GPU resources for free. See the note below for details! |

### paygo
| **QOS**             | **Account** | **Partition**  | **Time limit** | **Description**|
| ------------------- | ----------- | ---------------| -------------- | --------------------------------------------------------|
| job_cpu             | paygo       | bdw,epyc2      | 96 hours       |This is the default CPU qos. It's used for all general computing. |
| job_cpu_long        | paygo       | bdw,epyc2      | 16 days        |This CPU qos is used for very long jobs. *Note:* Checkpointing is recommended! |
| job_gpu             | paygo       | gpu            | 24 hours       |This is the default GPU qos. It's used for general GPU computing. |
| job_interactive     | paygo       | bdw,epyc2,gpu  | 8 hours        |This qos is used for interactive CPU/GPU jobs (i.e, OnDemand). Jobs are assigned higher priority to start quickly. |

### invest
| **QOS**             | **Account** | **Partition**  | **Time limit** | **Description**|
| ------------------- | ----------- | ---------------| -------------- | --------------------------------------------------------|
| job_icpu-*investor* | invest      | cpu-invest     |                | These CPU qos are used by investors to request their CPU resources. |
| job_gpu_*investor*  | invest      | gpu-invest     |                | These GPU qos are used by investors to request their GPU resources. |

### teaching
| **QOS**             | **Account** | **Partition**  | **Time limit** | **Description**|
| ------------------- | ----------- | ---------------| -------------- | --------------------------------------------------------|
| job_teaching        | teaching    | teaching       | 8 hours        | This qos is used during reserved teaching sessions on UBELIX

### sqos
Most QoS have more specific resource limits associated to them, e.g. the number
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

### Preemptable QoS

The resources dedicated to investors as well as the resources in the epyc2
partition can be used for free in the gratis account when resources are idle.
These idle resources can be used by jobs with the QOS `job_cpu_preemptable` and `job_gpu_preemptable` for CPU and GPU jobs respectively. However, *preemptable* jobs may be terminated by paygo or investor jobs at any time! If the job has been terminated to free resources for the paygo or investor jobs, the *preemptable* job is rescheduled in the queue. In order to use `job_cpu_preemptable` and `job_gpu_preemptable` efficiently, jobs should support automatic checkpointing or restarts.
By default, jobs that are preempted are resubmitted automatically. If this is undesirable for you, use the following option to enable that the job, if preempted,
won't be re-queued but canceled instead: `#SBATCH --no-requeue`
