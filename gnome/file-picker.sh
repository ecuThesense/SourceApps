#!/usr/bin/env bash
# Pick a file or directory from the home directory with fzf and open it with
# its default app / file manager. Press ctrl-t to toggle between files and dirs.

self=$(realpath "$0")
printf -v q '%q' "$self"

list() {
  case $1 in
  files)
    find ~ \( -name .git -o -name .cache -o -name node_modules \) -prune -o \
      \( -type f -o -type l \) -print
    ;;
  dirs)
    find ~ \( -name .git -o -name .cache -o -name node_modules \) -prune -o \
      -type d -print
    ;;
  esac 2>/dev/null
}

preview() {
  if [ -d "$1" ]; then
    ls -A --color=always "$1"
  elif [ "$(file -b --mime-encoding "$1")" = binary ]; then
    file -b "$1"
  else
    cat "$1"
  fi
}

toggle() {
  case $FZF_PROMPT in
  files*) echo "change-prompt(dirs [ctrl-t]> )+reload($q --list dirs)" ;;
  *) echo "change-prompt(files [ctrl-t]> )+reload($q --list files)" ;;
  esac
}

# Helper modes used by fzf (it calls this script again for reload/preview/toggle)
case ${1-} in
--list)
  list "$2"
  exit
  ;;
--preview)
  preview "$2"
  exit
  ;;
--toggle)
  toggle
  exit
  ;;
esac

selection=$(
  list files |
    fzf \
      --style=full \
      --prompt 'files [ctrl-t]> ' \
      --preview "$q --preview {}" \
      --bind 'focus:transform-header:file --brief {}' \
      --bind "ctrl-t:transform:$q --toggle"
)

[ -n "$selection" ] || exit 0

# xdg-open opens files in their default app and directories in the file manager.
# To open a terminal in the directory instead, swap the line below for:
#   [ -d "$selection" ] && gnome-terminal --working-directory="$selection"
setsid -f xdg-open "$selection" >/dev/null 2>&1
