#!/bin/zsh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

gap=($(bspc config window_gap))

# primary monitor
MONITOR=$(xrandr | grep " connected primary" | cut -d ' ' -f1) \
WLAN=$(ip link show | grep " wlp" | sed -E 's/^[0-9]+: (wlp.*):.*/\1/') \
ETH=$(ip link show | grep " enp" | sed -E 's/^[0-9]+: (enp.*):.*/\1/') \
WIDTH=$(( $(xrandr | grep ' connected primary' | cut -d' ' -f4 | sed 's/x.*$//') - $gap - $gap )) \
HEIGHT="25" \
PADDING=$(( $gap )) \
NETTOTAL_SCRIPT="$HOME/.config/bin/nettotal" \
polybar topbar $@ &> $HOME/.config/polybar/primary.log &

# other monitors
monitors=($(xrandr | grep " connected" | grep -v "primary" | awk '{print $1, $3}'))
for name res in $monitors; do
	MONITOR=$name \
	WIDTH=$(( $(echo $res | sed 's/x.*$//') - $gap - $gap )) \
	HEIGHT="25" \
	PADDING=$(( $gap )) \
	polybar offbar $@ 2> $HOME/.config/polybar/${name}.log &
done
