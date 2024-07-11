# GPUs

This page contains all information you need to successfully submit GPU-jobs on
UBELIX.

!!! danger "Important Information on GPU Usage"

    Code that runs on the CPU will **not** auto-magically make
    use of GPUs by simply submitting a job to the GPU partition! You have to
    explicitly ensure that your code is able to run on the GPUs, e.g. an CUDA or OpenACC
    implementation is used.

When submitting to the GPU partition the GPU type specification is **required**.

## GPU Types

UBELIX currently features four types of GPUs. You have to choose an
architecture and use one of the following `--gres` option to select it.

| Type | SLURM gres option |
| ---- | ----------------- |
| Nvidia Geforce GTX 1080 Ti | `--gres=gpu:gtx1080ti:<number_of_gpus>` |
| Nvidia Geforce RTX 3090 | `--gres=gpu:rtx3090:<number_of_gpus>` |
| Nvidia Geforce RTX 4090 | `--gres=gpu:rtx4090:<number_of_gpus>` |
| Nvidia Tesla P100 | `--gres=gpu:teslap100:<number_of_gpus>` |
| Nvidia A100 | `--gres=gpu:a100:<number_of_gpus>` |


## Job Submission

Use the following options to submit a job to the `gpu` partition using the
default job QoS:

```Bash
#SBATCH --partition=gpu
#SBATCH --gres=gpu:<type>:<number_of_gpus>
```


## QoS `job_gpu_preemptable`

For investors we provide the `gpu-invest` investor partitions with a specific
QoS per investor that guarantees instant access to the purchased resources.
Nevertheless, to efficiently use all resources, the QoS `job_gpu_preemptable` exists
in the `gpu` partition. Jobs, submitted with this QoS have access to all GPU
resources, but  may be interrupted if resources are required for investor jobs.
Short jobs, and jobs that make use of checkpointing will benefit from these
additional resources.

Example: Requesting any four RTX3090 from the resource pool in the `gpu`
partition:
```Bash
#SBATCH --partition=gpu
#SBATCH --qos=job_gpu_preemptable
#SBATCH --gres=gpu:rtx3090:4
## Use the following option to ensure that the job, if preempted,
## won't be re-queued but canceled instead:
#SBATCH --no-requeue
```

## Application Adaptation

Applications do only run on GPUs if they are built specifically to run on GPUs
that means with GPU support. There are multiple ways to implement algorithms for
GPU usage. The most common ones are low level languages like CUDA or pragma
oriented implementations like OpenACC.

### CUDA

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
$ srun --ntasks-per-node=1 --jobid 123456 nvidia-smi
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
Nvidia Geforce GTX 1080 Ti: [https://www.nvidia.com/en-us/geforce/products/10series/geforce-gtx-1080-ti](https://www.nvidia.com/en-us/geforce/products/10series/geforce-gtx-1080-ti/)  
Nvidia Geforce RTX 3090: [https://www.nvidia.com/de-de/geforce/graphics-cards/30-series/rtx-3090/](https://www.nvidia.com/de-de/geforce/graphics-cards/30-series/rtx-3090/)  
Nvidia Geforce RTX 4090: [https://www.nvidia.com/de-de/geforce/graphics-cards/40-series/rtx-4090/](https://www.nvidia.com/de-de/geforce/graphics-cards/40-series/rtx-4090/)  
Nvidia Tesla P100: [http://www.nvidia.com/object/tesla-p100.html](http://www.nvidia.com/object/tesla-p100.html)
