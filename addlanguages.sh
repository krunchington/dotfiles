set -euo pipefail


for package in "$@"; do
    if [ ! -d "./languages/$package" ]; then
        echo "Package for language $package does not exist"
        exit 1
    fi
done

for package in "$@"; do
    echo "Installing $package"
    stow -v -t $HOME --no-folding --dotfiles -d ./languages -R $package
done

echo "Updating mise"

mise bootstrap
mise install
