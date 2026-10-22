#!/usr/bin/env bash
# Pick a file from the home directory with fzf and open it with its default app.
file=$(
  find ~ \
    \( -name .git -o -name .cache -o -name node_modules \) -prune -o \
    \( -type f -o -type l \) -print 2>/dev/null |
    fzf \
      --style=full \
      --preview 'if [ "$(file -b --mime-encoding {})" = binary ]; then file -b {}; else cat {}; fi' \
      --bind 'focus:transform-header:file --brief {}'
)

[ -n "$file" ] || exit 0

setsid -f xdg-open "$file" >/dev/null 2>&1
