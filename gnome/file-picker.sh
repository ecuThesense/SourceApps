#!/usr/bin/env bash
file=$(
    find . -type f -not -path '*/.git/*' |
        fzf \
            --style=full \
            --preview 'cat {}' \
            --bind 'focus:transform-header:file --brief {}'
)

if [ -n "$file" ]; then
    setsid -f xdg-open "$file" >/dev/null 2>&1
fi
