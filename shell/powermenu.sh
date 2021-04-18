#!/bin/sh

action=$(printf "suspend\nreboot\nshutdown\nlogout" | wofi -d -p "power:" -L 5)

case "$action" in
    "shutdown")
	shutdown now;;
    "reboot")
        reboot;;
    "suspend")
        systemctl suspend;;
    "logout")
        swaymsg exit;;
esac
