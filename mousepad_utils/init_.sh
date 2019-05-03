#!/bin/bash

current_dir=$( cd $(dirname $0) ; pwd )
mousepadOn_loc=$current_dir/mousepadOn.sh
mousepadOff_loc=$current_dir/mousepadOff.sh
_alias="alias mousepadOn=\"sh $mousepadOn_loc\""
echo "$_alias" >> ~/.bashrc
_alias="alias mousepadOff=\"sh $mousepadOff_loc\""
echo "$_alias" >> ~/.bashrc
