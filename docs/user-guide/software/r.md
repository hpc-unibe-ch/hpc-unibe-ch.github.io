# R

## Description

UBELIX no longer features the R version from EPEL as this version gets automatically updated and therefore things are not reproducible. R isn now provided by an environment module and must be loaded explicitly:

```Bash
module load R/3.4.4-foss-2018a-X11-20180131

-bash-4.1$ R --version
R version 3.4.4 (2018-03-15) -- "Someone to Lean On"
Copyright (C) 2018 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under the terms of the
GNU General Public License versions 2 or 3.
For more information about these matters see
http://www.gnu.org/licenses/.
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

### Customizing the Workspace

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


# User-defined function for calculating L1/L2-norm, returns euclidian distance (L2-norm) by default
myDistance <- function(x, y, type=c("Euclidian", "L2", "Manhattan", "L1")) {
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

Run R interactively. To install additional R packages call the install.packages() function with the name of the package as argument. Upon installing the first package, you will receive a warning that you do not have sufficient permissions to write to "/usr/lib64/R/library". Type "y" to use a personal library instead:

```Bash
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
~/R/x86_64-redhat-linux-gnu-library/3.4
```

Next, select a CRAN mirror to download from. The mirrorlist will be not the same as below. The mirrolist is constantly changing, but will look like it.

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


