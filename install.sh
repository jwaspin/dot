#!/bin/bash

HAMMERSPOON=0
FZF=0

usage() {
    echo $0
    exit
}

while getopts "hf" opt; do
    case $opt in
        h)
            echo "Including hammerspoon"
            HAMMERSPOON=1
            ;;
        f)
            echo "Including fuzzy finder"
            FZF=1
            ;;
    esac
done

sym_l() {
    src=$1
    link=$2

    echo "creating symlink $link -> $src"
    ln -s -f ~/dot/files/$src $link
}

setup_bash () {
    echo 'creating bash links'
    sym_l bash/bash_profile ~/.bash_profile
    sym_l bash/bash_aliases ~/.bash_aliases
    sym_l bash/bashrc ~/.bashrc
    sym_l bash/functions ~/.functions
}

setup_tmux () {
    echo 'installing tmux files'
    sym_l tmux/tmux.conf ~/.tmux.conf 
}

setup_hammerspoon () {
    echo 'installing hammerspoon files'
    mkdir -p ~/.hammerspoon/Spoons
    sym_l hammerspoon/init.lua ~/.hammerspoon/init.lua 
    sym_l hammerspoon/Spoons/WindowScreenLeftAndRight.spoon ~/.hammerspoon/Spoons/WindowScreenLeftAndRight.spoon
}

vim_folders () {
    mkdir ~/.vim
    mkdir -p ~/.vim/bundle
}

setup_vim () {
    echo 'installing vim files and plugins'
    vim_folders
    sym_l vim/vimrc ~/.vimrc
    sym_l vim/colors ~/.vim
    sym_l vim/autoload ~/.vim
}

setup_vim_plugins () {
	# Auto close brackets
    if [ -d ~/.vim/bundle/auto-pairs ] ; then
		echo "Auto Pairs Plugin already installed."
	else
		git clone https://github.com/jiangmiao/auto-pairs.git ~/.vim/bundle/auto-pairs
	fi

    # Surround
    if [ -d ~/.vim/bundle/vim-surround ] ; then
        echo "Surround already installed."
    else
        git clone https://github.com/tpope/vim-surround.git ~/.vim/bundle/vim-surround
    fi

    # Windowswap
    if [ -d ~/.vim/bundle/vim-windowswap ] ; then
        echo "WindowSwap already installed."
    else
        git clone https://github.com/wesQ3/vim-windowswap.git ~/.vim/bundle/vim-windowswap
    fi

    # Peekaboo
    if [ -d ~/.vim/bundle/vim-peekaboo ] ; then
        echo "Peekaboo already installed."
    else
        git clone https://github.com/junegunn/vim-peekaboo ~/.vim/bundle/vim-peekaboo
    fi
}

install_fzf () {
    if [ -d ~/.fzf ] ; then
        echo "fzf already installed"
    else
        sym_l files/vim/fzf_functions ~/.fzf_functions &&
        git clone https://github.com/junegunn/fzf.git ~/.vim/bundle/fzf &&
        git clone https://github.com/junegunn/fzf.vim.git ~/.vim/bundle/fzf.vim &&
        git clone --depth 1 http://github.com/junegunn/fzf.git ~/.fzf &&
        yes | ~/.fzf/install
    fi
}

setup_tmux && setup_bash && setup_vim && setup_vim_plugins

if [ $HAMMERSPOON -eq 1 ]; then
    echo HAMMERTIME
    setup_hammerspoon
fi

if [ $FZF -eq 1 ]; then
    echo FUZZYTIME
    install_fzf
fi
