include:
  - init.yum_repo
  - init.zabbix_repo

zabbix-agent:
  pkg.installed

/etc/zabbix/zabbix_agentd.conf:
  file.managed:
    - source: salt://init/files/zabbix_agentd.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      zabbix_server_ip: 172.16.103.128

zabbix-agent-service:
  service.running:
    - name: zabbix-agent
    - enable: True
