#!/bin/bash
# Link files to $HOME/.

# utilities
source scripts/common.sh

# link single-files to top-level
dotfiles_dir=$(pwd -P)/dotfiles
assets=$(cd $dotfiles_dir && find . -maxdepth 1 -type f \( -not -name '*.template' \) | xargs)
link_assets $home $dotfiles_dir $assets

# .config directories
test -d $home/.config || mkdir ~/.config
for name in fish zed; do
  link_asset $home/.config/$name $dotfiles_dir/.config/$name
done
