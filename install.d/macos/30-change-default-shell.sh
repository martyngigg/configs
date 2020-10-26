#!/bin/sh
# Switch shell to zsh

# common utilities
source scripts/common.sh

new_default_shell=$(which zsh)
if [ "$SHELL" != "$new_default_shell" ]; then
  info "Setting default shell to ZSH for current user"
  chsh -s "$new_default_shell" $(whoami)
fi
