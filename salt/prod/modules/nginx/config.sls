/etc/profile.d/nginx.sh:
  file.managed:
    - source: salt://web/nginx/files/nginx.sh

/usr/lib/systemd/system/nginx.service:
  file.managed:
    - source: salt://web/nginx/files/nginx.service

nginx-daemon:
  cmd.run:
    - name: systemctl daemon-reload

nginx-service:
  service.running:
    - name: nginx
    - enable: True
