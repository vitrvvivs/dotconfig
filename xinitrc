# Disable bell
xset -b

# Configure trackpad
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Button Mapping Enabled" 0 1

# configure mouse
# ~/bin/configure_logitech_g502

# monitors
"$HOME/bin/configure-monitors"

# Load xresources
[[ -f ~/.config/xresources/xresources ]] && xrdb -merge "$HOME/.config/xresources/xresources"

# Set desktop background
[[ -f ~/bin/fehbg ]] && ~/bin/fehbg &

# Start "screensaver"
xautolock -locker "$HOME/bin/i3lock-next" -time 10 &

# Start the Window Manager
export _JAVA_AWT_WM_NONREPARENTING=1 # bspwm doesn't play nice with java
exec bspwm
