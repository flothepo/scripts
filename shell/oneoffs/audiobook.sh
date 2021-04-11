#!/usr/bin/env sh

for a in CD*; do
    (
    cd "$a" || exit
    for f in *.mp3; do
        cp "$f" "../out/$a-$f"
    done
    )
done
