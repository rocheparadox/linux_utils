#!/bin/bash


#initiate variables
port=3306
host="localhost"
#password=""
user=root
databases_to_ignore="^(mysql|information_schema|performance_schema|sys)$"
name=mysql_$port
action=list
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

set_action(){
  echo "Action is $1"
  action=$1
}

while getopts ":p:P:u:h:a:" opt
do
  case "$opt" in
    P ) set_port "$OPTARG" ;;
    p ) set_password "$OPTARG" ;;
    u ) set_user "$OPTARG" ;;
    h ) set_host "$OPTARG" ;;
    a ) set_action "$OPTARG" ;;
  esac
done

if [ -z $password ]; then
   echo "No password"
   databases=$( mysql -u $user -h $host -P $port -Ne "show databases;" )
else
   echo "with password"
   databases=$( mysql -u $user -p$password -h $host -P $port -Ne "show databases;" )
fi


# iterate through databases
for database in $databases; do
        if [[ ! $database =~ $databases_to_ignore ]]; then
          echo "$database"
          if [ "$action" = "delete" ]; then
            echo "dropping database $database"
            if [ -z $password ]; then
              #echo "No password"
              mysql -u $user -h $host -P $port -Ne "drop database $database;"
            else
              #echo "with password"
              mysql -u $user -p$password -h $host -P $port -Ne "drop database $database;"
            fi
          fi
        fi
done


