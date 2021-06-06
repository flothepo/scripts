#!/bin/sh
# minimal integration of pass with wofi
# depends on fd, wofi, wl-clipboard

pw_store="$HOME/.password-store"

account=$(fd --base-directory "$pw_store" -e "gpg" . -x echo "{.}" | wofi -dip "pass")

[ -n "$account" ] || exit

pass show "$account" | wl-copy

notify-send "wpassmenu" "copied password for $account"
sleep 30
[ "$(pgrep -c wpassmenu)" -eq 1 ] && wl-copy -c && notify-send "wpassmenu" "cleared clipboard"
