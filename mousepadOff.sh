
if [ -z $1 ]; then
    echo "Please enter the device id as first argument after running xinput command"
    exit
fi

deviceId=$1
xinput set-prop $deviceId "Device Enabled" 0
