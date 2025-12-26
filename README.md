# dot

Personal dotfiles and configuration scripts for MacOS and Linux.

## Prerequisites

Before running the installation, ensure the following:

1.  **SSH Keys**: Configure ssh key for use with GitHub. The bootstrap scripts clone via SSH.
2.  **macOS**:
    - Install Xcode from the App Store.
    - Install **Xcode Command Line Tools** (`xcode-select --install`).
3.  **Linux**: Ensure `curl` and `sudo` are installed.

## Installation

### macOS

The bootstrap script will install Xcode Command Line Tools, Homebrew, Python, and then set up all dotfiles and system preferences.

### Install via curl

```bash
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

### Install via curl

```bash
curl -fsSL https://raw.githubusercontent.com/jwaspin/dot/main/scripts/bootstrap-linux.sh | bash
```

**What it does:**

1.  Updates `apt` and installs `git`, `tmux`, `vim`, `python3`, `build-essential`, `curl`.
2.  Runs the common Python installer to symlink configuration files.

## Post-Installation

After the bootstrap script completes:

1.  **Configure Git User**: Update your git configuration with your actual name and email.
    ```bash
    git config --global user.name "Your Name"
    git config --global user.email "your_email@example.com"
    ```
    _(Alternatively, edit `~/.gitconfig.local` if you use the include directive)_

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
