Scratch - temporary file space

## Description

Scratch file space are meant for temporary data storage. Interim computational data should be located there. 
We distinguish local and network scratch spaces. 

## Network Scratch
Network scratch spaces are located on the parallel file system and accessible to all nodes. In contrast to `HOME` or `WORKSPACEs`, scratch is meant for temporary data, especially with larger quota requirements. 
Jobs creating a lot of temporary data, which may need or may not need to be post-processed should run in this space. As an example, a application creating a huge amount of temporary output, which need to be analysed, but only partly need to be stored for a longer term.
Quota and file quota is less restrictive on scratch compared to `HOME` or permanent `WORKSPACE` directories. Every user can use up to **50TB** and **50M** files. There is **no snapshot** and **no backup** feature available. Furthermore, an **automatic deletion policy** is planned, deleting files which are older than **30 days**. 

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
module load Workspace/home
mkdir $SCRATCH
cd $SCRATCH
```

Please note that this space is per default **no** private space. If you want to restrict access you can change permissions using:

```
chmod 700 $SCRATCH
```

## Local Scratch
In some cases files need to be read or written multiple times by an application during a computational job. 
Instead of reading and writing the data multiple times on the network storage, it may be more efficient to initially copy the data to the compute node, run the computation and finally copy the resulting data back at the end. Thus, the application can access the data from the local storage, during the job run time.

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

 2. Execute [MODIFY COMPLETELY TO YOUR NEEDS]
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
