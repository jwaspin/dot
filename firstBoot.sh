#!/bin/bash
# Ensure the script exits on any error
set -e

# Install Homebrew
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Check and install necessary packages from Brewfile located in the same directory
echo "Installing packages from Brewfile..."
brew bundle --file=/USB_drive/Brewfile

# Apply dotfiles
echo "Applying dotfiles..."
cp /USB_drive/dotfiles/.bashrc ~/
cp /USB_drive/dotfiles/.zshrc ~/
cp /USB_drive/dotfiles/.vimrc ~/
cp /USB_drive/dotfiles/.gitconfig ~/

# Configure SSH
echo "Configuring SSH..."
mkdir -p ~/.ssh
cp /USB_drive/ssh_keys/id_rsa ~/.ssh/
cp /USB_drive/ssh_keys/id_rsa.pub ~/.ssh/
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub

# Run Ansible Playbooks
echo "Running Ansible playbooks..."
ansible-playbook /USB_drive/ansible/main.yml

echo "Setup completed successfully."
