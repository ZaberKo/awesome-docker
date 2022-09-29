FROM nvcr.io/nvidia/pytorch:22.02-py3

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y neovim curl git tmux htop zsh

# ssh server (also for horovod ssh connection)
RUN apt install -y openssh-server && \
    mkdir -p /var/run/sshd && \
    sed -i '/PermitRootLogin prohibit-password/c\PermitRootLogin yes' /etc/ssh/sshd_config && \
    sed -i '/StrictHostKeyChecking/c\    StrictHostKeyChecking no' /etc/ssh/ssh_config


# install on base env
ARG HOROVOD_HOME=/opt/conda

ADD horovod_pytorch.yml horovod_pytorch_requirements.txt horovod_pytorch_env.sh /tmp/conda_env/

# note: currently `conda` is accessible
RUN conda install mamba -n base
RUN set -ex && chmod +x /tmp/conda_env/horovod_pytorch_env.sh && \
    ENV_PREFIX=$HOROVOD_HOME /tmp/conda_env/horovod_pytorch_env.sh /tmp/conda_env/horovod_pytorch.yml
# RUN echo "conda activate ${HOROVOD_HOME}">>/root/.bashrc

# fix ssh login envs missing issue
RUN env | egrep -v "^(HOME=|USER=|MAIL=|LS_COLORS=|LANG=|HOSTNAME=|PWD=|TERM=|SHLVL=|LANGUAGE=|_=|SHELL=)" >> /etc/environment

RUN conda init bash




# locale config
# no need for this base image, already set to utf-8
# export PATH=/opt/conda/lib/python3.8/site-packages/torch_tensorrt/bin:/opt/conda/bin:$PATH

