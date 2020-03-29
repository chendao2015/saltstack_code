redis-install:
  file.managed:
    - name: /usr/src/redis-5.0.5.tar.gz
    - source: salt://modules/redis/files/redis-5.0.5.tar.gz
  cmd.run:
    - name: cd /usr/src && tar xf redis-5.0.5.tar.gz && cd redis-5.0.5 && make install
    - unless: test -f /usr/local/bin/redis-server

/etc/redis.conf:
  file.managed:
    - source: salt://modules/redis/files/redis.conf
    - template: jinja
    - defaults:
      IPADDR: {{ grains['fqdn_ip4'][0] }}
      PORT: 6379
      PASS: runtime

/usr/lib/systemd/system/redis.service:
  file.managed:
    - source: salt://modules/redis/files/redis.service
  cmd.run:
    - name: systemctl daemon-reload

redis_transparent_hugepage:
  file.append:
    - name: /etc/rc.local
    - text:
      - echo never > /sys/kernel/mm/transparent_hugepage/enabled
  cmd.run:
    - name: echo never > /sys/kernel/mm/transparent_hugepage/enabled && /usr/bin/chmod a+x /etc/rc.d/rc.local

redis-service:
  service.running:
    - name: redis
    - enable: True
