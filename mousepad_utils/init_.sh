#!/bin/bash

current_dir=$( cd $(dirname $0) ; pwd )
mousepadOn_loc=$current_dir/mousepadOn.sh
mousepadOff_loc=$current_dir/mousepadOff.sh
mousestickOn_loc=$current_dir/mousestickOn.sh
mousestickOff_loc=$current_dir/mousestickOff.sh
_alias="alias mousepadOn=\"sh $mousepadOn_loc\""
echo "$_alias" >> ~/.bashrc
_alias="alias mousepadOff=\"sh $mousepadOff_loc\""
echo "$_alias" >> ~/.bashrc
_alias="alias mousestickOn=\"sh $mousestickOn_loc\""
echo "$_alias" >> ~/.bashrc
_alias="alias mousestickOff=\"sh $mousestickOff_loc\""
echo "$_alias" >> ~/.bashrc

