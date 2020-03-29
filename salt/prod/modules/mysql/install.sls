libaio:
  pkg.installed:
    - pkgs:
      - libaio-devel
      - libaio

mysql_user:
  user.present:
    - name: mysql
    - shell: /sbin/nologin
    - system: True
    - uid: 306

mysql_group:
  group.present:
    - name: mysql
    - gid: 306
    - system: True
    - addusers:
      - mysql

mysql_install:
  file.managed:
    - name: /usr/src/mysql-5.7.22-linux-glibc2.12-x86_64.tar.gz
    - source: salt://modules/mysql/files/mysql-5.7.22-linux-glibc2.12-x86_64.tar.gz
  cmd.run:
    - name: cd /usr/src && tar xf mysql-5.7.22-linux-glibc2.12-x86_64.tar.gz -C /usr/local/
    - unless: test -d /usr/local/mysql-5.7.22-linux-glibc2.12-x86_64

/usr/local/mysql:
  file.symlink:
    - target: mysql-5.7.22-linux-glibc2.12-x86_64
    - user: mysql
    - group: mysql
    - recurse:
      - user
      - group

/etc/profile.d/mysql.sh:
  file.managed:
    - source: salt://modules/mysql/files/mysql.sh

/opt/data:
  file.directory:
    - user: mysql
    - group: mysql
    - makedirs: True

/var/log/mysql:
  file.directory:
    - user: mysql
    - group: mysql
    - makedirs: True

mysql_initialize:
  cmd.run:
    - name: /usr/local/mysql/bin/mysqld --initialize --user=mysql --datadir=/opt/data/ &> /tmp/mysql_pass && touch /etc/my.cnf.d/mysql.lock
    - unless: test -f /etc/my.cnf.d/mysql.lock

/usr/local/include/mysql:
  file.symlink:
    - target: /usr/local/mysql/include

/etc/ld.so.conf.d/mysql.conf:
  file.managed:
    - source: salt://modules/mysql/files/mysql.conf
  cmd.run:
    - name: ldconfig

/etc/my.cnf:
  file.managed:
    - source: salt://modules/mysql/files/my.cnf

/usr/lib/systemd/system/mysqld.service:
  file.managed:
    - source: salt://modules/mysql/files/mysqld.service
  cmd.run:
    - name: systemctl daemon-reload

mysql-service:
  service.running:
    - name: mysqld
    - enable: True

mysql-master_setpassword:
  cmd.run:
    - name: tmp_pass=$(grep password /tmp/mysql_pass |awk '{print $NF}') && /usr/local/mysql/bin/mysql -uroot -p"$tmp_pass" -e 'set password=password("wangqing123!");' --connect-expired-password
    - unless: /usr/local/mysql/bin/mysql -uroot -p'wangqing123!' -e 'exit'
