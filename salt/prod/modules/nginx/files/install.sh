#!/bin/bash

cd /usr/src
tar xf nginx-1.16.1.tar.gz
cd nginx-1.16.1
./configure \
--prefix=/usr/local/nginx \
--user=nginx \
--group=nginx \
--with-debug \
--with-http_ssl_module \
--with-http_realip_module \
--with-http_image_filter_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_stub_status_module \
--http-log-path=/var/log/nginx/access.log \
--error-log-path=/var/log/nginx/error.log && \
make -j $(grep 'processor' /proc/cpuinfo | wc -l) && make install
