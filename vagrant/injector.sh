#! /bin/bash

set -e

echo " * Installing obm-loadtest tool .."

sudo su - root -c 'echo "[obm-loadtest]
name=obm-loadtest 
baseurl=http://rpm.obm.org/obm-load-testing/unstable/6/
enabled=1
gpgcheck=0" > /etc/yum.repos.d/obm-loadtest.repo'
sudo su - root -c 'yum install -y obm-loadtest'

echo " * Done"
