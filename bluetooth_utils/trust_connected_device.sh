blueDev=$(pactl list short)
device_mac_addr_output=$(echo $blueDev | grep -Po "(?<=bluez_source\.).{17}(?=\.a2dp_source)")

IFS=' ' read -ra device_mac_addr <<< $device_mac_addr_output

echo $device_mac_addr
device_mac_addr=$(echo $device_mac_addr | sed "s/_/:/g")
echo $device_mac_addr

bluetoothctl << EOF
	trust $device_mac_addr
EOF
