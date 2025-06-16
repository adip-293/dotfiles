#!/usr/bin/env bash

notify-send "Getting list of available Wi-Fi networks..."

# Get a list of available wifi connections and morph it into a nice-looking list
wifi_list=$(nmcli -t -f SSID,SIGNAL,SECURITY device wifi list | awk -F':' '
BEGIN { printf "" }
{
    ssid = $1;
    signal = $2;
    sec = ($3 == "--") ? "Open" : $3;
    if (length(ssid) > 0) {
        printf("  %s (%s%%, %s)\n", ssid, signal, sec);
    }
}' | sort -k2 -nr)


connected=$(nmcli -fields WIFI g)
if [[ "$connected" =~ "enabled" ]]; then
	toggle="  Disable Wi-Fi"
elif [[ "$connected" =~ "disabled" ]]; then
	toggle="  Enable Wi-Fi"
fi

# Use wofi to select wifi network
chosen_network=$(echo -e "$toggle\n$wifi_list" | uniq -u | wofi \
    --dmenu \
    --insensitive \
    --prompt "Wi-Fi Networks" \
    --height 500 \
    --width 600 \
    --columns 1 \
    --lines 15 \
    --cache-file /dev/null \
    --style ~/.config/wofi/style.css)

# Get name of connection
read -r chosen_id <<< "$(echo "$chosen_network" | sed -E 's/^  (.*) \(.*/\1/')"


if [ "$chosen_network" = "" ]; then
	exit
elif [ "$chosen_network" = "  Enable Wi-Fi" ]; then
	nmcli radio wifi on
elif [ "$chosen_network" = "  Disable Wi-Fi" ]; then
	nmcli radio wifi off
else
	# Message to show when connection is activated successfully
	success_message="You are now connected to the Wi-Fi network \"$chosen_id\"."
	# Get saved connections
	saved_connections=$(nmcli -g NAME connection)
	if [[ $(echo "$saved_connections" | grep -w "$chosen_id") = "$chosen_id" ]]; then
		nmcli connection up id "$chosen_id" | grep "successfully" && notify-send "Connection Established" "$success_message"
	else
		if [[ "$chosen_network" =~ "" ]]; then
			wifi_password=$(wofi \
			    --dmenu \
			    --password \
			    --prompt "Enter Password" \
			    --height 200 \
			    --width 400 \
			    --cache-file /dev/null \
			    --style ~/.config/wofi/style.css)
		fi
		nmcli device wifi connect "$chosen_id" password "$wifi_password" | grep "successfully" && notify-send "Connection Established" "$success_message"
	fi
fi
