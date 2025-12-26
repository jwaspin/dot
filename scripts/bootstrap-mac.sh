#!/bin/bash
set -e

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
fi

# 1. Install Xcode Command Line Tools
if ! xcode-select -p &> /dev/null; then

    echo ">>> Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "!! Please complete the Xcode installation dialog and run this script again."
    exit 1
fi

# 2. Install Homebrew
if ! command -v brew &> /dev/null; then
    echo ">>> Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add brew to path for this session
    if [ -f "/opt/homebrew/bin/brew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -f "/usr/local/bin/brew" ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo ">>> Homebrew already installed."
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

