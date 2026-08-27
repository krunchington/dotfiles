set -euo pipefail

PACKAGE=$1

if [ ! -d "./$PACKAGE" ]; then
    echo "Package $PACKAGE does not exist"
    exit 1
fi

echo "Installing $PACKAGE"

stow -v -t $HOME --dotfiles -R $PACKAGE

echo "Updating mise"

mise bootstrap
mise install
