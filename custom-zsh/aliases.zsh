# My own aliases not including those in zsh/common-aliases
#
#

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

# ripgrep
# --no-heading is useful to combine file:line number to easily open in other editors
alias rgnh='rg --no-heading'

# docker
alias dk='docker'
alias dkr='docker run'
alias dkcp='docker cp'
alias dkc='docker compose'
