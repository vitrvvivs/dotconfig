#!/bin/bash

# Terminate already running bar instances
pidfile="$HOME/.config/polybar/${DISPLAY/:/}.pid"
# Match lines in pidfile to processes named "polybar" (don't kill the wrong process on reboot)
grep -Fxf <(pgrep -x polybar) "$pidfile" | xargs kill &>/dev/null

# gap=($(bspc config window_gap))
gap=0
dpi="$(xrdb -query | grep Xft.dpi | cut -f 2)"
HEIGHT="$(( 24 * dpi / 96 ))"

# primary monitor
MONITOR=$(xrandr | sed -nE 's/^(.+) connected primary.*/\1/p') \
WLAN=$(ip link show | grep " wlp" | sed -E 's/^[0-9]+: (wlp.*):.*/\1/') \
ETH=$(ip link show | grep " enp" | sed -E 's/^[0-9]+: (enp.*):.*/\1/') \
WIDTH=$(( $(xrandr | grep ' connected primary' | cut -d' ' -f4 | sed 's/x.*$//') - gap - gap )) \
HEIGHT="$HEIGHT" \
PADDING=$(( gap )) \
DPI="$DPI" \
NETTOTAL_SCRIPT="$HOME/.config/bin/nettotal" \
polybar topbar "$@" &> "$HOME/.config/polybar/primary.log" &
echo "$!" > "$pidfile"

# other monitors
xrandr | sed -nE '/primary/d;s/^(.+) connected ([^ ]+).*$/\1 \2/p' |\
while read -r name res; do
	MONITOR=$name \
	WIDTH=$(( ${res/x*/} - gap - gap )) \
	HEIGHT="$HEIGHT" \
	PADDING=$(( gap )) \
	polybar offbar "$@" 2>"$HOME/.config/polybar/$name.log" &
    echo "$!" >> "$pidfile"
done
