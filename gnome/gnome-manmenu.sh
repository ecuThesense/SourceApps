#!/bin/sh
# gnomemanmenu.sh - search man pages with wofi, or pick a random one
RANDOMPAGE="$HOME/SourceApps/gnome/gnome-randommanpage.sh"   # adjust path
RANDOM_ENTRY="[ Random page ]"

choice=$( { echo "$RANDOM_ENTRY"; man -k . | awk '{print $1, $2}'; } | wofi --dmenu -i -p "man:")
[ -z "$choice" ] && exit 0

[ "$choice" = "$RANDOM_ENTRY" ] && choice=$("$RANDOMPAGE")
[ -z "$choice" ] && exit 1

name=$(echo "$choice" | awk '{print $1}' | sed 's/(.*//')
section=$(echo "$choice" | grep -o '([^)]*)' | tr -d '()')

exec gnome-terminal -- man $section "$name"
