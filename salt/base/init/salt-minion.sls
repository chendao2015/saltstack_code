include:
  - init.yum_repo
  - init.salt_repo

salt-minion-install:
  pkg.installed:
    - name: salt-minion

/etc/salt/minion:
  file.managed:
    - source: salt://init/files/minion
    - user: root
    - group: root
    - mode: 640
    - template: jinja
    - defaults:
      MASTER_IP: 172.16.103.128

salt-minion-service:
  service.running:
    - name: salt-minion
    - enable: True
