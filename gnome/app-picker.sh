#!/usr/bin/env bash
file=$(
  find /usr/bin /usr/local/bin ~/.local/bin \
    -maxdepth 1 \( -type f -o -type l \) -executable -print 2>/dev/null |
    sort -u |
    fzf \
      --style=full \
      --preview 'if [ "$(file -b --mime-encoding {})" = binary ]; then file -b {}; else cat {}; fi' \
      --bind 'focus:transform-header:file --brief {}'
)

[ -n "$file" ] || exit 0

if [ -x "$file" ] && [ ! -d "$file" ]; then
  # exec "$file" >/dev/null 2>&1
  gnome-terminal -e "$file" >/dev/null 2>&1
else
  setsid -f xdg-open "$file" >/dev/null 2>&1
fi
