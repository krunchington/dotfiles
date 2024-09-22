# Dotfiles

```
echo "dotfiles" >> ~/.gitignore
git clone --bare git@github.com:krunchington/dotfiles.git ~/dotfiles
git --git-dir=~/dotfiles --work-tree=~ checkout
# remove or backup any conflicting files, then try again
source ~/.zshrc
```
