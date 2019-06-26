bluetoothctl << IAMEND
power on
agent off
IAMEND

sleep 5
bluetoothctl << IAMEND
agent NoInputNoOutput
default-agent
discoverable on
IAMEND
