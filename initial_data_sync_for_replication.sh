#!/bin/sh

START_TIME=$(date +%s)
echo "Start time: " `date`

###Enable replication between Master-Master and Master-Slave
ansible-playbook -i hosts -vvv initial_data_insert_master.yml

echo "End time: " `date`
END_TIME=$(date +%s)

TIME_CALCULATION=$(($END_TIME - $START_TIME))
TOTAL_TIME_TAKEN=$(date -d@$TIME_CALCULATION -u "+%H hrs %M mins %S sec")

echo "Total time taken: $TOTAL_TIME_TAKEN"

exit
