ARG IMAGE_TAG=24.04-py3

FROM nvcr.io/nvidia/jax:${IMAGE_TAG}


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
    neovim curl git tmux htop zsh pipx \
    iproute2 openssh-server iputils-ping dnsutils; \
    rm -rf /var/lib/apt/lists/*

# ssh server (also for horovod ssh connection)
RUN sed -i "/PermitRootLogin prohibit-password/c\PermitRootLogin yes" /etc/ssh/sshd_config
EXPOSE 22

RUN pipx ensurepath && \
    pipx install nvitop && \
    pipx install bpytop

# fix ssh login envs missing issue
RUN env | egrep -v "^(HOME=|USER=|MAIL=|LS_COLORS=|LANG=|HOSTNAME=|PWD=|TERM=|SHLVL=|LANGUAGE=|_=|SHELL=)" >> /etc/environment

CMD ["/bin/bash"]

