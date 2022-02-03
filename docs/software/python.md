# Python

## Description

There are multiple versions of Python available on our HPCs. 
On the one hand there are `Python` modules for Python 3 and 2. Which already has a longer list of additional packages installed, including `pip3` respectively `pip`. 
On the other hand there is Anaconda installed, which brings an even longer list of packages with it. 

For Anaconda see [Anaconda page](Anaconda.md)

## Additional Packages

There are additional modules which build on top of Python and provide additional Python packages. E.g. the `SciPy-bundle` provides:

- numpy
- scipy
- mpi4py
- numexpr
- Bottleneck
- pandas
- mpmath and
- deap

Another provided Python package is `TensorFlow`.

If you need additional packages we suggest to install them using either `pip` for Python2 and `pip3` for Python3. 
You can install into your private HOME using the `(pip or pip3) install --user` option or share the packages with your colleges using the Workspace module, e.g. for installing a package `matplotlib`:

```Bash
## load Python first, this can also be `module load Anaconda3`
module load Python
## maybe you need to specify the Workspace name first OR use `Workspace_Home`
module load Workspace  
## pip install in the Workspace or HOME location
##   the variable PYTHONPACKAGEPATH is set in the Workspace module
pip install --prefix $PYTHONPACKAGEPATH matplotlib
```

!!! types attention ""
    Python module need to be loaded before loading Workspace, because some settings require the Python version information.

Therewith the Python packages are automatically available when 
```Bash 
module load Python     ## OR module load Anaconda3
module load Workspace  ## maybe you need to specify the Workspace name first
python -c "import matplotlib"
```
since `$PYTHONPATH` and `$PATH` are set to the above specified location. 

!!! type caution
    if you get the error:
    `ERROR: You must give at least one requirement to install (see "pip help install")`
    you need to reload the Workspace module to properly set the variables. 
    The Workspace module need to have Anaconda3/Python loaded first to read the proper Python Version. 
    `module load Python ## OR module load Anaconda3`
