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
PHP_VER=`apt-cache search php-fpm|grep -e '[[:digit:]]\.[[:digit:]]' -o`
if [ "$PHP_VER" = "" ] ; then PHP_VER="8.1"; fi
for pkg in net-tools make g++ php$PHP_VER-fpm nginx php$PHP_VER-mysql php$PHP_VER-common php$PHP_VER-gd php$PHP_VER-zip php$PHP_VER-mbstring php$PHP_VER-xml php$PHP_VER-curl php$PHP_VER-intl php$PHP_VER-xmlrpc php$PHP_VER-soap php-yaml php-apcu tzdata
do
        while ! sudo apt-get install -y "$pkg"
        do
                sudo dpkg --configure -a
                sudo apt-get install -f
                echo "Network fail, retry... you might want to change another apt source for install"
        done
done
sudo dpkg -i *.deb || sudo apt-get install -f -y
exit 0
