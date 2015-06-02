#!/bin/bash

echo "
# Dont't change names, only IPs
172.16.24.11   virt-obm-hp-01.obm-int.dc1
172.16.24.133 obm3.example.com
172.16.24.134 obm4.example.com opush3.example.com
172.16.24.135 obm5.example.com cassandra1.example.com
172.16.24.136 obm6.example.com cassandra2.example.com
172.16.24.137 injector.example.com
" >> /etc/hosts

#ansible-playbook -vv -f 5 -i xen-bench-inventory obm.yml
#vagrant provision
vagrant up --provider=libvirt
