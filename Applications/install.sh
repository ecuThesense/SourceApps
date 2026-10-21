### Tor-Browser ###
cp -r ~/apps/tor-browser/start-tor-browser.desktop ~/.local/share/applications/
# mv -r ~/apps/firefox/ /usr/bin/firefox
cp -r ~/SourceApps/Applications/firefox-new.desktop ~/.local/share/applications/

### Localsend ###
doas mkdir /usr/local/share/localsend
doas mv -f ~/apps/LocalSend.AppImage /usr/local/share/localsend
doas cp -r ~/SourceApps/Applications/localsend/localsend-logo.png /usr/local/share/localsend
doas cp -r ~/SourceApps/Applications/localsend/localsend.desktop /usr/local/share/applications/
doas cp -r ~/SourceApps/Applications/localsend/localsend /usr/local/bin/

doas cp -r ~/SourceApps/Applications/pdfcraft/ /usr/local/share/
doas cp -r ~/apps/pdfcraft.AppImage /usr/local/share/pdfcraft/
doas cp -r ~/SourceApps/Applications/pdfcraft/pdfcraft.desktop /usr/local/share/applications/
doas cp -r ~/SourceApps/Applications/pdfcraft/pdfcraft /usr/local/bin/

doas cp -r ~/SourceApps/Applications/firefox-new/ /usr/local/share/
doas cp -r ~/SourceApps/Applications/firefox-new/firefox-new /usr/local/bin/
doas cp -r ~/SourceApps/Applications/firefox-new/firefox-new.desktop /usr/local/share/applications/

# gsettings get org.gnome.shell favorite-apps
# desktop-file-validate ~/.local/share/applications/*
