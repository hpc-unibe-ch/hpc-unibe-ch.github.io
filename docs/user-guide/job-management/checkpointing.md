# Checkpointing

## Description

Checkpointing: Saving the state of a computation so that it can be resumed later. On this page we provide some useful information for making your own code checkpoint-able.

!!! types note ""
    Currently, we do not provide and support programs and libraries (e.g. BLCR) that allow to checkpoint proprietary (closed source) software.

!!! types note ""
    Some applications provide built-in checkpoint/restart mechanisms: Gaussian, Quantum Espresso, CP2K and more.

## Why checkpointing

Imagine a job is already running for several hours when an event occurs which leads to the abortion of the job. Such events can be:

* Exceeding the time limit
* Exceeding allocated memory
* Job gets preempted by another job (gpu partition only!)
* Node failure

Checkpointing a job means that you frequently save the job state so that you can resume computation from the last checkpoint in case of a disastrous event.

## General recipe for checkpointing your own code

Introducing checkpointing logic in your code consists of 3 steps

     1. Look for a state file containing a previously saved state.
     2. If a state file exists, then restore the state. Else, start from scratch.
     3. Periodically save the state.

## Using UNIX signals

You can save the state of your job at specific points in time, after certain iterations, or at whatever event you choose to trigger a state saving. You can also trap specific UNIX signals and act as soon as the signal occurs. The following table lists common signals that you might want to trap in your program:

| Signal Name | Signal Number | Description | Default Disposition | 
|-------------|---------------|-------------|---------------------|
| SIGTERM     | 15            | SIGTERM initiates the termination of a process | Term - Terminate the process |
| SIGCONT     | 18            | SIGCONT continues a stopped process | Cont - Continue the process if stopped |
| SIGUSR1     | 10            | User-defined signals. SIGUSR1/SIGUSR2 are never sent by the kernel | Term - Terminate the process |
| SIGUSR2     | 12            | User-defined signals. SIGUSR1/SIGUSR2 are never sent by the kernel | Term - Terminate the process |

!!! types note ""
    _kill -l_ for a list of all supported signals. Note that some signals cannot be trapped, e.g SIGKILL

Slurm sends SIGCONT followed by SIGTERM just before a job is canceled. Trapping the signal (e.g. SIGTERM) gives you 60 seconds for housekeeping tasks, e.g. save current state. At the latest after that your job is canceled with SIGKILL. This is true for jobs canceled by the owner using scancel and jobs canceled by Slurm, e.g. because of exceeding time limit.

## Register a signal handler for a UNIX signal

The following examples show how to register a signal handler in different languages, but omit the logic for creating a checkpoint and restart a job from an existing checkpoint. We will provide a working example further down below on this page.


**Bash**

```Bash
#!/bin/bash

function signal_handler {
  # Save program state and exit
  (...)
  exit
}

trap signal_handler TERM
(...)
```


**C/C++**

```C++
#include <signal.h>  // C
#include <csignal>   // C++

void signal_handler(int signal) {
  // Save program state and exit
  (...)
 exit(0);
}

// Register signal handler for SIGTERM
signal(SIGTERM, signal_handler);  // signal_handler: function to handle signal
(...)
```

**Python**

```Python
#! /usr/bin/env python
import signal
import sys


def signal_handler(sig, frame):
  # Save program state and exit
  (...)
  sys.exit(0)


signal.signal(signal.SIGTERM, signal_handler)
(...)
```

## Signaling checkpoint creation without canceling the job

You can use a UNIX signal to trigger the creation of a checkpoint of a running job. For example, consider a job that traps SIGUSR1 and saves intermediate results as soon as the signal occurs. You can then create a checkpoint by signaling SIGUSR1 to the job using _scancel_:

```Bash
scancel --signal=USR1 <jobid>
```

!!! types note ""
    Use _--batch_ option to signal the batch step (shell script), but not any other associated job step _(srun)_ or child processes of the shell script. Use _--full_ option to signal all steps associated with the job including the shell script and its child processes.

!!! types note ""
    Using _scancel_ with the _--signal_ option won't terminate the job or job step.







