# -*-shell-script-*-
################################################################################
# .bashrc: executed by bash(1) for non-login shells.
#
# Author: Martyn Gigg
################################################################################

# if not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

################################################################################
# history
################################################################################
export HISTFILESIZE=999999
export HISTSIZE=999999
# don't put duplicate lines or lines starting with space in the history.
export HISTCONTROL=ignoredups:ignorespace
export HISTIGNORE="&:ls:[bf]g:exit:[ \t]*"
# make sure the history is updated at every command
export PROMPT_COMMAND="history -a; history -n;"
# append to history file
shopt -s histappend

################################################################################
# misc shell options
################################################################################
shopt -s cdspell
shopt -s checkwinsize
shopt -s progcomp

################################################################################
# prompt - use bash-git-prompt
################################################################################
GIT_PROMPT_THEME=Solarized_Ubuntu
GIT_PROMPT_ONLY_IN_REPO=0
# if .bashrc is a symlink to the repository version then set the prompt
# using bash-git-prompt
if [ -L $HOME/.bashrc ]; then
  _cfgs_repo=$(dirname $(dirname $(readlink -f $HOME/.bashrc)))
  source $_cfgs_repo/thirdparty/bash-git-prompt/gitprompt.sh
else
  echo "Expected .bashrc to symlink to configs repository. Cannot set up bash-git-prompt."
fi

################################################################################
# coloured ls & dirs + aliases
################################################################################
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    color_dir=yes
else
    color_dir=
fi

################################################################################
# aliases
################################################################################
if [ -f ~/.bash_aliases -o -h ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

################################################################################
# add .local/bin to path
################################################################################
if [ -d $HOME/.local/bin ]; then
  export PATH=$HOME/.local/bin:$PATH
fi

################################################################################
# completion
################################################################################
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

################################################################################
# command improvements
################################################################################
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

################################################################################
# clean up
################################################################################

unset color_prompt color_dir

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/mgigg/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/mgigg/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/mgigg/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/mgigg/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/dmn58364/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
