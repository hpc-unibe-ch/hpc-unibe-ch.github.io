# TensorFlow

Deep learning framework for Python.

There are two options availble to install TensorFlow on UBELIX:

- Install Tensorflow using CUDA and cuDNN from UBELIX software stack
- Install Tensorflow using CUDA from pip-extras

## Install Tensorflow using CUDA and cuDNN from UBELIX software stack (recommended)

This approach uses for UBELIX optimised installations of CUDA and cuDNN and therefore theoretically provides superior performance.

In order to use CUDA and cuDNN modules from the UBELIX software stack with
TensorFlow we need to find a matching version of Tensorflow:

- List available CUDA and cuDNN version as modules with `module spider`
- Find matching Tensorflow version [here](https://www.tensorflow.org/install/source#tested_build_configurations)

Currently the following versions are supported:

| Tensorflow Version | CUDA version | cuDNN version |
| ------------------ | ------------ | ------------- |
| tensorflow-2.14.0  | CUDA/11.8.0  | 8.7.0.84      |
| tensorflow-2.15.0  | CUDA/12.2.0  | 8.9.2.26      |

To install either of these version request an interactive job on a GPU node:

```bash
salloc --time=01:00:00 --partition=gpu --gres=gpu/rtx4090:1 --cpus-per-task=16 --mem-per-cpu=4G
srun --pty bash
```
This will result in a shell directly on a GPU node.

### Install tensorflow-2.14.0
```bash
module load CUDA/11.8.0
module load cuDNN/8.7.0.84-CUDA-11.8.0

module load Anaconda3
eval "$(conda shell.bash hook)"

conda create -n tf214 python=3.9 -c conda-forge
conda activate tf214
pip install tensorflow==2.14.0
```

### Install tensorflow-2.15.0
```bash
module load CUDA/12.2.0
module load cuDNN/8.9.2.26-CUDA-12.2.0

module load Anaconda3
eval "$(conda shell.bash hook)"

conda create -n tf215 python=3.9 -c conda-forge
conda activate tf215
pip install tensorflow==2.15.0
```

### Check the installation

To check if the installation of TensorFlow was successful we can check if a GPU
is detected:

```bash
python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"
```

!!! note "Other versions"

    Other versions might work as well, i.e TensorFlow 2.17 with CUDA 12.2. However we advise against this practice as these unsupported configurations tend to break more easilly and are harder to debug. If you need a different version of TensorFlow, please follow the approach below.

## Install Tensorflow using CUDA from pip-extras

If you need to install a different version of TensorFlow that isn't available
for the CUDA and cuDNN module version on UBELIX you can use a CUDA installation
from TensorFlow pip extras that match your required Tensorflow version:

To install either of these version request an interactive job on a GPU node:

```bash
salloc --time=01:00:00 --partition=gpu --gres=gpu/rtx4090:1 --cpus-per-task=16 --mem-per-cpu=4G
srun --pty bash
```
This will result in a shell directly on a GPU node.

### Install tensorflow-2.17.0
```bash
module load Anaconda3
eval "$(conda shell.bash hook)"

conda create -n tf217 python=3.9 -c conda-forge
conda activate tf217
pip install "tensorflow[and-cuda]==2.17.0"
```

Again, we can verify the installation using the command:

```bash
python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"
```

This will throw the following error messages but detects the GPU and works as expected:

```
E external/local_xla/xla/stream_executor/cuda/cuda_fft.cc:485] Unable to register cuFFT factory: Attempting to register factory for plugin cuFFT when one has already been registered
E external/local_xla/xla/stream_executor/cuda/cuda_dnn.cc:8454] Unable to register cuDNN factory: Attempting to register factory for plugin cuDNN when one has already been registered
E external/local_xla/xla/stream_executor/cuda/cuda_blas.cc:1452] Unable to register cuBLAS factory: Attempting to register factory for plugin cuBLAS when one has already been registered
```

### Install tensorflow-2.16.1

```bash
module load Anaconda3
eval "$(conda shell.bash hook)"

conda create -n tf216 python=3.9 -c conda-forge
conda activate tf216
pip install "tensorflow[and-cuda]==2.16.1"
```

Due to a bug in this TensorFlow version, the following code needs to executed
every time before Tensorflow is used:

```bash
NVIDIA_DIR=$(dirname $(dirname $(python -c "import nvidia.cudnn;print(nvidia.cudnn.__file__)")))
for dir in $NVIDIA_DIR/*; do
    if [ -d "$dir/lib" ]; then
        export LD_LIBRARY_PATH="$dir/lib:$LD_LIBRARY_PATH"
    fi
done
```

After this, we can again verify the installation using the command:

```bash
python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"
```

## License
TensorFlow is licensed under Apache License 2.0.
