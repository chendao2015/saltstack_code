include:
  - modules.redis.install

redis-slave-config:
  file.managed:
    - name: /etc/redis.conf
    - source: salt://modules/redis/files/slave.conf
    - template: jinja
    - defaults:
      IPADDR: {{ grains['fqdn_ip4'][0] }}
      PORT: 6379
      PASS: runtime
      MASTERIP: 172.16.103.129
      MASTERPORT: 6379
      MASTER_PASSWORD: runtime

redis-slave-service:
  service.running:
    - name: redis
    - enable: True
