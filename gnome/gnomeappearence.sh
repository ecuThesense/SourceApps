# In case if you used gtk3 or something like that and want to switch to original gnome
dconf dump / >~/dconf-backup.ini
# dconf load / < ~/dconf-backup.ini
dconf reset -f /org/gnome/desktop/interface/
dconf reset -f /org/gnome/desktop/wm/preferences/
dconf reset -f /org/gnome/desktop/background/
dconf reset -f /org/gnome/desktop/screensaver/
dconf reset -f /org/gnome/shell/extensions/
dconf reset -f /org/gnome/shell/
dconf reset -f /org/gnome/mutter/
mkdir ~/appearance-old
mv ~/.themes ~/.icons ~/.fonts ~/appearance-old/ 2>/dev/null
mv ~/.local/share/themes ~/.local/share/icons ~/.local/share/gnome-shell/extensions ~/appearance-old/ 2>/dev/null
mv ~/.config/gtk-3.0/settings.ini ~/.config/gtk-3.0/gtk.css ~/appearance-old/ 2>/dev/null
mv ~/.config/gtk-4.0/settings.ini ~/.config/gtk-4.0/gtk.css ~/appearance-old/ 2>/dev/null
# env | grep -E 'GTK_THEME|QT_QPA|QT_STYLE|XCURSOR|GDK_'
#for i in $(seq 1 9); do
#  gsettings set org.gnome.shell.keybindings switch-to-application-$i "[]"
#  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Super>$i']"
#  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$i "['<Super><Shift>$i']"
#done
