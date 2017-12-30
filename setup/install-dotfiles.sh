#!/bin/bash

# here
setup_dir=$(cd $(dirname "$0") && pwd)

# utilities
. $setup_dir/common.sh

# link into destination
ignored="setup.sh|setup-emacs-cpp.sh|README.md|.gitignore|setup|.git"
dotfiles_dir=$setup_dir/../dotfiles
assets=$(ls -A1 $dotfiles_dir | egrep -v ignored | xargs)
link_assets $home $dotfiles_dir $assets
