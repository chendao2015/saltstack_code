/tmp/salt-repo-latest.el7.noarch.rpm:
  file.managed:
    - source: salt://init/files/salt-repo-latest.el7.noarch.rpm
  cmd.run:
    - name: rpm -Uvh /tmp/salt-repo-latest.el7.noarch.rpm
    - unless: rpm -qa|grep salt-repo
