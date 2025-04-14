# Interactive / Remote Computing with VS Code

!!! warning "Deprecation notice"

    With the release of [UBELIX OnDemand](https://ondemand.hpc.unibe.ch), we
    provide [VS Code as an interactive
    app](../../runjobs/ondemand/code-server.md). We recommend to use the
    new interactive app to run VS Code on UBELIX. The functionality
    described on this page may be removed in the future.

!!! tip "Important"
    - This tutorial shows how to work interactively on a compute node! If you need to access the submit nodes, most of the steps below can be skipped!
    - Please keep in mind that these resources will be dedicated for you, thus an idle session will waste resources.

This tutorial outlines how to set up VS Code for interactive/remote development/debugging on UBELIX computing nodes.

## Prerequisites

- The latest version of VS Code installed on your local machine
- Latest version of the ["Remote Development" extension pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)

## Setup

The following steps need to be performed **only once**.

### Local ssh config

Add the following lines to the ssh config file on your local machine (~/.ssh/config) and replace <name> with your UBELIX username:

```
Host ubelix
  HostName submit02.unibe.ch
  IdentityFile ~/.ssh/id_rsa_ubelix
  ServerAliveInterval 60
  User <name>

Host ubelix-code-tunnel
  ProxyCommand ssh ubelix "nc \$(squeue --me --name=code-tunnel --states=R -h -O NodeList,Comment)"
  StrictHostKeyChecking no
  ServerAliveInterval 240
  ServerAliveCountMax 2
  User <name>
```

!!! tip "Attention Windows users"
    Due to different symbols escaping sequences between Linux and Windows, the
    ProxyCommand in the ubelix-code-tunnel block needs to be changed on Windows.
    Note the extra \\ !

    ```
    Host ubelix-code-tunnel
      ProxyCommand ssh ubelix "nc \\$(squeue --me --name=code-tunnel --states=R -h -O NodeList,Comment)"
      StrictHostKeyChecking no
      ServerAliveInterval 240
      ServerAliveCountMax 2
      User <name>
    ```

You can also make these modifications from within Visual Studio Code using the command palette `> Remote-SSH: Open SSH Configuration File`.

### Add code-tunnel.sbatch

Connect to the UBELIX cluster and create the following sbatch file in your home directory (`~/code-tunnel.sbatch`):

```bash
#!/bin/bash
# -----------------------------------------------------------------------------
# USER CODE TUNNEL SETTINGS
# -----------------------------------------------------------------------------
# You may add other configs here for your desired development environment,
# like cpu cores, gpu, memory per core, etc.
#SBATCH --time=01:00:00
#SBATCH --partition=epyc2
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=2G
#
# -----------------------------------------------------------------------------
# NO MODIFICATIONS BELOW THIS LINE
# -----------------------------------------------------------------------------
#SBATCH --job-name="code-tunnel"
#SBATCH --output=code-tunnel.log
#SBATCH --signal=B:TERM@60 # tells the controller
                           # to send SIGTERM to the job 60 secs
                           # before its time ends to give it a
                           # chance for better cleanup.

cleanup() {
    echo "Caught signal - removing SLURM env file"
    rm -f ~/.code-tunnel-env.bash
}

# Trap the timeout signal (SIGTERM) and call the cleanup function
trap 'cleanup' SIGTERM

# find open port
PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
scontrol update JobId="$SLURM_JOB_ID" Comment="$PORT"

# store SLURM variables to file
env | awk -F= '$1~/^SLURM_/{print "export "$0}' > ~/.code-tunnel-env.bash

# start sshd server on the available port
echo "Starting sshd on port $PORT"
/usr/sbin/sshd -D -p ${PORT} -f /dev/null -h ${HOME}/.ssh/id_ed25519_ubelix_internal &
wait
```

### Export SLURM job variables

A running slurm job exports a number of environmental variables to the shell to properly set up the user job.
In order to make these automatically available from within your Visual Studio Code tunnel, add the following to the `~/.bashrc` file on UBELIX:

```bash
# source slurm environment if we're connecting through code-tunnel
[ -f ~/.code-tunnel-env.bash ] && source ~/.code-tunnel-env.bash
```

## Usage

The following steps are performed every time you want to connect your VS Code to the cluster

### Start UBELIX code-tunnel job
From your local terminal, connect to the cluster using `ssh ubelix` and once logged in, 
use `sbatch code-tunnel.sbatch` to start the remote server. Make sure that your job does run!

Sample output:
   
```commandline
[user@submit02 ~]$ sbatch code-tunnel.sbatch
Submitted batch job 1383495
[user@login0b ~]$ squeue --me

  JOBID      PARTITION      NAME             USER      ST      TIME      NODES      NODELIST(REASON)
1383495          epyc2      code-tunnel      user       R      0:17          1           bnode001
```

### Connect to code-tunnel from VS Code
Open VS Code on your local machine and connect to your projects using `Remote Explorer` with `ubelix-code-tunnel` as the ssh target.
