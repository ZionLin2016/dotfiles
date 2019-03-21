export FZF_DEFAULT_OPTS='
--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
'

test -d "${FZF_BASE}" && fzf_base="${FZF_BASE}"

if [[ -z "${fzf_base}" ]]; then
  fzfdirs=(
    "${HOME}/.fzf"
    "/usr/local/opt/fzf"
    "/usr/share/fzf"
  )
  for dir in ${fzfdirs}; do
      if [[ -d "${dir}" ]]; then
          fzf_base="${dir}"
          break
      fi
  done

  if [[ -z "${fzf_base}" ]]; then
      if (( ${+commands[brew]} )) && dir="$(brew --prefix fzf 2>/dev/null)"; then
          if [[ -d "${dir}" ]]; then
              fzf_base="${dir}"
          fi
      fi
  fi
fi


if [[ -n "${fzf_base}" ]]; then

  # Fix fzf shell directory for Archlinux package
  if [[ ! -d "${fzf_base}/shell" ]] && [[ -f /etc/arch-release ]]; then
    fzf_shell="${fzf_base}"
  else
    fzf_shell="${fzf_base}/shell"
  fi

  # Setup fzf
  # ---------
  if ! (( ${+commands[fzf]} )) && [[ ! "$PATH" == *$fzf_base/bin* ]]; then
    export PATH="$PATH:$fzf_base/bin"
  fi

  if (( ${+commands[fd]} )); then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
    _fzf_compgen_path() {
      fd --hidden --follow --exclude ".git" . "$1"
    }
  
    _fzf_compgen_dir() {
      fd --type d --hidden --follow --exclude ".git" . "$1"
    }
  fi
  # Auto-completion
  # ---------------
  if [[ ! "$DISABLE_FZF_AUTO_COMPLETION" == "true" ]]; then
    [[ $- == *i* ]] && source "${fzf_shell}/completion.zsh" 2> /dev/null
  fi

  # Key bindings
  # ------------
  if [[ ! "$DISABLE_FZF_KEY_BINDINGS" == "true" ]]; then
    source "${fzf_shell}/key-bindings.zsh"
  fi

else
  print "fzf plugin: Cannot find fzf installation directory.\n"\
        "Please add \`export FZF_BASE=/path/to/fzf/install/dir\` to your .zshrc" >&2
fi

unset fzf_base fzf_shell dir fzfdirs
