#!/bin/bash
# Link files to $HOME/.

# utilities
source scripts/common.sh

# link files into toplevel
dotfiles_dir=$(readlink -e dotfiles)
assets=$(cd $dotfiles_dir && find . -maxdepth 1 -type f | xargs)
link_assets $dotfiles_dir $home $assets

# .config directories
test -d $home/.config || mkdir ~/.config
for name in fish zed alacritty; do
  link_asset $dotfiles_dir/.config/$name $home/.config/$name
done

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
