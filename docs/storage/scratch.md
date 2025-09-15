# Scratch - temporary file space

!!! warning
    Scratch serves as a temporary repository for compute output and is explicitly designed for short-term usage. Unlike other storage locations, scratch is not backed up. Do not put data here that is crucial for your research!
    Files are subject to automatic removal if they are not accessed within a timeframe of 30 days.

Scratch file space are meant for temporary data storage. Interim computational data should be located there. 
We distinguish local and network scratch spaces. 

## Network Scratch
Network scratch spaces are located on the parallel file system and accessible to all nodes. In contrast to `HOME` or `WORKSPACEs`, scratch is meant for temporary data, especially with larger quota requirements. 
Jobs creating a lot of temporary data, which may need or may not need to be post-processed should run in this space. As an example, a application creating a huge amount of temporary output, which need to be analysed, but only partly need to be stored for a longer term.
Block and file quota is less restrictive on scratch compared to `HOME` or permanent `WORKSPACE` directories. Every user can use up to **15TB** and **10M** files. There is **no snapshot** and **no backup** feature available. Furthermore, an **automatic deletion policy** is implemented, deleting files which are older than **30 days**. Files are subject to automatic removal only if they are not accessed within a timeframe of 30 days. Any file with an access timestamp within the last 30 days remains exempt from the policy, ensuring that actively utilized files are not inadvertently affected.

Scratch file space can be accessed using the Workspace module and the `$SCRATCH` environment variable. 

```BASH
module load Workspace
cd $SCRATCH
```

For personal Scratch see [below](scratch.md#peronal-scratch)

### Workspace Scratch
Each Workspace has a `$SCRATCH` space with the same access permissions like the permanent Workspace directory (using primary and secondary groups). The Workspace can be accessed using `$SCRATCH` variable (after loading the Workspace module). It will point to `/storage/scratch/<researchGroupID>/<WorkspaceID>`. Please use `$SCRATCH` to access it. 

### Personal Scratch

Users without a Workspace can also use "personal" Scratch. This space does need to be created initially:
```BASH
module load Workspace_Home
mkdir $SCRATCH
cd $SCRATCH
```

!!! tip "Private Scratch"
    Please note that this space is per default **no** private space. If you want to restrict access you can change permissions using:

    ```
    chmod 700 $SCRATCH
    ```

## Local Scratch

Cases:

- temporary files are produced, which are not relevant after the computation
- files need to be read or written multiple times within a job

Local storage (`$TMPDIR`) should be used instead of network storage. 

`$TMPDIR` is a node local storage which only exists during the job life time and cleaned automatically afterwards. The actual directory is `/scratch/local/<jobID>`, but it is highly recommended to use `$TMPDIR`. 
If necessary data can be copied there initially at the beginning of the job, processes (multiple times) and necessary results copied back at the end. 

!!! note "`$TMPDIR` instead of `/tmp`"
    `$TMPDIR` is much larger than `/tmp` and cleaned automatically. Especially in case of job errors data in `/tmp` will persist and clog the nodes memory. 

### Example: temporary files

In the following example the `example.exe` will need a place to store temporary/intermediate files, not necessary after the computation. The location is provided using the `--builddir` option. And the local scratch (`$TMPDDIR`) is specified. 

```Bash
#!/bin/bash
#SBATCH --job-name tmpdir
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1

srun example.exe --builddir=$TMPDIR input.dat
```

If you want to have the advantage of low latency file system (local) but you need to keep files, you still can use `$TMPDIR` and copy files to the network storage (e.g. `$WORKSPACE` or `$HOME`) at the end of your job. This is only efficient if a) more files are manipulated local (in `$TMPDIR`) than copied to the network storage or b) files are manipulated multiple times, before copying to the network storage.

### Example: including data movement
In the following example script, all files from the submitting directory are copied to the head compute node. At the end of the job all files from the compute node local directory is copied back. The compute node local `$TMPDIR` is used, which points to `/scratch/local/<jobid>`, a job specific directory in the nodes internal disc.

```Bash
#!/bin/bash
#SBATCH --job-name tmpdir
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
###SBATCH --output slurm.out # when specifying output file name, add rm slurm.out in cleanup function

# I. Define directory names [DO NOT CHANGE]
# =========================================
# get name of the temporary directory working directory, physically on the compute-node
workdir="${TMPDIR}"
# get submit directory
# (every file/folder below this directory is copied to the compute node)
submitdir="${SLURM_SUBMIT_DIR}"

# 1. Transfer to node [DO NOT CHANGE]
# ===================================
# create/empty the temporary directory on the compute node
if [ ! -d "${workdir}" ]; then
  mkdir -p "${workdir}"
else
  rm -rf "${workdir}"/*
fi

# change current directory to the location of the sbatch command
# ("submitdir" is somewhere in the home directory on the head node)
cd "${submitdir}"
# copy all files/folders in "submitdir" to "workdir"
# ("workdir" == temporary directory on the compute node)
cp -prf * ${workdir}
# change directory to the temporary directory on the compute-node
cd ${workdir}

# 3. Function to transfer back to the head node [DO NOT CHANGE]
# =============================================================
# define clean-up function
function clean_up {
  # - remove log-file on the compute-node, to prevent overwiting actual output with empty file
  rm slurm-${SLURM_JOB_ID}.out
  # - TODO delete temporary files from the compute-node, before copying. Prevent copying unnecessary files.
  # rm -r ...
  # - change directory to the location of the sbatch command (on the head node)
  cd "${submitdir}"
  # - copy everything from the temporary directory on the compute-node
  cp -prf "${workdir}"/* .
  # - erase the temporary directory from the compute-node
  rm -rf "${workdir}"/*
  rm -rf "${workdir}"
  # - exit the script
  exit
}

# call "clean_up" function when this script exits, it is run even if SLURM cancels the job
trap 'clean_up' EXIT

# 2. Execute [MODIFY COMPLETELY TO YOUR NEEDS]
# ============================================
# TODO add your computation here
# simple example, hello world
srun echo "hello world from $HOSTNAME"
```

Further aspects to consider:

- copy only necessary files
    + have only necessary files in the submit directory
    + remove all unnecessary files before copying the data back, e.g. remove large input files
- In case of a parallel job, you need to verify that all process run on one single node (`--nodes=1`) OR copy the data to all related nodes (e.g. `srun -n1 cp ...`).
