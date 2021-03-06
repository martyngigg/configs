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

# Plugins
plugins=(
  colored-man-pages
  common-aliases
  debian
  docker
  docker-compose
  dircolors-solarized
  gitfast
  zsh-autosuggestions
  web-search
)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Customize autosuggest
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8,underline'
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

# Conda env if available
[ -f $HOME/miniconda3/etc/profile.d/conda.sh ] && source $HOME/miniconda3/etc/profile.d/conda.sh

# Add .local/bin to path
[ -d $HOME/.local/bin ] && export PATH=$HOME/.local/bin:$PATH



# ------------------------------------------------------------------------------
# Replace various strings on pressing space
# See http://zshwiki.org/home/examples/zleiab
# ------------------------------------------------------------------------------
typeset -Ag abbreviations
abbreviations=(
  "Im"    "| more"
  "Ia"    "| awk"
  "Ig"    "| grep"
  "Ieg"   "| egrep"
  "Ip"    "| $PAGER"
  "Ih"    "| head"
  "It"    "| tail"
  "Is"    "| sort"
  "Iv"    "| ${VISUAL:-${EDITOR}}"
  "Iw"    "| wc"
  "Ix"    "| xargs"
)

magic-abbrev-expand() {
    local MATCH
    LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9]#}
    LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
    zle self-insert
}

no-magic-abbrev-expand() {
  LBUFFER+=' '
}

zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey " " magic-abbrev-expand
bindkey "^x " no-magic-abbrev-expand
bindkey -M isearch " " self-insert

# ------------------------------------------------------------------------------
