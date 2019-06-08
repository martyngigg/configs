#!/bin/sh

setup_dir=$(cd $(dirname "$0") && pwd)
. $setup_dir/common.sh

info "Setting default shell to ZSH for current user"
chsh -s $(which zsh) $(whoami)

