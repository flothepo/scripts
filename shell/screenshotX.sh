#!/bin/sh

p=$(date +%s)
d="$HOME/Pictures/screenshots/"

maim -s "$d$p.png" && notify-send "Screenshot taken" "$d$p.png" --icon=dialog-information
