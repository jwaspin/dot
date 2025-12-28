
#!/bin/bash
set -e

# Ensure sudo password is cached
if ! sudo -v; then
    echo "!! Sudo is required to run this script. Exiting."
    exit 1
fi

# Ensure default login shell is bash
BASH_PATH="$(command -v bash)"
# Read the user's login shell from directory service (macOS)
CURRENT_LOGIN_SHELL="$(dscl . -read /Users/$USER UserShell 2>/dev/null | awk '{print $2}')"
# Fallback to $SHELL if dscl fails or returns empty
if [ -z "$CURRENT_LOGIN_SHELL" ]; then
    CURRENT_LOGIN_SHELL="$SHELL"
fi

if [ "$CURRENT_LOGIN_SHELL" != "$BASH_PATH" ]; then
    echo ">>> Changing default login shell to bash ($BASH_PATH) for user $USER..."
    if ! grep -qx "$BASH_PATH" /etc/shells; then
        echo "$BASH_PATH" | sudo tee -a /etc/shells
    fi
    if chsh -s "$BASH_PATH" "$USER"; then
        echo ">>> Default shell changed to bash. Please log out and log back in for the change to take effect."
    else
        echo "!! Failed to change default shell."
    fi
else
    echo ">>> Default login shell is already bash."
fi

DOTFILES_DIR="$HOME/dot"
REPO_URL="git@github.com:jwaspin/dot.git"

echo ">>> Starting Bootstrap for Mac..."

# 0. Ensure Dotfiles Repo is Cloned
if [ ! -d "$DOTFILES_DIR" ]; then
    echo ">>> Cloning dotfiles to $DOTFILES_DIR..."
    if ! command -v git &> /dev/null; then
        echo "!! git not found. Attempting to install Xcode Command Line Tools..."
        xcode-select --install || true
        echo "!! Please complete the Xcode installation and run this script again."
        exit 1
    fi
    git clone "$REPO_URL" "$DOTFILES_DIR"

else
    echo ">>> Dotfiles already present at $DOTFILES_DIR"
    echo ">>> Updating dotfiles repo..."
    git -C "$DOTFILES_DIR" pull --ff-only || echo "!! Failed to update dotfiles repo. Continuing with existing files."
fi

# Link macOS bash configuration
repo_root="$DOTFILES_DIR"
ln -sfn "$repo_root/files/bash/mac/bashrc" "$HOME/.bashrc"
ln -sfn "$repo_root/files/bash/mac/bash_profile" "$HOME/.bash_profile"
ln -sfn "$repo_root/files/bash/mac/bash_aliases" "$HOME/.bash_aliases"
echo ">>> Linked bash configs for macOS."

# 1. Install Xcode Command Line Tools
if ! xcode-select -p &> /dev/null; then

    echo ">>> Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "!! Please complete the Xcode installation dialog and run this script again."
    exit 1
fi

# 2. Install Homebrew (robust for curl | bash)
# Always add Homebrew to PATH if present, before checking/installing
if [ -x "/opt/homebrew/bin/brew" ]; then
    eval "$('/opt/homebrew/bin/brew' shellenv)"
elif [ -x "/usr/local/bin/brew" ]; then
    eval "$('/usr/local/bin/brew' shellenv)"
fi

if ! command -v brew &> /dev/null; then
    echo ">>> Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add brew to path for this session after install
    if [ -x "/opt/homebrew/bin/brew" ]; then
        eval "$('/opt/homebrew/bin/brew' shellenv)"
    elif [ -x "/usr/local/bin/brew" ]; then
        eval "$('/usr/local/bin/brew' shellenv)"
    fi
else
    echo ">>> Homebrew already installed. Skipping installation."
fi

# 3. Install Python
if ! command -v python3 &> /dev/null; then
    echo ">>> Installing Python..."
    brew install python
else
    echo ">>> Python already installed."
fi

# 4. Hand off to Python
echo ">>> Handing off to Python installer..."
python3 "$DOTFILES_DIR/scripts/install_mac.py"

