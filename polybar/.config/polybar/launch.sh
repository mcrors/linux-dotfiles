#!/usr/bin/env bash
if [ $(xrandr | grep HDMI-1 | awk '{ print $2 }') = "disconnected" ]; then
    export MONITOR=eDP-1
else
    export MONITOR=HDMI-1
fi

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar main -c $HOME/.config/polybar/gruvbox/config.ini &