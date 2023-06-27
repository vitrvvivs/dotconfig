# Disable bell
xset -b

systemctl --user import-environment DISPLAY XAUTHORITY

# Load xresources
[[ -f ~/.config/xresources/xresources ]] && xrdb -merge "$HOME/.config/xresources/xresources"

#nvidia
#xrandr --setprovideroutputsource modesetting NVIDIA-G0
#primary="eDP-1-1"
#xrandr --output "$primary" --auto --primary --dpi 144

# run hardware-specific configuration scripts
for script in "$HOME"/.config/bin/xinit/*; do
    bash "$script" &
done

# Start the Window Manager
exec bspwm
