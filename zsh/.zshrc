# Fix for unreliable profile sourcing, eg. switching to a second TTY
if [[ -z "$PROFILE_SOURCED" ]]; then
  source ~/.zprofile
fi

ZINIT_DIR="$HOME/.local/share/zinit/zinit.git"
ZINIT_FILE="$ZINIT_DIR/zinit.zsh"

if [[ ! -f "$ZINIT_FILE" ]]; then
  mkdir -p "${ZINIT_DIR%/*}" && chmod g-rwX "${ZINIT_DIR%/*}"
  git clone https://github.com/zdharma-continuum/zinit "$ZINIT_DIR"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

setopt promptsubst

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
HISTDUP=erase

setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
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

eval "$(dircolors -b)"

ZSH_THEME="robbyrussell"

zinit snippet OMZT::$ZSH_THEME
zinit snippet OMZL::async_prompt.zsh
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::mise
zinit snippet OMZP::kubectl
zinit snippet OMZP::man
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::extract
zinit snippet OMZP::tldr
zinit snippet OMZP::eza
zinit snippet OMZP::dirhistory
zinit snippet OMZP::copypath
zinit snippet OMZP::tmux
zinit snippet OMZP::fzf
zinit snippet OMZP::ssh
zinit snippet OMZP::brew
zinit snippet OMZP::command-not-found
zinit light marlonrichert/zsh-autocomplete
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

zstyle ':bracketed-paste-magic' paste-init pasteinit
zstyle ':bracketed-paste-magic' paste-finish pastefinish

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

fpath+=~/.zfunc
path+=($HOME/.local/bin)

alias ..='cd ..'
alias ...='cd ../..'
alias mkdir='mkdir -p'
alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'
alias ln='ln -i'
alias df='df -h'
alias du='du -h'
alias ps='ps aux'
alias psg='ps aux | grep -v grep | grep -i'
alias path='echo $PATH | tr ":" "\n"'
alias myip='curl -s ifconfig.me'
alias reload='source ~/.zshrc'

if [[ "$(uname -s)" == "Darwin" ]]; then
  CLIP_COPY=(pbcopy)
  CLIP_PASTE=(pbpaste)
elif grep -qEi "(Microsoft|WSL)" /proc/version 2>/dev/null && command -v win32yank.exe &>/dev/null; then
  CLIP_COPY=(win32yank.exe -i --crlf)
  CLIP_PASTE=(win32yank.exe -o --lf)
elif [ -n "$WAYLAND_DISPLAY" ] && command -v wl-copy &>/dev/null && command -v wl-paste &>/dev/null; then
  CLIP_COPY=(wl-copy)
  CLIP_PASTE=(wl-paste)
elif command -v xclip &>/dev/null; then
  CLIP_COPY=(xclip -selection clipboard -i)
  CLIP_PASTE=(xclip -selection clipboard -o)
else
  CLIP_COPY=()
  CLIP_PASTE=()
fi

clip() {
  if [ -t 0 ]; then
    "${CLIP_PASTE[@]}"
  else
    "${CLIP_COPY[@]}"
  fi
}

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

