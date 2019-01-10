# color
autoload -U colors && colors

if [[ -z "$LS_COLORS" ]]; then
    eval "$(dircolors -b)"
fi
alias ls='ls --color=tty'
zstyle ':completion:*' list-colors "${(s/:/)LS_COLORS}"
unset LS_COLORS

