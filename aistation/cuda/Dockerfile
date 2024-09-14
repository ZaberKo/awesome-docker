ARG IMAGE_TAG=12.4.1-cudnn-devel-ubuntu22.04

FROM nvcr.io/nvidia/cuda:${IMAGE_TAG}

ENV TZ=Asia/Shanghai

RUN set -ex && \
    sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list

RUN set -ex; \
    apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    neovim curl git tmux htop zsh pipx \
    iproute2 openssh-server iputils-ping dnsutils libgl1 && \
    rm -rf /var/lib/apt/lists/*

RUN set -ex; \
    pipx ensurepath && \
    pipx install nvitop && \
    pipx install bpytop

ARG INSTALL_MAMBA=true

# note: install mambaforge
RUN if [ ${INSTALL_MAMBA} = true ]; then \
    set -ex; \
    wget -O Miniforge3.sh  "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh" && \
    bash Miniforge3.sh -b && \
    rm Miniforge3.sh && \
    ~/miniforge3/bin/mamba init; \
    fi


# see https://gitlab.com/nvidia/container-images/cuda/-/blob/master/README.md#ld_library_path-notice
# ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

# ssh server
RUN set -eux; \
    mkdir -p /var/run/sshd && \
    sed -i '/PermitRootLogin prohibit-password/c\PermitRootLogin yes' /etc/ssh/sshd_config
EXPOSE 22

# fix ssh login envs missing issue
RUN env | egrep -v "^(HOME=|USER=|MAIL=|LS_COLORS=|LANG=|HOSTNAME=|PWD=|TERM=|SHLVL=|LANGUAGE=|_=|SHELL=)" >> /etc/environment

CMD ["/bin/bash"]

