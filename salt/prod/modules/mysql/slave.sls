include:
  - modules.mysql.install

mysql-slave-config:
  file.managed:
    - name: /etc/my.cnf.d/slave.cnf
    - source: salt://modules/mysql/files/slave.cnf
    - user: root
    - group: root
    - mode: 644

mysql-slave-service:
  service.running:
    - name: mysqld
    - enable: True
