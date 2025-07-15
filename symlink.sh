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
            ln -Fis "$PWD/$dotfile" "$HOME"
            ;;
    esac
done

mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty/"
ln -Fis "$PWD/ghostty_config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
