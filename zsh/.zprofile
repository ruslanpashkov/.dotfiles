if [[ "$(uname)" == "Darwin" ]]; then
  eval $(/opt/homebrew/bin/brew shellenv)

  export HOMEBREW_NO_INSTALL_CLEANUP=0

  # Added by OrbStack: command-line tools and integration
  # This won't be added again if you remove it.
  source ~/.orbstack/shell/init.zsh 2>/dev/null || :
fi

if [[ "$(uname)" == "Linux" ]]; then
  export FLYCTL_INSTALL="$HOME/.fly"
  export PATH="$FLYCTL_INSTALL/bin:$PATH"
fi

export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"

export PROFILE_SOURCED=1
