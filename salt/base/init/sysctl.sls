net.ipv4.ip_forward:
  sysctl.present:
    - value: 1

vm.overcommit_memory:
  sysctl.present:
    - value: 1

net.core.somaxconn:
  sysctl.present:
    - value: 1024
