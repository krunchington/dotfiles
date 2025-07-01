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
dotfiles config status.showuntrackedfiles no
```

## Setting up wezterm

https://wezfurlong.org/wezterm/installation.html

run
```
cp ~/.config/wezterm/wezterm.template.lua ~/.config/wezterm/wezterm.lua
```

Apply any customizations to wezterm in `~/.config/wezterm/wezterm.lua`

If you're on windows, after cloning this repo be sure to copy your wezterm config
from your wsl your user home directory in windows.

## Setting up zsh

Install zsh using an appropriate package manager for your system, and then run
```
chsh -s $(which zsh)
```
to make zsh your default shell.

Add the customizations from this repo to your .zshrc
```
echo "source ~/.config/krunchington/.zshrc.krunchington" >> .zshrc
```
And then add any desired customizations to your `.zshrc` file.  Keep order in mind,
if you wish to customize your prompt for example which is set in the krunchington
zshrc, do it after you source the krunchington zshrc.

## Setting up Nvim

https://github.com/neovim/neovim/blob/master/INSTALL.md

## Other Dependencies

rust: https://www.rust-lang.org/tools/install
ripgrep: https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation
