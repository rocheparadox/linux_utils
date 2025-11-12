#!/bin/bash

activate_scripts=$(find . | grep "bin/activate$")
while [ -z $activate_scripts ]; do
	cd ..
	echo "Traversed to $(pwd)"
	activate_scripts=$(find . | grep "bin/activate$")
done


scripts=($activate_scripts)

if [ -z ${scripts[0]} ]; then
	echo "No virtual environment activate script available"
else
	echo "The virtual environment activate scirpt is ${scripts[0]}"

	source "${scripts[0]}"
fi
