# dot

My personal dotfiles and configuration scripts for MacOS and Linux.

## Installation

### macOS

The bootstrap script will install Xcode Command Line Tools, Homebrew, Python, and then set up all dotfiles and system preferences.

```bash
# Install via curl
curl -fsSL https://raw.githubusercontent.com/jwaspin/dot/main/scripts/bootstrap-mac.sh | bash
```

**What it does:**

1.  Installs **Xcode Command Line Tools**.
2.  Installs **Homebrew** and bundles packages from `files/brew/Brewfile`.
3.  Installs **Python** and runs the setup script.
4.  Symlinks configuration files (vim, tmux, bash, git, hammerspoon) to your home directory.
5.  Sets macOS system defaults (Dock, Finder, Trackpad, etc.).

### Linux (Debian/Ubuntu)

The bootstrap script will install core dependencies (git, tmux, vim, python3) and set up dotfiles.

```bash
# Install via curl
curl -fsSL https://raw.githubusercontent.com/jwaspin/dot/main/scripts/bootstrap-linux.sh | bash
```

**What it does:**

1.  Updates `apt` and installs `git`, `tmux`, `vim`, `python3`, `build-essential`, `curl`.
2.  Runs the common Python installer to symlink configuration files.

## Structure

- `bin/`: Helper scripts added to `$PATH`.
- `files/`: The actual dotfiles, organized by topic (bash, git, vim, etc.).
- `scripts/`: Installation and bootstrapping scripts.

## Included Configurations

- **Bash**: Custom prompt, aliases, and environment setup.
- **Vim**: `vim-plug` manager, linting (ALE), fuzzy finding (FZF), and language support.
- **Tmux**: Mouse support, intuitive split bindings, and reload shortcuts.
- **Git**: Global ignore file, useful aliases (`lg`, `st`, `co`), and rebase-by-default.
- **Hammerspoon**: Window management hotkeys (halves, quarters, thirds).
- **macOS**: Automated system preferences (Dark mode, Dock settings, etc.).
