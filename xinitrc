# Disable bell
xset -b

# Configure trackpad
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Button Mapping Enabled" 0 1

# configure mouse
# ~/bin/configure_logitech_g502

# Assume DP-1 is the one at work
if (xrandr | grep "$1 connected"); then
	# 1920x1200
	xrandr --output DP-1 --auto --right-of eDP-1 --rotate left
	xrandr --output eDP-1 --pos 0x720
	# 4k
	#xrandr --output DP-1 --auto --left-of eDP-1 --rotate left
	#xrandr --output eDP-1 --pos 2160x2640
fi

# Load xresources
[[ -f ~/.config/xresources/xresources ]] && xrdb -merge "$HOME/.config/xresources/xresources"

# Set desktop background
[[ -f ~/bin/fehbg ]] && ~/bin/fehbg &

# Start "screensaver"
xautolock -locker "$HOME/bin/i3lock-next" -time 10 &

# Start the Window Manager
exec bspwm
