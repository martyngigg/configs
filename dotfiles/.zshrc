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
  debian
  gitfast
  zsh-autosuggestions
  web-search
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

# Better cat/less
# bat has a different name on ubunutu
if type "batcat" > /dev/null; then
    alias bat=batcat
fi

# source-highlighting with less
if type "bat" > /dev/null; then
    alias less=bat
    # use less as the pager for bat
    BAT_PAGER="less -RF"
    export BAT_PAGER
else
    if type "highlight" > /dev/null; then
      LESSOPEN="| $(command -v highlight) %s --out-format xterm256 --line-numbers --quiet --force --style solarized-dark"
      export LESSOPEN
    elif [ "$(command -v src-hilite-lesspipe.sh)" ]; then
      LESSOPEN="| $(command -v src-hilite-lesspipe.sh) %s"
      export LESSOPEN
    fi
    alias less='less -m -N -g -i -J --line-numbers --underline-special'
    export LESS=' -R '
fi

# quick access to arguments of ripgrep
if type "rg" > /dev/null; then
    # --no-heading is useful to combine file:line number to easily open in other editors
    alias rgnh='rg --no-heading'
fi


# docker - uses vagrant-based setup to avoid Docker Desktop
if type "docker" > /dev/null; then
  # CLI talks to Vagrant VM. Use IP rather than docker.local as docker command
  # appears to hang for a breif moment when using the hostname...
  export DOCKER_HOST=tcp://192.168.63.4:2375

  # Aliase to work with docker/vagrant VM
  docker-vagrant() {
    pushd $VCS_CFGS_DIR/vagrant-docker-engine
    vagrant $1
    popd
  }
fi

# docker-compose
if type "docker-compose" > /dev/null; then
  alias dcmp='docker-compose'
fi

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

# Conda/mamba aliases
if [ -f "/Users/dmn58364/opt/mambaforge/etc/profile.d/mamba.sh" ]; then
  mact() {
    mamba activate $1
  }
  menv() {
    mamba env "$@"
  }
  menv-upd() {
    mamba env update --file $1 --prune
  }
  mupd() {
    mamba update -n base mamba
  }
fi
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
if type "mamba" > /dev/null; then
  do-mamba-upgrades() {
    mamba update --name base --all
  }
else
  # do nothing if mamba is not installed
  do-mamba-upgrades() {
  }
fi

# one-shot command to install all package updates
do-package-upgrades() {
  do-brew-upgrades
  do-mamba-upgrades
}


