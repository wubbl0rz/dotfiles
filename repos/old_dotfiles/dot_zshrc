autoload -U promptinit; promptinit; 

autoload -U compinit
compinit
zstyle ':completion:*' menu yes select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

autoload -U select-word-style
select-word-style bash

setopt auto_cd

prompt pure

HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
#setopt appendhistory
setopt inc_append_history
setopt share_history

. ~/repos/base16-shell/scripts/base16-tomorrow-night.sh

function ls() 
{
  if [[ "$1" == -* ]]; then
    exa --colour-scale -bghla -snew $2
  else
    exa --colour-scale -bghla -snew $1
  fi
}

mem() {
  echo $(echo $(smem -t -P $1 | tail -n 1 | rev | cut -d ' ' -f 2 | rev) / 1024 | bc) MB
}

alias l="exa -bghl -snew"
alias ll="exa -bghl -snew"
alias top="htop"
alias eZ="vim ~/.zshrc"
alias eI="vim ~/.config/i3/config"
alias rm="trash"
alias dot="cd ~/repos/dotfiles"
alias history="history 0"

if test $TMUX; then
  bindkey '^[[1~'  beginning-of-line
  bindkey '^[[4~'  end-of-line
  bindkey '^[[3~'  delete-char
else
  bindkey '^[[H'  beginning-of-line
  bindkey '^[[F'  end-of-line
  bindkey '^[[3~'  delete-char
fi

export PATH="$PATH:`yarn global bin`"

source /usr/share/doc/find-the-command/ftc.zsh

