FROM ubuntu:16.04

MAINTAINER Huang Rui vowstar@gmail.com

ENV PATH=/opt/xtensa-lx106-elf/bin:/opt/xtensa-esp108-elf/bin:/opt/xtensa-esp32-elf/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin COMPILE=gcc

RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq \
    && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
        git \
        gcc \
        python2.7 \
        python-pip \
        python-serial \
        libncurses-dev \
        flex \
        bison \
        gperf \
        make \
        wget \
        unzip \
    && git clone --recursive https://github.com/vowstar/xtensa-toolchain.git /opt/xtensa-toolchain \
    && cd /opt/xtensa-toolchain \
    && tar -zxvf xtensa-lx106-elf-linux64.tar.gz -C /opt/ \
    && tar -zxvf xtensa-esp108-elf-linux64.tar.gz -C /opt/ \
    && tar -zxvf xtensa-esp32-elf-linux64.tar.gz -C /opt/ \
    && cp -rf /opt/xtensa-toolchain/library/esp8266/* /opt/xtensa-lx106-elf/xtensa-lx106-elf/sysroot/lib/ \
    && cp -rf /opt/xtensa-toolchain/include/xtensa/* /opt/xtensa-lx106-elf/xtensa-lx106-elf/include/xtensa/ \
    && git clone --recursive https://github.com/igrr/esptool-ck.git /opt/esptool-ck \
    && cd /opt/esptool-ck \
    && make \
    && mv /opt/esptool-ck/esptool /usr/local/bin/ \
    && cd /opt \
    && rm -rf /opt/xtensa-toolchain \
    && rm -rf /opt/esptool-ck \
    && pip install esptool \
    && DEBIAN_FRONTEND=noninteractive apt-get purge -yq \
        -h \
    && DEBIAN_FRONTEND=noninteractive apt-get autoremove -yq --purge \
    && DEBIAN_FRONTEND=noninteractive apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*
