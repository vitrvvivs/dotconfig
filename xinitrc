# Disable bell
xset -b

# Configure trackpad
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Button Mapping Enabled" 0 1

# configure mouse
"$HOME/.config/bin/configure-logitech-g502"

# monitors
"$HOME/.config/bin/configure-monitors"

# Load xresources
[[ -f ~/.config/xresources/xresources ]] && xrdb -merge "$HOME/.config/xresources/xresources"

# Set desktop background
[[ -x "$HOME/.fehbg" ]] && "$HOME/.fehbg" &

# Start "screensaver"
# xautolock -locker "$HOME/bin/i3lock-next" -time 10 &

# Start the Window Manager
exec bspwm
