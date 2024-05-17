# Apptainer

Put your scientific workflows, software and libraries in a container and run it on UBELIX

## Examples

### Work interactively

Submit an interactive SLURM job and then use the shell command to spawn an interactive shell within the Singularity container:

```Bash
srun --time=01:00:00 --mem-per-cpu=2G --pty bash
apptainer shell <image>
```

### Execute the containers "runscript"

```Bash
#!/bin/bash
#SBATCH --partition=all
#SBATCH --mem-per-cpu=2G

apptainer run <image>   #or ./<image>
```

### Run a command within your container image

```Bash
apptainer exec <image> <command>

e.g:
apptainer exec container.img cat /etc/os-release
```

### Bind directories

Per default the started application (e.g. `cat` in the last example) runs withing the container. The container works like a seperate machine with own operation system etc. Thus, per default you have no access to files and directories outside the container. This can be changed using binding paths. 

If files are needed outside the container, e.g. in your HOME you can add the path to `APPTAINER_BINDPATH="src1[:dest1],src2[:dest2]`. All subdirectories and files will be accessible. Thus you could bind your HOME directory as:

```Bash
export APPTAINER_BINDPATH="$HOME/:$HOME/"   
# or simply 
export APPTAINER_BINDPATH="$HOME"
```

## Further Information

Official Apptainer Documentation can be found at [https://apptainer.org/documentation/](https://apptainer.org/documentation/).
