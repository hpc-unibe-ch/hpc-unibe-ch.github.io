[r-install]: ../installing/r.md

# R

## Loading the R module

R is provided by an environment module and must be loaded explicitly:

```Bash
module load R
R --version
  R version 4.2.1 (2022-06-23) -- "Funny-Looking Kid"
  ...
```

## Listing all installed packages

You can list all installed R packages using the following one-liner:

```Bash
R -e 'installed.packages()'
```

R is installed as global Module in various versions. There are already a longer list of pre-installed packages available. If you need additional packages you can install them by yourself. See [Installing R packages][r-install] for details.

## Batch Execution of R

The syntax for running R non-interactively with input read from _infile_ and output send to _outfile_ is:

```Bash
R CMD BATCH [options] infile [outfile]
```

Suppose you placed your R code in a file called foo.R:

**foo.R**

```Bash
set.seed(3000)
valx<-seq(-2,2,0.01)
valy<-2*valx+rnorm(length(valx),0,4)
# Save plot to pdf
pdf('histplot.pdf')
hist(valy,prob=TRUE,breaks=20, main="Histogram and PDF",xlab="y", ylim=c(0,0.15))
curve(dnorm(x,mean(valy),sd(valy)),add=T,col="red")
dev.off()
```

To execute foo.R on the cluster, add the R call to your job script...

**Rbatch.sh**

```Bash
#! /bin/bash
#SBATCH --mail-user=<put your valid email address here!>
#SBATCH --mail-type=end,fail
#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=2G

# Put your code below this line
module load vital-it
module load R/3.4.2
R CMD BATCH --no-save --no-restore foo.R
```

...and submit your job script to the cluster:

```Bash
sbatch Rbatch.sh
```

## Advanced Topics

### Parallel R

By default, R will not make use of multiple cores available on compute nodes to parallelize computations. Parallel processing functionality is provided by add-on packages. Consider the following contrived example to get you started. To follow the example, you need the following packages installed, and the corresponding libraries loaded:

```Bash
> library(doParallel)
> library(foreach)
```

The foreach package provides a looping construct for executing R statements repeatedly, either sequentially (similar to a for loop) or in parallel. While the binary operator %do% is used for executing the statements sequentially, the %dopar% operator is used to execute code in parallel using the currently registered backend. The getDoParWorkers() function returns the number of execution workers (cores) available in the currently registered doPar backend, by default this corresponds to one worker:

```Bash
> getDoParWorkers()
[1] 1
```

Hence, the following R code will execute on a single core (even with the %dopar% operator):

```Bash
> start.time <- Sys.time()
> foreach(i=4:1, .combine='c', .inorder=FALSE) %dopar% {
+ Sys.sleep(3*i)
+ i
+ }
end.time <- Sys.time()
exec.time <- end.time - start.time
[1] 4 3 2 1
```

Let's measure the runtime of the sequentiall execution:

```Bash
> start.time <- Sys.time(); foreach(i=4:1, .combine='c', .inorder=TRUE) %dopar% { Sys.sleep(3*i); i }; end.time <- Sys.time(); exec.time <- end.time - start.time; exec.time
[1] 4 3 2 1
Time difference of 30.04088 secs
```

Now, we will register a parallel backend to allow the %dopar% operator to execute in parallel. The doParallel package provides a parallel backend for the %dopar% operator. Let's find out the number of cores available on the current node

```Bash
> system('nproc')
[1] 24
```

To register the doPar backend call the function registerDoParallel(). With no arguments provided, the number of cores assigned to the backend matches the value of _options("cores")_, or if not set, to half of the cores detected by the parallel package. 

```Bash
 registerDoParallel()
> getDoParWorkers()
[1] 12
```

To assign 4 cores to the parallel backend:

```Bash
> registerDoParallel(cores=4)
> getDoParWorkers()
[1] 4
```

!!! types caution "Request the correct number of slots"
    Because it is crucial to request the correct number of slots for a parallel job, we propose to set the number of cores for the doPar backend to the number of slots allocated to your job:
    `registerDoParallel(cores=Sys.getenv("SLURM_CPUS_PER_TASK"))`

Now, run the example again:

```Bash
> foreach(i=4:1, .combine='c', .inorder=FALSE) %dopar% {
+ Sys.sleep(3*i)
+ i
+ }
[1] 4 3 2 1
```

Well, the output is basically the same (the results are combined in the same order!). Let's again measure the runtime of the parallel execution on 4 cores:

!!! types caution "The binary operator %do% will always execute a foreach-loop sequentially even if registerDoParallel was called before! To correctly run a foreach in parallel, two conditions must be met:"
    * registerDoParallel() must be called with a certain number of cores
    * The %dopar% operator must be used in the foreach-loop to have it run in parallel!
