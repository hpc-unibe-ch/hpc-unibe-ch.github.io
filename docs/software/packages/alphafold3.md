# AlphaFold3

AlphaFold3 is a cutting-edge AI system developed by DeepMind for predicting protein structures with high accuracy. Building on its predecessors, AlphaFold3 integrates additional molecular modeling capabilities, making it a powerful tool for structural biology research.

This guide provides step-by-step instructions on setting up and running AlphaFold3 on UBELIX using Slurm.

## Directory Structure Setup

Before running AlphaFold3, set up the necessary directory structure.

1. Choose a suitable location for AlphaFold3. For example:
   ```bash
   export AF3_ROOT=~/alphafold3/
   ```
2. Create the required directories:
   ```bash
   mkdir -p $AF3_ROOT
   mkdir -p $AF3_ROOT/input             # Store input JSON files
   mkdir -p $AF3_ROOT/output            # Store generated structure outputs
   mkdir -p $AF3_ROOT/model_parameters  # Store downloaded model parameters
   mkdir -p $AF3_ROOT/databases         # Store public databases
   ```

## Cloning the AlphaFold3 Repository

Clone the official AlphaFold3 source code from GitHub:

```bash
cd $AF3_ROOT
git clone https://github.com/google-deepmind/alphafold3.git src
```

## Creating the Slurm Submission Script

Create a Slurm submission script (e.g., `run_alphafold3.sh`) for running AlphaFold3 on a GPU node.

1. Navigate to the project directory:
   ```bash
   cd $AF3_ROOT
   ```
2. Create `run_alphafold3.sh` and add the following content:
   ```bash
   #!/bin/bash
   #SBATCH --job-name="alphafold3_job"
   #SBATCH --time=01:00:00
   #SBATCH --partition=gpu
   #SBATCH --gres=gpu:rtx4090:1
   #SBATCH --cpus-per-task=16
   #SBATCH --mem-per-cpu=5760M

   module load CUDA/12.6

   singularity exec \
        --nv \
        --bind $PWD/input:/root/af_input \
        --bind $PWD/output:/root/af_output \
        --bind $PWD/model_parameters:/root/models \
        --bind $PWD/databases:/root/public_databases \
        /storage/software/singularity/containers/alphafold3.sif \
        python src/run_alphafold.py \
        --json_path=/root/af_input/fold_input.json \
        --model_dir=/root/models \
        --db_dir=/root/public_databases \
        --output_dir=/root/af_output
   ```
4. Save and close the file

## Downloading Public Databases

AlphaFold3 requires publicly available databases for structure prediction.

!!! danger "Danger: Very large databases"

    The AlphaFold3 databases are nearly 650GB in size. To avoid redundant downloads and conserve storage, it is recommended that a single copy be maintained in a shared workspace for the entire lab. Check with colleagues and supervisors if a copy of the databases is already accessible to you!

    === "Link existing databases"

        If the public databases are already available, simply create a symbolic
        link to their location:

        ```bash
        cd $AF3_ROOT
        ln -s /path/to/workspace/databases databases
        ```

    === "Install databases to shared workspace"

        1. Navigate to the shared workspace to store the dabases, e.g.:
           ```bash
           cd /path/to/workspace/alphafold3/databases
           ```
        2. Download the database fetch script:
           ```bash
           wget https://raw.githubusercontent.com/google-deepmind/alphafold3/refs/heads/main/fetch_databases.sh
           ```
        3. Make the script executable and run it:
           ```bash
           chmod u+x fetch_databases.sh
           ./fetch_databases.sh databases
           ```
         4. Continue with lining existing databases
           ```bash
           cd $AF3_ROOT
           ln -s /path/to/workspace/databases databases
           ```

    === "Install databases to user home "

        1. Navigate to the AlphaFold3 project directory:
           ```bash
           cd $AF3_ROOT
           ```
        2. Download the database fetch script:
           ```bash
           wget https://raw.githubusercontent.com/google-deepmind/alphafold3/refs/heads/main/fetch_databases.sh
           ```
        3. Make the script executable and run it:
           ```bash
           chmod u+x fetch_databases.sh
           ./fetch_databases.sh databases
           ```

## Downloading Model Parameters

AlphaFold3 model parameters need to be downloaded separately. To request access to the model parameters, please complete this [form](https://forms.gle/svvpY4u2jsHEwWYS6). Access will be granted at Google DeepMind’s sole discretion. You may only use AlphaFold 3 model parameters if received directly from Google. Use is subject to these [terms of use](https://github.com/google-deepmind/alphafold3/blob/main/WEIGHTS_TERMS_OF_USE.md).

Ensure they are stored in the `model_parameters` directory:

```bash
cd $AF3_ROOT/model_parameters
# Download and extract model parameters following official AlphaFold3 instructions.
```

## Preparing Input File

AlphaFold3 requires a JSON input file containing sequence and configuration details. Create an input file at `input/fold_input.json`:

Example:

```json
{
  "name": "2PV7",
  "sequences": [
    {
      "protein": {
        "id": ["A", "B"],
        "sequence": "GMRESYANENQFGFKTINSDIHKIVIVGGYGKLGGLFARYLRASGYPISILDREDWAVAESILANADVVIVSVPINLTLETIERLKPYLTENMLLADLTSVKREPLAKMLEVHTGAVLGLHPMFGADIASMAKQVVVRCDGRFPERYEWLLEQIQIWGAKIYQTNATEHDHNMTYIQALRHFSTFANGLHLSKQPINLANLLALSSPIYRLELAMIGRLFAQDAELYADIIMDKSENLAVIETLKQTYDEALTFFENNDRQGFIDAFHKVRDWFGDYSEQFLKESRQLLQQANDLKQG"
      }
    }
  ],
  "modelSeeds": [1],
  "dialect": "alphafold3",
  "version": 1
}
```

## Submitting the Job

Once everything is set up, submit the job to Slurm:

```bash
sbatch run_alphafold3.sh
```

## Output Location

Once the job is complete, the predicted structures will be available in:

```
$AF3_ROOT/output/
```

