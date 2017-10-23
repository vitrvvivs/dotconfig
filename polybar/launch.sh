#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

primary_monitor=$(xrandr | grep " connected" | sort -k3 -n | head -1 | cut -d ' ' -f1)
wlan_dev=$(ip link show | sed -E 's/^[0-9]+: (wl.*):.*/\1/;tx;d;:x;q')
eth_dev=$(ip link show | sed -E 's/^[0-9]+: (en.*):.*/\1/;tx;d;:x;q')
MONITOR=$primary_monitor WLAN=$wlan_dev ETH=$eth_dev polybar topbar 2> $HOME/.config/polybar/error.log &
