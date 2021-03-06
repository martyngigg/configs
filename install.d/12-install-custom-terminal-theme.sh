#!/bin/bash
# Install a custom shell profile to configure terminal fonts etc

# only install if gnome terminal is installed
if [ -z "$(which gnome-terminal)" ]; then
  info gnome-terminal command not found. Skipping terminal profile creation
  exit 0
fi


# utilities
. scripts/common.sh

# create new default gnome profile
dconf_dir=/org/gnome/terminal/legacy
terminal_profiles_dir=$dconf_dir/profiles:
profile_id="$(uuidgen)"
info "creating new terminal profile with id '$profile_id'"
dconf write $terminal_profiles_dir/default "'$profile_id'"
dconf write $terminal_profiles_dir/list "['$profile_id']"
profile_dir="$terminal_profiles_dir/:$profile_id"

info "setting terminal defaults"
dconf write "$dconf_dir/default-show-menubar" false
dconf write "$profile_dir/visible-name" "'Default'"
dconf write "$profile_dir/font" "'Inconsolata Medium 12'"
dconf write "$profile_dir/use-system-font" false
dconf write "$profile_dir/default-size-rows" 49
dconf write "$profile_dir/default-size-columns" 102
dconf write "$profile_dir/audible-bell"  false
dconf write "$profile_dir/use-custom-command" true
dconf write "$profile_dir/custom-command" "'/usr/bin/tmux'"

info "installing solarized theme for gnome terminal"
thirdparty/gnome-terminal-colors-solarized/install.sh --scheme=light  --profile=Default --skip-dircolors
