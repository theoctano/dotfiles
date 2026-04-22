# dotfiles

My macOS/Linux development environment.

## Quick start

```bash
brew install gh && gh auth login
git clone https://github.com/theoctano/dotfiles.git ~/Repositories/dotfiles
cd ~/Repositories/dotfiles && ./install.sh
source ~/.zshrc
```

## What's included

- **Shell**: zsh with autosuggestions + syntax-highlighting, starship prompt
- **Packages**: Brewfile with CLI tools and casks
- **VS Code**: extensions list (settings managed by native sync)
- **Install script**: idempotent, safe to re-run
