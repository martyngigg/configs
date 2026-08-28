#!/bin/bash
# Link files to $HOME/.

# utilities
source scripts/common.sh

# link single-files to top-level
dotfiles_dir=$(pwd -P)/dotfiles
assets=$(cd $dotfiles_dir && find . -maxdepth 1 -type f \( -not -name '*.template' \) | xargs)
link_assets $dotfiles_dir $home $assets

# .config directories
test -d $home/.config || mkdir ~/.config
for name in fish zed alacritty; do
  link_asset $dotfiles_dir/.config/$name $home/.config/$name
done
