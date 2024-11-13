# Overview

[software-overview]: ../software/index.md
[firststeps-loggingin]: ../firststeps/loggingin.md
[slurm-quickstart]: ../runjobs/scheduled-jobs/slurm-quickstart.md
[module-environment]: ../software/Lmod_modules.md
[data-storage-options]: ../storage/index.md
[software]: ../software/index.md

---

Here you find general descriptions of how to run jobs on UBELIX, i.e. how to run your scientific software using the job scheduler, general information about the UBELIX environment, as well as the new UBELIX web interface that you can use instead of the traditional approaxh using a terminal.
If you are looking for ways to install your software on UBELIX or advice for a specific application, consult the [software section][software-overview] instead.

---

When you log in to UBELIX, you access one of the
login nodes. These login nodes are shared by all users and are only intended
for simple management tasks, e.g.

- compiling software (but consider allocating a compute node for large build
  jobs)
- submitting and managing scheduled jobs
- moving data
- light pre- and postprocessing (a few cores / a few GB of memory)

All compute heavy tasks must be submitted through the job scheduler such that
they are run on the compute nodes.


!!! warning

    All tasks not adhering to the above fair use rules for the login nodes will
    be terminated without warning.


Before you can run jobs on UBELIX you will need to 

- install your software stack
- understand the type of job your trying to run and find suitable partition
- decide where to put your data and get your data there
- create a job script to launch your job
- submit the job

If you're a new user please familiarize yourself with the UBELIX environment:

- Read the [Slurm quickstart guide][slurm-quickstart] to get started submitting
 jobs through the UBELIX job scheduler.
- Read the [module environment][module-environment] page to learn
how to use the module system on UBELIX to find already installed software and to
manage your own software installations.
- Read the [data storage options][data-storage-options] page to learn more
  about where to store your data.
