/etc/yum.repos.d/zabbix.repo:
  file.managed:
    - source: salt://init/files/zabbix.repo
