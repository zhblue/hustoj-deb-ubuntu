#!/bin/sh

sudo apt autoremove -y --purge needrestart
sudo apt-get update 
sudo apt-get -y upgrade
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y universe
sudo add-apt-repository -y multiverse
sudo add-apt-repository -y restricted
sudo apt-get install debhelper
set -ex \
&& git clone https://github.com/zhblue/hustoj.git \
&& git clone https://github.com/zhblue/hustoj-deb-ubuntu.git \
&& mv hustoj/trunk/* hustoj-deb-ubuntu \
&& cd hustoj-deb-ubuntu && dpkg-buildpackage 
cd ..
sudo dpkg -i *.deb || sudo apt-get install -f -y
exit 0
