#!/bin/bash

current_dir=$( cd $(dirname $0) ; pwd )
script_loc=$current_dir/clean_dir.sh
_alias="alias cleandir=\"sh $script_loc\""
echo "$_alias" >> ~/.bashrc
