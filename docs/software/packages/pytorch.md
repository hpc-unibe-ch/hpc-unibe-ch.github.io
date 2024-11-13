[python-install]: ../installing/python.md

# PyTorch

[PyTorch](https://pytorch.org) is an open source Python package that provides tensor computation, like NumPy, with GPU acceleration and deep neural networks built on a tape-based autograd system.

PyTorch can be installed by following the [official instructions](https://pytorch.org/get-started/locally/) for installing a CUDA compatible PyTorch via pip or conda. Please consult the [Python packages installation guide][python-install] for an overview of recommended ways to manage Python installations on UBELIX. 

If you install pre-built binaries (using either pip or conda) then you do not need load any CUDA modules on UBELIX before installing PyTorch. This is because PyTorch, unless compiled from source, is always delivered with a copy of the CUDA library if a CUDA capable version is installed.

## Install PyTorch using conda

To install any version of PyTorch request an interactive job on a GPU node:

```bash
salloc --time=01:00:00 --partition=gpu --gres=gpu/rtx4090:1 --cpus-per-task=16 --mem-per-cpu=4G
srun --pty bash
```
This will result in a shell directly on a GPU node.

### Install the latest version

```bash
module load Anaconda3
eval "$(conda shell.bash hook)"

conda create -n pytorch python=3.9 -c conda-forge
conda activate pytorch
conda install pytorch::pytorch torchvision torchaudio -c pytorch
```

You can verify the detection of a GPU in your PyTorch installation the following
command:

```bash
python3 -c "import torch; print(torch.cuda.is_available())"
```

### Install a previous version

To install a previous version of Pytorch, follow the general procedure above but check for the specific commands in the
[official documentation](https://pytorch.org/get-started/previous-versions/).

## Install PyTorch through pip

As an alternative to `conda` you can install PyTorch directly through `pip`.
Please see our documentation on [installing Python
packages](../installing/python.md) for general advise on `pip` and follow the
[official instruction](https://pytorch.org/get-started/locally/) to install
PyTorch.

