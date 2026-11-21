#!/usr/bin/env bash

if pgrep -x .waybar-wrapped >/dev/null; then
    pkill -SIGUSR1 -x .waybar-wrapped
else
    setsid waybar >/dev/null 2>&1 &
fi
