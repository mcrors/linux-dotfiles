#! /bin/bash
if [ $(xrandr | grep DP-2 | awk '{ print $2 }') = "connected" ]; then
    # work setup
    xrandr --output eDP-1 --mode 1920x1080 --pos 0x1080 --rotate normal \
           --output DP-1 --off \
           --output HDMI-1 --mode 2560x1440 --pos 5760x720 --rotate normal \
           --output DP-2 --primary --mode 3840x2160 --pos 1920x0 --rotate normal
else
    if [ $(xrandr | grep HDMI-1 | awk '{ print $2 }') = "connected" ]; then
        # home setup
        xrandr --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --primary --mode 2560x1440 --pos 1920x0 --rotate normal --output DP-2 --off
    else
        # just the laptop, no monitors
        xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off
    fi
fi

WALLPAPERS_DIR=/home/rhoulihan/Pictures
# below is for random wallpapers. Not sure if I like that.
# WALLPAPER_FILE=$(ls -t $WALLPAPERS_DIR | sort -R | tail -1)
WALLPAPER_FILE=wallpapers/snaw-1.jpg
WALLPAPER=$WALLPAPERS_DIR/$WALLPAPER_FILE
# feh --bg-scale $WALLPAPER
feh --bg-fill $WALLPAPER

picom --experimental-backends --config /home/rhoulihan/.config/picom/picom.conf
