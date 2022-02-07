#! /bin/bash
if [ $(xrandr | grep HDMI-1 | awk '{ print $2 }') = "disconnected" ]; then
   xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off
else
   xrandr --output eDP-1 --mode 1920x1080 --pos 0x1080 --rotate normal --output DP-1 --off --output HDMI-1 --primary --mode 3840x2160 --pos 1920x0 --rotate normal --output DP-2 --off
fi

feh --bg-scale /home/rhoulihan/Pictures/wallpapers/aenami-1633200656101-9566.jpg
picom --experimental-backends --config /home/rhoulihan/.config/picom/picom.conf
