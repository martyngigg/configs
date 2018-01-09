#!/bin/bash

# here
setup_dir=$(cd $(dirname "$0") && pwd)

# utilities
. $setup_dir/common.sh

# link files into destination
dotfiles_dir=$setup_dir/../dotfiles
assets=$(cd $dotfiles_dir && find . -maxdepth 1 -type f | xargs)
link_assets $home $dotfiles_dir $assets

# link directories
link_asset $home/.config/powerline $dotfiles_dir/.config/powerline
