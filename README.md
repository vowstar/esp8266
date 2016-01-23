# Docker NodeMCU build
[![Docker Pulls](https://img.shields.io/docker/pulls/vowstar/esp8266.svg)](https://hub.docker.com/r/vowstar/esp8266/) [![Docker Stars](https://img.shields.io/docker/stars/vowstar/esp8266.svg)](https://hub.docker.com/r/vowstar/esp8266/) [![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/vowstar/esp8266/blob/master/LICENSE)

It is a build environment of espressif's esp8266 and esp8285.

## Usage
### Install Docker
Follow the instructions at https://docs.docker.com/installation.

### Run

Execute some command under this docker image

``docker run --rm -ti -v `pwd`:$(somewhere) vowstar/esp8266 $(somecommand)``

For example

``docker run --rm -ti -v `pwd`:/build vowstar/esp8266 /bin/bash``

## Thanks
This docker image uses [esp-open-sdk](https://github.com/pfalcon/esp-open-sdk). Thanks to the maintainer and creator [Paul Sokolovsky](http://pfalcon-oe.blogspot.com/) who contributed it.

