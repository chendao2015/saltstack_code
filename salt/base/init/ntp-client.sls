ntpdate:
  pkg.installed

time-sync:
  cron.present:
    - name: ntpdate time1.aliyun.com
    - user: root
    - minute: 01
    - hour: 00
