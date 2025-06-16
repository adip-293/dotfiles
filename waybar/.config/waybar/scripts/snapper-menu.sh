#!/bin/bash

# snapper-menu.sh - A wofi menu for Snapper snapshot management
# For use with Waybar custom module

# Check if snapper is installed
if ! command -v snapper &> /dev/null; then
    notify-send "Snapper not found" "Please install snapper to use this feature" -i dialog-error
    exit 1
fi

# Check if wofi is installed
if ! command -v wofi &> /dev/null; then
    notify-send "Wofi not found" "Please install wofi to use this feature" -i dialog-error
    exit 1
fi

# Check if btrfs-assistant is installed (optional)
HAS_BTRFS_ASSISTANT=false
if command -v btrfs-assistant &> /dev/null; then
    HAS_BTRFS_ASSISTANT=true
fi

# Default config is root
CONFIG="root"

# Function to get all available snapper configs
get_configs() {
    snapper list-configs | tail -n +3 | awk '{print $1}'
}

# Function to list snapshots for a config
list_snapshots() {
    local config=$1
    # Format: NUM | DATE | USER | DESCRIPTION
    snapper -c "$config" list | tail -n +3 | awk '{printf "%5s | %s | %-10s | %s\n", $1, $2" "$3, $4, $7}'
}

# Function to create a new snapshot
create_snapshot() {
    local config=$1
    local description=$2
    
    if [[ -z "$description" ]]; then
        description="Created from Waybar menu"
    fi
    
    snapper -c "$config" create -d "$description"
    notify-send "Snapshot created" "New snapshot created for $config" -i dialog-information
}

# Function to revert to a snapshot
revert_snapshot() {
    local config=$1
    local snapshot=$2
    
    # Check if we're running with sudo/root privileges
    if [[ $EUID -ne 0 ]]; then
        # Try using pkexec for GUI authentication
        if command -v pkexec &> /dev/null; then
            pkexec snapper -c "$config" undochange "$snapshot".."0"
            notify-send "System reverted" "Reverted to snapshot $snapshot" -i dialog-information
        else
            # Fallback to btrfs-assistant if available
            if $HAS_BTRFS_ASSISTANT; then
                btrfs-assistant &
                notify-send "Opening Btrfs Assistant" "Please use Btrfs Assistant to revert snapshots" -i dialog-information
            else
                notify-send "Cannot revert snapshot" "Root privileges required. Try running 'sudo snapper -c $config undochange $snapshot..0'" -i dialog-error
            fi
        fi
    else
        snapper -c "$config" undochange "$snapshot".."0"
        notify-send "System reverted" "Reverted to snapshot $snapshot" -i dialog-information
    fi
}

# Main menu
main_menu() {
    local options="Create new snapshot\nList snapshots\nOpen Btrfs Assistant"
    
    # If multiple configs are available, add option to select config
    if [[ $(get_configs | wc -l) -gt 1 ]]; then
        options="$options\nChange config"
    fi
    
    local choice=$(echo -e "$options" | wofi --dmenu --insensitive --width 300 --height 200 --prompt "Snapper Menu" --cache-file /dev/null)
    
    case "$choice" in
        "Create new snapshot")
            description=$(wofi --dmenu --insensitive --width 400 --prompt "Enter snapshot description:" --cache-file /dev/null)
            if [[ -n "$description" ]]; then
                create_snapshot "$CONFIG" "$description"
            fi
            ;;
        "List snapshots")
            snapshot_menu
            ;;
        "Open Btrfs Assistant")
            if $HAS_BTRFS_ASSISTANT; then
                btrfs-assistant &
            else
                notify-send "Btrfs Assistant not found" "Please install btrfs-assistant to use this feature" -i dialog-error
            fi
            ;;
        "Change config")
            config_menu
            ;;
    esac
}

# Config selection menu
config_menu() {
    local configs=$(get_configs)
    local choice=$(echo -e "$configs" | wofi --dmenu --insensitive --width 300 --prompt "Select config:" --cache-file /dev/null)
    
    if [[ -n "$choice" ]]; then
        CONFIG="$choice"
        main_menu
    fi
}

# Snapshot menu
snapshot_menu() {
    local snapshots=$(list_snapshots "$CONFIG")
    
    if [[ -z "$snapshots" ]]; then
        notify-send "No snapshots" "No snapshots found for config $CONFIG" -i dialog-information
        return
    fi
    
    local choice=$(echo -e "$snapshots" | wofi --dmenu --insensitive --width 800 --prompt "Select snapshot:" --cache-file /dev/null)
    
    if [[ -n "$choice" ]]; then
        local snapshot_num=$(echo "$choice" | awk '{print $1}')
        local options="View details\nRevert to this snapshot"
        local action=$(echo -e "$options" | wofi --dmenu --insensitive --width 300 --prompt "Snapshot $snapshot_num:" --cache-file /dev/null)
        
        case "$action" in
            "View details")
                snapper -c "$CONFIG" status "$snapshot_num".."0" | wofi --dmenu --width 800 --height 600 --prompt "Changes in snapshot $snapshot_num:" --cache-file /dev/null
                ;;
            "Revert to this snapshot")
                local confirm=$(echo -e "Yes\nNo" | wofi --dmenu --insensitive --width 300 --prompt "Are you sure you want to revert to snapshot $snapshot_num?" --cache-file /dev/null)
                if [[ "$confirm" == "Yes" ]]; then
                    revert_snapshot "$CONFIG" "$snapshot_num"
                fi
                ;;
        esac
    fi
}

# Start the main menu
main_menu
