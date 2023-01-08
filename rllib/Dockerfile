FROM nvcr.io/nvidia/pytorch:22.08-py3

EXPOSE 22

ENV TZ=Asia/Shanghai

RUN set -ex && \
    sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list && \
    sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list


# opencv: libgl1
# mujoco: libosmesa6-dev libgl1-mesa-glx libglfw3
RUN set -ex; \
    apt update;  \
    DEBIAN_FRONTEND=noninteractive apt install -y \
        neovim curl git tmux htop zsh iproute2 openssh-server libgl1 \
        libosmesa6-dev libgl1-mesa-dev libgl1-mesa-glx libglfw3 patchelf; \
    rm -rf /var/lib/apt/lists/*



RUN sed -i '/PermitRootLogin prohibit-password/c\PermitRootLogin yes' /etc/ssh/sshd_config
# mkdir -p /var/run/sshd 

ARG MACHINE_TYPE=gpu
# ARG MACHINE_TYPE=cpu

# install rllib
RUN conda install mamba -n base
RUN set -ex; \
    git clone https://github.com/ZaberKo/conda-envs.git /root/conda-envs; \
    mamba env create -f /root/conda-envs/rllib/rllib-nocache-${MACHINE_TYPE}.yaml
RUN echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/.mujoco/mjpro150/bin' >> /root/.bashrc
RUN conda init && echo "conda activate rllib" >> /root/.bashrc

# fix ssh login envs missing issue
RUN env | egrep -v "^(HOME=|USER=|MAIL=|LS_COLORS=|LANG=|HOSTNAME=|PWD=|TERM=|SHLVL=|LANGUAGE=|_=|SHELL=)" >> /etc/environment


VOLUME [ "/root/workspace" ]
VOLUME [ "/root/.mujoco" ]
VOLUME [ "/root/ray_results" ]
WORKDIR /root/workspace

CMD ["/bin/bash"]