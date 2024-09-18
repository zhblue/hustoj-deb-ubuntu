#!/bin/sh

VERSION=0.0.1
BUILDDIR="/root/hustoj-${VERSION}"
sudo apt-get install debhelper
set -ex \
&& git clone https://github.com/zhblue/hustoj.git \
&& cd hustoj \
&& cd .. \
&& git clone https://github.com/zhblue/hustoj-deb-ubuntu.git \
&& mv hustoj/trunk/* hustoj-deb-ubuntu \
&& cd hustoj-deb-ubuntu && dpkg-buildpackage 


