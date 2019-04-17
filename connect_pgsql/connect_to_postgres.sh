#!/bin/bash

if [ -z $1 ]; then
    echo "postmaster port to connect to is required"
    exit 
fi
port=$1
psql -U postgres -h localhost -p $port
