# Uncomment this to profile shell startup
# Also requires uncommenting line at the end of the file
# zmodload zsh/zprof

# ------------------------------------------------------------------------------
# Oh My Zsh configuration
# ------------------------------------------------------------------------------
# Path to config VCS files
export VCS_CFGS_DIR=$HOME/.repos/configs
# Path to your oh-my-zsh installation.
export ZSH=$VCS_CFGS_DIR/thirdparty/oh-my-zsh

# Local customizations
ZSH_CUSTOM=$VCS_CFGS_DIR/custom-zsh

# Prompt theme
ZSH_THEME="prince"

# Disable marking untracked files under VCS as dirty.
# This makes repository status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Allow searching /usr/local for zsh completions
ZSH_DISABLE_COMPFIX="true"

# Plugins
zstyle ':omz:plugins:nvm' lazy yes
plugins=(
  colored-man-pages
  common-aliases
  nvm
  zsh-autosuggestions
)
if type "dircolors" > /dev/null; then
  plugins+=(
    dircolors-solarized
  )
fi
if type "docker" > /dev/null; then
  plugins+=(
    docker
    docker-compose
  )
fi

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Customize autosuggest
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='underline'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# ------------------------------------------------------------------------------
# Further customization
# ------------------------------------------------------------------------------
# Add .local/bin to path
[ -d $HOME/.local/bin ] && export PATH=$HOME/.local/bin:$PATH

# Allow local customizations
[ -f $HOME/.zshrc_local ] && source $HOME/.zshrc_local

# Preferred editor
export EDITOR='vim'

# Activate command-not-found helpers
[ -f /etc/zsh_command_not_found ] && source /etc/zsh_command_not_found

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Override default less options to disable the pager for small input
export LESS=-FRX

# Custom key bindings
bindkey "^[^[[D" backward-word
bindkey "^[^[[C" forward-word

# -----------------------------------------------------------------------------

# Packaging-related aliases
# perform a full brew upgrade
if type "brew" > /dev/null; then
  do-brew-upgrades() {
    brew update
    brew upgrade
    brew cleanup
  }
else
  # cover case that brew is not installed
  do-brew-upgrades() {
  }
fi

# one-shot command to install all package updates
do-package-upgrades() {
  do-brew-upgrades
}

# Aliases
alias doco="docker compose"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/dmn58364/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Uncomment to profile the shell startup time
# # Also requires line at the top of the file to be uncommented
# zprof
