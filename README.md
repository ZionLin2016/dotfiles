# Kevin dotfiles
This is my personal dotfiles.

## Install
1. git clone https://github.com/kevinhwang91/dotfiles.git
2. cd dotfiles; ./bootstrap.sh;

note: what is neovim language-server [coc.nvim](https://github.com/neoclide/coc.nvim)?  
note: if want to install coc.nvim, please link coc.vim when running bootstrap.sh.  
note: if .zshrc exist, please check the orignal file and to be overwrited by soft link of zshrc.

## zsh
1. restart zsh.
2. zplug install.

note: z.lua plugin depends on lua.

## tmux
note: tmuxp is a python module.

## neovim
1. nvim +PlugInstall +qall

note: coc.nvim is language server protocol plugin depend on yarn.  
note: if want to install coc, install yarn before running above command.  
note: fzf.vim plugin depends on fzf.

## ideavim
note: ideavimrc depends on ideavim plugin inside intelligent idea.

## mycli
note: myclirc is a python module.

