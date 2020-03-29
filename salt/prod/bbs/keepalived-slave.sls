include:
  - modules.keepalived.install

keepalived_slave_config:
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://bbs/files/keepalived_slave.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja

keepalived_haproxy_slave_script:
  file.managed:
    - name: /scripts/notify.sh
    - source: salt://bbs/files/notify.sh
    - user: root
    - group: root
    - mode: 755

keepalived_slave_service:
  service.running:
    - name: keepalived
    - enable: True

haproxy_slave_service:
  service.dead:
    - name: haproxy
    - enable: False
