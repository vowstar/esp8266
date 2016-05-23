FROM alpine:edge

MAINTAINER Huang Rui vowstar@gmail.com

ENV PATH /opt/esp-open-sdk/xtensa-lx106-elf/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin 
ENV COMPILE gcc

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk --no-cache add \
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
        libexpat-dev \
    && pip install pyserial
    && adduser crosstoolbbs