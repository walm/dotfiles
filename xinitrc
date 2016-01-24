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

# infinite loop, reload for wm
exec sh -c "while true; do \
  frankenwm ;\
  sleep 1 ;\
done"

