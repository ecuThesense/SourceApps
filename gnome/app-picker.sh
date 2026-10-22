#!/usr/bin/env bash
out=$(
  find /usr/bin /usr/local/bin ~/.local/bin \
    -maxdepth 1 \( -type f -o -type l \) -executable -print 2>/dev/null |
    sort -u |
    fzf \
      --style=full \
      --expect=alt-enter \
      --preview 'if [ "$(file -b --mime-encoding {})" = binary ]; then file -b {}; else cat {}; fi' \
      --bind 'focus:transform-header:file --brief {}'
)

key=$(sed -n 1p <<<"$out")
file=$(sed -n 2p <<<"$out")

[ -n "$file" ] || exit 0

if [ "$key" = alt-enter ]; then
  exec "$file" # CLI/TUI: takes over this terminal
else
  setsid -f "$file" >/dev/null 2>&1 # GUI: detached, terminal can close
fi
