/etc/security/limits.conf:
  file.managed:
    - source: salt://init/files/limits.conf
    - user: root
    - group: root
    - mode: 644