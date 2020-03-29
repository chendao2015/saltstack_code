yum_for_php:
  file.managed:
    - name: /tmp/remi-release-7.rpm
    - source: salt://application/php/files/remi-release-7.rpm
  cmd.run:
    - name: rpm -Uvh /tmp/remi-release-7.rpm --nodeps && yum makecache --enablerepo=remi
    - unless: rpm -qa|grep remi-release
  pkg.installed:
    - name: php72-php-mysqlnd
    - require:
      - cmd: yum_for_php

php_download:
  file.managed:
    - name: /usr/src/php-7.2.8.tar.xz
    - source: salt://application/php/files/php-7.2.8.tar.xz

php_install:
  file.managed:
    - name: /tmp/php_install.sh
    - source: salt://application/php/files/install.sh
  cmd.run:
    - name: /bin/bash /tmp/php_install.sh
    - unless: test -d /usr/local/php7

/etc/profile.d/php7.sh:
  file.managed:
    - source: salt://application/php/files/php7.sh

php-config:
  cmd.run:
    - name: cp /usr/src/php-7.2.8/php.ini-production /etc/php.ini && cp /usr/local/php7/etc/php-fpm.conf.default /usr/local/php7/etc/php-fpm.conf && cp /usr/local/php7/etc/php-fpm.d/www.conf.default /usr/local/php7/etc/php-fpm.d/www.conf

/usr/lib/systemd/system/php-fpm.service:
  file.managed:
    - source: salt://application/php/files/php-fpm.service
  cmd.run:
    - name: systemctl daemon-reload

php-service:
  service.running:
    - name: php-fpm
    - enable: True
