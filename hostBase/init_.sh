#!/bin/bash

current_dir=$( cd $(dirname $0) ; pwd )
script_loc=$current_dir/prime_base.sh
_alias="alias hostbase=\"sh $script_loc\""
echo "$_alias" >> ~/.bashrc
