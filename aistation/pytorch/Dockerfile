FROM nvcr.io/nvidia/pytorch:23.03-py3

EXPOSE 22

ENV TZ=Asia/Shanghai

RUN set -eux; \
    apt update; \
    DEBIAN_FRONTEND=noninteractive apt install -y ca-certificates; \
    rm -rf /var/lib/apt/lists/*

RUN set -ex && \
    sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list


# opencv: libgl1
# mujoco: libosmesa6-dev libgl1-mesa-glx libglfw3
RUN set -ex; \
    apt update;  \
    DEBIAN_FRONTEND=noninteractive apt install -y \
        neovim curl git tmux htop zsh iproute2 openssh-server libgl1 \
        libosmesa6-dev libgl1-mesa-glx libglfw3; \
    rm -rf /var/lib/apt/lists/*

# ssh server
RUN apt install -y openssh-server && \
    mkdir -p /var/run/sshd && \
    sed -i '/PermitRootLogin prohibit-password/c\PermitRootLogin yes' /etc/ssh/sshd_config


# jupyter lab
ARG JUPYTER_CONFIG_DIR=/root/.jupyter/

RUN mkdir -p $JUPYTER_CONFIG_DIR && \
    wget -P $JUPYTER_CONFIG_DIR https://raw.githubusercontent.com/Winowang/jupyter_gpu/master/jupyter_notebook_config.py && \
    wget -P $JUPYTER_CONFIG_DIR https://raw.githubusercontent.com/Winowang/jupyter_gpu/master/custom.js

# use local script
# COPY ../jupyter_notebook_config.py ../custom.js $JUPYTER_CONFIG_DIR



RUN env | egrep -v "^(HOME=|USER=|MAIL=|LS_COLORS=|LANG=|HOSTNAME=|PWD=|TERM=|SHLVL=|LANGUAGE=|_=|SHELL=)" >> /etc/environment
