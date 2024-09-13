#!/bin/bash --login

set -exo pipefail


conda_envfile=${1-"horovod_pytorch.yml"}

# set relevant build variables for horovod
export NCCL_HOME=$ENV_PREFIX
export HOROVOD_CUDA_HOME=$CUDA_HOME
export HOROVOD_NCCL_HOME=$NCCL_HOME
export HOROVOD_NCCL_LINK=SHARED
export HOROVOD_GPU_OPERATIONS=NCCL

# create the conda environment
if [ -x "$(command -v mamba)" ]
then
    mamba env update -n base --file $conda_envfile 
else
    conda env update -n base --file $conda_envfile 
fi