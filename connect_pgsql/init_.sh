#!/bin/bash
current_dir=$( cd $(dirname $0) ; pwd )
script_loc=$current_dir/connect_to_postgres.sh
_alias="alias pgsql=\"sh $script_loc\""
echo "$_alias" >> ~/.bashrc
