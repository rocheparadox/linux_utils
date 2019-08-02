#!/bin/bash
#reads sql files from directory given after -d and imports them to the specified mysql server

#exit at first error
set -e

#initiate variables
port=3306
host="localhost"
password=test
user=test
databases_to_ignore="^(mysql|information_schema|performance_schema|sys)$"
directory_path="none"
#change variables if explicitly mentioned in CLI
set_port(){
  echo "port is $1"
  port=$1
}

set_user(){
  echo "user is $1"
  user=$1
}

set_password(){
  echo "password is $1"
  password=$1
}

set_host(){
  echo "host is $1"
  host=$1
}

set_dir_path(){
  echo "name is $1"
  directory_path=$1
}

while getopts ":p:P:u:h:d:" opt
do
  case "$opt" in
    P ) set_port "$OPTARG" ;;
    p ) set_password "$OPTARG" ;;
    u ) set_user "$OPTARG" ;;
    h ) set_host "$OPTARG" ;;
    d ) set_dir_path "$OPTARG" ;;
  esac
done

if [ $directory_path = "none" ]; then
  echo "directory_path -d in which mysql files exist is required"
  exit
fi

# option N suppresses the
cd $directory_path
databases=$( ls )
if [ ! -z "$databases" ]; then
  echo "databases exist"
else
  echo "Error whil"
  exit
fi

# iterate through databases
for database in $databases; do
        if [[ ! $database =~ $databases_to_ignore ]] && [[ $database == *".sql" ]]; then

          database_name=${database:0:-4}
          echo "Creating database $database_name";
          mysql -u $user -p$password -h $host -P $port -e "create database $database_name";
          echo "importing $database"
          mysql -u $user -p$password -h $host -P $port $database_name < $database
        fi
done
