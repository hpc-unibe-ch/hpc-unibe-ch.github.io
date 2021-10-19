# Array Jobs with Slurm

## Description

Array jobs are jobs where the job setup, including job size, memory, time etc. is constant, but the application input varies. One use case are parameter studies. 

Instead of submitting N jobs independently, you can submit one array job unifying N tasks. These provide advantages in the job handling as well as for the SLURM scheduler.


## Submitting an Array

To submit an array job, specify the number of tasks as a range of task IDs using the --array option:

```Bash
#SBATCH --array=n[,k[,...]][-m[:s]]%<max_tasks>
```

The task id range specified in the option argument may be: 

- comma separated list of values: `#SBATCH --array=1,3,5` 
- simple range of the form n-m: `#SBATCH --array=201-300` (201, 202, 203, ..., 300)
- range with a step size s: `#SBATCH --array=100-200:2` (100, 102, 104, ... 200)
- combination thereof: `#SBATCH --array=1,3,100-200` (1, 3, 100, 101, 102, ..., 200)

Furthermore, the **amount of concurent** running jobs can **limited** using the `%` seperator, e.g. for max 100 concurrent jobs of 1-400: `#SBATCH --array=1-400%100`. Therewith you can prevent fully filling your available resources. 
The task IDs will be exported to the job tasks via the environment variable `SLURM_ARRAY_TASK_ID`. Additionally, `SLURM_ARRAY_TASK_MAX`, `SLURM_ARRAY_TASK_MIN`, `SLURM_ARRAY_TASK_STEP` are available in job, describing the task range of the job.

!!! types danger ""
    Specifying `--array=10` will not submit an array job with 10 tasks, but an array job with a single task with task id 10. To run an array job with multiple tasks you must specify a range or a comma separated list of task ids.


## Output files
Per default the output files are named as `slurm-<jobid>_<taskid>.out`. When renaming the output/error files variables for the job ID (`%A`) and for the task ID (`%a`) can be used. For example:

```Bash
#SBATCH --output=array_example_%A_%a.out
#SBATCH --error=array_example_%A_%a.err
```
Thus a file `array_example_6543212_12.out` will be written for the 12th task of job 6543212.

## Canceling Individual Tasks

You can cancel individual tasks of an array job by indicating tasks ids to the scancel command:

```Bash
$ squeue
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
79265_[49-99:2%20]      test Simple H  foo 		PD      0:00      1 (QOSMaxCpuPerUserLimit)
          79265_41      test Simple H  foo  	R       0:10      1 fnode03
          79265_43      test Simple H  foo  	R       0:10      1 fnode03
          79265_45      test Simple H  foo  	R       0:10      1 fnode03
          79265_47      test Simple H  foo  	R       0:10      1 fnode03
```

Use the `--array` option to the squeue command to display one tasks per line:

```Bash
$ squeue --array
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
          79265_65      test Simple H  foo		PD      0:00      1 (QOSMaxCpuPerUserLimit)
          79265_67      test Simple H  foo		PD      0:00      1 (QOSMaxCpuPerUserLimit)
          79265_69      test Simple H  foo		PD      0:00      1 (QOSMaxCpuPerUserLimit)
          79265_97      test Simple H  foo		PD      0:00      1 (QOSMaxCpuPerUserLimit)
          79265_57      test Simple H  foo		R       0:47      1 fnode03
          79265_59      test Simple H  foo  	R       0:47      1 fnode03
          79265_61      test Simple H  foo  	R       0:47      1 fnode03
          79265_63      test Simple H  foo  	R       0:47      1 fnode03
```

## Examples

### Use case 1: 1000 computations, same resource requirements, different input/output arguments

Instead of submitting 1000 individual jobs, submit a single array jobs with 1000 tasks:

```Bash
#!/bin/bash
#SBATCH --time=00:30:00    	# Each task takes max 30 minutes
#SBATCH --mem-per-cpu=2G   	# Each task uses max 2G of memory
#SBATCH --array=1-1000    	# Submit 1000 tasks with task ID 1,2,...,1000.

# The name of the input files must reflect the task ID!
srun ./foo input_data_${SLURM_ARRAY_TASK_ID}.txt > output_${SLURM_ARRAY_TASK_ID}.txt
```

!!! types note ""
    Task with ID 20 will run the program foo with the following arguments:  
    ./foo input_data_20.txt > output_20.txt

### Use case 2: Read arguments from file

Submit an array job with 1000 tasks. Each task executes the program foo with different arguments:

```Bash
#!/bin/bash
#SBATCH --time=00:30:00    # Each task takes max 30 minutes
#SBATCH --mem-per-cpu=2G   # Each task uses max 2G of memory
### Submit 1000 tasks with task ID 1,2,...,1000. Run max 20 tasks concurrently
#SBATCH --array=1-1000%20  

data_dir=$WORKSPACE/projects/example/input_data        
result_dir=$WORKSPACE/projects/example/results

param_store=$WORKSPACE/projects/example/args.txt     
### args.txt contains 1000 lines with 2 arguments per line.
###    Line <i> contains arguments for run <i>
# Get first argument
param_a=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $1}')
# Get second argument
param_b=$(cat $param_store | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $2}')

### Input files are named input_run_0001.txt,...input_run_1000.txt
###    Zero pad the task ID to match the numbering of the input files
n=$(printf "%04d" $SLURM_ARRAY_TASK_ID)


srun ./foo -c $param_a -p $param_b -i ${data_dir}/input_run_${n}.txt -o ${result_dir}/result_run_${n}.txt
```
