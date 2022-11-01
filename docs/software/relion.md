# Relion

## Description

Some useful information on using Relion.

## Running Relion

A standard submission script serves as a template for your Relion jobs. Create a file with the following content within your home directory:


**qsub.sh**
```Bash
#!/bin/bash
#SBATCH --mail-user=<put your valid email address>
#SBATCH --mail-type=end,fail
#SBATCH --ntasks=XXXmpinodesXXX
#SBATCH --time=XXXextra1XXX
#SBATCH --mem-per-cpu=XXXextra2XXX
#SBATCH --partition=XXXqueueXXX
#SBATCH --error=XXXerrfileXXX
#SBATCH --output=XXXoutfileXXX

module load relion/1.4

mpiexec XXXcommandXXX
####the end
```

!!! types note ""
    Substitute your own email address!

!!! types note ""
    Keywords starting and finishing with "XXX" are recognized by Relion and should not be edited.

!!! types note ""
    To select a specific processor family you can edit the -pe option and subsitute "orte-sandy", "orte-ivy" or "orte-broadwell" for "orte".


 Now, you can set up tasks that will run on the cluster as follows:

1. Start the Relion GUI
2. Click on the "Running" tab
3. Add appropriate values for each option:  
    **Number of MPI procs:** The number of processes the job should use.  
    **Number of threads:** Currently only 1 thread is supported on UBELIX.  
    **Available RAM per thread:** Relion jobs can be quite eager but it is impossible to precisely predict how much RAM each process will need. 4 is usually a good place to start. This option here is only indicative and puts no limit on the RAM that Relion can use. Nonetheless to prevent stupid mistakes, you should always enter the same amount of RAM here as in the option "Maximum RAM per process" (see below).  
    **Submit to queue:** Must be set to yes if the aim is to run on UBELIX queuing system.  
    **Queue name:** In general set it to « all ». If you want to use a specific queue, please refer to https://docs.id.unibe.ch/ubelix/advanced-topics/parallel-jobs
    **Queue submit command:** Set it to "sbatch".  
    **Maximum CPU time:** The maximum allowed running time. See https://docs.id.unibe.ch/ubelix/ubelix-101/the-job-script (Mandatory options) for details on the meaning of this option for UBELIX usage.  
    **Maximum RAM process:** The maximum allowed RAM per process allowed by UBELIX. If you ask for too much RAM your job is less likely to start fast. If you ask for too little RAM your job will crash. The error output by Relion and UBELIX in such case is not always explicit. Nevertheless, too little RAM is the most common cause of crash. Therefore if you experience an unexpected crash, try increasing the available RAM per thread. See https://docs.id.unibe.ch/ubelix/ubelix-101/the-job-script (Mandatory options) for details on the meaning of this option for UBELIX usage. Note that unlike in "Available RAM per thread" option, you must append a "G" to the desired number of Gigabytes (for example, 4G). To prevent stupid mistake, you should always enter the same amount of RAM here as in the option "Available RAM per thread".
    **Standard submission script:** Path to the standard submission script described above.
    **Minimum dedicated core per node:** Set to 1.

## Further Information

Relion wiki: [http://www2.mrc-lmb.cam.ac.uk/relion/index.php/Main_Page](http://www2.mrc-lmb.cam.ac.uk/relion/index.php/Main_Page)

Tutorial: [http://www2.mrc-lmb.cam.ac.uk/groups/scheres/relion13_tutorial.pdf](http://www2.mrc-lmb.cam.ac.uk/groups/scheres/relion13_tutorial.pdf)
