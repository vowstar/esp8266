FROM alpine:edge

MAINTAINER Huang Rui vowstar@gmail.com

ENV PATH=/opt/xtensa-lx106-elf/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin COMPILE=gcc

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
    && git clone --recursive https://github.com/pfalcon/esp-open-sdk.git /opt \
    && adduser -D -H -u 1000 build \
    && chown -R build /opt \
    && chgrp -R build /opt

USER build

RUN cd /opt \
    && make STANDALONE=n

USER root
