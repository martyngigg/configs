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

# link emacs startup files
emacs_d_dir=$home/.emacs.d
if [ ! -d $emacs_d_dir/lisp ]; then
  info linking emacs startup code
  dotfiles_emacs_dir=$dotfiles_dir/.emacs.d
  mkdir -p $emacs_d_dir/lisp
  link_asset $emacs_d_dir/init.el $dotfiles_emacs_dir/init.el
  assets=$(cd $dotfiles_emacs_dir/lisp && find . -maxdepth 1 -type f | xargs)
  link_assets $emacs_d_dir/lisp $dotfiles_emacs_dir/lisp $assets
else
  info emacs startup files already linked
fi

# link powerline assests
powerline_dir=$home/.config/powerline
if [ ! -d $powerline_dir ]; then
  info linking powerline to $powerline_dir
  mkdir -p $powerline_dir/themes/tmux
  link_asset $powerline_dir/themes/tmux/default.json \
      $dotfiles_dir/.config/powerline/themes/tmux/default.json
else
  info powerline assets already linked
fi
