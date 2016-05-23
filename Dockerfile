FROM alpine:latest

MAINTAINER Huang Rui vowstar@gmail.com

ENV PATH /opt/esp-open-sdk/xtensa-lx106-elf/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin 
ENV COMPILE gcc

RUN apk --no-cache add \
        autoconf \
        automake \
        bison \
        bzip2 \
        flex \
        g++ \
        gawk \
        gcc \
        git \
        gperf \
        libtool \
        make \
        ncurses-dev \
        expat-dev \
        nano \
        python \
        py-pip \
        sed \
        texinfo \
        unrar \
        unzip \
        help2man \
        wget \
        expat-dev \
    && pip install pyserial \
    && mkdir -p /opt/crosstool \
    && adduser -D -H -u 1000 build \
    && chown -R build /opt/crosstool \
    && chgrp -R build /opt/crosstool

USER build

RUN cd /opt/crosstool \
    && git clone -b lx106 https://github.com/jcmvbkbc/crosstool-NG.git crosstool-NG \
    && cd crosstool-NG \
    && ./bootstrap \
    && ./configure --prefix=`pwd` \
    && make -j`nproc` \
    && make install \
    && ./ct-ng xtensa-lx106-elf \
    && ./ct-ng build 
