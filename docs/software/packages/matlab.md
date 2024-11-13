# MATLAB

UBELIX is featuring a recent release of MATLAB.

## Facts about MATLAB on UBELIX

* It **can run in parallel on one node**, thanks to the Parallel Computing ToolBox
* It **can take advantage of GPUs**
* It cannot run on more than one node as we do not have the Distributed Computing Toolbox.

## Running MATLAB on the Compute Nodes

Submitting a MATLAB job to the cluster is very similar to submitting any other serial job. Lets try to run a simple MATLAB script which we will put in a file _boxfilter.m_

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

boxfilter.sh
```Bash
#!/bin/bash
#SBATCH --mail-user=foo@bar.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --job-name=boxfilter
#SBATCH --time=00:10:00
#SBATCH --mem-per-cpu=2G

# Load MATLAB form the environment modules
module load MATLAB
# Tell MATLAB to run our box filter.m file and exit
matlab -nodisplay -r "boxfilter, exit"
```

### Passing Arguments to a m-File

There are several ways to provide input arguments in MATLAB.

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
#!/bin/bash
(...)
# Load MATLAB form the environment modules
module load MATLAB
# Tell MATLAB to run our box filter.m file and exit
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

## Infos about featured MATLAB

```
-----------------------------------------------------------------------------------------------------
MATLAB Version: 9.11.0.1769968 (R2021b)
MATLAB License Number: 40639324
Operating System: Linux 3.10.0-1160.76.1.el7.x86_64 #1 SMP Wed Aug 10 16:21:17 UTC 2022 x86_64
Java Version: Java 1.8.0_202-b08 with Oracle Corporation Java HotSpot(TM) 64-Bit Server VM mixed mode
-----------------------------------------------------------------------------------------------------
MATLAB                                                Version 9.11        (R2021b)
Simulink                                              Version 10.4        (R2021b)
5G Toolbox                                            Version 2.3         (R2021b)
AUTOSAR Blockset                                      Version 2.5         (R2021b)
Aerospace Blockset                                    Version 5.1         (R2021b)
Aerospace Toolbox                                     Version 4.1         (R2021b)
Antenna Toolbox                                       Version 5.1         (R2021b)
Audio Toolbox                                         Version 3.1         (R2021b)
Automated Driving Toolbox                             Version 3.4         (R2021b)
Bioinformatics Toolbox                                Version 4.15.2      (R2021b)
Communications Toolbox                                Version 7.6         (R2021b)
Computer Vision Toolbox                               Version 10.1        (R2021b)
Control System Toolbox                                Version 10.11       (R2021b)
Curve Fitting Toolbox                                 Version 3.6         (R2021b)
DDS Blockset                                          Version 1.1         (R2021b)
DSP System Toolbox                                    Version 9.13        (R2021b)
Database Toolbox                                      Version 10.2        (R2021b)
Datafeed Toolbox                                      Version 6.1         (R2021b)
Deep Learning HDL Toolbox                             Version 1.2         (R2021b)
Deep Learning Toolbox                                 Version 14.3        (R2021b)
Econometrics Toolbox                                  Version 5.7         (R2021b)
Embedded Coder                                        Version 7.7         (R2021b)
Filter Design HDL Coder                               Version 3.1.10      (R2021b)
Financial Instruments Toolbox                         Version 3.3         (R2021b)
Financial Toolbox                                     Version 6.2         (R2021b)
Fixed-Point Designer                                  Version 7.3         (R2021b)
Fuzzy Logic Toolbox                                   Version 2.8.2       (R2021b)
GPU Coder                                             Version 2.2         (R2021b)
Global Optimization Toolbox                           Version 4.6         (R2021b)
HDL Coder                                             Version 3.19        (R2021b)
HDL Verifier                                          Version 6.4         (R2021b)
Image Acquisition Toolbox                             Version 6.5         (R2021b)
Image Processing Toolbox                              Version 11.4        (R2021b)
Instrument Control Toolbox                            Version 4.5         (R2021b)
LTE Toolbox                                           Version 3.6         (R2021b)
Lidar Toolbox                                         Version 2.0         (R2021b)
MATLAB Coder                                          Version 5.3         (R2021b)
MATLAB Compiler                                       Version 8.3         (R2021b)
MATLAB Compiler SDK                                   Version 6.11        (R2021b)
MATLAB Report Generator                               Version 5.11        (R2021b)
Mapping Toolbox                                       Version 5.2         (R2021b)
Mixed-Signal Blockset                                 Version 2.1         (R2021b)
Model Predictive Control Toolbox                      Version 7.2         (R2021b)
Motor Control Blockset                                Version 1.3         (R2021b)
Navigation Toolbox                                    Version 2.1         (R2021b)
Optimization Toolbox                                  Version 9.2         (R2021b)
Parallel Computing Toolbox                            Version 7.5         (R2021b)
Partial Differential Equation Toolbox                 Version 3.7         (R2021b)
Phased Array System Toolbox                           Version 4.6         (R2021b)
Powertrain Blockset                                   Version 1.10        (R2021b)
Predictive Maintenance Toolbox                        Version 2.4         (R2021b)
RF Blockset                                           Version 8.2         (R2021b)
RF PCB Toolbox                                        Version 1.0         (R2021b)
RF Toolbox                                            Version 4.2         (R2021b)
ROS Toolbox                                           Version 1.4         (R2021b)
Radar Toolbox                                         Version 1.1         (R2021b)
Reinforcement Learning Toolbox                        Version 2.1         (R2021b)
Risk Management Toolbox                               Version 1.10        (R2021b)
Robotics System Toolbox                               Version 3.4         (R2021b)
Robust Control Toolbox                                Version 6.11        (R2021b)
Satellite Communications Toolbox                      Version 1.1         (R2021b)
Sensor Fusion and Tracking Toolbox                    Version 2.2         (R2021b)
SerDes Toolbox                                        Version 2.2         (R2021b)
Signal Integrity Toolbox                              Version 1.0         (R2021b)
Signal Processing Toolbox                             Version 8.7         (R2021b)
SimBiology                                            Version 6.2         (R2021b)
SimEvents                                             Version 5.11        (R2021b)
Simscape                                              Version 5.2         (R2021b)
Simscape Driveline                                    Version 3.4         (R2021b)
Simscape Electrical                                   Version 7.6         (R2021b)
Simscape Fluids                                       Version 3.3         (R2021b)
Simscape Multibody                                    Version 7.4         (R2021b)
Simulink 3D Animation                                 Version 9.3         (R2021b)
Simulink Check                                        Version 5.2         (R2021b)
Simulink Code Inspector                               Version 4.0         (R2021b)
Simulink Coder                                        Version 9.6         (R2021b)
Simulink Compiler                                     Version 1.3         (R2021b)
Simulink Control Design                               Version 6.0         (R2021b)
Simulink Coverage                                     Version 5.3         (R2021b)
Simulink Design Optimization                          Version 3.10        (R2021b)
Simulink Design Verifier                              Version 4.6         (R2021b)
Simulink PLC Coder                                    Version 3.5         (R2021b)
Simulink Report Generator                             Version 5.11        (R2021b)
Simulink Requirements                                 Version 1.8         (R2021b)
Simulink Test                                         Version 3.5         (R2021b)
SoC Blockset                                          Version 1.5         (R2021b)
Stateflow                                             Version 10.5        (R2021b)
Statistics and Machine Learning Toolbox               Version 12.2        (R2021b)
Symbolic Math Toolbox                                 Version 9.0         (R2021b)
System Composer                                       Version 2.1         (R2021b)
System Identification Toolbox                         Version 9.15        (R2021b)
Text Analytics Toolbox                                Version 1.8         (R2021b)
UAV Toolbox                                           Version 1.2         (R2021b)
Vehicle Dynamics Blockset                             Version 1.7         (R2021b)
Vehicle Network Toolbox                               Version 5.1         (R2021b)
Vision HDL Toolbox                                    Version 2.4         (R2021b)
WLAN Toolbox                                          Version 3.3         (R2021b)
Wavelet Toolbox                                       Version 6.0         (R2021b)
Wireless HDL Toolbox                                  Version 2.3         (R2021b)
```

