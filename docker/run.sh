#!/bin/bash

DOMAIN_NAME="thilaire.lyon.lan"

sed -ri "s/obm.example.com/$DOMAIN_NAME/g" obmfull-example

echo "$TARGET_PORT_22_TCP_ADDR $DOMAIN_NAME" >> /etc/hosts

ansible-playbook -vvv -i obmfull-example obm.yml
