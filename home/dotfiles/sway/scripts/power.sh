#!/bin/sh
choice=$(printf 'Lock\nSuspend\nLogout\nReboot\nShutdown\n' | rofi -dmenu -i -p power)
case "$choice" in
    "Lock")             swaylock -f ;;
    "Suspend")          systemctl suspend ;;
    "Logout")           swaymsg exit ;;
    "Reboot")           systemctl reboot ;;
    "Shutdown")         systemctl poweroff ;;
esac
