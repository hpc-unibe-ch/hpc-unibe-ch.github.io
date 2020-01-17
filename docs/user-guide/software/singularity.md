# Singularity

## Description

Put your scientific workflows, software and libraries in a Singularity container and run it on UBELIX

## Examples

### Work interactively

Submit an interactive SLURM job and then use the shell command to spawn an interactive shell within the Singularity container:

```Bash
srun --time=01:00:00 --mem-per-cpu=2G --pty bash
singularity shell <image>
```

### Execute the containers "runscript"

```Bash
#!/bin/bash
#SBATCH --partition=all
#SBATCH --mem-per-cpu=2G

singularity run <image>   #or ./<image>
```

### Run a command within your container image

```Bash
singularity exec <image> <command>

e.g:
singularity exec container.img cat /etc/os-release
```


## Further Information

Official Singularity Documentation can be found at [https://sylabs.io/docs/](https://sylabs.io/docs/)
