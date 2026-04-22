# Prerequisites: brew, starship, claude-code

# Variables
export DOTFILES_FOLDER="$HOME/Repositories/dotfiles"

# Aliases
alias v="code"
alias tf="terraform"
alias ll="ls -la"
alias zshreload="source $HOME/.zshrc"
alias zshrefresh="zshreload"
alias zshrc="code $HOME/.zshrc"
alias ccc="code $HOME/.claude/settings.json"
alias icloud="cd $HOME/Library/Mobile\ Documents/com-apple-CloudDocs/"
alias dotfiles="cd $DOTFILES_FOLDER"

# Functions
gitcp() {
  git add -A
  msg=$(git diff --cached | claude -p --model claude-haiku-4-5-20251001 "Generate a concise conventional commit message from this diff. Output only the message, nothing else.")
  git commit -m "$msg"
  git push
}
export -f gitcp

tmux-shortcuts() {
  echo "=== TMUX shortcuts ==="
  echo "Everything uses Ctrl+B"
  echo "% => Split vertical || \" => Split horizontal || ←↑↓→ => Naviguer entre panes"
  echo "z => Zoom || x => Fermer pane || c => Nouvelle fenêtre || 1-9 => Choix fenêtre"
  echo "n / p => Fenêtre suivante / précédente || , => Renommer fenêtre"
  echo "d => Détacher la session"
  echo "s => Lister les sessions"
  echo "D => Fermer pane/window"
}
export -f tmux-shortcuts

# Bindings
bindkey "^Z" undo

# Private aliases (from dotfiles-private)
[ -f "$HOME/.aliases-private" ] && source "$HOME/.aliases-private"

# Plugins
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Path
export PATH="/opt/homebrew/bin:$PATH"
fpath+=("$(brew --prefix)/share/zsh/site-functions")

# Prompt
eval "$(starship init zsh)"
