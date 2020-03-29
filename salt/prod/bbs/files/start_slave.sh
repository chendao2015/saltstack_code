#!/bin/bash
master_ip=172.16.103.129
mysql=/usr/local/mysql/bin/mysql
user=repl
pass=repl123
slave_user=root
slave_pass=wangqing123!

for i in $(seq 1 10);do
    $mysql -u$user -p$pass -h$master_ip -e "exit"
    if [ $? -eq 0 ];then
        LOG_FILE=$($mysql -u$user -p$pass -h$master_ip -e "show master status" 2> /dev/null | awk 'NR==2{print $1}')
        LOG_POS=$($mysql -u$user -p$pass -h$master_ip -e "show master status" 2> /dev/null | awk 'NR==2{print $2}')
	$mysql -u$slave_user -p$slave_pass -e "change master to master_host='$master_ip', master_user='$user', master_password='$pass', master_log_file='$LOG_FILE', master_log_pos=$LOG_POS; start slave;"
        $mysql -u$slave_user -p$slave_pass -e "show slave status\G"
        exit
    else
        sleep 60
    fi
done
