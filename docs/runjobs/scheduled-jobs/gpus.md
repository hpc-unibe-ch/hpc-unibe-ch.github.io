# GPUs

This page contains all information you need to successfully submit GPU-jobs on
UBELIX. When submitting to the GPU partition the GPU type specification is **required**.

Applications do only run on GPUs if they are built specifically to run on GPUs
that means with GPU support, e.g. CUDA. Please ensure that your application
supports GPUs before submitting to the GPU partitions.


## GPU Types

UBELIX currently features various types of GPUs. You have to choose an
architecture and use one of the following `--gres` option to select it.

| Type | SLURM gres option |
| ---- | ----------------- |
| Nvidia Geforce RTX 3090 | `--gres=gpu:rtx3090:<number_of_gpus>` |
| Nvidia Geforce RTX 4090 | `--gres=gpu:rtx4090:<number_of_gpus>` |
| Nvidia A100 | `--gres=gpu:a100:<number_of_gpus>` |
| Nvidia H100 | `--gres=gpu:h100:<number_of_gpus>` |
| Nvidia H200 | `--gres=gpu:h200:<number_of_gpus>` |

Alternatively, you may use the `--gpus`, `--gpus-per-node` and
`--gpus-per-tasks` otions. Note that the GPU type still needs to be specified
as shown above.

For details on the memory available on the different types of GPU, please see
our [GPU Hardware page](../../hardware/gpu.md).

## Job Submission

GPU jobs must be submitted to the `gpu` or `gpu-invest` partitions.

=== "gratis account"
    ```Bash
    #!/bin/bash
    #------------------------
    #SBATCH --account=gratis
    #------------------------
    #SBATCH --partition=gpu
    #SBATCH --gres=gpu:<type>:<number_of_gpus>
    ```
=== "paygo account"
    ```Bash
    #!/bin/bash
    #------------------------
    #SBATCH --account=paygo
    #SBATCH --wckey=<wckey>
    #------------------------
    #SBATCH --partition=gpu
    #SBATCH --gres=gpu:<type>:<number_of_gpus>
    ```
=== "invest account"
    ```Bash
    #!/bin/bash
    #------------------------
    #SBATCH --account=invest
    #SBATCH --qos=<investor_qos>
    #------------------------
    #SBATCH --partition=gpu-invest
    #SBATCH --gres=gpu:<type>:<number_of_gpus>
    ```
=== "teaching account"
    ```Bash
    #!/bin/bash
    #------------------------
    #SBATCH --account=teaching
    #SBATCH --reservation=<reservation>
    #------------------------
    #SBATCH --partition=teaching
    #SBATCH --gres=gpu:<type>:<number_of_gpus>
    ```

### Requesting CPU and memory resources with GPUs

To ensure fair GPU allocations a restriction on the CPU and memory resources that can be requested per GPU is implemented.

In the past, we observed that GPU resources were often left unused because some jobs requested disproportionately large amounts of CPU or memory per GPU. To address this issue, we have implemented a restriction on the CPU and memory resources that can be requested per GPU:

| Type | CPUs per GPU | Memory per GPU |
| ---- | -------------| -------------- |
| Nvidia RTX 3090 | 4 | 60GB |
| Nvidia RTX 4090 | 16 | 90GB |
| Nvidia A100 | 20 | 80GB |
| Nvidia H100 | 16 | 90GB |
| Nvidia H200 | 16 | 90GB |

If you submit a GPU job that requests more resources than are available per GPU, your job will be rejected. If your job requires more CPU and memory resources, you may choose to allocate additional GPUs even if these additional GPUs remain unused by your application.

## CUDA

We provide compiler and library to build CUDA-based application. These are
accessible using environment modules. Use `module spider CUDA` to see which versions
are available:

```Bash
module spider CUDA
------------------------------------------------------------------------------------------------------------------------------------
  CUDA:
------------------------------------------------------------------------------------------------------------------------------------
    Description:
      CUDA (formerly Compute Unified Device Architecture) is a parallel computing platform and programming model created by NVIDIA
      and implemented by the graphics processing units (GPUs) that they produce. CUDA gives developers access to the virtual
      instruction set and memory of the parallel computational elements in CUDA GPUs.

     Versions:
        CUDA/11.8.0
        CUDA/12.1.1
        CUDA/12.2.0
```

Run `module load <module>` to load a specific version of CUDA:

```Bash
module load CUDA/12.2.0
```

!!! tip "cuDNN"
    If you need cuDNN you must **only** load the cuDNN module. The appropriate
    CUDA version is then loaded automatically as a dependency.

## GPU Usage Monitoring

To verify the **usage** of one or multiple GPUs the `nvidia-smi` tool can be
utilized. The tool needs to be launched on the related node. After the job
started running, a new job step can be created using `srun` and call
`nvidia-smi` to display the resource utilization. Here we attach the process to
an job with the jobID `123456`. You need to replace the jobId with your gathered
jobID previously presented in the sbatch output.

```Bash
$ sbatch job.sh
Submitted batch job 123456
$ squeue --me
# verify that job gets started
$ srun --overlap --jobid 123456 nvidia-smi
Fri Nov 11 11:11:11 2021
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 495.29.05    Driver Version: 495.29.05    CUDA Version: 11.5     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  NVIDIA GeForce ...  On   | 00000000:04:00.0 Off |                  N/A |
| 23%   25C    P8     8W / 250W |      1MiB / 11178MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
|   1  NVIDIA GeForce ...  On   | 00000000:08:00.0 Off |                  N/A |
| 23%   24C    P8     8W / 250W |      1MiB / 11178MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
```

Therewith the GPU core utilization and memory usage can be displayed for all GPU
cards belonging to that job.

Note that this is a one-off presentation of the usage and the called
`nvidia-smi` command runs within your allocation. The required resources for
this job step should be minimal and should not noticeably influence your job
performance.

## Further Information

CUDA: [https://developer.nvidia.com/cuda-zone](https://developer.nvidia.com/cuda-zone)  
CUDA C/C++ Basics: [http://www.nvidia.com/docs/IO/116711/sc11-cuda-c-basics.pdf](http://www.nvidia.com/docs/IO/116711/sc11-cuda-c-basics.pdf)  
