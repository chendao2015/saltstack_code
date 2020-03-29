systemd-devel:
  pkg.installed

haproxy:
  user.present:
    - system: True
    - shell: /sbin/nologin

/usr/src/haproxy-2.1.3.tar.gz:
  file.managed:
    - source: salt://modules/haproxy/files/haproxy-2.1.3.tar.gz
  cmd.run:
    - name: cd /usr/src && tar xf haproxy-2.1.3.tar.gz && cd haproxy-2.1.3 && make clean && make -j $(grep 'processor' /proc/cpuinfo |wc -l) TARGET=linux-glibc USE_OPENSSL=1 USE_ZLIB=1 USE_PCRE=1 USE_SYSTEMD=1 && make install PREFIX=/usr/local/haproxy && cp haproxy  /usr/sbin/ && rm -rf /usr/src/haproxy-2.1.3
    - unless: test -d /usr/local/haproxy

net.ipv4.ip_nonlocal_bind:
  sysctl.present:
    - value: 1
  cmd.run:
    - name: sysctl -p

/etc/haproxy:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755
    - makedirs: True

/etc/haproxy/haproxy.cfg:
  file.managed:
    - source: salt://modules/haproxy/files/haproxy.cfg
    - template: jinja
    - defaults:
      VIP: 172.16.103.250
      ADMIN_STATS_PORT: 8189
      LB_PORT: 80

/usr/lib/systemd/system/haproxy.service:
  file.managed:
    - source: salt://modules/haproxy/files/haproxy.service
  cmd.run:
    - name: systemctl daemon-reload

haproxy_log_config:
  file.append:
    - name: /etc/rsyslog.conf
    - text:
      - local0.*                        /var/log/haproxy.log
  service.running:
    - name: rsyslog
    - enable: True
    - watch:
      - file: haproxy_log_config

haproxy-service:
  service.running:
    - name: haproxy
    - enable: True
