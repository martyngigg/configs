#!/bin/bash
# Link files to $HOME/.

# utilities
source scripts/common.sh

# link non-template files into toplevel
dotfiles_dir=$(pwd -P)/dotfiles
assets=$(cd $dotfiles_dir && find . -maxdepth 1 -type f \( -not -name '*.template' \) | xargs)
link_assets $home $dotfiles_dir $assets

# export any environment variables required by template files
export CONDARC_PKG_DIR="  - $HOME/.cache/conda"
templates=$(cd $dotfiles_dir && find . -maxdepth 1 -type f -name '*.template' | xargs)
install_templates $home $dotfiles_dir $templates
unset CONDARC_PKG_DIR
