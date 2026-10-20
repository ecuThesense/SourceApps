# apt install doas
# apt purge sudo && apt autoremove -y
doas apt update && doas apt upgrade -y && doas apt full-upgrade -y && doas apt autoremove -y
doas apt install git fzf firefox-esr thunderbird gimp libreoffice timeshift htop imagemagick ffmpeg mat2 secrets celluloid foomatic-db cups cups-pk-helper curl wl-clipboard make clang cmake ninja-build rustup meson just tealdeer vrms wget manpages man-db laptop-detect golang-go gnupg gcc mc
doas apt install starship
doas apt install ripgrep fd-find luarocks lazygit python3-pynvim
doas apt purge foot-terminfo gnome-software-plugin-flatpak flatpak -y && doas apt autoremove -y

cp ~/SourceApps/starship.toml ~/.config/starship.toml
cp ~/SourceApps/starship-base.toml ~/.config/starship-base.toml
cp ~/SourceApps/.bashrc ~/.bashrc
cp -r ~/SourceApps/AdwaitaMono/ ~/.local/share/fonts/
rm -rf ~/.config/alacritty/
cp -r ~/SourceApps/alacritty/ ~/.config/
fc-cache -fv
source ~/.bashrc
