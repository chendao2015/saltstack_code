#!/bin/bash
VIP=$2
case "$1" in
  master)
	ip a|grep '172.16.103.250' &>/dev/null
        if [ $? -eq 0 ];then
            systemctl start haproxy
        fi
  ;;
  backup)
	ip a|grep '172.16.103.250' &>/dev/null
        if [ $? -ne 0 ];then
            systemctl stop haproxy
        fi
  ;;
  *)
        echo "Usage:$0 master|backup VIP"
  ;;
esac
