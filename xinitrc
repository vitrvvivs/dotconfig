# Disable bell
xset -b

systemctl --user import-environment DISPLAY XAUTHORITY

# Load xresources
[[ -f ~/.config/xresources/xresources ]] && xrdb -merge "$HOME/.config/xresources/xresources"

# run hardware-specific configuration scripts
for script in "$HOME"/.config/bin/xinit/*; do
    bash "$script" &
done

# Start the Window Manager
exec bspwm
