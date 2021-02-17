# CUDA

## Description

Libraries for parallel programm on NVIDIA GPUs. 

## run only

If you only want to use the CUDA with your already compiled application you only need to load:
```Bash
module load CUDA
```

## compile applications

CUDA has restriction in supported compilers. E.g. CUDA/10.1.243 is not compatible with GCC/9.3.9
We suggest to load complete toolchains, e.g. 
```Bash
module load fosscuda
```
This provides beside CUDA and GCC also OpenMPI, OpenBLAS, FFTW, ScaLAPACK and others. 

