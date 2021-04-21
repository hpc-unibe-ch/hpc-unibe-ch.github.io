# Python

## Description
there are multiple versions of Pyhton available on our HPCs. 
On the one hand there are `Python` modules for Python 2 and 3. Which already has a longer list of additional packages installed, including `pip`. 
On the other hand there is Anaconda installed, which brings an even longer list of packages with it. 

For Anaconda see [Anaconda page](Anaconda.md)

## Additional Packages
If you need additional packages we suggest to install them using `pip`. 
You can install into your private HOME using the `pip install --user` option or share the packages with your colleges using the Workspace module, e.g. for installing a package `matplotlib`:

```Bash
## load Python first, this can also be `module load Anaconda3`
module load Python
## maybe you need to specify the Workspace name first OR use `Workspace/home`
module load Workspace  
## pip install in the Workspace or HOME location
##   the variable PYTHONPACKAGEPATH is set in the Workspace module
pip install --prefix $PYTHONPACKAGEPATH matplotlib
```

Therewith the Python packages are automatically available when 
```Bash 
module load Python     ## OR module load Anaconda3
module load Workspace  ## maybe you need to specify the Workspace name first
python -c "import matplotlib"
```
since `$PYTHONPATH` and `$PATH` are set to the above specified location. 
