cp -r ~/.bashrc ~/SourceApps/
exec ~/SourceApps/neovim/backup.sh
exec ~/SourceApps/gnome/keybindings-export.sh

git add ~/SourceApps/. && git commit -m "fix" && git push
