#!/bin/bash
# Link solarized dircolors to $HOME

# utilities
source scripts/common.sh

dircolors_theme=dircolors.ansi-light
if [[ ! -L $home/.dircolors ]]; then
  info "installing solarize dircolors"
  link_asset $home/.dircolors $(readlink -e thirdparty/dircolors-solarized/$dircolors_theme)
else
  info "solarized dircolors is already installed"
fi
