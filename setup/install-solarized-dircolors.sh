#!/bin/bash

# here
setup_dir=$(cd $(dirname "$0") && pwd)

. $setup_dir/common.sh

dircolors_theme=dircolors.256dark
if [ ! -L $home/.dircolors ]; then
  info "installing solarize dircolors"
  link_asset $home/.dircolors $ $setup_dir/../thirdparty/dircolors-solarized/$dircolors_theme
else
  info "solarized dircolors is already installed"
fi
