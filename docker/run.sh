#!/bin/bash

echo "
# Dont't change names, only IPs
172.16.24.101   bench-obm-3.ci.obm-int.dc1
172.16.24.133   bench-opush1.ci.obm-int.dc1
172.16.24.134   bench-opush2.ci.obm-int.dc1
172.16.24.135   bench-opush3.ci.obm-int.dc1
" >> /etc/hosts

ansible-playbook -vv -f 5 -i xen-bench-inventory obm.yml
