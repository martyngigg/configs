#!/bin/sh
# Switch shell to zsh

# common utilities
source scripts/common.sh

info "Setting default shell to ZSH for current user"
chsh -s $(which zsh) $(whoami)
