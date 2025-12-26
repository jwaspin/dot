#!/bin/bash
set -e

DOTFILES_DIR="$HOME/dot"
REPO_URL="git@github.com:jwaspin/dot.git"

echo ">>> Starting Bootstrap for Linux (Debian/Ubuntu)..."

# 0. Ensure Dotfiles Repo is Cloned
if [ ! -d "$DOTFILES_DIR" ]; then
    echo ">>> Cloning dotfiles to $DOTFILES_DIR..."
    if ! command -v git &> /dev/null; then
         # Git should be installed in step 1, but if we run this via curl, we might need it earlier?
         # Actually, step 1 installs git. So we should do step 1 first?
         # But step 1 is "Update and Install Dependencies".
         # If I curl | bash, I am running this script.
         # So I can run step 1, THEN clone.
         true
    fi
else
    echo ">>> Dotfiles already present at $DOTFILES_DIR"
fi

# 1. Update and Install Dependencies
if [ -x "$(command -v apt-get)" ]; then
    echo ">>> Updating apt and installing dependencies..."
    sudo apt-get update
    sudo apt-get install -y git tmux vim python3 python3-pip build-essential curl \
        ca-certificates gnupg lsb-release

    # Install Docker
    if ! command -v docker &> /dev/null; then
        echo ">>> Installing Docker..."
        sudo install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get update
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        sudo usermod -aG docker "$USER"
    else
        echo ">>> Docker already installed."
    fi
else
    echo "!! apt-get not found. This script currently supports Debian/Ubuntu based systems."
    exit 1
fi

# 2. Clone if not already done (now that we have git)
if [ ! -d "$DOTFILES_DIR" ]; then
    echo ">>> Cloning dotfiles to $DOTFILES_DIR..."
    git clone "$REPO_URL" "$DOTFILES_DIR"
fi

# 3. Run Common Installer
echo ">>> Running Python installer..."
python3 "$DOTFILES_DIR/scripts/install_common.py"

echo ">>> Linux Bootstrap Complete!"

