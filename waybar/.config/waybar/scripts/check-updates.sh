#!/bin/bash

# Check if DNF is available (Fedora)
if command -v dnf &> /dev/null; then
    updates=$(dnf check-update --quiet | grep -v "^$" | wc -l)
    if [ "$updates" -gt 0 ]; then
        echo "$updates"
    else
        echo "0"
    fi
# Check if pacman is available (Arch)
elif command -v pacman &> /dev/null; then
    updates=$(pacman -Qu | wc -l)
    if [ "$updates" -gt 0 ]; then
        echo "$updates"
    else
        echo "0"
    fi
# Check if apt is available (Debian/Ubuntu)
elif command -v apt &> /dev/null; then
    apt-get update -qq > /dev/null
    updates=$(apt-get -s upgrade | grep -c "^Inst")
    if [ "$updates" -gt 0 ]; then
        echo "$updates"
    else
        echo "0"
    fi
else
    echo "?"
fi
