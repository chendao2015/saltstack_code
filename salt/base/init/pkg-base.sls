base-install:
  pkg.installed:
    - pkgs:
      - screen
      - tree
      - psmisc
      - openssl
      - openssl-devel
      - telnet
      - iftop
      - iotop
      - sysstat
      - wget
      - ntpdate
      - dos2unix
      - lsof
      - net-tools
      - vim-enhanced
      - zip
      - unzip
      - bzip2
      - bind-utils
      - gcc
      - gcc-c++
      - glibc
      - make
      - autoconf
      - mailx
      - MySQL-python

Development Tools:
  pkg.group_installed
