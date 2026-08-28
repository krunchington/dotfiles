set -euo pipefail

if command -v brew >/dev/null 2>&1; then
    if ! command -v stow >/dev/null 2>&1; then
        brew install stow
    fi

elif command -v pacman >/dev/null 2>&1; then
    if ! command -v stow >/dev/null 2>&1; then
        sudo pacman -Sy --noconfirm stow
    fi
else
    echo "Could not find a supported package manager"
    echo "Expected brew on macOS or pacman on Linux"
    exit 1
fi

if ! command -v mise >/dev/null 2>&1; then
    echo "Could not find mise installed"
    exit 1
fi

echo ""
echo "****************"
echo "STOWING DOTFILES"
echo "****************"
echo ""

# stow -v -t $HOME --dotfiles -R wezterm
# stow -v -t $HOME --dotfiles -R hypr
stow -v -t $HOME --dotfiles -R --no-folding base
if echo $OSTYPE | grep "darwin"; then
    stow -v -t $HOME --dotfiles -R --no-folding mac
fi

echo ""
echo "**************"
echo "UPDATING ZSHRC"
echo "**************"
echo ""

if ! grep -q 'source  ~/.config/krunchington/zshrc.krunchington' $HOME/.zshrc; then
    echo 'source  ~/.config/krunchington/zshrc.krunchington' >> $HOME/.zshrc
fi

echo ""
echo "****************"
echo "INSTALLING TOOLS"
echo "****************"
echo ""

mise bootstrap
mise install

