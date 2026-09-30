#!/bin/sh
# Pick a bookmark, or type something that matches nothing to web-search it.
# bm="$HOME/.surf/bookmarks.html"
#
# pairs=""
# [ -s "$bm" ] && pairs=$(sed -n 's/.*<A HREF="\([^"]*\)"[^>]*>\(.*\)<\/A>.*/\1\t\2/p' "$bm")
#
# sel=$(printf '%s\n' "$pairs" | cut -f2 | sort -f |
#       dmenu -fn monospace:size=14 -i -l 10 -p 'Bookmark / Search:')
# [ -z "$sel" ] && exit 0
#
# # exact title match? (ENVIRON avoids awk mangling backslashes in -v)
# eurl=$(printf '%s\n' "$pairs" | T="$sel" awk -F'\t' '$2==ENVIRON["T"]{print $1; exit}')
#
# if [ -n "$eurl" ]; then
#     # bookmark: reverse the HTML-escaping
#     url=$(printf '%s' "$eurl" | sed 's/&lt;/</g; s/&gt;/>/g; s/&quot;/"/g; s/&amp;/\&/g')
# else
#     # no bookmark: percent-encode the query and search
#     q=$(printf '%s' "$sel" | od -An -v -tx1 | tr -d ' \n' | sed 's/../%&/g')
#     url="https://www.startpage.com/do/dsearch?query=$q"
# fi
#
# exec surf "$url"

# Pick a bookmark, paste a link, or type a query to web-search.
bm="$HOME/.surf/bookmarks.html"

search_url() {
    q=$(printf '%s' "$1" | od -An -v -tx1 | tr -d ' \n' | sed 's/../%&/g')
    printf 'https://www.startpage.com/do/dsearch?query=%s' "$q"
}

pairs=""
[ -s "$bm" ] && pairs=$(sed -n 's/.*<A HREF="\([^"]*\)"[^>]*>\(.*\)<\/A>.*/\1\t\2/p' "$bm")

sel=$(printf '%s\n' "$pairs" | cut -f2 | sort -f |
      dmenu -fn monospace:size=14 -i -l 10 -p 'Bookmark / URL / Search:')
[ -z "$sel" ] && exit 0

eurl=$(printf '%s\n' "$pairs" | T="$sel" awk -F'\t' '$2==ENVIRON["T"]{print $1; exit}')

if [ -n "$eurl" ]; then
    # bookmark: reverse the HTML-escaping
    url=$(printf '%s' "$eurl" | sed 's/&lt;/</g; s/&gt;/>/g; s/&quot;/"/g; s/&amp;/\&/g')
else
    case "$sel" in
        http://*|https://*|file://*|about:*)
            url=$sel ;;                       # full link
        *[[:space:]]*)
            url=$(search_url "$sel") ;;       # several words: search
        *.*)
            url="https://$sel" ;;             # bare domain, e.g. example.com/page
        *)
            url=$(search_url "$sel") ;;       # single word: search
    esac
fi

exec surf "$url"
