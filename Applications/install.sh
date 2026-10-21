### Tor-Browser ###
cp -r ~/apps/tor-browser/start-tor-browser.desktop ~/.local/share/applications/

### Localsend ###
mkdir ~/local/share/localsend
mv -f ~/apps/LocalSend.AppImage ~/.local/share/localsend/
cp -r ~/SourceApps/Applications/localsend/localsend-logo.png ~/.local/share/localsend
cp -r ~/SourceApps/Applications/localsend/localsend.desktop ~/.local/share/applications/
cp -r ~/SourceApps/Applications/localsend/localsend ~/.local/bin/

### PDFCraft ###
cp -r ~/SourceApps/Applications/pdfcraft/ ~/.local/share/
cp -r ~/apps/pdfcraft.AppImage ~/.local/share/pdfcraft/
cp -r ~/SourceApps/Applications/pdfcraft/pdfcraft.desktop ~/.local/share/applications/
cp -r ~/SourceApps/Applications/pdfcraft/pdfcraft ~/.local/bin/

### Firefox Mainline ###
cp -r ~/SourceApps/Applications/firefox-new/ ~/.local/share/
cp -r ~/apps/firefox/ ~/.local/share/firefox-new/
cp -r ~/SourceApps/Applications/firefox-new/firefox-new ~/.local/bin/
cp -r ~/SourceApps/Applications/firefox-new/firefox-new.desktop ~/.local/share/applications/

mkdir -p "$HOME/.local/share/icons/hicolor/512x512/apps"
install -m 644 ~/.local/share/firefox-new/firefox.png "$HOME/.local/share/icons/hicolor/512x512/apps/firefox-new.png"
install -m 644 ~/.local/share/localsend/localsend-logo.png "$HOME/.local/share/icons/hicolor/512x512/apps/localsend-logo.png"
install -m 644 ~/.local/share/pdfcraft/pdfcraft.png "$HOME/.local/share/icons/hicolor/512x512/apps/pdfcraft.png"

# gsettings get org.gnome.shell favorite-apps
# desktop-file-validate ~/.local/share/applications/*
