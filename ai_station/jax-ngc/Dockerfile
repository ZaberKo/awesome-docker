ARG IMAGE_TAG=24.04-py3

FROM nvcr.io/nvidia/jax:${IMAGE_TAG}

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
        neovim curl git tmux htop zsh pipx \
        iproute2 openssh-server iputils-ping dnsutils libgl1 \
        libosmesa6-dev libgl1-mesa-glx libglfw3; \
    rm -rf /var/lib/apt/lists/*

# ssh server
RUN set -eux; \
    mkdir -p /var/run/sshd && \
    sed -i '/PermitRootLogin prohibit-password/c\PermitRootLogin yes' /etc/ssh/sshd_config
EXPOSE 22

RUN pipx ensurepath && \
    pipx install nvitop && \
    pipx install bpytop

# jupyter lab
RUN pip install jupyterlab

ARG JUPYTER_CONFIG_DIR=/root/.jupyter/

RUN mkdir -p $JUPYTER_CONFIG_DIR && \
    wget -P $JUPYTER_CONFIG_DIR https://raw.githubusercontent.com/Winowang/jupyter_gpu/master/jupyter_notebook_config.py && \
    wget -P $JUPYTER_CONFIG_DIR https://raw.githubusercontent.com/Winowang/jupyter_gpu/master/custom.js

# use local script
# COPY ../jupyter_notebook_config.py ../custom.js $JUPYTER_CONFIG_DIR

RUN env | egrep -v "^(HOME=|USER=|MAIL=|LS_COLORS=|LANG=|HOSTNAME=|PWD=|TERM=|SHLVL=|LANGUAGE=|_=|SHELL=)" >> /etc/environment

CMD ["/bin/bash"]