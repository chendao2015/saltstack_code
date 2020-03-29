include:
  - modules.mysql.master

master-grant:
  cmd.run:
    - name: /usr/local/mysql/bin/mysql -uroot -pwangqing123! -e "GRANT REPLICATION SLAVE,SUPER ON *.* to 'repl'@'172.16.103.%' identified by 'repl123'"
    - unless: /usr/local/mysql/bin/mysql -urepl -prepl123 -h 172.16.103.129 -e "exit"
