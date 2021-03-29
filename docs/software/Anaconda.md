# Anaconda

## Description
Anaconda provides Python and a long list of packages as well as Jupyter and environment and package manager conda and pip.

## Availability
On our systems we provide Anaconda3, which gets update regularly. 

## Usage
``` Bash
module load Anaconda3
```

## additional Packages
we suggest to install additional packages, e.g. `packXYZ` using
```Bash
pip install --user packYXZ
```

## conda 
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

Please do **not** run conda init. This would add hard coded environment changes in your `$HOME/.bashrc`. 
Instead initialise the conda environment using:
``` Bash 
module load Anaconda3
eval "$(conda shell.bash hook)"
```
This should also be used in your batch submission scripts when working with conda environments.

## Jupyter
For Jupyter information please see [JupyterLab](JupyterLab.md)