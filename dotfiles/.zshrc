# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# ------------------------------------------------------------------------------
# Oh My Zsh configuration
# ------------------------------------------------------------------------------
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.repos/configs/thirdparty/oh-my-zsh

# Local customizations
ZSH_CUSTOM=$ZSH/../../thirdparty-custom/oh-my-zsh

# Use modified theme in custom directory
ZSH_THEME="agnoster-modified"

# Disable marking untracked files under VCS as dirty.
# This makes repository status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins
plugins=(
  colored-man-pages
  common-aliases
  debian
  docker
  docker-compose
  dircolors-solarized
  gitfast
  web-search
)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='emacs'
fi
