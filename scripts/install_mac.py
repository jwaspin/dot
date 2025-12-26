import os
import sys
import subprocess
from pathlib import Path
import install_common

def install_mac():
    print(">>> Starting Mac Installation...")

    # 1. Run Common Install
    install_common.install_common()

    # 2. Hammerspoon
    print(">>> Setting up Hammerspoon...")
    home = Path.home()
    repo_root = Path(__file__).parent.parent.resolve()
    src = repo_root / "files/hammerspoon"
    dest = home / ".hammerspoon"
    install_common.create_symlink(src, dest, is_dir=True)

    # 3. Homebrew Bundle
    print(">>> Running Brew Bundle...")
    brewfile = repo_root / "files/brew/Brewfile"
    if brewfile.exists():
        try:
            subprocess.run(["brew", "bundle", "--file", str(brewfile)], check=True)
        except subprocess.CalledProcessError:
            print("!! Brew Bundle failed. Please check the output.")
    else:
        print("!! Brewfile not found.")

    # 4. Mac Defaults
    print(">>> Setting Mac Defaults...")
    set_mac_defaults(repo_root)

    print(">>> Mac Installation Complete.")

def set_mac_defaults(repo_root):
    # Helper to run defaults command
    def defaults(domain, key, type_flag, value):
        cmd = ["defaults", "write", domain, key, type_flag, str(value)]
        subprocess.run(cmd)

    # Global Domain
    defaults("NSGlobalDomain", "KeyRepeat", "-int", 2)
    defaults("NSGlobalDomain", "InitialKeyRepeat", "-int", 15)
    defaults("NSGlobalDomain", "AppleShowAllExtensions", "-bool", "true")
    defaults("NSGlobalDomain", "AppleActionOnDoubleClick", "-string", "Minimize")
    defaults("NSGlobalDomain", "AppleInterfaceStyle", "-string", "Dark")
    
    # Web Search (DuckDuckGo)
    # Note: -dict-add is complex to handle with simple wrapper, using raw subprocess for this one
    subprocess.run([
        "defaults", "write", "NSGlobalDomain", "NSPreferredWebServices", 
        "-dict-add", "NSWebServicesProviderWebSearch", 
        "-dict", "NSDefaultDisplayName", "DuckDuckGo", 
        "NSProviderIdentifier", "com.duckduckgo"
    ])

    # Import Plists
    mac_files = repo_root / "files/mac"
    
    # Dictionary
    dict_plist = mac_files / "dictionary_replacements.plist"
    if dict_plist.exists():
        subprocess.run(["defaults", "import", "NSGlobalDomain", str(dict_plist)])

    # Trackpad
    trackpad_plist = mac_files / "trackpad_settings.plist"
    if trackpad_plist.exists():
        subprocess.run(["defaults", "import", "com.apple.AppleMultitouchTrackpad", str(trackpad_plist)])

    # Mouse
    mouse_plist = mac_files / "mouse_settings.plist"
    if mouse_plist.exists():
        subprocess.run(["defaults", "import", "com.apple.driver.AppleHIDMouse", str(mouse_plist)])

    # Dock
    # Clear Dock persistent apps first
    subprocess.run(["defaults", "write", "com.apple.dock", "persistent-apps", "-array"])

    dock_plist = mac_files / "dock_settings.plist"
    if dock_plist.exists():
        subprocess.run(["defaults", "import", "com.apple.dock", str(dock_plist)])
    
    subprocess.run(["killall", "Dock"])

if __name__ == "__main__":
    install_mac()
