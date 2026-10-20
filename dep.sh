# apt install doas
# apt purge sudo && apt autoremove -y
doas apt update && doas apt upgrade -y && doas apt full-upgrade -y && doas apt autoremove -y
doas apt install git fzf firefox-esr thunderbird gimp libreoffice timeshift htop imagemagick ffmpeg mat2 secrets celluloid foomatic-db cups cups-pk-helper curl wl-clipboard make clang cmake ninja-build rustup meson just tealdeer vrms wget manpages man-db laptop-detect golang-go gnupg gcc mc
doas apt install ripgrep fd-find luarocks lazygit python3-pynvim
doas apt purge foot-terminfo gnome-software-plugin-flatpak flatpak -y && doas apt autoremove -y

cp ~/SourceApps/.bashrc ~/.bashrc
cp -r ~/SourceApps/AdwaitaMono/ ~/.local/share/fonts/
rm -rf ~/.config/alacritty/
cp -r ~/SourceApps/alacritty/ ~/.config/
fc-cache -fv
source ~/.bashrc
# doas update-alternatives --config x-terminal-emulator
# gsettings set org.gnome.desktop.default-applications.terminal exec '/usr/bin/gnome-terminal.wrapper'
# gsettings set org.gnome.desktop.default-applications.terminal exec-arg '-e'
# * 0  /usr/bin/gnome-terminal.wrapper   40   auto mode
