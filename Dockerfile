FROM ubuntu
MAINTAINER Huang Rui vowstar@gmail.com

ENV PATH /opt/esp-open-sdk/xtensa-lx106-elf/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin 
ENV COMPILE gcc
RUN apt-get update -qq && \
	apt-get install -yq wget python python-serial srecord make unzip && \
	wget https://github.com/nodemcu/nodemcu-firmware/raw/master/tools/esp-open-sdk.tar.gz && \
	tar -zxvf esp-open-sdk.tar.gz && \
	rm -rf esp-open-sdk.tar.gz && \
	mv esp-open-sdk /opt/ && \
	apt-get remove -yq --purge wget && \
	apt-get autoremove -yq --purge && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && rm -rf /tmp
