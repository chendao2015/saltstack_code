/etc/selinux/config:
  file.managed:
    - source: salt://init/files/selinux_config
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: setenforce 0 || echo 'ok'
