# Make a backup of your current Neovim files:
# # required
mv ~/.config/nvim{,.bak}
# # optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

cp -r ~/.config/nvim/ ~/SourceApps/neovim/
