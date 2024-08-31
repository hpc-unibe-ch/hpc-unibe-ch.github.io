# Parallel BZIP2

## Description
Data need to be packed and compressed for archiving or transfer. There are multiple tools available like tar and gzip, bzip. Pbzip2 is a parallel implementation of bzip2. For general information see [bzip2](https://sourceware.org/bzip2/) and [pbzip2](http://compression.ca/pbzip2/)

## Availability
The tool is available on all nodes without loading any module. 

## Usage
Parallel packing and compressing can be performed on a compute node using `tar` with a specified number of threads

As an example, a file or directory `/data/to/pack` can be packed and compressed into a file `/packed/file.tar.bz2` using the job script:

```Bash
#SBATCH --job-name="pbzip2"
#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=2G
## For parallel jobs with 8 cores
#SBATCH --cpus-per-task=8           ## select the amount of cores required

source="data/to/pack"               ## specify your data to compress
target="/packed/file.tar.bz2"       ## specify directory and filename

# archive dir data_unibe to a tar file and compress it using pbzip2
srun tar -cS $source | pbzip2 -p$SLURM_CPUS_PER_TASK > $target

# Generate a sha256 fingerprint, to later check the integrity 
sha256sum $target > ${target}.sha256sum
```
