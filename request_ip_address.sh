#!/bin/bash

start_value=130
end_value=145


is_within_range(){

	target=$1
	local start_value=$2
	local end_value=$3

	for x in $( seq $start_value $end_value ); do
		if [ "$x" = "$target" ];then
			return 0
		fi
	done
	return 1

}

is_ip_address_equals_expected(){
	
	#echo "in function $present_ip_address"
	last_octet=$( echo $present_ip_address | grep --perl-regexp --only-matching "(\d{1,3}.)$" )
	
	for i in $(seq $start_value $end_value);
	do
		#echo "$i $last_octet"
		if [[ "$i" = "$last_octet" ]]; then
			#echo "Good to go"
			return 0 #In bash the return is the exit status and in if statement 0 equals true for bash -- exit status
		fi
	done
	return 1

}

get_last_octet(){
	local ip_address=$1
	#echo " inside $ip_address"
	last_octet=$( echo $ip_address | grep --perl-regexp --only-matching "(\d{1,3}.)$" )
	echo "last octet of $ip_address is $last_octet" >&2
	echo $last_octet
}

get_base_octets(){
	local temp_ip_address=$1
	base_octets=$( echo $temp_ip_address | grep --perl-regexp --only-matching "^(\d{1,3}.){3}" )
	echo $base_octets
}


#check if we are conneceted to network -- wifi interface
if [ $( iwconfig 2>&1 | grep --only-matching --perl-regexp '(?<=ESSID:).*' ) == "off/any" ]; then
	echo "Then device is not connected to any network through wifi.. So terminating process"
	exit 0
fi


#fetch present ip address
ip_addresses=$(ifconfig | grep --only-matching --perl-regexp "(?<=inet\s)(\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3})")

echo $ip_addresses
for ip_address in $ip_addresses;
do
	if [ "$ip_address" != "127.0.0.1" ]; then
		present_ip_address=$ip_address
	fi
done
echo present ip address is $present_ip_address

if [ -z $present_ip_address ]; then
	echo "The requested address is occupied by another device"

	#Get prev_requested_ip -- it certainly is available because it is highly improbablr for a device to be connected to
	#a network and not have an IP without explicitly having requested for an IP(which was assigned to another device)

	prev_req_ip=$(cat /etc/dhcp/dhclient.conf | grep --perl-regexp --only-matching "(?<=send dhcp-requested-address )(\d{1,3}.){4}(?=;)")
	prev_req_ip_last_octet=$( get_last_octet $prev_req_ip )
	new_req_ip_last_octet=$(( $prev_req_ip_last_octet + 1 ))

	if ! is_within_range "$new_req_ip_last_octet" "$start_value" "$end_value"; then
		echo "New requested ip last octet is not within range... looks like we have run out of options going back to square one"
		exit 
	else
		new_req_ip=$( get_base_octets $prev_req_ip )$new_req_ip_last_octet
		echo "New requested IP address is $new_req_ip"
		sed -r -i "s/send dhcp-requested-address.*/send dhcp-requested-address $new_req_ip;/g" /etc/dhcp/dhclient.conf
		echo "Restarting network-manager"
		service network-manager restart
		exit 0
	fi
fi


if is_ip_address_equals_expected;
then
	echo "IP Address is within expected range..so exiting"
	exit 0
fi
echo "IP address is still not within expected range.. so trying again.."

#construct new IP to request

present_ip_base_octets=$( get_base_octets "$present_ip_address" )
new_req_ip=$present_ip_base_octets$start_value

echo "New requested IP address is $new_req_ip"

#check if a requested ip exists in dhclient.conf
if grep -q "send dhcp-requested-address" /etc/dhcp/dhclient.conf; then
	#it exist.. so replace it
	sed -r -i "s/send dhcp-requested-address.*/send dhcp-requested-address $new_req_ip;/g" /etc/dhcp/dhclient.conf

else
	echo "send dhcp-requested-address $new_req_ip;"> /etc/dhcp/dhclient.conf
fi

service network-manager restart
