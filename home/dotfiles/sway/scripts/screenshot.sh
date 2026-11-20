#!/usr/bin/env bash
# usage: screenshot.sh area-save | area-copy | screen-copy

dir="$HOME/Pictures/Screenshots"
mkdir -p "$dir"
file="$dir/$(date +%Y-%m-%d_%H-%M-%S).png"

case "$1" in
    area-save|area-copy)
        # freeze the screen first so menus stay visible, then re-run self
        exec wayfreeze --after-freeze-cmd "$0 --pick $1"
        ;;
    --pick)
        region=$(slurp) || { pkill wayfreeze; exit 0; }
        if [ "$2" = "area-save" ]; then
            grim -g "$region" "$file"
        else
            grim -g "$region" - | wl-copy
        fi
        pkill wayfreeze
        ;;
    screen-copy)
        grim - | wl-copy
        ;;
esac
