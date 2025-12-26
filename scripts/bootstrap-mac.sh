#!/bin/bash
set -e

echo ">>> Starting Bootstrap for Mac..."

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

# 4. Clone Repository (if not running from it)
REPO_DIR="$HOME/dot"
if [ ! -d "$REPO_DIR" ]; then
    echo ">>> Cloning dotfiles repository..."
    # Assuming public or ssh key is set up
    git clone https://github.com/jwaspin/dot.git "$REPO_DIR"
else
    echo ">>> Dotfiles repository exists at $REPO_DIR"
fi

# 5. Hand off to Python
echo ">>> Handing off to Python installer..."
python3 "$REPO_DIR/scripts/install_mac.py"
