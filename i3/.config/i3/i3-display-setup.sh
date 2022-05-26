#! /bin/bash
if [ $(xrandr | grep HDMI-1 | awk '{ print $2 }') = "disconnected" ]; then
   xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off
else
   MODE=$(xrandr | grep HDMI-1 | awk '{ print $3 }')
   MODE=${MODE:0:9}
   xrandr --output eDP-1 --mode 1920x1080 --pos 0x1080 --rotate normal --output DP-1 --off --output HDMI-1 --primary --mode $MODE --pos 1920x0 --rotate normal --output DP-2 --off
   xrandr --output HDMI-1 --right-of eDP-1
fi

feh --bg-scale /home/rhoulihan/Pictures/wallpapers/aenami-1633200656101-9566.jpg
picom --experimental-backends --config /home/rhoulihan/.config/picom/picom.conf
