# ------------------------------------------------------------------------------
# Oh My Zsh configuration
# ------------------------------------------------------------------------------
# Path to config VCS files
export VCS_CFGS_DIR=$HOME/.repos/configs
# Path to your oh-my-zsh installation.
export ZSH=$VCS_CFGS_DIR/thirdparty/oh-my-zsh

# Local customizations
ZSH_CUSTOM=$VCS_CFGS_DIR/custom-zsh

# Use modified theme in custom directory
ZSH_THEME="agnoster-modified"

# Disable marking untracked files under VCS as dirty.
# This makes repository status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Allow searching /usr/local for zsh completions
ZSH_DISABLE_COMPFIX="true"

# Plugins
plugins=(
  colored-man-pages
  common-aliases
  gitfast
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

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='emacs'
fi

# Activate command-not-found helpers
[ -f /etc/zsh_command_not_found ] && source /etc/zsh_command_not_found

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Override default less options to disable the pager for small input
export LESS=-FRX

# Custom key bindings
bindkey "^[^[[D" backward-word
bindkey "^[^[[C" forward-word


# node
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
# -----------------------------------------------------------------------------

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/dmn58364/opt/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/dmn58364/opt/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/dmn58364/opt/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/dmn58364/opt/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

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

# perform a full mamba upgrade of base environment
if type "conda" > /dev/null; then
  do-conda-upgrades() {
    # First pull in any Python updates as these are not caught by --all.
    # This won't upgrade minor versions, only patches.
    # Use conda install python=X.Y to upgrade to a newer line.
    conda update --yes --name base --channel conda-forge python
    conda update --yes --name base --channel conda-forge --all
  }
else
  # do nothing if mamba is not installed
  do-conda-upgrades() {
  }
fi

# one-shot command to install all package updates
do-package-upgrades() {
  do-brew-upgrades
  do-conda-upgrades
}



### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/dmn58364/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
