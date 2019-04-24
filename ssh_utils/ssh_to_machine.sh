machine_name=$1
username=$2
password=$3

file_path=$( cd $( dirname $0 ); pwd )
if [ "$1" = "--help" ] || [ -z "$1"  ] || [ -z "$2"  ] || [ -z "$3" ] ; then 

echo "Requires 3 arguments \nssh_to_machine [machine_name] [username] [password]  "

else

expect $file_path/ssh_to_machine.expect $username $machine_name $password

fi
