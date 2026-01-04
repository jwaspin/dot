Finder settings applied by `finder_defaults.sh`

- New Finder windows open at your Home folder.
- Show all filename extensions.
- Keep folders on top in Finder windows (and attempt on Desktop).
- Show connected servers on the Desktop; do NOT show hard disks.
- Enable three-finger drag on the trackpad (accessibility + trackpad prefs).

Notes about three-finger drag:

- The script enables `TrackpadThreeFingerDrag` for both built-in and Bluetooth trackpads
  and sets the accessibility `threeFingerDrag` flag. Some macOS versions may require you
  to log out and log back in (or reboot) for the change to fully take effect.
- Disable creation of `.DS_Store` files on network volumes.
- Show Finder path bar and status bar.

Notes:

- Sidebar item changes (e.g. hiding Recents, Shared, Trash or Recent Tags)
  are stored in `com.apple.sidebarlists` and are not modified by this
  script. If you want automated sidebar edits I can add an implementation
  that updates `com.apple.sidebarlists` with `PlistBuddy` or by exporting
  a prepared plist and using `defaults import`.

Power settings applied by `power_defaults.sh`:

- AC block (runs on all machines): sets the Lock Screen/clock defaults from the screenshot and applies `pmset -c displaysleep 120 sleep 0`.
- Battery block (runs when `system_profiler SPPowerDataType` reports a physical battery is installed): applies the 10-minute screensaver + 5-minute password delay values and `pmset -b displaysleep 20 sleep 15`, so laptops always get the battery profile while desktops skip it.

Notes:

- The battery block is skipped on desktops because they have no battery; the AC block still runs.
- `pmset` requires `sudo`, so bootstrap already prompts for that before running this script.
- Lock Screen toggles like showing usernames or password hints remain manual because they lack documented `defaults` keys.

To apply manually (the bootstrap runs this automatically):

```bash
bash files/mac/finder_defaults.sh
```
