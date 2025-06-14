FROM ubuntu:24.04
LABEL maintainer="zaber" version="24.04"

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

RUN set -eux; \
    apt update; \
    apt install -y ca-certificates; \
    rm -rf /var/lib/apt/lists/*

# COPY sources.list /etc/apt/sources.list
RUN set -ex && \
    sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
    
RUN set -eux; \
    apt update && apt full-upgrade -y; \
    yes | unminimize; \
    apt install -y git neovim; \
    apt install -y ack antlr3 asciidoc autoconf automake autopoint binutils bison build-essential \
        bzip2 ccache clang cmake cpio curl device-tree-compiler flex gawk gcc-multilib g++-multilib gettext \
        genisoimage git gperf haveged help2man intltool libc6-dev-i386 libelf-dev libfuse-dev libglib2.0-dev \
        libgmp3-dev libltdl-dev libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libpython3-dev \
        libreadline-dev libssl-dev libtool llvm lrzsz msmtp ninja-build p7zip p7zip-full patch pkgconf \
        python3 python3-pyelftools python3-setuptools qemu-utils rsync scons squashfs-tools subversion \
        swig texinfo uglifyjs upx-ucl unzip vim wget xmlto xxd zlib1g-dev; \
    apt install -y sudo gosu; \
    gosu nobody true; \
    rm -rf /var/lib/apt/lists/*

ENV UID=1000
ENV GID=1000
ENV USERNAME=fubuki
ENV WORKDIR="/openwrt"
ENV TERM=xterm-256color

VOLUME ["${WORKDIR}"]

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

CMD ["/bin/bash"]
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
