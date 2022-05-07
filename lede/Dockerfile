FROM ubuntu:20.04
LABEL maintainer="zaber" version="20.04"

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

RUN apt update \
    && apt full-upgrade -y
    
RUN apt install -y ack antlr3 asciidoc autoconf automake autopoint binutils bison build-essential \
    bzip2 ccache cmake cpio curl device-tree-compiler fastjar flex gawk gettext gcc-multilib g++-multilib \
    git gperf haveged help2man intltool libc6-dev-i386 libelf-dev libglib2.0-dev libgmp3-dev libltdl-dev \
    libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libreadline-dev libssl-dev libtool lrzsz \
    mkisofs msmtp nano ninja-build p7zip p7zip-full patch pkgconf python2.7 python3 python3-pip qemu-utils \
    rsync scons squashfs-tools subversion swig texinfo uglifyjs upx-ucl unzip vim wget xmlto xxd zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

ARG USERNAME=fubuki

RUN apt install -y sudo && useradd -m -G sudo ${USERNAME}
# RUN git clone https://github.com/coolsnowwolf/lede
USER ${USERNAME}

VOLUME [ "/home/${USERNAME}/lede" ]
WORKDIR /home/${USERNAME}/lede

ENV TERM xterm-256color

