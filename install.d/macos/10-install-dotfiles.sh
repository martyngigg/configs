#!/bin/bash
# Link files to $HOME/.

# utilities
source scripts/common.sh

# link files into toplevel
dotfiles_dir=$(pwd -P)/dotfiles
assets=$(cd $dotfiles_dir && find . -maxdepth 1 -type f | xargs)
link_assets $home $dotfiles_dir $assets

