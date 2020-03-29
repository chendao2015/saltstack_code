nginx:
  user.present:
    - system: True
    - shell: /sbin/nologin

depend_on_nginx:
  pkg.installed:
    - pkgs:
      - pcre-devel
      - openssl
      - openssl-devel
      - gd-devel
      - gcc
      - gcc-c++

Development Tools:
  pkg.group_installed

/var/log/nginx:
  file.directory:
    - user: nginx
    - group: nginx
    - mode: 755
    - makedirs: True

download_nginx:
  file.managed:
    - name: /usr/src/nginx-1.16.1.tar.gz
    - source: salt://web/nginx/files/nginx-1.16.1.tar.gz

nginx_install:
  file.managed:
    - name: /tmp/nginx_install.sh
    - source: salt://web/nginx/files/install.sh
    - mode: 755
    - user: root
    - group: root

  cmd.run:
    - name: /bin/bash /tmp/nginx_install.sh
    - unless: test -d /usr/local/nginx

clean_packages:
  file.absent:
    - name: /usr/src/nginx-1.16.1
