# GPUs

## Description

This page contains all information you need to submit GPU-jobs successfully on Ubelix.

## Important Information on GPU Usage

!!! types note ""
    Code that runs on the CPU will not magically make use of GPUs by simply submitting a job to the 'gpu' partition! You have to explicitly adapt your code to run on the GPU. Also, code that runs on a GPU will not necessarily run faster than it runs on the CPU. For example, GPUs are not suited to handle tasks that are not highly parallelizable. In other words, you must understand the characteristics of your job, and make sure that you only submit jobs to the 'gpu' partition that can actually benefit from GPUs.

## Privileged vs. Regular Users

We have two categories of users on Ubelix concerning GPU usage: privileged and regular users. Privileged users are users that have invested money into GPUs. Jobs of privileged users can preempt running jobs of regular users on a certain number of GPUs. Unless the option _--no-requeue_ was used when submitting the job, a preempted job is automatically requeued, or canceled otherwise. A requeued job can start on different resources. This behavior is enforced by job QOSs. Whether a job is privileged or not depends on the job QoS that was used to submit the job. Regular users submit their jobs always with the unprivileged QoS 'job_gpu', while privileged users submits their jobs by default with the privileged QoS 'job_gpu_<name_of_head>'. Additionally, privileged users can also submit jobs with the unprivileged QoS. A privileged job will cancel a running unprivileged job when the following two criteria are met:

*    There are no free GPU resources of the requested GPU type available.
*    The QoS of the privileged user has not yet reached the maximum number of GPUs allowed to use with this QoS.

If an unprivileged job needs to be preempted to make resources available for a privileged job, Slurm will always preempt the youngest running job in the partition.

!!! types warning ""
    Because an unprivileged job can be preempted at any time, it is important that you checkpoint your jobs. This allows you to resubmit the job and continue execution from the last saved checkpoint.


## Access to the 'gpu' Partition

While the 'gpu' partition is open for everybody, regular users must request access to this partition explicitly before they can submit jobs. You have to request access only once. To do so, simply write an email to [hpc@id.unibe.ch](mailto:hpc@id.unibe.ch) and describe in a few words your application.

## GPU Type

Ubelix currently features three types of GPUs

| Number of Cards    | GPU          |
|--------------------|--------------|
| 48                 | Nvidia Geforce GTX 1080 Ti |
| 24                 | Nvidia Geforce RTX 2080 Ti |
| 16                 | Nvidia Tesla P100     |

You must request a GPU using the `--gres` option:

!!! types warning ""
    Currently you can specify only two GRES types when requesting GPU resources: gtx1080ti and teslaP100. Requesting type gtx1080ti will allocate GTX or RTX cards to your job. To request a specific Geforce card you must use the --constraint option (see below).

```Bash
--gres=gpu:gtx1080ti:<number_of_gpus>
or
--gres=gpu:teslaP100:<number_of_gpus>
```

Use the `--constraint` option to differentiate between Geforce GTX and RTX cards:

```Bash
To request Geforce GTX cards:
--gres=gpu:gtx1080ti:<number_of_gpus>
--constraint=gtx1080

To request Geforce RTX cards:
--gres=gpu:gtx1080ti:<number_of_gpus>
--constraint=rtx2080
```

## Job Submission

Use the following options to submit a job to the gpu partition using the default job QoS:

```Bash
#SBATCH --partition=gpu
#SBATCH --gres=gpu:<type>:<number_of_gpus>
```
**Privileged user only:** Use the following options to submit a job using the non-privileged QoS:

```Bash
#SBATCH --partition=gpu
#SBATCH --qos=job_gpu
#SBATCH --gres=gpu:<type>:<number_of_gpus>
```

Use the following option to ensure that the job, if preempted, won't be requeued but canceled instead:

```Bash
#SBATCH --no-requeue
```

## CUDA

CUDA versions are now managed through module files. Run _module avail_ to see which versions are available:

```Bash
module avail
(...)
CUDA/9.0.176                              help2man/1.47.4                                    (D)    numactl/2.0.11-GCCcore-6.4.0                             (D)
CUDA/9.1.85                               hwloc/1.11.3-GCC-5.4.0-2.26                               OpenBLAS/0.2.18-GCC-5.4.0-2.26-LAPACK-3.6.1
CUDA/9.2.88                        (D)    hwloc/1.11.5-GCC-6.3.0-2.27                               OpenBLAS/0.2.19-GCC-6.3.0-2.27-LAPACK-3.7.0
cuDNN/7.0.5-CUDA-9.0.176                  hwloc/1.11.7-GCCcore-6.4.0                                OpenBLAS/0.2.20-GCC-6.4.0-2.28                           (D)
cuDNN/7.0.5-CUDA-9.1.85                   hwloc/1.11.8-GCCcore-6.4.0                         (D)    OpenMPI/1.10.3-GCC-5.4.0-2.26
cuDNN/7.1.4-CUDA-9.2.88
(...)
```

Run _module load <module>_ to load a specific version of CUDA:

```Bash
module load cuDNN/7.1.4-CUDA-9.2.88
```

!!! types note ""
    If you need cuDNN you must load the cuDNN module. The appropriate CUDA version is then loaded as a dependency.

## Further Information

CUDA: [https://developer.nvidia.com/cuda-zone](https://developer.nvidia.com/cuda-zone)  
CUDA C/C++ Basics: [http://www.nvidia.com/docs/IO/116711/sc11-cuda-c-basics.pdf](http://www.nvidia.com/docs/IO/116711/sc11-cuda-c-basics.pdf)  
Nvidia Geforce GTX 1080 Ti: [https://www.nvidia.com/en-us/geforce/products/10series/geforce-gtx-1080-ti](https://www.nvidia.com/en-us/geforce/products/10series/geforce-gtx-1080-ti/)  
Nvidia Tesla P100: [http://www.nvidia.com/object/tesla-p100.html](http://www.nvidia.com/object/tesla-p100.html)

