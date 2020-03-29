include:
  - modules.mysql.install

mysql-master-config:
  file.managed:
    - name: /etc/my.cnf.d/master.cnf
    - source: salt://modules/mysql/files/master.cnf
    - user: root
    - group: root
    - mode: 644

mysql-master-service:
  service.running:
    - name: mysqld
    - enable: True
