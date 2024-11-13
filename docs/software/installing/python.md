[conda]: https://docs.conda.io/en/latest/
[conda-env]: https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#sharing-an-environment
[pip]: https://pip.pypa.io/en/latest/
[pip-virt-env]: https://packaging.python.org/en/latest/tutorials/installing-packages/#creating-virtual-environments
[python]: https://www.python.org/
[scientific-python]: https://scientific-python.org/
[pre-installed]: ../Lmod_modules.md

# Installing Python packages

Over the past decade, the [Python programming language][python] and [Scientific
Python][scientific-python] packages like NumPy, SciPy, JAX, and PyTorch have
gained a lot of popularity in the data science and HPC communities.

A Python installation usually consists of the Python interpreter, the Python
standard library and one or more third party Python packages. Such Python
packages may include both compiled code and a lot of so-called Python modules,
i.e. a lot of small files containing Python code. A typical
[Conda][conda] environment tends to contain tens to hundreds of thousands of
relatively small files filling up your file quota. Additionally, installing
such a large number of small files to our storage can put a lot of strain on the
filesystem and can lead to suboptimal cluster performance.

!!! tip "Expert tip: Use containerized environments"

    In order to circumvent the issue of "lots of tiny files" and potentially
    degraded performance, you can wrap your Python environment in a container
    and run your simulations from within this isolated environment. Note that 
    this approach is especially useful if the Python environment is very static
    and is going to be used over long periods of time!

## Anaconda (`conda`)

