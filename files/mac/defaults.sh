#!/bin/bash

# Setting the default USB drive path
USB_DRIVE_PATH="${1:-/Volumes/SKINNY}"
MAC_SETTINGS_PATH="${USB_DRIVE_PATH}/dot/files/mac"

defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain AppleActionOnDoubleClick -string "Minimize"
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
defaults write NSGlobalDomain NSPreferredWebServices -dict-add NSWebServicesProviderWebSearch -dict NSDefaultDisplayName DuckDuckGo NSProviderIdentifier com.duckduckgo

USER_DICT_FILE="${MAC_SETTINGS_PATH}/dictionary_replacements.plist"
defaults import NSGlobalDomain "$USER_DICT_FILE"

# Set trackpad settings
TRACKPAD_SETTINGS_FILE="${MAC_SETTINGS_PATH}/trackpad_settings.plist"
defaults import com.apple.AppleMultitouchTrackpad "$TRACKPAD_SETTINGS_FILE"

MOUSE_SETTINGS_FILE="${MAC_SETTINGS_PATH}/mouse_settings.plist"
defaults import com.apple.driver.AppleHIDMouse "$MOUSE_SETTINGS_FILE"

DOCK_SETTINGS_FILE="${MAC_SETTINGS_PATH}/dock_settings.plist"
defaults import com.apple.dock "$DOCK_SETTINGS_FILE"
