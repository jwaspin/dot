import os
import sys
import shutil
from pathlib import Path

def install_common():
    print(">>> Starting Common Installation...")
    
    home = Path.home()
    # repo_root is ../ from this script
    repo_root = Path(__file__).parent.parent.resolve()
    files_dir = repo_root / "files"

    # Mapping: Source (relative to files/) -> Destination (relative to Home)
    links = {
        "bash/bash_profile": ".bash_profile",
        "bash/bash_aliases": ".bash_aliases",
        "bash/bashrc": ".bashrc",
        "bash/functions": ".functions",
        "git/gitconfig": ".gitconfig",
        "git/gitignore_global": ".gitignore_global",
        "tmux/tmux.conf": ".tmux.conf",
        "vim/vimrc": ".vimrc",
    }

    # Directories to symlink entirely
    # We link files/vim -> ~/.vim. This provides autoload/, ftplugin/, etc.
    dir_links = {
        "vim": ".vim"
    }

    # 1. File Links
    for src_rel, dest_rel in links.items():
        src = files_dir / src_rel
        dest = home / dest_rel
        create_symlink(src, dest)

    # 2. Directory Links
    for src_rel, dest_rel in dir_links.items():
        src = files_dir / src_rel
        dest = home / dest_rel
        create_symlink(src, dest, is_dir=True)

    print(">>> Common Installation Complete.")

def create_symlink(src, dest, is_dir=False):
    if not src.exists():
        print(f"!! Source not found: {src}")
        return

    if dest.is_symlink():
        if dest.resolve() == src:
            print(f"OK: {dest.name} -> {src.name}")
            return
        else:
            print(f"UPDATE: {dest.name} -> {src.name} (was {dest.resolve()})")
            dest.unlink()
    elif dest.exists():
        # If it's a directory and we want to link a directory, we might need to move it
        # If it's a file and we want to link a file, backup
        backup = dest.with_suffix(dest.suffix + ".bak")
        print(f"BACKUP: {dest} -> {backup}")
        dest.rename(backup)
    
    # Create parent dirs if needed
    if not dest.parent.exists():
        dest.parent.mkdir(parents=True)

    dest.symlink_to(src)
    print(f"LINK: {dest} -> {src}")

if __name__ == "__main__":
    install_common()
