Finder settings applied by `finder_defaults.sh`

- New Finder windows open at your Home folder.
- Show all filename extensions.
- Keep folders on top in Finder windows (and attempt on Desktop).
- Show connected servers on the Desktop; do NOT show hard disks.
- Disable creation of `.DS_Store` files on network volumes.
- Show Finder path bar and status bar.

Notes:

- Sidebar item changes (e.g. hiding Recents, Shared, Trash or Recent Tags)
  are stored in `com.apple.sidebarlists` and are not modified by this
  script. If you want automated sidebar edits I can add an implementation
  that updates `com.apple.sidebarlists` with `PlistBuddy` or by exporting
  a prepared plist and using `defaults import`.

To apply manually (the bootstrap runs this automatically):

```bash
bash files/mac/finder_defaults.sh
```
