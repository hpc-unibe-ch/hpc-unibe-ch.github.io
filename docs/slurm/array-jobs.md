# Array Jobs with Slurm

## Description

You want to submit multiple jobs that are identical or differ only in some arguments. Instead of submitting N jobs independently, you can submit one array job unifying N tasks.


## Submitting an Array 

To submit an array job, specify the number of tasks as a range of task ids using the --array option:

```Bash
#SBATCH --array=n[,k[,...]][-m[:s]]
```

The task id range specified in the option argument may be a single number, a simple range of the form n-m, a range with a step size s, a comma separated list of values, or a combination thereof. The task ids will be exported to the job tasks via the environment variable SLURM_ARRAY_TASK_ID. Other variables available in the context of the job describing the task range are: SLURM_ARRAY_TASK_MAX, SLURM_ARRAY_TASK_MIN, SLURM_ARRAY_TASK_STEP.

!!! types danger ""
    Specifying --array=10 will not submit an array job with 10 tasks, but an array job with a single task with task id 10. To run an array job with multiple tasks you must specify a range or a comma separated list of task ids.

### Limit the Number of Concurrently Running Tasks

You may want to limit the number of concurrently running tasks if the tasks are very resource demanding and too many of them running concurrently would lower the overall performance of the cluster. To limit the number of tasks that are allowed to run concurrently, use a "%" separator:

```Bash
#SBATCH --array=n[,k[,...]][-m[:s]]%<max_tasks>
```

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

Use the --array option to the squeue command to display one tasks per line:

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
./foo input_data_${SLURM_ARRAY_TASK_ID}.txt > output_${SLURM_ARRAY_TASK_ID}.txt
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

data_dir=$HOME/projects/example/input_data        
result_dir=$HOME/projects/example/results

param_store=$HOME/projects/example/args.txt     
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
