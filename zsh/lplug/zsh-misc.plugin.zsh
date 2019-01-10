# complete menu
unsetopt menu_complete
zmodload -i zsh/complist
zstyle ':completion:*:*:*:*:*' menu select

# complete match case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# misc
setopt AUTO_CD
setopt MULTIOS

# edit command using EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

