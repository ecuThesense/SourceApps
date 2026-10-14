#!/bin/sh
# Pick a bookmark ("name | URL"), paste a link, or type a query to web-search.
# bm="$HOME/bookmarks.html"
#
# search_url() {
#     q=$(printf '%s' "$1" | od -An -v -tx1 | tr -d ' \n' | sed 's/../%&/g')
#     printf 'https://www.startpage.com/do/dsearch?query=%s' "$q"
# }
#
# # url<TAB>title, with HTML entities decoded up front
# pairs=""
# [ -s "$bm" ] && pairs=$(sed -n 's/.*<A HREF="\([^"]*\)"[^>]*>\(.*\)<\/A>.*/\1\t\2/p' "$bm" |
#                         sed 's/&lt;/</g; s/&gt;/>/g; s/&quot;/"/g; s/&amp;/\&/g')
#
# sel=$(printf '%s\n' "$pairs" | awk -F'\t' 'NF>=2{print $2 " | " $1}' | sort -f |
#       wofi --dmenu -i -p 'Bookmark / URL / Search:')
# [ -z "$sel" ] && exit 0
#
# # did we pick a "name | URL" line? then take its URL
# url=$(printf '%s\n' "$pairs" |
#       T="$sel" awk -F'\t' 'NF>=2 && ($2 " | " $1)==ENVIRON["T"]{print $1; exit}')
#
# if [ -z "$url" ]; then
#     case "$sel" in
#         http://*|https://*|file://*|about:*)
#             url=$sel ;;                       # full link
#         *[[:space:]]*)
#             url=$(search_url "$sel") ;;       # several words: search
#         *.*)
#             url="https://$sel" ;;             # bare domain
#         *)
#             url=$(search_url "$sel") ;;       # single word: search
#     esac
# fi
#
# exec firefox --new-tab "$url"

bm="$HOME/bookmarks.html"

search_url() {
    q=$(printf '%s' "$1" |
        od -An -v -tx1 |
        tr -d ' \n' |
        sed 's/../%&/g')

    printf 'https://www.startpage.com/do/dsearch?query=%s' "$q"
}

# Open GNOME Terminal when launched from a graphical menu.
if [ ! -t 0 ] || [ ! -t 1 ]; then
    case "$0" in
        /*) script_path="$0" ;;
        *)  script_path="$PWD/$0" ;;
    esac

    exec gnome-terminal -- "$script_path"
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

# Select a bookmark, or enter a URL/search query.
sel=$(
    {
        [ -n "$menu" ] && printf '%s\n' "$menu"
    } |
    fzf \
        --prompt='Bookmark / URL / Search: ' \
        --header='Select a bookmark or type a URL/search query' \
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
            url=$(search_url "$sel")
            ;;
        *.*)
            url="https://$sel"
            ;;
        *)
            url=$(search_url "$sel")
            ;;
    esac
fi

exec firefox --new-tab "$url"
