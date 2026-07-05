#!/bin/bash
# Link files to $HOME/.

# utilities
source scripts/common.sh

# link non-template files into toplevel
dotfiles_dir=$(pwd -P)/dotfiles
assets=$(cd $dotfiles_dir && find . -maxdepth 1 -type f \( -not -name '*.template' \) | xargs)
link_assets $home $dotfiles_dir $assets
