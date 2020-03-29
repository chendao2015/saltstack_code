include:
  - pkg_lnmp
  - modules.nginx.install
  - modules.nginx.config
  - modules.mysql.install
  - modules.php.install

lnmp-config:
  file.managed:
    - name: /usr/local/nginx/conf/nginx.conf
    - source: salt://modules/nginx/files/nginx.conf
  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - watch:
      - file: lnmp-config
