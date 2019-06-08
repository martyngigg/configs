#!/bin/bash
# Link files to $HOME

# here
setup_dir=$(cd $(dirname "$0") && pwd)

# utilities
. $setup_dir/common.sh

# link files into toplevel
dotfiles_dir=$setup_dir/../dotfiles
assets=$(cd $dotfiles_dir && find . -maxdepth 1 -type f | xargs)
link_assets $home $dotfiles_dir $assets

# link powerline assests
powerline_dir=$home/.config/powerline
info linking powerline to $powerline_dir
if [ ! -d $powerline_dir ]; then
  mkdir -p $powerline_dir/themes/tmux
  link_asset $powerline_dir/themes/tmux/default.json \
      $dotfiles_dir/.config/powerline/themes/tmux/default.json
fi

# setup vim plugin manager
plug_vim=~/.local/share/nvim/site/autoload/plug.vim
if [ ! -f  $plug_vim ]; then
  curl -fLo $plug_vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
