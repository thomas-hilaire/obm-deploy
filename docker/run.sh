#!/bin/bash

echo "
# Dont't change names, only IPs
172.16.24.138   bench-obm-25.ci.obm-int.dc1
" >> /etc/hosts

ansible-playbook -vv -f 5 -i xen-bench-inventory obm.yml
