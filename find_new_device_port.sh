#/bin/bash

prior_connected_devices=$(ls /dev/)
x=$(read -p "Connect the device and press enter")

post_connected_devices=$(ls /dev/)
#echo $post_connected_devices

for device in $post_connected_devices;
do
  if [[ ! "$prior_connected_devices" =~ .*$device.* ]] && [ $device != serial ]; then
    echo $device
  fi
done 
