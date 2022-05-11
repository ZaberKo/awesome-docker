FROM nvcr.io/nvidia/pytorch:22.04-py3

EXPOSE 22

RUN apt update && \
    apt install -y neovim curl git tmux htop zsh iproute2 openssh-server
    
RUN sed -i '/PermitRootLogin prohibit-password/c\PermitRootLogin yes' /etc/ssh/sshd_config
    # mkdir -p /var/run/sshd 



RUN conda install mamba -n base
RUN set -ex && \
    git clone https://github.com/ZaberKo/conda-envs.git /root/conda-envs && \
    mamba env create -f /root/conda-envs/rllib-gpu-nocache.yml

# fix ssh login envs missing issue
RUN env | egrep -v "^(HOME=|USER=|MAIL=|LS_COLORS=|LANG=|HOSTNAME=|PWD=|TERM=|SHLVL=|LANGUAGE=|_=|SHELL=)" >> /etc/environment

VOLUME [ "/root/workspace" ]
WORKDIR /root/workspace


CMD ["/bin/bash"]