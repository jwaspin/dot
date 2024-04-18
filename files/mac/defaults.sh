#!/bin/bash

# Setting the default USB drive path
USB_DRIVE_PATH="${1:-/Volumes/SKINNY}"

defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain AppleActionOnDoubleClick -string "Minimize"
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
defaults write NSGlobalDomain NSPreferredWebServices -dict-add NSWebServicesProviderWebSearch -dict NSDefaultDisplayName DuckDuckGo NSProviderIdentifier com.duckduckgo

USER_DICT_FILE="${USB_DRIVE_PATH}/path/to/dictionary_replacements.plist"
defaults import NSGlobalDomain "$USER_DICT_FILE"

# Set trackpad settings
TRACKPAD_SETTINGS_FILE="${USB_DRIVE_PATH}/path/to/trackpad_settings.plist"
defaults import com.apple.AppleMultitouchTrackpad "$TRACKPAD_SETTINGS_FILE"
