# Interactive Jobs

## Description

This page describes how to request resources for interactive jobs and how to use the allocated resources when working interactively.

There are various use cases for requesting interactive resources, e.g.

- debugging: launching a job, tweaking the setup (e.g. compile options), launching job again, tweaking, ...
- interactive interfaces: inspecting a node, or when launching a GUI

In general there are 3 major ways to allocate resources:

- `sbatch`: submitting a script which gets scheduled and launched when resources are available, after submitting the shell is coming back immediately
- `srun`: submitting a single task (no serial preparation or post-processes required), 
    + output on screen
    + shell is blocked until job finished
- `salloc`: requesting resources but no specification of tasks. 
    + requested resources will be blocked until job gets killed/canceled
    + shell block until job starts
    + `srun` command launches task on these resources

## `salloc`

`salloc` creates a SLURM job allocation with the specified (of default) resources, including CPUs/GPUs, memory, walltime. Here 4 tasks on 1 node with 2GB (8GB total) and 1h is requested from `submit01`

```Bash
bash-4.2$ hostname
submit01.ubelix.unibe.ch
bash-4.2$ salloc --nodes=1 --ntasks-per-node=4 --mem-per-cpu=2G --time=01:00:00
salloc: Pending job allocation 63752579
salloc: job 63752579 queued and waiting for resources
salloc: job 63752579 has been allocated resources
salloc: Granted job allocation 63752579
bash-4.2$ hostname
submit01.ubelix.unibe.ch
bash-4.2$ srun hostname
bnode007
```
After submitting the `salloc` command the terminal will be blocked until the job gets granted.
Then the session still persists on the login node `submit01`. Only when using `srun` commands are executed on the requested compute node. The task send with `srun` can run immediately, since the resources are allocated already. 

! type Attention "quit session"
    Please release resources immediately if not needed anymore, by using `exit`, `Ctrl-d` or `scancel $SLURM_JOB_ID`

## Interactive shell session
An interactive shell session on a compute node can be established using 

```Bash
bash-4.2$ srun --pty bash 
srun: job 9173384 queued and waiting for resources
srun: job 9173384 has been allocated resources
bash-4.2$ hostname
bnode026
```
The command is blocking until the resources are granted. The session then is established directly on the first compute node. 

## Graphical Interfaces using X11 Forwarding

Requirements:

- You must login to UBELIX with X11 forwarding enabled: `ssh -Y <user>@submit03.unibe.ch` . Make this the default with **ForwardX11 yes** in  `~/.ssh/config` .
    * Password-less communication between all nodes within UBELIX. In order to make this possible, generate a new SSH key (without passphrase) on the login node (submit) and add the public key to `~/.ssh/authorized_keys` :  
    `ssh-keygen -t rsa -b 4096`
    `cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys`
- A X-Server on your local workstation, e.g.
    + MAC:  Xquartz (X11 no longer included in macOS)
    + Windows: MobaXTerm or Xming

!!! types danger ""
    DO NOT reuse an existing SSH key for this purpose, i.e. do not copy an existing private key from your local machine to UBELIX.

With all the requirements in place can now submit an interactive job and export an X11 display on the allocated compute node, e.g:

```Bash
srun -n 1 --x11 gnuplot ex_gnuplot.p
```

You can also use X11 forwarding with non interactive jobs adding the option 
```Bash
#SBATCH --x11
```
in your job script and using again `srun --x11` to launch your application. 

