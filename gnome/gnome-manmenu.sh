#!/bin/sh
# gnomemanmenu.sh - search man pages with wofi, or pick a random one
# RANDOMPAGE="$HOME/SourceApps/gnome/gnome-randommanpage.sh"   # adjust path
# RANDOM_ENTRY="[ Random page ]"
#
# choice=$( { echo "$RANDOM_ENTRY"; man -k . | awk '{print}'; } | wofi --dmenu -i -p "man:")
# # choice=$( { echo "$RANDOM_ENTRY"; man -k . | sed 's/ - .*//; s/,[^(]*(/ (/' | sort -u; } | wofi --dmenu -i -p "man:")
# [ -z "$choice" ] && exit 0
#
# [ "$choice" = "$RANDOM_ENTRY" ] && choice=$("$RANDOMPAGE")
# [ -z "$choice" ] && exit 1
#
# name=$(echo "$choice" | awk '{print $1}' | sed 's/(.*//')
# section=$(echo "$choice" | grep -o '([^)]*)' | tr -d '()')
#
# exec gnome-terminal -- man $section "$name"

RANDOMPAGE="$HOME/SourceApps/gnome/gnome-randommanpage.sh"
RANDOM_ENTRY="[ Random page ]"

# Open a terminal if launched from a graphical launcher.
if [ ! -t 0 ] || [ ! -t 1 ]; then
    case "$0" in
        /*) script_path="$0" ;;
        *)  script_path="$PWD/$0" ;;
    esac

    exec gnome-terminal -- "$script_path"
fi

# Live search with fzf.
choice=$(
    : | fzf \
        --disabled \
        --prompt="man: " \
        --header="Type to search man pages" \
        --bind "start:reload(printf '%s\n' '$RANDOM_ENTRY')" \
        --bind "change:reload(sleep 0.15; printf '%s\n' '$RANDOM_ENTRY'; if [ -n {q} ]; then man -k -- {q} 2>/dev/null; fi; true)"
)

[ -z "$choice" ] && exit 0

# Random man page.
if [ "$choice" = "$RANDOM_ENTRY" ]; then
    choice=$("$RANDOMPAGE") || exit 1
fi

[ -z "$choice" ] && exit 1

# Extract name and section from entries such as "wofi (1) - description".
name=$(printf '%s\n' "$choice" |
    sed -nE 's/^([^[:space:]]+)[[:space:]]+\([^)]+\).*/\1/p')

section=$(printf '%s\n' "$choice" |
    sed -nE 's/^[^[:space:]]+[[:space:]]+\(([^)]+)\).*/\1/p')

[ -z "$name" ] || [ -z "$section" ] && exit 1

# Open the selected page in this terminal.
exec man "$section" "$name"
