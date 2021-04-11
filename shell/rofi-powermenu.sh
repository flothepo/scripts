#!/bin/sh

if [ "$#" -ne 1 ]; then
    printf "Suspend\0icon\37system-suspend\n"
    printf "Reboot\0icon\37system-restart\n"
    printf "Shutdown\0icon\37system-shutdown\n"
    printf "Logout\0icon\37system-log-out\n"
else
    case "$@" in
        "Shutdown")
            printf "Cancel\0icon\37window-close\nShutdown now\0icon\37system-shutdown\n";;
        "Reboot")
            reboot;;
        "Suspend")
            systemctl suspend;;
        "Logout")
            killall xmonad-x86_64-linux;;
        "Shutdown now")
            shutdown now;;
    esac
fi
