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
# git options
################################################################################
export GIT_PS1_SHOWDIRTYSTATE=1

################################################################################
# prompt
################################################################################
# colour if we can!
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
else
    color_prompt=
fi
if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;31m\]\u@\h\[\033[01;34m\] \W$(__git_ps1 " (%s)") \$ \[\033[00m\]'
else
    PS1='\u@\h \W$(__git_ps1 " (%s)") \$ '
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
