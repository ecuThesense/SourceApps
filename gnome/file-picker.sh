# #!/usr/bin/env bash
# file=$(
#     find . -type f -not -path '*/.git/*' |
#         fzf \
#             --style=full \
#             --preview 'cat {}' \
#             --bind 'focus:transform-header:file --brief {}'
# )
#
# if [ -n "$file" ]; then
#     setsid -f xdg-open "$file" >/dev/null 2>&1
# fi

#!/usr/bin/env bash

file=$(
    find ~ /usr/bin \
        \( -name .git -o -name .cache -o -name node_modules \) -prune -o \
        \( -type f -o -type l \) -print 2>/dev/null |
        fzf \
            --style=full \
            --preview 'if [ "$(file -b --mime-encoding {})" = binary ]; then file -b {}; else cat {}; fi' \
            --bind 'focus:transform-header:file --brief {}'
)

[ -n "$file" ] || exit 0

if [ -x "$file" ] && [ ! -d "$file" ]; then
    exec "$file"
else
    setsid -f xdg-open "$file" >/dev/null 2>&1
fi
