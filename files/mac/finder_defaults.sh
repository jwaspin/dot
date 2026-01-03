#!/usr/bin/env bash
# Apply Finder and related macOS defaults used in my personal setup.
# Idempotent: safe to run multiple times.

set -euo pipefail

echo ">>> Applying Finder defaults..."

# New Finder windows show the user's Home folder
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Keep folders on top in windows (and attempt to enable on desktop)
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true || true

# Show hard disks and connected servers on the Desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true

# Do not create .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Show status and path bars
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true

# Make changes take effect
killall Finder || true

echo ">>> Finder defaults applied."
