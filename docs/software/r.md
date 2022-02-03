# R

## Description

R is provided by an environment module and must be loaded explicitly:

```Bash
module load R ##OR## module load R/3.4.4-foss-2018a-X11-20180131
R --version
  R version 4.0.0 (2020-04-24) -- "Arbor Day"
  ...
```

The **Vital-IT project** is also providing some versions. The following commands will list the available versions:

```Bash
module load vital-it
module avail 2>&1 | grep " R\/"
  R/3.4.2
  R/latest
```

To use one of these version, you have to load the respective module, which then masks the system's version, i.e.

```Bash
module load vital-it
module load R/3.4.2
```

!!! types danger ""
    Do not forget to put those two lines into your job script as well in order to use the same version from within the job later on a compute node!

## Basic Topics

### Customizing the R Workspace

At startup, unless --no-init-file, or --vanilla was given, R searches for a user profile in the current directory (from where R was started), or in the user's home directory (in that order). A different path of the user profile file can be specified by the R_PROFILE_USER environment variable. The found user profile is then sourced into the workspace. You can use this file to customize your workspace, i.e., to set specific options, define functions, load libraries, and so on. Consider the following example:

**.Rprofile**
```Bash
# Set some options
options(stringsAsFactors=FALSE)
options(max.print=100)
options(scipen=10)

# Load  class library
library(class)

# Don't save workspace by default
q <- function (save="no", ...) {
  quit(save=save, ...)
}

# User-defined function for setting standard seed
mySeed <- function() set.seed(5450)


# User-defined function for calculating L1/L2-norm, returns euclidean distance (L2-norm) by default
myDistance <- function(x, y, type=c("Euclidean", "L2", "Manhattan", "L1")) {
  type <- match.arg(type)
  if ((type == "Manhattan") | (type == "L1")) {
    d <- sum( abs(x - y) )
  } else {
    d <- sqrt( sum( (x - y) ^ 2) )
  }
  return(d)
}
```

### Installing Packages
R is installed as global Module in various versions. There are already a longer list of pre-installed packages available. If you need additional packages you can install them by yourself. The default location would be the R installation directory, which is not writeable for users. Nevertheless, in the following is shown how to install into a shared HPC Workspace or into your private HOME. 


#### A) Into a shared Workspace
With the Workspace tools we provide short-cuts to install R packages in the shared Workspace location. Therefore, the environment variable `$R_LIBS` is set to `$WORKSPACE/RPackages`. Initially this directory need to be created, using:

```Bash
module load Workspace
mkdir $R_LIBS
```
If you get the error `mkdir: cannot create directory ...` verify that you just loaded one Workspace while installing the package.

Then R packages can be installed using the `install.packages()` routine in an interactive R shell, e.g. for **doParallel**:

```
module load R
R
...
> install.packages("doParallel")
```

Please follow the procedure as shown below at [installation routine](#installation-routine).

Then the installed packaged will be available to you and all other Workspace members by simply loading the `Workspace` module. 

!!! type danger ""
    Please remember to add the Workspace and the R module to your job scripts:
    ```
    module load Workspace
    module load R
    ```


#### B) Into your HOME

!!! note "Note"
    you can also use procedure A) and load `Workspace_Home` to install into your HOME directory.

If you are not using a Workspace module and try to install a package, at the first time R tries to install the package into a global/generic location, which is not writeable by users. You can then select to install in a "personal library" into your HOME:

```Bash
module load R
R
> install.packages("doParallel")
Installing package into ‘/usr/lib64/R/library’
(as ‘lib’ is unspecified)
Warnung in install.packages("doParallel")
  'lib = "/usr/lib64/R/library" ist nicht schreibbar
Would you like to use a personal library instead?  (y/n)
```

Next, type "y" to create your personal library at the default location within your HOME directory:


```Bash
Would you like to create a personal library
~/R/x86_64-redhat-linux-gnu-library/4.0
```

#### Installation Routine

Next, select a CRAN mirror to download from. The mirror list will be not the same as below. The mirror list is constantly changing, but will look like it.

Pick any country nearby, i.e. Switzerland. If https makes problems, pick "(HTTP mirrors)" and then select something nearby as shown below

```Bash
--- Bitte einen CRAN Spiegel für diese Sitzung auswählen ---
Error in download.file(url, destfile = f, quiet = TRUE) :
  nicht unterstütztes URL Schema
HTTPS CRAN mirror
 1: 0-Cloud [https]                2: Austria [https]
 3: Chile [https]                  4: China (Beijing 4) [https]
 5: Colombia (Cali) [https]        6: France (Lyon 2) [https]
 7: France (Paris 2) [https]       8: Germany (Münster) [https]
 9: Iceland [https]               10: Mexico (Mexico City) [https]
11: Russia (Moscow) [https]       12: Spain (A Coruña) [https]
13: Switzerland [https]           14: UK (Bristol) [https]
15: UK (Cambridge) [https]        16: USA (CA 1) [https]
17: USA (KS) [https]              18: USA (MI 1) [https]
19: USA (TN) [https]              20: USA (TX) [https]
21: USA (WA) [https]              22: (HTTP mirrors)

Selection: 22
HTTP CRAN mirror
 1: 0-Cloud                       2: Algeria
 3: Argentina (La Plata)          4: Australia (Canberra)
 5: Australia (Melbourne)         6: Austria
 7: Belgium (Antwerp)             8: Belgium (Ghent)
(...)
65: Slovakia                     66: South Africa (Cape Town)
67: South Africa (Johannesburg)  68: Spain (A Coruña)
69: Spain (Madrid)               70: Sweden
71: Switzerland                  72: Taiwan (Chungli)
73: Taiwan (Taipei)              74: Thailand
75: Turkey (Denizli)             76: Turkey (Mersin)
(...)
93: USA (OH 2)                   94: USA (OR)
95: USA (PA 2)                   96: USA (TN)
97: USA (TX)                     98: USA (WA)
99: Venezuela
Selection: 71
```

Finally, the package gets installed. After installing the package you can close the interactive session by typing q().

Do not forget to load the corresponding library (for each R session) before using functions provided by the package:

```Bash
> library(doParallel)
```

### Batch Execution of R

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
> detectCores()
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

### Installing DESeq2 from Bioconductor packages

DESeq2[^1)] installed from Bioconductor[^2)] has many dependencies. Two odd facts are hindering a succesful build of DESeq2 in first place:

* data.table is needed by Hmisc, which in turn is needed by DESeq2. While Hmisc is automatically installed prior to DESeq2, data.table is not and has to be installed manually first.

[^1)]:[https://bioconductor.org/packages/release/bioc/html/DESeq2.html](https://bioconductor.org/packages/release/bioc/html/DESeq2.html)

[^2)]:[https://bioconductor.org/](https://bioconductor.org/)
