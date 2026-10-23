# su - && apt update && apt upgrade -y && apt install doas -y
# vi /etc/doas.conf
# permit persist username as root
# chown root:root /etc/doas.conf
# chmod 0400 /etc/doas.conf
# apt purge sudo && apt autoremove -y
doas apt update && doas apt upgrade -y && doas apt full-upgrade -y && doas apt autoremove -y
doas apt install git fzf firefox-esr thunderbird gimp libreoffice timeshift htop imagemagick ffmpeg mat2 secrets celluloid foomatic-db cups cups-pk-helper curl wl-clipboard make clang cmake ninja-build rustup meson just tealdeer vrms wget manpages man-db laptop-detect golang-go gnupg gcc mc converseen
doas apt install ripgrep fd-find luarocks lazygit python3-pynvim
# doas apt purge foot-terminfo gnome-software-plugin-flatpak flatpak -y && doas apt autoremove -y

cp ~/SourceApps/.bashrc ~/.bashrc
cp -r ~/SourceApps/AdwaitaMono/ ~/.local/share/fonts/
rm -rf ~/.config/alacritty/
cp -r ~/SourceApps/alacritty/ ~/.config/
fc-cache -fv
cp -r ~/SourceApps/Templates/ ~/
exec ~/SourceApps/gnome/keybindings-import.sh
exec ~/SourceApps/neovim/install.sh
doas exec ~/SourceApps/Vimix-Grub/install.sh

mkdir -p ~/apps/

curl -LO ~/apps/ https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
curl -LO ~/apps/ https://github.com/pkgforge-dev/PDF-Tricks-AppImage/releases/download/0.4.1-2%402026-10-22_1792689058/PDF_Tricks-0.4.1-2-anylinux-x86_64.AppImage
curl -LO ~/apps/ https://github.com/pkgforge-dev/Eyedropper-AppImage/releases/download/2.2.1-1%402026-10-22_1792689101/Eyedropper-2.2.1-1-anylinux-x86_64.AppImage
curl -LO ~/apps/ https://github.com/janhq/jan/releases/download/v0.8.7/Jan_0.8.7_amd64.AppImage
curl -LO ~/apps/ https://github.com/pkgforge-dev/Gradia-AppImage/releases/download/1.13.0%402026-10-22_1792688704/Gradia-1.13.0-anylinux-x86_64.AppImage
curl -LO ~/apps/ https://github.com/pkgforge-dev/Impression-AppImage/releases/download/3.8.0-1%402026-10-22_1792689451/Impression-3.8.0-1-anylinux-x86_64.AppImage
curl -LO ~/apps/ https://github.com/localsend/localsend/releases/download/v1.18.2/LocalSend-1.18.2-linux-x86-64.AppImage
curl -LO ~/apps/ https://github.com/pkgforge-dev/NewsFlash-AppImage/releases/download/5.2.3-1%402026-10-22_1792688923/Newsflash-5.2.5-1-anylinux-x86_64.AppImage
curl -LO ~/apps/ https://github.com/storytold/pdfcraft/releases/download/v0.13.0/pdfcraft-0.13.0-linux-x86_64.AppImage
curl -LO ~/apps/ https://github.com/pkgforge-dev/PDF-Tricks-AppImage/releases/download/0.4.1-2%402026-10-22_1792689058/PDF_Tricks-0.4.1-2-anylinux-x86_64.AppImage

bin-import ~/apps/

# source ~/.bashrc
# doas update-alternatives --config x-terminal-emulator
# gsettings set org.gnome.desktop.default-applications.terminal exec '/usr/bin/gnome-terminal.wrapper'
# gsettings set org.gnome.desktop.default-applications.terminal exec-arg '-e'
# * 0  /usr/bin/gnome-terminal.wrapper   40   auto mode
