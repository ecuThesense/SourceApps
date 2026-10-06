#!/bin/sh
# manmenu.sh - search man pages with noctalia dmenu, or pick a random one
RANDOMPAGE="$HOME/SourceApps/noctalia/noctalia-randommanpage.sh"   # adjust path
TERM_CMD="${TERMINAL:-foot}"         # your terminal emulator
RANDOM_ENTRY="[ Random page ]"

choice=$( { echo "$RANDOM_ENTRY"; man -k . | awk '{print $1, $2}'; } | noctalia dmenu -p "man:")
[ -z "$choice" ] && exit 0

[ "$choice" = "$RANDOM_ENTRY" ] && choice=$("$RANDOMPAGE")
[ -z "$choice" ] && exit 1

name=$(echo "$choice" | awk '{print $1}' | sed 's/(.*//')
section=$(echo "$choice" | grep -o '([^)]*)' | tr -d '()')

exec $TERM_CMD -e man $section "$name"
