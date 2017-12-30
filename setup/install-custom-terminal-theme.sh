#!/bin/bash

# here
setup_dir=$(cd $(dirname "$0") && pwd)

# source utilities
. $setup_dir/common.sh

info "installing solarized theme for gnome terminal"
$setup_dir/../thirdparty/gnome-terminal-colors-solarized/install.sh --scheme=dark --profile=Default
info "setting terminal defaults"
gconftool-2 -s /apps/gnome-terminal/profiles/Default/font --type string "Inconsolata Medium 12"
gconftool-2 -s /apps/gnome-terminal/profiles/Default/use_system_font --type boolean false
gconftool-2 -s /apps/gnome-terminal/profiles/Default/use_custom_default_size --type boolean true
gconftool-2 -s /apps/gnome-terminal/profiles/Default/default_size_rows --type int 49
gconftool-2 -s /apps/gnome-terminal/profiles/Default/default_size_columns --type int 102
gconftool-2 -s /apps/gnome-terminal/profiles/Default/silent_bell --type boolean true
gconftool-2 -s /apps/gnome-terminal/profiles/Default/default_show_menubar --type boolean false
