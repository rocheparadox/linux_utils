#!/bin/bash

echo "Hey buddy! who are you?"
read username
echo "Hello $username, It is good to hear from ya! Are you interested in programming? [yes/ no]"
read userDec

if [ "$userDec" = "yes" ]; then
	echo "Good, you are at the right place!"
elif [ "$userDec" = "no" ]; then
        echo "Sorry to hear that.. Bubyee, This is not the place for you."
fi 

