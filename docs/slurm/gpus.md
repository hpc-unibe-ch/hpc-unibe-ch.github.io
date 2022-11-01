# GPUs

## Description

This page contains all information you need to successfully submit GPU-jobs on
UBELIX.

## Important Information on GPU Usage

!!! types note ""
    Code that runs on the CPU will **not** auto-magically make
    use of GPUs by simply submitting a job to the 'gpu' partition! You have to
    explicitly adapt your code to run on the GPU, e.g. an CUDA or OpenACC
    implementation. Also, code that runs on a GPU will not necessarily run faster
    than it runs on the CPU. For example, GPUs require a huge amount of highly
    parallelizable tasks. In other words, you must understand the characteristics
    of your job, and make sure that you only submit jobs to the 'gpu' partition
    that can actually benefit from GPUs.

When submitting to the GPU partition the GPU type specification is **required**. 

## GPU Types

UBELIX currently features four types of GPUs. You have to choose an
architecture and use one of the following `--gres` option to select it.

| Type | SLURM gres option |
| ---- | ----------------- | 
| Nvidia Geforce GTX 1080 Ti | `--gres=gpu:gtx1080ti:<number_of_gpus>` |
| Nvidia Geforce RTX 2080 Ti | `--gres=gpu:rtx2080ti:<number_of_gpus>` |
| Nvidia Geforce RTX 3090 | `--gres=gpu:rtx3090:<number_of_gpus>` |
| Nvidia Tesla P100 | `--gres=gpu:teslap100:<number_of_gpus>` |


## Job Submission

Use the following options to submit a job to the `gpu` partition using the
default job QoS:

```Bash
#SBATCH --partition=gpu
#SBATCH --gres=gpu:<type>:<number_of_gpus>
```


## QoS `job_gpu_preempt`

For investors we provide the `gpu-invest` investor partitions with a specific
QoS per investor that guarantees instant access to the purchased resources.  
Nevertheless, to efficiently use all resources, the QoS `job_gpu_preempt` exists
in the `gpu` partition. Jobs, submitted with this QoS have access to all GPU
resources, but  may be interrupted if resources are required for investor jobs.
Short jobs, and jobs that make use of checkpointing will benefit from these
additional resources.

Example: Requesting any four RTX2080Ti from the resource pool in the `gpu`
partition:
```Bash
#SBATCH --partition=gpu
#SBATCH --qos=job_gpu_preempt
#SBATCH --gres=gpu:rtx2080ti:4
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
accessible using environment modules. Use `module avail` to see which versions
are available:

```Bash
module avail CUDA
---- /software.el7/modulefiles/all ----
   CUDA/8.0.61                           cuDNN/7.1.4-CUDA-9.2.88
   CUDA/9.0.176                          cuDNN/7.6.0.64-gcccuda-2019a (D)
   CUDA/9.1.85                           fosscuda/2019a
   CUDA/9.2.88                           fosscuda/2019b               (D)
   CUDA/10.1.105-GCC-8.2.0-2.31.1        gcccuda/2019a
   CUDA/10.1.243                  (D)    gcccuda/2019b                (D)
   cuDNN/6.0-CUDA-8.0.61                 OpenMPI/3.1.3-gcccuda-2019a
   cuDNN/7.0.5-CUDA-9.0.176              OpenMPI/3.1.4-gcccuda-2019b
   cuDNN/7.0.5-CUDA-9.1.85
```

Run `module load <module>` to load a specific version of CUDA:

```Bash
module load cuDNN/7.1.4-CUDA-9.2.88
```

!!! types note ""
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
Nvidia Geforce RTX 2080 Ti: [https://www.nvidia.com/de-de/geforce/graphics-cards/rtx-2080-ti/](https://www.nvidia.com/de-de/geforce/graphics-cards/rtx-2080-ti/)  
Nvidia Geforce RTX 3090: [https://www.nvidia.com/de-de/geforce/graphics-cards/30-series/rtx-3090/](https://www.nvidia.com/de-de/geforce/graphics-cards/30-series/rtx-3090/)  
Nvidia Tesla P100: [http://www.nvidia.com/object/tesla-p100.html](http://www.nvidia.com/object/tesla-p100.html)
