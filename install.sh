#!/bin/bash
set -e
DOTFILES=$(cd "$(dirname "$0")" && pwd)

echo "=== dotfiles install ==="

# Homebrew
if ! command -v brew &>/dev/null; then
    echo "[install] Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "[ok] Homebrew"
fi

# Brewfile
echo "[install] Brew bundle..."
brew bundle --file="$DOTFILES/Brewfile" --no-lock

# Symlinks
link() {
    local src="$1" dst="$2"
    if [ "$(readlink "$dst" 2>/dev/null)" = "$src" ]; then
        echo "[ok] $dst"
    else
        mkdir -p "$(dirname "$dst")"
        ln -sf "$src" "$dst"
        echo "[link] $dst → $src"
    fi
}

link "$DOTFILES/.zshrc" "$HOME/.zshrc"
link "$DOTFILES/.zprofile" "$HOME/.zprofile"
link "$DOTFILES/starship.toml" "$HOME/.config/starship.toml"

# VS Code extensions
if command -v code &>/dev/null; then
    installed=$(code --list-extensions)
    while IFS= read -r ext; do
        if echo "$installed" | grep -qi "^$ext$"; then
            echo "[ok] vscode: $ext"
        else
            echo "[install] vscode: $ext"
            code --install-extension "$ext" --force
        fi
    done < "$DOTFILES/vscode/extensions.txt"
else
    echo "[skip] VS Code non installé"
fi

echo "=== done ==="
