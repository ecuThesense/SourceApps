dconf reset -f /org/gnome/settings-daemon/plugins/media-keys/
dconf reset -f /org/gnome/desktop/wm/keybindings/
dconf reset -f /org/gnome/shell/keybindings/
dconf reset -f /org/gnome/mutter/keybindings/

dconf load /org/gnome/desktop/wm/keybindings/              < wm-keybindings.dconf
dconf load /org/gnome/shell/keybindings/                   < shell-keybindings.dconf
dconf load /org/gnome/mutter/keybindings/                  < mutter-keybindings.dconf
dconf load /org/gnome/settings-daemon/plugins/media-keys/  < media-keys.dconf
