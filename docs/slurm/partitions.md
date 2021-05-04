# SLURM partition and QOS

## Description
UBELIX provides different CPU and GPU architectures. Furthermore, we provide job different queues for different job priorities and limitations. 

!!! note "restructuring 04.05.2021"
    With the maintainace 04.05.2021 we restructured the Slurm partition to:

    - more effcient resource usage: All users get access to all resources. Investors have priviledeged access
    - general access to GPUs without preempting
    - resource sharing (fair share) based on research groups using Workspaces, instead of institute based sharing 
    - simpler partition design

There are three main control mechanisms to specify queues and resources: 

- [**Partitions**](#partitions) and 
- [Quality of Service (**QoS**)](#qos)
- `--gres` to select the targeted GPU architecture, see [GPUs](gpus.md)

## Partitions
There are the current 3 partitions, epyc2 is default:

| Partition | job type | CPU / GPU | node / GPU memory | local Scratch |
| --------- | -------- | ---------- | ---------------- | ------------- |
|**epyc2** | single and multi-core |AMD Epyc2 2x64 cores | 1TB | 1TB |
| bdw | full nodes only (x*20cores) | Intel Broadwell 2x10 cores | 156GB | 1TB |
| gpu | GPU <br> (8 GPUs per node, <br> varying CPUs) | Nvidia GTX 1080 Ti <br> Nvidia RTX 2080 Ti <br> Nvidia RTX 3090 <br> Nvidia Tesla P100  | 11GB <br> 11GB <br> 12GB <br> 24GB | 800GB <br> 2x960GB <br> 1.92TB <br> 800GB  |

The **current usage** can be listed on the [UBELIX status page](https://www.ubelix.unibe.ch/)

## QoS
Within these partitions, **QoS** are used to distinguish different job limits. In each partition there is a default QoS (**bold** below). Each QoS has specific limits:

| Partition | QoS | time limit | cores/node/GPU limit | max jobs |
| --------- | --- | ---------- | ---------------- | ------- |
| **epyc2** | **job_epyc2** | 4 days | 512 cores | array jobs up to 10000 tasks |
| | job_epyc2_debug | 20 min | 20 cores | 1 |
| | job_epyc2_long | 15 days | 64 cores | 50 |
| | job_epyc2_short | 6h | 10 nodes | 50 | 
| bdw | **job_bdw** | 24 h | 50 nodes | 300 |
| | bdw_debug | 20 min | 2 nodes | 1 |
| | bdw_short | 6 h | 2 nodes | 10 |
| gpu | **job_gpu** | 24 h | 6x GTX 1080 Ti <br> 2x RTX 2080 Ti <br> 1x RTX 3090 <br> 1x Tesla P100 | 10 |
| | job_gpu_debug | 20 min | 1 GPU | 1 |
| | job_gpu_preempt | 24 h | 12x GTX 1080 Ti <br> 4x RTX 2080 Ti <br> 4x RTX 3090 <br> 4x Tesla P100 | 24 |
 
The QoS job_epyc2_short and job_gpu_preempt have access extended resources. In case of job_gpu_preempt, these jobs will be pre-empted if not enough resources for the investors. 

Thus a job can be submitted to the gpu partition using a RTX3090 and allow pre-emption:

```Bash
sbatch --partition=gpu --qos=job_gpu_preempt --gres=gpu:rtx3090 myjob.sh
```

Please see for more details: [GPUs](gpus.md)

## Investor QoS
Investors get elvated priviledges on additional additional resources. These priviledges are managed using *investor QoS* in *investor partitions*. The membership to these is managed on basis of HPC Workspaces, see [Workspace Management](../hpc-workspaces/management.md#investor-qos).