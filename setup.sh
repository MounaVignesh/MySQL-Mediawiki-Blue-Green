#!/bin/sh

START_TIME=$(date +%s)
echo "Start time: " `date`

###Remove old IP's
sed -i 's/10.*//g ; /^$/d'  hosts

###Creatimg EC2 instances
ansible-playbook  -vvv create.yml

sleep 2m

###Configure mysql:
ansible-playbook -i hosts -vvv configure_mysql.yml


exit
