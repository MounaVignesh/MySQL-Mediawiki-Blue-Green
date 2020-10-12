Ansible playbook for configuring MySQL cluster and Web page for mediawiki. This playbook will supports only Blue-Green which have the following mandatory fields.
1) Servers must be in Multi-Region
2) For each Region One MySQL master and one MySQL slave. In same server have installed apache (httpd)


Pre-requisites:
1) Group Var file - User needs to provide the inputs as per their needs in the file "group_vars/all.yml" which will take as an input for all the playbooks for various activities.
2) AWS direct connect - Both Regions "group_vars/all.yml".
3) AWS VPC and Subnet's.( Need to update those details in 
4) Hosts - All playbooks reads this "hosts" file run the tasks on the servers which are available on the hosts file. This file will automatically updated based on the servers created.

Configuration:
	To support various configuration like setup, DR failure playbooks are consolidated in to seperate scripts. Below are the scripts,
1) setup.sh - 
	a) create.yml - This playbook will create EC2 instances in both regions and update those IP's in hosts file.
	b) configure_mysql.yml - Configure MySQL in all 4 servers - This configuration would be Master-Slave Seup.
	c) configure_mysql.yml - This will install mediawiki and setup.
	
2) initial_data_sync_for_replication.sh	 - This shell script will do Master-Master replication and Master2-Slave2 replication.
	a) initial_data_insert_master.yml - This playbook will do Enable replication between Master-Master and Master-Slave.
	b) Master-Slave setup for both regions - Sample data insert and enable multi-region replication.
	
3) initial_data_insert_master.yml - This playbook will do Final master-slave replication.

4) service_restart.yml - This will restart MySQL Services if needed we can use for all servers restart.

5) dr_mysql_failover.sh - This script and playbook will do any failover happens.
   If any one of the server like master or slave will failed during AWS maintance or any status failed. This script will replace the server without any data loss.
   This playbook will replace the failed server without data loss and downtime.
	
Steps:

1. Run the setup.sh shell script to create EC2 instances and setup MySQL and Apache in 4 servers.
2. initial_data_sync_for_replication.sh - Enable replication between Master-Master and Master-Slave (This will insert sample data)
3. initial_data_insert_master.yml - This playbook will do Final master-slave replication.

After above steps completed. You can login all 4 servers and verified the MySQL Master-Master and Master-Slave Replication with deleting and inserting any sample data.

