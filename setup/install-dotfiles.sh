#!/bin/bash

# here
setup_dir=$(cd $(dirname "$0") && pwd)

# utilities
. $setup_dir/common.sh

# link files into destination
ignored="setup.sh|setup-emacs-cpp.sh|README.md|.gitignore|setup|.git|.config"
dotfiles_dir=$setup_dir/../dotfiles
assets=$(ls -A1 $dotfiles_dir | egrep -v ignored | xargs)
link_assets $home $dotfiles_dir $assets

# link directories
link_asset $dotfiles_dir/.config/powerline $home/.config/powerline
