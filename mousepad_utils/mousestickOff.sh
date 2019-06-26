#!/bin/bash
deviceId=$(echo $(xinput) | grep -P -o "(?<=Stick.id=)([0-9]*)")
xinput set-prop $deviceId "Device Enabled" 0
