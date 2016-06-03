# Espressif ESP8266, ESP8285 build environment
[![Docker Pulls](https://img.shields.io/docker/pulls/vowstar/esp8266.svg)](https://hub.docker.com/r/vowstar/esp8266/) [![Docker Stars](https://img.shields.io/docker/stars/vowstar/esp8266.svg)](https://hub.docker.com/r/vowstar/esp8266/) [![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/vowstar/esp8266/blob/master/LICENSE)

It is a build environment of espressif's esp8266 and esp8285.

## Usage
### Install Docker
[Follow the instructions at https://docs.docker.com/engine/installation/](https://docs.docker.com/engine/installation/)

### Run

Execute some command under this docker image

``docker run --rm -ti -v `pwd`:$(somewhere) vowstar/esp8266 $(somecommand)``

For example

``docker run --rm -ti -v `pwd`:/build vowstar/esp8266 /bin/bash``

This can mount host's `` `pwd` `` to container's `` /build `` path.

### Programming Hardware

You could use Host's searial port to programming hardware, such as esp8266,esp32,nemu,device++, etc.

If you want flash espxx in docker's container, you can export host's serial ports to container, privileged permission needed.

The parameters is  ``-v /dev/host:/dev/container``

For example

``sudo docker run --rm -ti --privileged -v /dev/ttyUSB0:/dev/ttyUSB0 -v `pwd`:/build vowstar/esp8266 /bin/bash``

This can export host's `` /dev/ttyUSB0 `` in container's `` /dev/ttyUSB0 ``.

And then, use container's esptool to program it.

For esp8266

``esptool -cc esp8266 -cp /dev/ttyUSB0 -cd nodemcu -ca 0x00000 -cf 00000.bin -ca 0x40000 -cf 40000.bin``

For esp32

``esptool -cc esp32 -cp /dev/ttyUSB0 -cd nodemcu -ca 0x00000 -cf 00000.bin -ca 0x40000 -cf 40000.bin``

## boot2docker under VM

If you run docker under a VM, such as [Oracle VM VirtualBox](https://www.virtualbox.org/), the host's serial port and folder should share to VM
 image first. You may need share host's USB device which used as serial adapter to VM image, a VirtualBox Extension Pack is needed for USB 2.0 and USB 3.0 devices.

## Build From Scratch

If you want build from scratch, please use [Dockerfile-From-Scratch](https://github.com/vowstar/esp8266/blob/master/Dockerfile-From-Scratch)

## Thanks
This docker image uses [esp-open-sdk](https://github.com/pfalcon/esp-open-sdk). Thanks to the maintainer and creator [Paul Sokolovsky](http://pfalcon-oe.blogspot.com/) who contributed it.

This Dockerfile is learn [Marcel Stör](https://github.com/marcelstoer)'s [docker-nodemcu-build](https://github.com/marcelstoer/docker-nodemcu-build) who contributed the NodeMCU online building service.

The toolchain comes from:
- [Arduino ESP8266 project](https://github.com/esp8266/Arduino/blob/master/README.md)
- [Arduino ESP32 project](https://github.com/me-no-dev/ESP31B)

The program tool [esptool-ck](https://github.com/igrr/esptool-ck) by Christian Klippel, which can programming both esp8266,esp8285 and esp32.
