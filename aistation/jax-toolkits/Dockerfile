FROM ghcr.io/nvidia/jax:jax

ENV TZ=Asia/Shanghai

RUN set -ex && \
    sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list

RUN set -ex; \
    apt update;  \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    build-essential clang cmake lld vim python-is-python3 python3-pip wget \
    neovim curl git tmux htop zsh pipx \
    iproute2 openssh-server iputils-ping dnsutils libgl1; \
    rm -rf /var/lib/apt/lists/*

RUN set -ex; \
    pipx ensurepath && \
    pipx install nvitop && \
    pipx install bpytop

# ssh server
RUN set -eux; \
    mkdir -p /var/run/sshd && \
    sed -i '/PermitRootLogin prohibit-password/c\PermitRootLogin yes' /etc/ssh/sshd_config
EXPOSE 22

# fix ssh login envs missing issue
RUN env | egrep -v "^(HOME=|USER=|MAIL=|LS_COLORS=|LANG=|HOSTNAME=|PWD=|TERM=|SHLVL=|LANGUAGE=|_=|SHELL=)" >> /etc/environment

CMD ["/bin/bash"]

