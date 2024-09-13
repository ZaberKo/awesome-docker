ARG IMAGE_TAG=12.4.1-cudnn-devel-ubuntu22.04


FROM nvcr.io/nvidia/cuda:${IMAGE_TAG}

ENV TZ=Asia/Shanghai

RUN set -ex && \
    sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list

RUN set -ex; \
    apt update;  \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    neovim curl git tmux htop zsh pipx \
    iproute2 openssh-server iputils-ping dnsutils libgl1; \
    rm -rf /var/lib/apt/lists/*

# ssh server
RUN set -eux; \
    mkdir -p /var/run/sshd && \
    sed -i '/PermitRootLogin prohibit-password/c\PermitRootLogin yes' /etc/ssh/sshd_config
EXPOSE 22

RUN set -ex; \
    pipx ensurepath && \
    pipx install nvitop && \
    pipx install bpytop

ARG INSTALL_MAMBA=false

# note: install mambaforge
RUN if [ ${INSTALL_MAMBA} = true ]; then \
    set -ex; \
    wget -O Miniforge3.sh  "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh" && \
    bash Miniforge3.sh -b && \
    rm Miniforge3.sh && \
    ~/miniforge3/bin/mamba init; \
    fi

# install pyenv compile deps
RUN set -ex; \
    apt update;  \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev curl git \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev; \
    rm -rf /var/lib/apt/lists/*

# install pyenv
RUN set -ex; curl https://pyenv.run | bash
# setup pyenv
RUN set -ex; \
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc && \
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc && \
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc && \
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile && \
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile && \
    echo 'eval "$(pyenv init -)"' >> ~/.profile

# install jax
ARG JAXHUB_VENV_NAME=jaxhub
ARG JAXHUB_PYTHON_VERSION=3.10
SHELL ["/bin/bash", "-l", "-c"]
RUN set -ex; \
    pyenv install ${JAXHUB_PYTHON_VERSION} && \
    pyenv virtualenv ${JAXHUB_PYTHON_VERSION} ${JAXHUB_VENV_NAME} && \
    pyenv global ${JAXHUB_VENV_NAME} && \
    LD_LIBRARY_PATH=/usr/local/cuda/lib64 pip install --upgrade "jax[cuda12_local]" jupyterlab

# ARG JUPYTER_CONFIG_DIR=/root/.jupyter/

# RUN mkdir -p $JUPYTER_CONFIG_DIR && \
#     wget -P $JUPYTER_CONFIG_DIR https://raw.githubusercontent.com/Winowang/jupyter_gpu/master/jupyter_notebook_config.py && \
#     wget -P $JUPYTER_CONFIG_DIR https://raw.githubusercontent.com/Winowang/jupyter_gpu/master/custom.js
    

# fix ssh login envs missing issue
RUN env | egrep -v "^(HOME=|USER=|MAIL=|LS_COLORS=|LANG=|HOSTNAME=|PWD=|TERM=|SHLVL=|LANGUAGE=|_=|SHELL=)" >> /etc/environment

CMD ["/bin/bash"]

