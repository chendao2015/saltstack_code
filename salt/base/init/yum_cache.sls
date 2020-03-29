yum_cache:
  cmd.run:
    - name: yum clean all && yum makecache fast
