#!/bin/bash

#get the dir name
#script_dir_path=$( cd $(dirname $0); pwd );
dirname=$( basename $( pwd ));
read -p 'do you really want to clean the present directory? [y/n] ' choice

if [ $choice == 'y' ]; then
  echo "cleaning directory"
  #clean the directory
  echo "../$dirname/*"
  rm -rf ../$dirname/*
  echo "directory cleaned"
else
  echo "operation aborted.."
fi
