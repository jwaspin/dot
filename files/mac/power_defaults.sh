#!/usr/bin/env bash
# Apply Lock Screen + power settings for macOS (AC block + battery block when battery exists)

set -euo pipefail

echo ">>> Applying mac power defaults..."

# AC / desktop block (always runs)
echo ">>> Applying AC Lock Screen settings"
defaults -currentHost write com.apple.screensaver idleTime -int 3600
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 3600
defaults write com.apple.screensaver showClock -bool true
defaults write com.apple.screensaver showClockBig -bool true || true
defaults write com.apple.menuextra.clock Show24Hour -bool false
defaults write com.apple.menuextra.clock ShowSeconds -bool false
defaults write com.apple.menuextra.clock FlashDateSeparators -bool true || true
sudo pmset -c displaysleep 120 sleep 0 >/dev/null

# Battery block (runs only when a physical battery is installed)
battery_info=$(system_profiler SPPowerDataType 2>/dev/null)
if echo "$battery_info" | grep -iq "Battery Installed: Yes"; then
    echo ">>> Applying battery Lock Screen + pmset settings"
    defaults -currentHost write com.apple.screensaver idleTime -int 600
    defaults write com.apple.screensaver askForPasswordDelay -int 300
    sudo pmset -b displaysleep 20 sleep 15 >/dev/null
else
    echo ">>> No battery found; skipping battery settings."
fi

echo "<<< Mac power defaults applied."