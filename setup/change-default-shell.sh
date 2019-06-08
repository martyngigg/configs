#!/bin/sh

setup_dir=$(cd $(dirname "$0") && pwd)
. $setup_dir/common.sh

info "Setting default shell to ZSH"
chsh -s $(which zsh)

