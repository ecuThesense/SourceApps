### Tor-Browser ###
cp -r ~/apps/tor-browser/start-tor-browser.desktop ~/.local/share/applications/
# mv -r ~/apps/firefox/ /usr/bin/firefox
cp -r ~/SourceApps/Applications/firefox-new.desktop ~/.local/share/applications/

### Localsend ###
doas mkdir /usr/local/share/localsend
doas mv -f ~/apps/LocalSend.AppImage /usr/local/share/localsend
wget https://github.com/localsend/localsend/blob/main/app/assets/img/logo-512.png?raw=true
mv ~/SourceApps/Applications/logo-512.png?raw=true ~/SourceApps/Applications/localsend-logo.png
doas mv -f ~/SourceApps/Applications/localsend-logo.png /usr/local/share/localsend
doas cp -r ~/SourceApps/Applications/localsend.desktop /usr/local/share/applications/

# gsettings get org.gnome.shell favorite-apps
# desktop-file-validate ~/.local/share/applications/*
