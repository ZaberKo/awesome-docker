FROM nvcr.io/nvidia/pytorch:22.02-py3

RUN apt update && \
    apt install -y neovim curl git tmux htop zsh

# ssh server
RUN apt install -y openssh-server && \
    mkdir -p /var/run/sshd && \
    sed -i '/PermitRootLogin prohibit-password/c\PermitRootLogin yes' /etc/ssh/sshd_config


# jupyter lab
ARG JUPYTER_CONFIG_DIR=/root/.jupyter/

RUN mkdir -p $JUPYTER_CONFIG_DIR && \
    wget -P $JUPYTER_CONFIG_DIR https://raw.githubusercontent.com/Winowang/jupyter_gpu/master/jupyter_notebook_config.py && \
    wget -P $JUPYTER_CONFIG_DIR https://raw.githubusercontent.com/Winowang/jupyter_gpu/master/custom.js


# Add Tini
# ENV TINI_VERSION v0.19.0
# ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
# RUN chmod +x /tini
# ENTRYPOINT ["/tini", "--"]
