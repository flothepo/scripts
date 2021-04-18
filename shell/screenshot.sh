#!/bin/sh

p=$(date +%s)
d="$HOME/data/pictures/screenshots/"

grim -g "$(slurp)" "$d$p.png" && notify-send "Screenshot taken" "$d$p.png" --icon=dialog-information
