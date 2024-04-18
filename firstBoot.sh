#!/bin/bash
# Ensure the script exits on any error
set -e

# Setting the default USB drive path
USB_DRIVE_PATH="${1:-/Volumes/SKINNY}"

# Install Homebrew
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to the PATH
eval "$(/opt/homebrew/bin/brew shellenv)"

# Check and install necessary packages from Brewfile located in the same directory
if [[ ! -f "${USB_DRIVE_PATH}/dot/files/brew/Brewfile" ]]; then
    echo "Brewfile not found in ${USB_DRIVE_PATH}/dot/files/brew/"
else
    echo "Installing packages from Brewfile..."
    brew bundle --file="${USB_DRIVE_PATH}/dot/files/brew/Brewfile"
fi

# Clearing Dock Items
defaults write com.apple.dock persistent-apps -array
killall Dock

# Set defaults
if [[ ! -f "${USB_DRIVE_PATH}/dot/files/mac/defaults.sh" ]]; then
    echo "defaults.sh not found in ${USB_DRIVE_PATH}/dot/files/mac/"
else
    echo "Setting defaults..."
    /bin/bash "${USB_DRIVE_PATH}/dot/files/mac/defaults.sh" $USB_DRIVE_PATH
fi

# Install dotfiles
if [[ ! -d "${USB_DRIVE_PATH}/dot/files" ]]; then
  echo "Dotfiles directory not found in ${USB_DRIVE_PATH}/dot/files/"
else
  echo "Installing dotfiles..."
  /bin/bash "${USB_DRIVE_PATH}/dot/install.sh" -ah
fi

# Configure SSH
echo "Configuring SSH..."
mkdir -p ~/.ssh

# Copy all keys while preserving the directory structure
cp -r ${USB_DRIVE_PATH}/ssh/ ~/.ssh/

# Set correct permissions for all files in the keys directory
find ~/.ssh/keys -type f -name '*.pub' -exec chmod 644 {} \;
find ~/.ssh/keys -type f ! -name '*.pub' -exec chmod 600 {} \;

# Ensure the entire dconf.d directory and contents have appropriate permissions
chmod -R 700 ~/.ssh/dconf.d

echo "SSH configuration completed."


echo "Setup completed successfully."
