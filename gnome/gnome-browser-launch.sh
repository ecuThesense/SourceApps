#!/bin/sh
bm="$HOME/bookmarks.html"
ddg_url="https://www.duckduckgo.com"

# Launched from a graphical menu: run the picker in GNOME Terminal,
# wait for it to close, then open Firefox from here.
if [ ! -t 0 ] || [ ! -t 1 ]; then
    case "$0" in
        /*) script_path="$0" ;;
        *)  script_path="$PWD/$0" ;;
    esac

    out=$(mktemp)
    gnome-terminal --wait -- "$script_path" "$out"
    url=$(cat "$out")
    rm -f "$out"

    [ -n "$url" ] && exec firefox --new-tab "$url"
    exit 0
fi

# Parse Firefox bookmarks: URL<TAB>title.
pairs=""
if [ -s "$bm" ]; then
    pairs=$(
        sed -n \
            's/.*<A HREF="\([^"]*\)"[^>]*>\(.*\)<\/A>.*/\1\t\2/p' \
            "$bm" |
        sed 's/\&lt;/</g; s/\&gt;/>/g; s/\&quot;/"/g; s/\&amp;/\&/g'
    )
fi

# Build the displayed bookmark list.
menu=$(
    printf '%s\n' "$pairs" |
        awk -F '\t' 'NF >= 2 { print $2 " | " $1 }' |
        sort -f
)

# Select a bookmark, or enter a URL.
sel=$(
    {
        [ -n "$menu" ] && printf '%s\n' "$menu"
    } |
    fzf \
        --prompt='Bookmark / URL: ' \
        --header='Select a bookmark or type a URL' \
        --bind='enter:accept-or-print-query'
)

[ -z "$sel" ] && exit 0

# If the selected line belongs to a bookmark, extract its URL.
url=$(
    printf '%s\n' "$pairs" |
        T="$sel" awk -F '\t' \
            'NF >= 2 && ($2 " | " $1) == ENVIRON["T"] {
                print $1
                exit
            }'
)

# Otherwise interpret the typed input.
if [ -z "$url" ]; then
    case "$sel" in
        http://*|https://*|file://*|about:*)
            url=$sel
            ;;
        *[[:space:]]*)
            url=$ddg_url
            ;;
        *.*)
            url="https://$sel"
            ;;
        *)
            url=$ddg_url
            ;;
    esac
fi

# Hand the URL back to the launcher; if run by hand, open it directly.
if [ -n "$1" ]; then
    printf '%s' "$url" > "$1"
else
    firefox --new-tab "$url" >/dev/null 2>&1 &
fi
