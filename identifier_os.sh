#This script has to be run as /bin/bash not /bin/dash
#This script is used to determine if a system has ubuntu or mac os

{
if [ -e /etc/os-release  ]; then 
	determiner=$(cat /etc/os-release)
fi
} ||
{
determiner=$(sw_vers)
}

if [[ $determiner == *Ubuntu*  ]]; then
	echo "It is Ubuntu" 

else [[ $determiner == *MAC*  ]]; 
	echo "It is MAC OS X"
fi
