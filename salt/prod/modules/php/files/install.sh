#!/bin/bash

cd /usr/src/
tar xf php-7.2.8.tar.xz
cd php-7.2.8
./configure --prefix=/usr/local/php7  \
--with-config-file-path=/etc \
--enable-fpm \
--enable-inline-optimization \
--disable-debug \
--disable-rpath \
--enable-shared \
--enable-soap \
--with-openssl \
--enable-bcmath \
--with-iconv \
--with-bz2 \
--enable-calendar \
--with-curl \
--enable-exif  \
--enable-ftp \
--with-gd \
--with-jpeg-dir \
--with-png-dir \
--with-zlib-dir \
--with-freetype-dir \
--with-gettext \
--enable-json \
--enable-mbstring \
--enable-pdo \
--with-mysqli=mysqlnd \
--with-pdo-mysql=mysqlnd \
--with-readline \
--enable-shmop \
--enable-simplexml \
--enable-sockets \
--enable-zip \
--enable-mysqlnd-compression-support \
--with-pear \
--enable-pcntl \
--enable-posix && \
make -j $(cat /proc/cpuinfo |grep processor|wc -l) && make install
