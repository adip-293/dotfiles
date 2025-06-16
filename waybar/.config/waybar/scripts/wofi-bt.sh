#!/usr/bin/env bash

notify-send "Getting list of Bluetooth devices..."

# Check if Bluetooth is powered on
bt_powered=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')
if [[ "$bt_powered" != "yes" ]]; then
    # Show toggle to enable Bluetooth
    toggle="  Enable Bluetooth"
else
    toggle="  Disable Bluetooth"
fi

# Get list of devices: format -> "  DeviceName (MAC) [connected/disconnected]"
devices=$(bluetoothctl devices | while read -r line; do
    mac=$(echo "$line" | awk '{print $2}')
    name=$(echo "$line" | cut -d' ' -f3-)
    info=$(bluetoothctl info "$mac")
    if echo "$info" | grep -q "Connected: yes"; then
        status="connected"
    else
        status="disconnected"
    fi
    echo "  $name ($mac) [$status]"
done)

# Build menu entries
menu=$(echo -e "$toggle\n$devices")

chosen=$(echo -e "$menu" | wofi \
    --dmenu \
    --insensitive \
    --prompt "Bluetooth Devices" \
    --height 500 \
    --width 600 \
    --columns 1 \
    --lines 15 \
    --cache-file /dev/null \
    --style ~/.config/wofi/style.css)

# If nothing chosen, exit
if [[ -z "$chosen" ]]; then
    exit
elif [[ "$chosen" == "  Enable Bluetooth" ]]; then
    bluetoothctl power on
elif [[ "$chosen" == "  Disable Bluetooth" ]]; then
    bluetoothctl power off
else
    # Extract MAC address
    mac=$(echo "$chosen" | grep -oP '\([A-F0-9:]+\)' | tr -d '()')
    # Extract current connection status
    if echo "$chosen" | grep -q "\[connected\]"; then
        # Disconnect device
        bluetoothctl disconnect "$mac"
        notify-send "Bluetooth" "Disconnected from device $mac"
    else
        # Connect device
        bluetoothctl connect "$mac"
        notify-send "Bluetooth" "Connecting to device $mac"
    fi
fi

