#!/bin/bash

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
[ -f $sysresources ] && xrdb -merge $sysresources
[ -f $sysmodmap ] && xmodmap $sysmodmap

# no bell
xset b off

# view options with `more /usr/share/X11/xkb/rules/base.lst`
# pc
setxkbmap -layout se -model pc105 -option ctrl:nocaps

# mac
#setxkbmap \
#  -layout se \
#  -model apple_laptop \
#  -variant mac \
#  -option lv3:lalt_switch \
#  -option lv3:ralt_alt

[ -f "$userresources" ] && xrdb -merge "$userresources"
# [ -f "$usermodmap" ] && xmodmap "$usermodmap"

urxvt # start this so we can run vmware-user.. and then quit and screen should be all ok
start-pulseaudio-x11
feh --image-bg black --bg-max '/home/walm/wallpapers/01uIG2a.jpg' --geometry +0 --no-fehbg
yabar &
frankenwm

