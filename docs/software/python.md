# Python

## Description

Some useful information on using Python.

## Advanced Topics

### Managing Virtual Environments, Versions with Anaconda

Anaconda is a high performance distribution of Python that includes the most popular packages for data science (numpy, scipy,...). It also features conda, a package, dependency and environment manager. With Anaconda you can run multiple versions of Python in isolated environments.

#### Installing Anaconda

1. Download the appropriate installer for the default Python environment. You can install other Python versions later by creating additional environments (see below):

**Python 2.7**

```Bash
$ wget http://repo.continuum.io/archive/Anaconda2-5.3.1-Linux-x86_64.sh
```

or


**Python 3.7**

```Bash
$ wget http://repo.continuum.io/archive/Anaconda3-5.3.1-Linux-x86_64.sh
```

2. Run the installer and follow the instructions:

**Python 2.7**

```Bash
$ bash Anaconda2-5.3.1-Linux-x86_64.sh
```

or

**Python 3.7**

```Bash
$ bash Anaconda3-5.3.1-Linux-x86_64.sh
```

This will create a default environment with the selected version of Python and adds numerous packages to the environment. After prepending the Anaconda bin directory to the path open a new terminal for the change to become active.

3. Test the installation by listing all installed packages:

```Bash
$ conda list
```
