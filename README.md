# Dotfiles

My dotfiles setup using wezterm, zsh, and nvim

## Cloning the repo

```
cd ~
echo "dotfiles" >> ./.gitignore
git clone --bare git@github.com:krunchington/dotfiles.git ./dotfiles
git --git-dir=./dotfiles --work-tree=./checkout
# remove or backup any conflicting files, then try again
source ~/.zshrc
```

## Setting up wezterm

https://wezfurlong.org/wezterm/installation.html

If you're on windows, after cloning this repo be sure to copy ~/.wezterm.lua
from your wsl into your user home directory in windows.

## Setting up zsh

Install zsh using an appropriate package manager for your system, and then run
```
chsh -s $(which zsh)
```
to make zsh your default shell.  Add any custom zsh commands to `~/.zshrc.custom`

## Setting up Nvim

https://github.com/neovim/neovim/blob/master/INSTALL.md
