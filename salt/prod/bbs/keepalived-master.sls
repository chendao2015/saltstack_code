include:
  - modules.keepalived.install

keepalived_master_config:
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://bbs/files/keepalived_master.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja

/scripts/check_haproxy.sh:
  file.managed:
    - source: salt://bbs/files/check_haproxy.sh
    - user: root
    - group: root
    - mode: 755

keepalived_haproxy_master_script:
  file.managed:
    - name: /scripts/notify.sh
    - source: salt://bbs/files/notify.sh
    - user: root
    - group: root
    - mode: 755

keepalived_master_service:
  service.running:
    - name: keepalived
    - enable: True
