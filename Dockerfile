FROM debian:jessie

MAINTAINER Huang Rui vowstar@gmail.com

ENV PATH=/opt/xtensa-lx106-elf/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin COMPILE=gcc

RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq \
    && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
        git \
        autoconf \
        build-essential \
        gperf \
        bison \
        flex \
        texinfo \
        libtool \
        libncurses5-dev \
        wget \
        apt-utils \
        gawk \
        sudo \
        unzip \
        libexpat-dev \
        python \
        python-pip \
    && pip install pyserial \
    && rm -rf /opt \
    && git clone --recursive https://github.com/pfalcon/esp-open-sdk.git /opt \
    && adduser --no-create-home --uid 1000 build \
    && usermod -a -G dialout build \
    && echo "build ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/build \
    && chmod 0440 /etc/sudoers.d/build \
    && chown -R build /opt \
    && chgrp -R build /opt

USER build

RUN cd /opt \
    && make STANDALONE=n

USER root

RUN DEBIAN_FRONTEND=noninteractive apt-get purge -yq \
        wget \
    && DEBIAN_FRONTEND=noninteractive apt-get autoremove -yq --purge \
    && DEBIAN_FRONTEND=noninteractive apt-get clean \
    && rm -rf /var/lib/apt/lists/* && rm -rf /tmp1