[Conda](https://docs.conda.io/en/latest/) is an open source environment and package management system. With Conda you can create independent environments, where you can install applications such as python and R, together with any packages which will be used by these applications. The environments are independent, with the Conda package manager managing the binaries, resolving dependencies, and ensuring that package used in multiple environments are stored only once. In a typical setting, each user has their own installation of a Conda and a set of personal environments.

!!! warning "Generic binaries"

    [Conda][conda] installs generic binaries that may be suboptimal for the performance on UBELIX clusters. In most situations it is recommended to use the [pre-installed libraries][pre-installed] over the version that can be installed from `conda`.

### Channels

Conda [channels](https://docs.conda.io/projects/conda/en/latest/user-guide/concepts/channels.html#what-is-a-conda-channel) are the locations where packages are stored. There are also multiple channels, with some important channels being:

- [`defaults`](https://repo.anaconda.com/pkgs/), the default channel,
- [`anaconda`](https://anaconda.org/anaconda), a mirror of the default channel,
- [`bioconda`](https://anaconda.org/bioconda), a distribution of bioinformatics software, and
- [`conda-forge`](https://anaconda.org/conda-forge), a community-led collection of recipes, build infrastructure, and distributions for the conda package manager.

The most useful channel that comes pre-installed in all distributions, is Conda-Forge. Channels are usually hosted in the [official Anaconda page](https://anaconda.org/), but in some rare occasions [custom channels](https://conda.io/projects/conda/en/latest/user-guide/tasks/create-custom-channels.html) may be used. For instance the [default channel](https://repo.anaconda.com/pkgs/) is hosted independently from the official Anaconda page. Many channels also maintain web pages with documentation both for their usage and for packages they distribute:

- [Default Conda channel](https://docs.anaconda.com/free/anaconda/reference/default-repositories/)
- [Bioconda](https://bioconda.github.io/)
- [Conda-Forge](https://conda-forge.org/)

### Loading the `Anaconda3` module

The `Anaconda3` distribution is provided as a module on UBELIX. To use any
`conda` commands, load the module using

```bash
module load Anaconda3
```

### Using `conda`

When using `conda` the system may complain about:

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

Please do not run `conda init`. Instead initialise the conda environment using:

``` Bash 
module load Anaconda3
eval "$(conda shell.bash hook)"
```

This should also be used in your batch submission scripts when working with conda environments.

### Managing environments

As an example, the creation and use of an environment for pandas jobs is presented. The command,
```bash
conda create --name pandas
```
creates an environment named `pandas`. The environment is activated with the command
```bash
conda activate pandas
```
anywhere in the file system.

Next, install the base R environment package that contains the R program, and any R packages required by the project. To install packages, first ensure that the `pandas` environment is active, and then install any package with the command
```bash
conda install <package_name>
```
all the required packages. Quite often, the channel name must also be specified:
```bash
conda install --channel <channel_name> <package_name>
```
Packages can be found by searching the [conda-forge channel](https://anaconda.org/conda-forge).

```bash
conda install --channel conda-forge pandas
```
will install all the components required to use the *pandas* pacakge in Python. After all the required packages have been installed, the environment is ready for use.

Packages in the conda-forge channel come with instructions for their installation. Quite often the channel is specified in the installation instructions, `-c conda-forge` or `--channel conda-forge`. 

After work in an environment is complete, deactivate the environment,
```bash
conda deactivate
```
to ensure that it does not interfere with any other operations. In contrast to [modules](../Lmod_modules.md), Conda is designed to operate with a single environment active at a time. Create one environment for each project, and Conda will ensure that any package that is shared between multiple environments is installed once.

### Using environments in submission scripts

Since all computationally heavy operations must be performed in compute nodes, Conda environments are also used in jobs submitted to the queuing system. Returning to the pandas example, a submission script running a single core pandas job can use the `pandas` environment as follows:
```
#SBATCH --job-name pandas-test-job
#SBATCH --nodes 1
#SBATCH --ntasks-per-node 1
#SBATCH --cpus-per-task 1
#SBATCH --time=0-02:00:00
#SBATCH --partition epyc2,bdw

echo "Launched at $(date)"
echo "Job ID: ${SLURM_JOBID}"
echo "Node list: ${SLURM_NODELIST}"
echo "Submit dir.: ${SLURM_SUBMIT_DIR}"
echo "Numb. of cores: ${SLURM_CPUS_PER_TASK}"

module load Anaconda3
eval "$(conda shell.bash hook)"

conda activate pandas

python pandas_test.py

conda deactivate
```

### Cleaning up package data

The Conda environment managers download and store a sizable amount of data to provided packages to the various environments. Even though the package data are shared between the various environments, they still consume space in your or your project's account.

There are two main sources of unused data, the compressed archives of the packages that Conda stores in its cache when downloading a package, and the data of removed packages. All unused data can be removed with the command
```bash
conda clean --all
```
that opens up an interactive dialogue with details about the operations performed. You can follow the default option, unless you have manually edited any files in you package data directory (default location `${HOME}/conda`).

!!! info "Updating environments to remove old package versions"
	As we create new environments, we often install the latest version of each package. However, if the environments are not updated regularly, we may end up with different versions of the same package across multiple environments. If we have the same version of a package installed in all environments, we can save space by removing unused older versions.

	To update a package across all environments, use the command
	```bash
	for e in $(conda env list | awk 'FNR>2 {print $1}'); do conda update --name $e <package name>; done
	```

    **WARNING:** Ensure this is really what you want! Sometimes you need a
    specific (older) version of a package in an environment because of
    compatibility!

	After updating packages, the `clean` command can be called to removed the data of unused older package versions.

_Sources_

- [Oficial Conda `clean` documentation](https://docs.conda.io/projects/conda/en/latest/commands/clean.html)
- [Understanding Conda `clean`](https://stackoverflow.com/questions/51960539/where-does-conda-clean-remove-packages-from)

### Pip

In some cases Python packages are not avaible through the conda channels and
need to be installed through pip. In this case simply ensure that `pip` is
indeed set to the `pip` executable within the environment

```bash
which pip
~/.conda/envs/<env name>/bin/pip
```

For instance, assume that a `mkdocs` project requires the following packages:

- `mkdocs`
- `mkdocs-minify-plugin`

The package `mkdocs-minify-plugin` is less popular and thus is is not available though a Conda channel, but it is available in PyPI. Activate your `conda` environment and install the required packages with `pip`

```bash
pip install --upgrade mkdocs mkdocs-minify-plugin
```

inside the environment. The packages will be installed inside a directory that `conda` created for the Conda environment, for instance
```
${HOME}/conda/envs/mkdocs
```
along side packages installed by `conda`. As a results, 'system-wide' installations with `pip` inside a Conda environment do not interfere with system packages.

!!! warning "Do not install packages in Conda environments with pip as a user"
    User installed packages (e.g.`pip install --user --upgrade mkdocs-minify-plugin`) are installed in the same directory for all environments, typically in `~/.local/`, and can interfere with other versions of the same package installed from other Conda environments.

## Python Virtual Environments (virtualenv)

!!! warning "The default Python is the OS Python"
    When you log into UBELIX, running `python` without loading a module or using
    a container will result in using the operating system Python installation.
    This is a Python 3.9 which can't be upgraded!
    Make sure this is what you want before continuing with this section!

Virtualenv is the Pythons native way of isolating a particular python environment from the default one. Each environment resides in a self-contained directory, so multiple virtualenvs can co-exist side by side with different versions of tools or dependencies installed. The downside of this approach is that the Python version can't be changed. If you need to be able to run specific versions of Python, please use the [Conda] installation method.

### Creating a virtualenv

We can create a virtualenv:

```bash
python -m venv --system-site-packages venvs/venv-for-demo
```

or

```bash
virtualenv --system-site-packages venvs/venv-for-demo
```

We recommend that, as in the example above, to use the `--system-site-packages` option. This ensures that already installed packages are used.

### Using a virtualenv

To use a virtualenv it is necessary to activate it:

```bash
source venvs/venv-for-demo/bin/activate
(venv-for-demo) [user@cluster:~]$
```

Once activated the prompt changes and any Python related commands that follow will refer to the Python installation and packages contained/linked in the virtualenv.

### Installing new packages

To install packages in the virtualenv it needs to be activated, and while it is active any packages installed with pip will be actually installed inside the virtualenv itself:

```bash
source venvs/venv-for-demo/bin/activate
(venv-for-demo) [user@cluster:~]$ pip install biopython
```

### Stop using a virtualenv

To stop using a virtualenv one needs to deactivate it:

```bash
(venv-for-demo) [user@cluster:~]$ deactivate
[user@cluster:~]$
```

### Removing a virtualenv

To permanently remove a virtualenv one simply deletes the directory which contains it.

```bash
rm -rf venvs/venv-for-demo/
```

## Discouraged installation methods

We strongly discourage installing Python packages
directly through the OS Python with `pip` without using virtual environments as
described above.
