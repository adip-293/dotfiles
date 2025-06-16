#!/bin/bash

# Check if snapper is installed
if ! command -v snapper &> /dev/null; then
    echo "?"
    exit 1
fi

# Default config is root, but check if it exists
CONFIG="root"
if ! snapper list-configs | grep -q "^$CONFIG "; then
    # Try to find any available config
    CONFIG=$(snapper list-configs | tail -n +3 | awk '{print $1}' | head -1)
    
    # If no configs found
    if [ -z "$CONFIG" ]; then
        echo "?"
        exit 1
    fi
fi

# Get the highest snapshot number
latest_snapshot=$(snapper -c "$CONFIG" list | tail -n +3 | awk '{print $1}' | sort -n | tail -1)

# Output just the latest snapshot number
echo "$latest_snapshot"
