FROM ubuntu:14.04

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
        help2man \
        python2.7 \
        python2.7-dev \
        python-serial \
    && rm -rf /opt \
    && git clone --recursive https://github.com/pfalcon/esp-open-sdk.git /opt \
    && useradd -M -s /bin/bash -u 1000 build \
    && usermod -a -G dialout build \
    && echo "build ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/build \
    && chmod 0440 /etc/sudoers.d/build \
    && chown -R build /opt \
    && chgrp -R build /opt \
    && cd /opt \
    && su build -c "make STANDALONE=n" \
    && rm -rf $(ls /opt/ | grep -v xtensa-lx106-elf) \
    && DEBIAN_FRONTEND=noninteractive apt-get purge -yq \
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
        unzip \
        libexpat-dev \
        help2man \
        python2.7-dev \
    && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
        make \
    && DEBIAN_FRONTEND=noninteractive apt-get autoremove -yq --purge \
    && DEBIAN_FRONTEND=noninteractive apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*