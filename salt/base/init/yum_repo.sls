{% if grains['os'] == 'RedHat' %}
/etc/yum.repos.d/CentOS-Base.repo:
  file.managed:
    - source: salt://init/files/CentOS-Base.repo
{% endif %}

/etc/yum.repos.d/epel.repo:
  file.managed:
    - source: salt://init/files/epel.repo
