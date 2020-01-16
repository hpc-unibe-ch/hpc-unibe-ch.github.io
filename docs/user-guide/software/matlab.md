# Matlab

## Description

UBELIX is always featuring the latest two (b)-releases of Matlab.

## Facts about Matlab on UBELIX

* It **can run in parallel on one node**, thanks to the Parallel Computing ToolBox
* It **can take advantage of GPUs**
* It cannot run on more than one node as we do not have the Distributed Computing Toolbox.

!!! types caution ""
    Matlab is NOT FREE to use! Every user using Matlab on UBELIX must have at least one valid license. You can buy licenses at our [software shop](https://softwareshop.unibe.ch/).


| MATLAB Version: 9.3.0.713579 (R2017b) contains: | MATLAB Version: 9.1.0.441655 (R2016b) contains: |
|-------------------------------------------------|-------------------------------------------------|
|Simulink Version 9.0 (R2017b)|Simulink Version 8.8 (R2016b)|
|Bioinformatics Toolbox Version 4.9 (R2017b)|Communications System Toolbox Version 6.3 (R2016b)|
|Communications System Toolbox Version 6.5 (R2017b)|Computer Vision System Toolbox Version 7.2 (R2016b)|
|Computer Vision System Toolbox Version 8.0 (R2017b)|Computer Vision System Toolbox Version 7.2 (R2016b)
|Control System Toolbox Version 10.3 (R2017b)|Curve Fitting Toolbox Version 3.5.4 (R2016b)|
|Curve Fitting Toolbox Version 3.5.6 (R2017b)|DSP System Toolbox Version 9.3 (R2016b)|
|DSP System Toolbox Version 9.5 (R2017b)|Database Toolbox Version 7.0 (R2016b)|
|Database Toolbox Version 8.0 (R2017b)|Financial Toolbox Version 5.8 (R2016b)|
|Financial Toolbox Version 5.10 (R2017b)|Fixed-Point Designer Version 5.3 (R2016b)|
|Fixed-Point Designer Version 6.0 (R2017b)|Fuzzy Logic Toolbox Version 2.2.24 (R2016b)|
|Fuzzy Logic Toolbox Version 2.3 (R2017b)|Image Acquisition Toolbox Version 5.1 (R2016b)|
|Global Optimization Toolbox Version 3.4.3 (R2017b)|Image Processing Toolbox Version 9.5 (R2016b)|
|Image Acquisition Toolbox Version 5.3 (R2017b)|MATLAB Coder Version 3.2 (R2016b)|
|Image Processing Toolbox Version 10.1 (R2017b)|MATLAB Compiler Version 6.3 (R2016b)|
|Instrument Control Toolbox Version 3.12 (R2017b)|MATLAB Compiler SDK Version 6.3 (R2016b)|
|MATLAB Coder Version 3.4 (R2017b)|Mapping Toolbox Version 4.4 (R2016b)|Model Predictive Control Toolbox Version 5.2.1 (R2016b)|
|MATLAB Compiler Version 6.5 (R2017b)|Neural Network Toolbox Version 9.1 (R2016b)|
|MATLAB Compiler SDK Version 6.4 (R2017b)|Optimization Toolbox Version 7.5 (R2016b)|
|Mapping Toolbox Version 4.5.1 (R2017b)|Parallel Computing Toolbox Version 6.9 (R2016b)|
|Model Predictive Control Toolbox Version 6.0 (R2017b)|Partial Differential Equation Toolbox Version 2.3 (R2016b)|
|Neural Network Toolbox Version 11.0 (R2017b)|Robust Control Toolbox Version 6.2 (R2016b)|
|Optimization Toolbox Version 8.0 (R2017b)|Signal Processing Toolbox Version 7.3 (R2016b)|
|Parallel Computing Toolbox Version 6.11 (R2017b)|Simscape Version 4.1 (R2016b)|
|Partial Differential Equation Toolbox Version 2.5 (R2017b)|Simscape Multibody Version 4.9 (R2016b)|
|Robust Control Toolbox Version 6.4 (R2017b)|Simscape Power Systems Version 6.6 (R2016b)|
|Signal Processing Toolbox Version 7.5 (R2017b)|Simulink Coder Version 8.11 (R2016b)|
|Simscape Version 4.3 (R2017b)|Simulink Control Design Version 4.4 (R2016b)|
|Simscape Multibody Version 5.1 (R2017b)|Simulink Design Optimization Version 3.1 (R2016b)|
|Simscape Power Systems Version 6.8 (R2017b)|Simulink Verification and Validation Version 3.12 (R2016b)|
|Simulink Check Version 4.0 (R2017b)|Stateflow Version 8.8 (R2016b)|
|Simulink Coder Version 8.13 (R2017b)|Statistics and Machine Learning Toolbox Version 11.0 (R2016b)|
|Simulink Control Design Version 5.0 (R2017b)|Symbolic Math Toolbox Version 7.1 (R2016b)|
|Simulink Coverage Version 4.0 (R2017b)|System Identification Toolbox Version 9.5 (R2016b)|
|Simulink Design Optimization Version 3.3 (R2017b)|Wavelet Toolbox Version 4.17 (R2016b)|
|Simulink Requirements Version 1.0 (R2017b)| |
|Stateflow Version 9.0 (R2017b)| |
|Statistics and Machine Learning Toolbox Version 11.2 (R2017b)| | 
|Symbolic Math Toolbox Version 8.0 (R2017b)| |
|System Identification Toolbox Version 9.7 (R2017b)| |
|Wavelet Toolbox Version 4.19 (R2017b)| |


## Running Matlab on the Compute Nodes

Submitting a Matlab job to the cluster is very similar to submitting any other serial job. Lets try to run a simple Matlab script which we will put in a file _boxfilter.m_

boxfilter.m
```Bash
% Compute a local mean filter over a neighborhood of 11x11 pixels

% Read image into workspace:
original = imread('girlface.png');
% Perform the mean filtering:
filtered = imboxfilt(original, 11);
% Save the original and the filtered image side-by-side:
imwrite([original, filtered],'comparison.png');
```

Now we need a submission script

boxfilter.qsub
```Bash
!#/bin/bash
#SBATCH -mail-user=foo@bar.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --job-name=boxfilter
#SBATCH --time=00:10:00
#SBATCH --mem-per-cpu=2G

# Load Matlab form the environment modules
module load matlab/R2015b
# Tell Matlab to run our box filter.m file and exit
matlab -nodisplay -r "boxfilter, exit"
```

### Passing Arguments to a m-File

There are several ways to provide input arguments in Matlab.

#### Define the Variables Before Running the Script

Lets take the box filter.m example from above. The script is not universal because the name of the input image and the box size is hardcoded in the script. We make the script more generally usable by:

**boxfilter.m**

```Bash
% Compute a local mean filter over a neighborhood of 11x11 pixels

% Read image into workspace:
original = imread(inputImg);
% Perform the mean filtering:
filtered = imboxfilt(original, x);
% Save the original and the filtered image side-by-side:
imwrite([original, filtered],'comparison.png');
```

and then:

**boxfilter.qsub**

```Bash
!#/bin/bash
(...)
# Load Matlab form the environment modules
module load matlab/R2015b
# Tell Matlab to run our box filter.m file and exit
matlab -nodisplay -r "inputImg='girlface.png'; x=11; boxfilter, exit"
```

## Advanced Topics

### Multithreading

By default, MATLAB makes use of the multithreading capabilities of the node on which it is running. It is crucial that you allocate the same number of slots for your job as your job utilizes cores.

**Disable Computational Multithreading**

If you do not need multithreading for your application consider to disable computational multithreading by setting the -singleCompThread option when starting MATLAB:

```Bash
matlab -nodisplay -singleCompThread -r "boxfilter('girlface.png', 'comparison.png', 11); exit"
```

**Disable Computational Multithreading**
If you do not need multithreading for your application consider to disable computational multithreading by setting the -singleCompThread option when starting MATLAB:

```Bash
matlab -nodisplay -singleCompThread -r "boxfilter('girlface.png', 'comparison.png', 11); exit"
```

**Running MATLAB in Multithreaded Mode**

Most of the time, running MATLAB in single-threaded mode will meet your needs. If you have mathematically intense computations that might benefit from multi-threading capabilities provided by MATLAB's BLAS implementation, then you should limit MATLAB to a well defined number of threads, so that you can allocate the correct number of slots for your job. Use the maxNumCompThreads(N) function to control the number of computational threads:



