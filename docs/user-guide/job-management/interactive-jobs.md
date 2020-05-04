# Interactive Jobs

## Description

This page describes how to request resources for interactive jobs and how to use the allocated resources when working interactively.

## Requesting resources

!!! types note ""
    Use salloc [options] to allocate resources for an interactive job. The command will block until sufficient resources are available.

!!! types caution ""
    After the resources have been successfully allocated to your job your are still located on the submit host. Applications started now will not run within the allocation!

```Bash
bash-4.2$ salloc --nodes=1 --ntasks-per-node=4 --mem-per-cpu=2G --time=01:00:00
salloc: Pending job allocation 63752579
salloc: job 63752579 queued and waiting for resources
salloc: job 63752579 has been allocated resources
salloc: Granted job allocation 63752579
bash-4.2$ hostname
submit01.ubelix.unibe.ch
```
## Use an allocation

!!! types note ""
    Use srun [options] --jobid=<id_of_job/allocation> <command> to start a job step under an existing job/allocation.

```Bash
bash-4.2$ srun -n1 --jobid=63752579 hostname
knode02
```

To work interactively on an allocated compute node:

```Bash
bash-4.2$ srun -n1 --jobid=63752579 --pty bash
bash-4.2$ hostname
knode02
```

## X11 Forwarding

!!! types notes "Requirements"
    * You must login to UBELIX with X11 forwarding enabled: _ssh -X <username>@submit.unibe.ch_ . Make this the default with **ForwardX11 yes** in ~/.ssh/config .
    * Password-less communication between all nodes within UBELIX. In order to make this possible, generate a new SSH key (without passphrase) on the login node (submit) and add the public key to ~/.ssh/authorized_keys :  
    **_ssh-keygen -t rsa -b 4096_**  
    **_cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys_**
    * A X-Server on your local workstation, e.g.
        * MAC:  Xquartz (X11 no longer included in macOS)
        * Windows: MobaXTerm or Xming
!!! types danger ""
    DO NOT reuse an existing SSH key for this purpose, i.e. do not copy an existing private key from your local machine to UBELIX.

With all the requirements in place you can now submit an interactive job and export an X11 display on the allocated compute node, e.g:

```Bash
srun -n 1 --pty --x11 xterm
```

You can also use X11 forwarding with non interactive jobs adding the option 
```Bash
#SBATCH --x11
```
in your job script and using again `srun --x11` to launch your application. 

