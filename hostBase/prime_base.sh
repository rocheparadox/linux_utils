#!/bin/bash

abs_path=$( cd $(dirname $0) ; pwd )
port=8000
serve_path="."
if [ ! -z $1 ]; then
  port=$1
fi
if [ ! -z $2 ]; then
  server_path=$2
fi

python3 $abs_path/host_base.py $port $serve_path
