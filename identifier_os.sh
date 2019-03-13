#This script has to be run as /bin/bash not /bin/dash
#This script is used to determine if a system has ubuntu or mac os

if [ -e /etc/os-release  ]; then 
	determiner=$(cat /etc/os-release)
else
	determiner=$(sw_vers)
fi


if [[ $determiner == *Ubuntu*  ]]; then
	echo "It is Ubuntu" 

elif [[ $determiner == *Mac*  ]]; then 
	echo "It is MAC OS X"
fi
