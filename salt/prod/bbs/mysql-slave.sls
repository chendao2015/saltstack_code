include:
  - modules.mysql.slave

/tmp/start_slave.sh:
  file.managed:
    - source: salt://bbs/files/start_slave.sh
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: /bin/bash /tmp/start_slave.sh
    - unless: /usr/local/mysql/bin/mysql -uroot -pwangqing123! -e 'show slave status\G' 2>/dev/null|grep 'Running:'|grep 'Yes'
