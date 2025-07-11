#!/bin/sh
# https://github.com/sugyan/dotfiles/blob/master/create_symlink.sh
cd $(dirname $0)
for dotfile in .?*; do
    case $dotfile in
        ..)
            continue;;
        .git)
            continue;;
        *)
            ln -Fis "$PWD/$dotfile" $HOME
            ;;
    esac
done
