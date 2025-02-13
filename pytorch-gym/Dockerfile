# Ubuntu 20.04, py3.8, pytorch 1.13, cuda 11.7,1
FROM nvcr.io/nvidia/pytorch:22.08-py3

ENV TZ=Asia/Shanghai

RUN set -eux; \
    apt update; \
    DEBIAN_FRONTEND=noninteractive apt install -y ca-certificates; \
    rm -rf /var/lib/apt/lists/*

RUN set -ex && \
    sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list

RUN set -ex; \
    apt update;  \
    DEBIAN_FRONTEND=noninteractive apt install -y \
        neovim curl git tmux htop zsh iproute2 openssh-server iputils-ping dnsutils \
        ffmpeg unzip libsm6 libxext6 ninja-build libglib2.0-0 libsm6 libxrender-dev libxext6 \
        libosmesa6-dev libgl1-mesa-dev libgl1-mesa-glx libglfw3 patchelf; \
    rm -rf /var/lib/apt/lists/*


# install mujoco1.5
RUN set -ex && \
    mkdir /root/.mujoco && cd /root/.mujoco/ && \
    wget https://www.roboti.us/download/mjpro150_linux.zip && \
    unzip mjpro150_linux.zip && \
    rm mjpro150_linux.zip && \
    wget https://roboti.us/file/mjkey.txt

# LD_LIBRARY_PATH is declared in pytorch image, so it is safe to append to it
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/.mujoco/mjpro150/bin

# install gym
RUN pip install "cython<3" "numpy<2" "gym[mujoco,atari,accept-rom-license]==0.21.0"

# ssh server (also for horovod ssh connection)
RUN sed -i '/PermitRootLogin prohibit-password/c\PermitRootLogin yes' /etc/ssh/sshd_config
EXPOSE 22


# fix ssh login envs missing issue
RUN env | egrep -v "^(HOME=|USER=|MAIL=|LS_COLORS=|LANG=|HOSTNAME=|PWD=|TERM=|SHLVL=|LANGUAGE=|_=|SHELL=)" >> /etc/environment

CMD ["/bin/bash"]

