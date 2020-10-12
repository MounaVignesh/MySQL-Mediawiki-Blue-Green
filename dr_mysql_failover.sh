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


sleep 1m

###DR failover 
ansible-playbook -i hosts -vvv dr_mysql_failover.yml

echo "End time: " `date`
END_TIME=$(date +%s)

TIME_CALCULATION=$(($END_TIME - $START_TIME))
TOTAL_TIME_TAKEN=$(date -d@$TIME_CALCULATION -u "+%H hrs %M mins %S sec")

echo "Total time taken: $TOTAL_TIME_TAKEN"

exit
