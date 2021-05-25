# Disable bell
xset -b

# Load xresources
[[ -f ~/.config/xresources/xresources ]] && xrdb -merge "$HOME/.config/xresources/xresources"

primary="eDP-1"

#nvidia
#xrandr --setprovideroutputsource modesetting NVIDIA-G0
#primary="eDP-1-1"

xrandr --output "$primary" --auto --primary --dpi 144

# run hardware-specific configuration scripts
for script in "$HOME"/.config/bin/xinit/*; do
    bash "$script"
done

# Set desktop background
[[ -x "$HOME/.fehbg" ]] && "$HOME/.fehbg" &

# Start "screensaver"
xautolock -locker i3lock-fancy -time 10 &

# Start the Window Manager
exec bspwm
