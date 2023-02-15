FROM nvcr.io/nvidia/pytorch:22.10-py3
# note: >22.10 nvidia changes to not using conda

ENV TZ=Asia/Shanghai

RUN set -ex && \
    sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list && \
    sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list

RUN set -ex; \
    apt update;  \
    DEBIAN_FRONTEND=noninteractive apt install -y \
        neovim curl git tmux htop zsh iproute2 openssh-server; \
    rm -rf /var/lib/apt/lists/*

# ssh server (also for horovod ssh connection)
RUN sed -i '/PermitRootLogin prohibit-password/c\PermitRootLogin yes' /etc/ssh/sshd_config

# install on base env
ARG HOROVOD_HOME=/opt/conda

ADD horovod_pytorch.yml horovod_pytorch_requirements.txt horovod_pytorch_env.sh /tmp/conda_env/

# note: currently `conda` is accessible
RUN conda init && conda install mamba -n base -c conda-forge
RUN set -ex && chmod +x /tmp/conda_env/horovod_pytorch_env.sh && \
    ENV_PREFIX=$HOROVOD_HOME /tmp/conda_env/horovod_pytorch_env.sh /tmp/conda_env/horovod_pytorch.yml
# RUN echo "conda activate ${HOROVOD_HOME}">>/root/.bashrc

# fix ssh login envs missing issue
RUN env | egrep -v "^(HOME=|USER=|MAIL=|LS_COLORS=|LANG=|HOSTNAME=|PWD=|TERM=|SHLVL=|LANGUAGE=|_=|SHELL=)" >> /etc/environment

CMD ["/bin/bash"]

