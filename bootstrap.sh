#!/usr/bin/env bash

DOTFILES_ROOT=$(cd -P "$(dirname $0)" && pwd -P)

info() {
    printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user() {
    printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success() {
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail() {
    printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
    echo ''
    exit
}

link_file() {
    local src=$1 dst=$2

    local overwrite=false backup=false skip=false
    local action=

    if [[ -f $dst || -d $dst || -L $dst ]]; then

        local currentSrc=$(readlink $dst)

        if [[ $currentSrc == $src ]]; then
            skip=true
        else
            user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [o]verwrite, [b]ackup?"
            read -n 1 action

            case "$action" in
            o)
                overwrite=true
                ;;
            b)
                backup=true
                ;;
            s)
                skip=true
                ;;
            *) ;;

            esac

        fi

        if [[ $overwrite == true ]]; then
            rm -rf $dst
            success "removed $dst"
        fi

        if [[ $backup == true ]]; then
            mv $dst ${dst}.backup
            success "moved $dst to ${dst}.backup"
        fi

        if [[ $skip == true ]]; then
            success "skipped $src"
        fi
    fi

    if [[ $skip != true ]]; then # "false" or empty
        ln -s $1 $2
        success "linked $1 to $2"
    fi
}

NVIM_HOME=$HOME/.config/nvim
D_NVIM_HOME=$DOTFILES_ROOT/nvim
mkdir -p $NVIM_HOME/autoload 2>/dev/null

curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

link_file $D_NVIM_HOME/init.vim $NVIM_HOME/init.vim
link_file $D_NVIM_HOME/rm_deleted_undo.sh $NVIM_HOME/rm_deleted_undo
link_file $D_NVIM_HOME/coc-settings.json $NVIM_HOME/coc-settings.json

mkdir -p $HOME/.config/coc/extensions 2>/dev/null
link_file $D_NVIM_HOME/coc-package.json $HOME/.config/coc/extensions/package.json

D_IDEA_HOME=$DOTFILES_ROOT/idea
link_file $D_IDEA_HOME/ideavimrc $HOME/.ideavimrc

D_TMUX_HOME=$DOTFILES_ROOT/tmux
link_file $D_TMUX_HOME/tmux.conf $HOME/.tmux.conf

mkdir -p $HOME/.tmuxp 2>/dev/null
link_file $D_TMUX_HOME/landscape.yaml $HOME/.tmuxp/landscape.yaml
link_file $D_TMUX_HOME/portrait.yaml $HOME/.tmuxp/portrait.yaml

ZSH_HOME=$HOME/.config/zsh
D_ZSH_HOME=$DOTFILES_ROOT/zsh
mkdir -p $ZSH_HOME 2>/dev/null 

export ZPLUG_HOME=$ZSH_HOME/zplug
git clone https://github.com/zplug/zplug $ZPLUG_HOME

link_file $D_ZSH_HOME/zshrc $HOME/.zshrc
link_file $D_ZSH_HOME/lplug $ZSH_HOME/lplug

