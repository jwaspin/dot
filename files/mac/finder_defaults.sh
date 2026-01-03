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

# Show connected servers on the Desktop; do NOT show hard disks
# By default macOS may not show hard disks — keep that deselected per your preference
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true

# Do not create .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Show status and path bars
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true

# Enable three-finger drag for trackpads (may require logout/login)
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool true
defaults write com.apple.universalaccess threeFingerDrag -bool true

# Make changes take effect
killall Finder || true

echo ">>> Finder defaults applied."
