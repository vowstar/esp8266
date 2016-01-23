FROM ubuntu
MAINTAINER Huang Rui vowstar@gmail.com

ENV PATH /opt/esp-open-sdk/xtensa-lx106-elf/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin 
ENV COMPILE gcc
RUN apt-get update -qq
RUN apt-get install -yq wget python srecord make
RUN wget https://github.com/nodemcu/nodemcu-firmware/raw/master/tools/esp-open-sdk.tar.gz
RUN tar -zxvf esp-open-sdk.tar.gz
RUN rm -rf esp-open-sdk.tar.gz
RUN mv esp-open-sdk /opt/
RUN apt-get remove -yq --purge wget
RUN apt-get autoremove -yq --purge
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* && rm -rf /tmp
