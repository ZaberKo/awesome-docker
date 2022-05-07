FROM pytorch/pytorch:1.8.0-cuda11.1-cudnn8-devel
LABEL maintainer="zaberchann" version="1.8.0"

# ENV UID=1000
# ENV GID=1000
# ENV USERNAME=zaber

# # add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
# RUN groupadd -r redis && useradd -r -g redis redis

# USER ${USERNAME}

RUN apt-get update \
    && apt-get install -y vim curl git


ARG WORKSPACE_DIR=/workspace
ARG HOMEDIR=/home/${USERNAME}

USER ${USERNAME}
WORKDIR ${WORKSPACE_DIR}

RUN mkdir ${HOMEDIR}/software \
    && cd ${HOMEDIR}/software \
    && git clone https://github.com/NVIDIA/apex \
    && cd apex \
    && pip install -v --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" ./

RUN pip install matplotlib seaborn

# ENTRYPOINT ["./entrypoint.sh"] 