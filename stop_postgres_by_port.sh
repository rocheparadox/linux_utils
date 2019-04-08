#!/bin/bash
#works for postgresql package that has bin directory and data directory under the same parent directory
if [ -z $1  ]; then
    echo "Please enter the port of postgresql as first argument"
    exit
fi

port=$1
netstat_output=$(netstat -pta | grep $port)

#echo $netstat_output
pgsql_pid=$(echo $netstat_output | grep -P -o "(?<=LISTEN)(\s[0-9]*)")
pgsql_pid=$(echo $pgsql_pid | grep -P -o "([0-9]*\s)")

ps_output=$(ps -aux | grep $pgsql_pid)
pgsql_dir=$(echo $ps_output | grep -P -o "(/.\S*\s-D)")
pgsql_dir=$(echo $pgsql_dir | grep -P -o "(?:(?=(.*/bin)).)*")

$pgsql_dir"bin/pg_ctl" -D $pgsql_dir"data" stop


