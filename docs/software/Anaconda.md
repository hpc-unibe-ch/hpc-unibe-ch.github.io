# Anaconda

## Description
Anaconda provides Python and a long list of packages as well as Jupyter and environment and package manager conda and pip.

Anaconda brings a long list of Python packages. You can list them using 
```Bash
conda list
```

## Availability
On our systems we provide Anaconda3, which gets update regularly. 

## Usage
``` Bash
module load Anaconda3
```

## Additional Packages
to install additional packages please see [Additional Packages](python.md#additional-packages)

## Jupyter
For Jupyter information please see [JupyterLab](JupyterLab.md)

## Managing Virtual Environments, Versions with Anaconda
Anaconda is a high performance distribution of Python that includes the most popular packages for data science (numpy, scipy,...). It also features conda, a package, dependency and environment manager. With Anaconda you can run multiple versions of Python in isolated environments.

### conda 
when using conda the system may complain about:
```Bash
CommandNotFoundError: Your shell has not been properly configured to use 'conda activate'.
To initialize your shell, run
    $ conda init <SHELL_NAME>
Currently supported shells are:
  - bash
  - fish
  - tcsh
  - xonsh
  - zsh
  - powershell
See 'conda init --help' for more information and options.
IMPORTANT: You may need to close and restart your shell after running 'conda init'.
```

Please do **not** run `conda init`. This would add hard coded environment changes in your `$HOME/.bashrc`. 
Instead initialise the conda environment using:
``` Bash 
module load Anaconda3
eval "$(conda shell.bash hook)"
```
This should also be used in your batch submission scripts when working with conda environments.

## Move / Migration of conda environments
If conda environments need to be transfered on the system, e.g. from `$HOME` to `$WORKSPACE` you can use the `conda pack` (see official [conda pack documentation](https://conda.github.io/conda-pack/). 

If your environment is already moved you can recreate the environment with the old specification using:
```
export CONDA_ENVS_PATH=${HOME}/anaconda3/envs ## or where you had your old envs
module load Anaconda3
eval "$(conda shell.bash hook)"
conda info --envs
conda activate oldEnvName     ## choose your old environment name
conda list --explicit > spec-list.txt
unset CONDA_ENVS_PATH
conda create --name myEnvName --file spec-list.txt  # select a name
```