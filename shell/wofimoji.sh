#!/bin/sh 

VER="11.0"
URL="https://www.unicode.org/Public/emoji/${VER}/emoji-test.txt"
FILE="$XDG_CACHE_HOME/emojis.txt"

if [ ! -r "$FILE" ]
then
  curl "$URL" | awk -F "# " '/fully-qualified/{if (NF && length($1) != 0) print $2}' > "$FILE"
fi

emoji=$(wofi -d -p "emoji:" 2>/dev/null < "$FILE")
echo "$emoji" | cut -d " " -f 1 | wl-copy -n
