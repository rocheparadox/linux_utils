#!/bin/bash

#This script is written for Ubuntu 16.04
#This script has to be run with sudo permission

#variables
port=3306
mysql_data_dir="/var/lib/mysql"
mysql_run_dir="/var/run/mysqld"
scriptDirPath=$( cd $(dirname $0) ; pwd )

#remove trailing mysql files
echo "Removing trailing mysql..."
if [ -d /var/lib/mysql ]; then
	rm -rf /var/lib/mysql*
fi
if [ -d /var/run/mysqld ]; then
	rm -rf /var/run/mysqld
fi

#download and install mysql
echo "Installing mysql server"
DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server-5.7 --allow-unauthenticated

#change the port number
echo "Changing port number to $port .."
sed -i "s|port.*=.*\d*|port   = $port|g" /etc/mysql/mysql.conf.d/mysqld.cnf

#By default the bind address is set 127.0.0.1 which limits the mysql server
#to be accessed only locally from the container.
#By commenting the same or by changing it to 0.0.0.0 we expose the server's port
#to external connections
sed -i 's/bind-address/#bind-address/g' /etc/mysql/mysql.conf.d/mysqld.cnf

echo "Gonna stop"
sleep 5

#stop mysql service
echo "stopping mysql service"
if pgrep mysql; then
        killall /usr/sbin/mysqld
        sleep 5
else
        echo "mysql process does not exist.. So proceeding further without killing"
fi


#remove the data directory and clean the run directory
echo "Removing the data directory and cleaning run directory"
rm -rf $mysql_data_dir
rm -rf $mysql_run_dir

#create mysql data directory
echo "Creating mysql data directory"
mkdir $mysql_data_dir
chown mysql:mysql $mysql_data_dir
chmod -R 755 $mysql_data_dir

#create mysql run directory
echo "Creating mysql run directory"
mkdir $mysql_run_dir
chown mysql:mysql $mysql_run_dir
chmod -R 755 $mysql_run_dir

#initialize the data directory ----- insecure states that the user root would not have a password
echo "intializing data directory"
/usr/sbin/mysqld --initialize-insecure

#start mysql
/usr/bin/mysqld_safe &

sleep 5
#initialize users
mysql -u root -h 127.0.0.1 -P $port < $scriptDirPath/user_init.sql

#wait for a few seconds
sleep 3

#stop mysql service
pkill mysql

#Disable dns lookup and speed up transmission
echo "skip-name-resolve" >> /etc/mysql/mysql.conf.d/mysqld.cnf
