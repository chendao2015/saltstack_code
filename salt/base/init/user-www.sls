www-user-group:
  group.present:
    - name: www
    - system: True
    - gid: 808

  user.present:
    - name: www
    - system: True
    - fullname: www
    - shell: /sbin/nologin
    - uid: 808
    - gid: 808
