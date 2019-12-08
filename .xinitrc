#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

xrdb -merge .Xresources
xsetroot -solid black
xss-lock -n bin/lock-notify bin/lock &
xset s 600 20 # time to lock screen (first is notify)

# keyboard layout
setxkbmap capsmod # custom us layout

# Trackpoint scrolling for evdev
#xprop() { xinput set-prop "TPPS/2 IBM TrackPoint" "$@"; }
#xprop "Evdev Wheel Emulation" 1
#xprop "Evdev Wheel Emulation Button" 2
#xprop "Evdev Wheel Emulation Timeout" 200
#xprop "Evdev Wheel Emulation Axes" 6 7 4 5
#xprop "Device Accel Constant Deceleration" 0.45
#xprop "Device Accel Velocity Scaling" 10.0

bin/monitor-toggle auto

if [ "$(tty)" == "/dev/tty2" ]; then
    exec remote-viewer -f spice://localhost:5900
else
    exec i3
fi
