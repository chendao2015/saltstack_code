keepalived_install:
  pkg.installed:
    - name: keepalived

/scripts:
  file.directory:
    - user: root
    - group: root
    - makedirs: True
