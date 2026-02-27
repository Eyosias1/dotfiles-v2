#!/bin/zsh

DOTFILES="$HOME/.dotfiles"

# Backup a file if it exists and is not already a symlink
backup() {
  target=$1
  if [ -e "$target" ]; then
    if [ ! -L "$target" ]; then
      mv "$target" "$target.backup"
      echo "-----> Moved your old $target config file to $target.backup"
    fi
  fi
}

# Create a symlink only if the link doesn't already exist
symlink() {
  file=$1
  link=$2
  if [ ! -e "$link" ]; then
    echo "-----> Symlinking $link -> $file"
    ln -s "$file" "$link"
  else
    echo "-----> Skipping $link (already exists)"
  fi
}

# ── Dotfiles symlinks ────────────────────────────────────────────────────────
for name in zshrc zprofile aliases gitconfig; do
  target="$HOME/.$name"
  backup "$target"
  symlink "$DOTFILES/$name" "$target"
done

# ── SSH config ───────────────────────────────────────────────────────────────
if [[ "$(uname)" =~ "Darwin" ]]; then
  mkdir -p "$HOME/.ssh"
  target="$HOME/.ssh/config"
  backup "$target"
  symlink "$DOTFILES/config" "$target"
  ssh-add --apple-use-keychain ~/.ssh/id_ed25519 2>/dev/null || true
fi

# ── VS Code settings ─────────────────────────────────────────────────────────
if [[ "$(uname)" =~ "Darwin" ]]; then
  CODE_PATH="$HOME/Library/Application Support/Code/User"
else
  CODE_PATH="$HOME/.config/Code/User"
  if [ ! -e "$CODE_PATH" ]; then
    CODE_PATH="$HOME/.vscode-server/data/Machine"
  fi
fi

mkdir -p "$CODE_PATH"
for name in settings.json keybindings.json; do
  target="$CODE_PATH/$name"
  backup "$target"
  symlink "$DOTFILES/$name" "$target"
done

# ── Neovim config ────────────────────────────────────────────────────────────
mkdir -p "$HOME/.config"
target="$HOME/.config/nvim"
if [ -e "$target" ] && [ ! -L "$target" ]; then
  echo "-----> Backing up existing ~/.config/nvim to ~/.config/nvim.backup"
  mv "$target" "$target.backup"
fi
symlink "$DOTFILES/nvim" "$target"

# ── iTerm2 preferences ───────────────────────────────────────────────────────
if [[ "$(uname)" =~ "Darwin" ]]; then
  if [ -f "$DOTFILES/com.googlecode.iterm2.plist" ]; then
    echo "-----> Configuring iTerm2 to load prefs from $DOTFILES"
    defaults write com.googlecode.iterm2 PreferencesFolder "$DOTFILES"
    defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
    echo "       Restart iTerm2 for changes to take effect."
  else
    echo "-----> iTerm2 plist not found in $DOTFILES — skipping."
    echo "       Export your iTerm2 prefs via iTerm2 → Preferences → General → Preferences,"
    echo "       set the folder to $DOTFILES, then re-run install.sh."
  fi
fi

# ── zsh plugins ──────────────────────────────────────────────────────────────
ZSH_PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins"
mkdir -p "$ZSH_PLUGINS_DIR"

if [ ! -d "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting" ]; then
  echo "-----> Installing zsh plugin 'zsh-syntax-highlighting'..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting"
fi

if [ ! -d "$ZSH_PLUGINS_DIR/zsh-autosuggestions" ]; then
  echo "-----> Installing zsh plugin 'zsh-autosuggestions'..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_PLUGINS_DIR/zsh-autosuggestions"
fi

echo ""
echo "✅ Done! Open a new terminal tab to load the new configuration."
