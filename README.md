# dotfiles

My personal macOS development environment — clean, fast, and version-controlled.

---

## What's Inside

| File | Description |
|------|-------------|
| `zshrc` | Zsh config — Oh My Zsh, Powerlevel10k, NVM, pyenv |
| `zprofile` | Login shell — Homebrew, pyenv path setup |
| `aliases` | Custom shell aliases |
| `gitconfig` | Git identity, aliases, colors |
| `config` | SSH config — keychain + ed25519 key |
| `settings.json` | VS Code settings |
| `keybindings.json` | VS Code keybindings |
| `nvim/` | Neovim config (kickstart.nvim based) |
| `com.googlecode.iterm2.plist` | iTerm2 preferences |
| `install.sh` | One-command setup script |

---

## Fresh Machine Setup

### 1. Prerequisites

```sh
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

### 2. Clone this repo

```sh
git clone https://github.com/Eyosias1/dotfiles.git ~/.dotfiles
```

### 3. Run the install script

```sh
cd ~/.dotfiles
zsh install.sh
```

That's it. Open a new terminal tab and you're good to go.

---

## What `install.sh` Does

- Symlinks `zshrc`, `zprofile`, `aliases`, `gitconfig` → `~/.<name>`
- Symlinks `config` → `~/.ssh/config` and adds your SSH key to the keychain
- Symlinks `settings.json` and `keybindings.json` → VS Code user folder
- Symlinks `nvim/` → `~/.config/nvim`
- Configures iTerm2 to load prefs from this folder
- Installs `zsh-syntax-highlighting` and `zsh-autosuggestions` if missing

> Existing files are backed up as `<file>.backup` before being replaced.

---

## iTerm2

Preferences are stored in `com.googlecode.iterm2.plist`.

On a new machine, after running `install.sh`, restart iTerm2 — it will automatically load settings from this folder.

To re-export after making changes in iTerm2:
> iTerm2 → Preferences → General → Preferences → Save Current Settings to Folder

---

## Neovim

Config lives in `nvim/` and is based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

```
nvim/
├── init.lua              # Entry point
└── lua/
    ├── kickstart/        # Built-in kickstart plugins
    └── custom/           # Your personal additions
```

Plugin manager: [lazy.nvim](https://github.com/folke/lazy.nvim)

---

## Shell

- **Framework:** Oh My Zsh
- **Theme:** Powerlevel10k
- **Plugins:** git, zsh-syntax-highlighting, zsh-autosuggestions, history-substring-search
- **Node:** NVM (auto-switches via `.nvmrc`)
- **Python:** pyenv

---

## VS Code

Extensions expected:
- Neovim (`asvetliakov.vscode-neovim`) — configured with `/opt/homebrew/bin/nvim`
- Material Icon Theme
- Black Formatter (Python)
