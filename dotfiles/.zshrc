# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# ------------------------------------------------------------------------------
# Oh My Zsh configuration
# ------------------------------------------------------------------------------
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.repos/configs/thirdparty/oh-my-zsh

# Local customizations
ZSH_CUSTOM=$ZSH/../../custom-zsh

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

# Add .local/bin to path
[ -d $HOME/.local/bin ] && export PATH=$HOME/.local/bin:$PATH

# Custom key bindings
bindkey "^[^[[D" backward-word
bindkey "^[^[[C" forward-word

# Better cat/less
# bat has a different name on ubunutu
if  [ "$(command -v batcat)" ]; then
    alias bat=batcat
fi

# source-highlighting with less
if [ "$(command -v bat)" ]; then
    alias less=bat
    # use less as the pager for bat
    BAT_PAGER="less -RF"
    export BAT_PAGER
else
    if [ "$(command -v highlight)" ]; then
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
if [ "$(command -v rg)" ]; then
    # --no-heading is useful to combine file:line number to easily open in other editors
    alias rgnh='rg --no-heading'
fi

# -----------------------------------------------------------------------------

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/dmn58364/opt/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/dmn58364/opt/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/Users/dmn58364/opt/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/Users/dmn58364/opt/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Detect if a conda environment should be activated
if [ -n "${LOCAL_CONDA_ACTIVATE}"  ]; then
    conda activate "${LOCAL_CONDA_ACTIVATE}"
fi
