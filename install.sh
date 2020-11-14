#!/bin/bash

USAGE=1
BASHFILES=0
VIMFILES=0
TMUXFILES=0
GITCONFIG=0
HAMMERSPOON=0
CLEAN=0

usage() {
    printf "usage: ./install [-bvtghac]
    This menu prints when no options are selected
    -b  install bash config
    -v  install vim config
    -t  install tmux config
    -g  install git config
    -h  install hammerspoon config
    -a  install all dot files
    -c  cleanup dot files\n"
    exit
}

while getopts "bvtghac" opt; do
    case $opt in
        b)
            printf "Including bash\n"
            BASHFILES=1
            USAGE=0
            ;;
        v)
            printf "Including vim\n"
            VIMFILES=1
            USAGE=0
            ;;
        t)
            printf "Including tmux\n"
            TMUXFILES=1
            USAGE=0
            ;;
        g)
            printf "Including git\n"
            GITCONFIG=1
            USAGE=0
            ;;
        h)
            printf "Including hammerspoon\n"
            HAMMERSPOON=1
            USAGE=0
            ;;
        a)
            printf "Including all dot files\n"
            BASHFILES=1
            VIMFILES=1
            TMUXFILES=1
            GITCONFIG=1
            HAMMERSPOON=1
            USAGE=0
            ;;
        c)
            printf "Cleaning\n"
            CLEAN=1
            USAGE=0
            ;;
    esac
done

if [ $USAGE -eq 1 ]; then
    usage
fi

sym_l() {
    src=$1
    link=$2

    printf "creating symlink $link -> $src\n"
    ln -s -f ~/.dot/files/$src $link
}

setup_bash () {
    echo 'configuring bash'
    sym_l bash/bash_profile ~/.bash_profile
    sym_l bash/bash_aliases ~/.bash_aliases
    sym_l bash/bashrc ~/.bashrc
    sym_l bash/functions ~/.functions
}

clean_bash () {
    rm ~/.bashrc ~/.bash_profile ~/.bash_aliases
    rm -rf ~/.functions
}

setup_vim () {
    echo 'configuring vim'
    if [ -d ~/.vim ]; then
        printf "vim already installed\n"
    else
        printf "installing vim config\n"
        sym_l vim/vimrc ~/.vimrc
        mkdir ~/.vim
        if [ -d ~/.vim ]; then
            printf "linking vim colors\n"
            sym_l vim/ftplugin ~/.vim
            sym_l vim/colors ~/.vim
            sym_l vim/autoload ~/.vim
        else
            printf "\n\nsomething went wrong\n\n"
        fi
    fi
}

clean_vim () {
    rm ~/.vimrc
    rm -rf ~/.vim
}

setup_tmux () {
    echo 'configuring tmux'
    sym_l tmux/tmux.conf ~/.tmux.conf 
}

clean_tmux () {
    rm ~/.tmux.conf
}

setup_git () {
    echo 'configuring git'
    sym_l git/gitconfig ~/.gitconfig
}

clean_git () {
    rm ~/.gitconfig
}

setup_hammerspoon () {
    echo 'configuring hammerspoon'
    mkdir -p ~/.hammerspoon/Spoons
    if [ -d ~/.hammerspoon ]; then
        sym_l hammerspoon/init.lua ~/.hammerspoon/init.lua 
        if [ -d ~/.hammerspoon/Spoons ]; then
            sym_l hammerspoon/Spoons/WindowScreenLeftAndRight.spoon \
                    ~/.hammerspoon/Spoons/WindowScreenLeftAndRight.spoon
        fi
    fi
}

clean_hammerspoon () {
    rm -rf ~/.hammerspoon
}

cleanup_symlinks() {
    clean_bash
    clean_vim
    clean_tmux
    clean_git
    clean_hammerspoon
}

if [ $CLEAN -eq 1 ]; then
    HAMMERSPOON=0
    BASHFILES=0
    VIMFILES=0
    TMUXFILES=0
    GITCONFIG=0
    cleanup_symlinks
fi

if [ $BASHFILES -eq 1 ]; then
    setup_bash
fi

if [ $VIMFILES -eq 1 ]; then
    setup_vim
fi

if [ $TMUXFILES -eq 1 ]; then
    setup_tmux
fi

if [ $GITCONFIG -eq 1 ]; then
    setup_git
fi

if [ $HAMMERSPOON -eq 1 ]; then
    setup_hammerspoon
fi
