
# Installing R packages

R is installed as global module on UBELIX. There are already a longer list of pre-installed packages available. If you need additional packages you can install them into a shared HPC Workspace or into your home directory.

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

## Installing R packages into a shared Workspace
With the Workspace module we provide short-cuts to install R packages in the shared Workspace location. Therefore, the environment variable `$R_LIBS` is set to `$WORKSPACE/RPackages`. If this directory doesn't exist it needsto be created using:

```Bash
module load Workspace
mkdir $R_LIBS
```
If you get the error `mkdir: cannot create directory ...` verify that you loaded a Workspace while installing the package.

Then R packages can be installed using the `install.packages()` routine in an interactive R shell, e.g. for **doParallel**:

```
module load R
R
...
> install.packages("doParallel")
```

Please follow the procedure as shown below at [installation routine](#installation-routine).

Then the installed packaged will be available to you and all other Workspace members by simply loading the `Workspace` module. 

!!! tip
    Please remember to add the Workspace and the R module to your job scripts:
    ```
    module load Workspace
    module load R
    ```

## Installing R packages into your home directory

!!! tip
    You can also use the procedure above by simply loading `Workspace_Home` to install into your HOME directory.

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

You will be asked to select a CRAN mirror to download from. The mirror list will be not the same as below. The mirror list is constantly changing, but will look like it.

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

