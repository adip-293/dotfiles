#!/bin/bash

# Escape characters for Pango markup
escape() {
    echo "$1" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&apos;/g'
}

status=$(playerctl status 2>/dev/null)
artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

if [[ -z "$status" || -z "$title" ]]; then
    echo ""
    exit 0
fi

# Truncate long display
maxlen=40
song="${artist} - ${title}"
[ ${#song} -gt $maxlen ] && song="$(echo "$song" | cut -c1-$maxlen)…"

# Icons
case "$status" in
    Playing) icon="" ;; # Pause symbol
    Paused)  icon="" ;; # Play symbol
    *)       icon="" ;; # Fallback
esac

# Escape all values
escaped_song=$(escape "$song")
escaped_tooltip=$(escape "$artist - $title")

# Output JSON for Waybar
echo "{\"text\": \" $escaped_song\", \"tooltip\": \"$escaped_tooltip\", \"class\": \"media $status\"}"

