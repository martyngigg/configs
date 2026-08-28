#!/bin/sh
# Switch shell to zsh

# common utilities
source scripts/common.sh

new_default_shell=$(command -v fish)
if [ "$SHELL" != "$new_default_shell" ]; then
  info "Setting default shell to FISH for current user"
  command -v fish | sudo tee -a /etc/shells
  chsh -s "$new_default_shell"
fi
