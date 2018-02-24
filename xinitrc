#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# no bell
xset -b

# fast keyboard repeat
xset r rate 200 25

# merge in defaults and keymaps
[ -f "$sysresources" ] && xrdb -merge "$sysresources"
[ -f "$sysmodmap" ] && xmodmap "$sysmodmap"
[ -f "$userresources" ] && xrdb -merge "$userresources"
[ -f "$usermodmap" ] && xmodmap "$usermodmap"

vmware-user
sleep 2
# feh --image-bg black --bg-max '/home/walm/wallpapers/01uIG2a.jpg' --geometry +0 --no-fehbg
exec i3 --shmlog-size 0
