# ParaView

## Description

This article note specific information for launching ParaView Server on compute nodes and connect local ParaView with it. 

## Prerequisites 

[Passwordless SSH](../getting-Started/ssh-customization.md#passwordless-ssh-within-the-hpcs) need to be activated as well as connection established with [Port forwarding](../getting-Started/ssh-customization.md#port-forwarding). 

Furthermore, the local (on your local machine) ParaView version need to match the version loaded on the HPCs. 

## Launch ParaView server

First, as mentioned, establish a SSH session with [Port forwarding](../getting-Started/ssh-customization.md#port-forwarding), another port in the range [2000-65000] should be selected: 

```Bash
ssh -Y -L 15051:localhost:15051 submit.unibe.ch
```

Then load the modules:

```Bash
module load ParaView
```

The ParaView version can be displayed using:

```Bash
module list ParaView

Currently Loaded Modules Matching: ParaView
  1) ParaView/5.8.1-foss-2020b-mpi
```

Thus, in this example ParaView 5.8.1 need to be used in the local machine. 

To start the ParaView server on a compute node you can use:

```Bash
pvserver-parallel 15051   ### use your selected port number
```

This submits a job with `1 core` for `1h` in the `epyc2` partition. 
The tool prints a reminder to stop the job if not required anymore and shows the queueing information regularly:

```Bash
ParaView remote Server submitted to compute nodes
  when finished please kill the server using:
     scancel 2394231
job 2394231 status:
   JOBID  PARTITION    STATE               START_TIME
 2394231      epyc2  PENDING                      N/A
pvserver ready to connect on port 15051.
When finished, please stop ParaView Server using
 scancel 2394231
```


!!! type note ""
    Please cancel your job with `scancel $JOBID` or all your running jobs using `scancel -u $USER` if not needed anymore. 

Additional resources can be requested by `--slurm-args=""` option with the desired slurm options, e.g. `3 cores` for `20 min`:

```Bash
pvserver-parallel 15051 --slurm-args="--cpus-per-task=3 --time=00:20:00" 
```

In addition ParaView arguments can be added without any prefix. 

## Connect local client
Finally, the client on your local machine can connect using `localhost` and the selected port, here `15051`. E.g. using `pvpython`:

```Bash
pvpython

WARNING: Python 2.7 is not recommended.
This version is included in macOS for compatibility with legacy software.
Future versions of macOS will not include Python 2.7.
Instead, it is recommended that you transition to using 'python3' from within Terminal.

Python 2.7.16 (default, May  8 2021, 11:48:02)
[GCC Apple LLVM 12.0.5 (clang-1205.0.19.59.6) [+internal-os, ptrauth-isa=deploy on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> from paraview.simple import *
>>> Connect("localhost", 15051)
Connection (cs://localhost:15051) [2]
```