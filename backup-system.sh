cp -r ~/.bashrc ~/SourceApps/
exec ~/SourceApps/neovim/backup.sh
exec ~/SourceApps/gnome/keybindings-export.sh

git add . && git commit -m "fix" && git push
