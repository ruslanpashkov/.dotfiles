# Fix for unreliable profile sourcing, eg. switching to a second TTY
if [[ -z "$PROFILE_SOURCED" ]]; then
    source ~/.zprofile
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}

zstyle ':bracketed-paste-magic' paste-init pasteinit
zstyle ':bracketed-paste-magic' paste-finish pastefinish

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

plugins=(
  git
  mise
  docker
  kubectl

  man
  colored-man-pages
  extract
  tldr

  eza
  dirhistory
  copypath

  tmux
  fzf

  ssh

  brew

  command-not-found
  fast-syntax-highlighting
  zsh-autocomplete
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

fpath+=~/.zfunc
path+=($HOME/.local/bin)

alias ll='eza -la'
alias tree='eza --tree'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias mkdir='mkdir -p'
alias cp='cp -i'
alias rm='rm -i'
alias vim='nvim'
alias reload='source ~/.zshrc'

if [[ "$(uname)" == "Darwin" ]]; then
    alias clip='pbcopy'
else
    alias clip='xclip -in -selection clipboard'
fi

mkcd() {
  mkdir -p "$1" && cd "$1"
}

fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

tm() {
    local session=${1:-tmux}

    if ! tmux has-session 2>/dev/null; then
        tmux new-session -s "$session"
    else
        if [ -z "$TMUX" ]; then
            tmux attach-session
        fi
    fi
}

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
