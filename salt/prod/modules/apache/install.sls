apache-install:
  pkg.installed:
    - name: httpd

/etc/httpd/conf/httpd.conf:
  file.managed:
    - source: salt://modules/apache/files/httpd.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      IPADDR: {{ grains['fqdn_ip4'][0] }}
      PORT: 8081

/etc/httpd/conf.d/httpd-vhosts.conf:
  file.managed:
    - source: salt://modules/apache/files/httpd-vhosts.conf
    - user: root
    - group: root
    - mode: 644

php-testPage:
  file.managed:
    - name: /var/www/html/index.php
    - source: salt://modules/apache/files/index.php
    - user: root
    - group: root
    - mode: 644

apache-service:
  service.running:
    - name: httpd
    - enable: True
    - require:
      - pkg: apache-install
