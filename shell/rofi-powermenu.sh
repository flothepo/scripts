#!/bin/sh

if [ -z "$@" ]; then
    printf "Shutdown\0icon\37system-shutdown\n"
    printf "Suspend\0icon\37system-suspend\n"
    printf "Reboot\0icon\37system-restart\n"
else
    case "$@" in
        "Shutdown")
            printf "Cancel\0icon\37window-close\nShutdown now\0icon\37system-shutdown\n";;
        "Reboot")
            reboot;;
        "Suspend")
            systemctl suspend;;
        "Shutdown now")
            shutdown now;;
    esac
fi
