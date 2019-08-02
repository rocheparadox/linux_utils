#!/bin/bash
#Takes mysql dump of all databases as separate sql files

#exit at first error
set +e

#initiate variables
port=3306
host="localhost"
password=test
user=test
databases_to_ignore="^(mysql|information_schema|performance_schema|sys)$"
name=mysql_$port
#change variables if explicitly mentioned in CLI
set_port(){
  echo "port is $1"
  port=$1

  # give a name for directory
  name=mysql_$port
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

set_output_dir_name(){
  echo "name is $1"
  name=$1
}

while getopts ":p:P:u:h:n:" opt
do
  case "$opt" in
    P ) set_port "$OPTARG" ;;
    p ) set_password "$OPTARG" ;;
    u ) set_user "$OPTARG" ;;
    h ) set_host "$OPTARG" ;;
    n ) set_output_dir_name "$OPTARG" ;;
  esac
done

# option N suppresses the
databases=$( mysql -u $user -p$password -h $host -P $port -Ne "show databases;" )
if [ ! -z "$databases" ]; then
  echo "Creating directory $name"
  mkdir $name
else
  echo "Error whil"
  exit
fi

# iterate through databases
for database in $databases; do
        if [[ ! $database =~ $databases_to_ignore ]]; then
          echo "dumping $database"
          #echo "mysqldump -u $user -p$password -h $host -P $port $database > $name/$database.sql"
          mysqldump -u $user -p$password -h $host -P $port $database > $name/$database.sql
        fi
done
