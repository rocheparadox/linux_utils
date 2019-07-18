#!/bin/bash
# Run with sudo -- -requires root permission

#Parameters are the applications that has to be removed from the system

declare -a commands=('remove' 'purge')
declare -a _apps=($@)

set -e 

for _app in ${_apps[@]}; do 

  for _command in ${commands[@]};
  do
    echo $_command $_app
    apt-get -y $_command $_app
  done
done

