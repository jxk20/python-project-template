# Hash: f0af74665be0
FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
ENV LANG C.UTF-8
ENV cwd="/home/"
WORKDIR $cwd
RUN rm -rf /var/lib/apt/lists/* \
    /etc/apt/sources.list.d/cuda.list \
    /etc/apt/sources.list.d/nvidia-ml.list

RUN apt-get update && \
    # ==================================================================
    # tools
    # ------------------------------------------------------------------
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential \
    apt-utils \
    ca-certificates \
    wget \
    git \
    nano \
    curl \
    && \
    # ==================================================================
    # python 3.8
    # ------------------------------------------------------------------
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    software-properties-common \
    && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    python3.8 \
    python3.8-dev \
    python3-distutils-extra \
    && \
    wget -O ~/get-pip.py \
    https://bootstrap.pypa.io/get-pip.py && \
    python3.8 ~/get-pip.py && \
    ln -s /usr/bin/python3.8 /usr/local/bin/python3 && \
    ln -s /usr/bin/python3.8 /usr/local/bin/python

# ==================================================================
# Time zones
# ------------------------------------------------------------------
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata python3-tk
ENV TZ=Asia/Singapore
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


# ==================================================================
# python packages
# ------------------------------------------------------------------
RUN python -m pip --no-cache-dir install --upgrade \
    setuptools


# Other libraries
RUN python -m pip --no-cache-dir install --upgrade \
    protobuf==3.13.0 \
    boto3==1.14.56 \
    # Code Quality
    pylint==2.6.0 \
    pytest==6.2.5 \
    pytest-cov==3.0.0 \
    pytest-mock==3.7.0 \
    black==22.3.0 \
    radon==5.1.0 \
    mypy==0.942 \
    # Mypy type stubs
    types-PyYAML \
    types-requests \
    types-setuptools \

    # ==================================================================
    # config & cleanup
    # ------------------------------------------------------------------

    RUN ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*


ENV NVIDIA_DRIVER_CAPABILITIES=all



#####################3

