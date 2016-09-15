# ESP32, ESP8266 and ESP8285 build environment
[![Docker Pulls](https://img.shields.io/docker/pulls/vowstar/esp8266.svg)](https://hub.docker.com/r/vowstar/esp8266/) [![Docker Stars](https://img.shields.io/docker/stars/vowstar/esp8266.svg)](https://hub.docker.com/r/vowstar/esp8266/) [![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/vowstar/esp8266/blob/master/LICENSE)

It is a build environment of espressif's Wi-Fi(or bluetooth) Soc.

## Overview

### Chip support

- ESP8266
- ESP8285
- ESP31B
- ESP32 series

ESP8268 and ESP8689 not tested yet.

### Tools

- xtensa-lx106-elf toolchain
- xtensa-esp108-elf toolchain
- xtensa-esp32-elf toolchain
- esptool-ck
- python and pyserial

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

``docker run --name build --rm -ti --device /dev/ttyUSB0:/dev/ttyUSB0 -v `pwd`:/build vowstar/esp8266 /bin/bash``

The ``--device`` flag can export a host device in container without privileged mode.

This can export host's `` /dev/ttyUSB0 `` in container's `` /dev/ttyUSB0 ``.

And then, use container's esptool to program it.

For esp8266

``esptool -cc esp8266 -cp /dev/ttyUSB0 -cd nodemcu -ca 0x00000 -cf 00000.bin -ca 0x40000 -cf 40000.bin``

For esp32

``esptool -cc esp32 -cp /dev/ttyUSB0 -cd nodemcu -ca 0x00000 -cf 00000.bin -ca 0x40000 -cf 40000.bin``

## Special

### Export all device to container

It may dangerous

``docker run --name build --rm -ti --privileged -v /dev/ttyUSB0:/dev/ttyUSB0 -v `pwd`:/build vowstar/esp8266 /bin/bash``

The ``--privileged`` flag can export all host device in container. May by you like ``--device`` flag to limit container access.

### Build esp firmware On Windows/OS X

If you run docker under a VM, such as [Oracle VM VirtualBox](https://www.virtualbox.org/), the host's serial port and folder should share to VM
 image first. You may need share host's USB device which used as serial adapter to VM image, a VirtualBox Extension Pack is needed for USB 2.0 and USB 3.0 devices.

For example, Mount `` D:\ `` drive on Windows using docker-machine in git bash

- Share host's `` D:\ `` drive to docker linux images in VirtualBox, and name shared name `` d ``
- Start docker image using docker machine `` docker-machine start default `` or other way
- Mount vboxsf file-system using command below

`` docker-machine ssh default "sudo mkdir /d && sudo mount -t vboxsf -o uid=1000,gid=50 d /d" ``

And then, you can play 

`` docker run --rm -ti -v /d/xxx:/build -w "/build" --env "SDK_BASE=/build/ESP_RTOS_SDK/" vowstar/esp8266 bash ``

`` /d/xxx `` is the host path, `` /build `` is the container PATH, use `` --env `` flag can pass some environment variable in container, such as SDK_PATH and BIN_PATH by espressif. Also you can pass something like `` --env APP=1 --env SPI_SIZE_MAP=2 --env BOOT=new `` for custom and special build.

Finally, `` make `` and use esptool to program it. Before programming, make sure the host usb to serial adapter is assigned to VirtualBox's linux image.

OSX is much easier, also need do same work on VirtualBox.

Also, you can build it with ESP-IDF for esp32 by define IDF_PATH environment:

``docker run -ti --name esp-builder --env IDF_PATH="/build/esp-idf" --device /dev/ttyUSB0:/dev/ttyUSB0  -v ~/Projects/2016/esp8266:/build vowstar/esp8266 /bin/bash``

### Build Dockerfile From Scratch

If you want build from scratch, please use [Dockerfile-From-Scratch](https://github.com/vowstar/esp8266/blob/master/Dockerfile-From-Scratch)

## Thanks
This docker image uses [esp-open-sdk](https://github.com/pfalcon/esp-open-sdk). Thanks to the maintainer and creator [Paul Sokolovsky](http://pfalcon-oe.blogspot.com/) who contributed it.

This Dockerfile is learn [Marcel Stör](https://github.com/marcelstoer)'s [docker-nodemcu-build](https://github.com/marcelstoer/docker-nodemcu-build) who contributed the NodeMCU online building service.

The toolchain comes from:
- [Arduino ESP8266 project](https://github.com/esp8266/Arduino/blob/master/README.md)
- [Arduino ESP32 project](https://github.com/me-no-dev/ESP31B)

The program tool [esptool-ck](https://github.com/igrr/esptool-ck) by Christian Klippel, which can programming both esp8266,esp8285 and esp32.
