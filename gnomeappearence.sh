dconf dump / > ~/dconf-backup.ini
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
