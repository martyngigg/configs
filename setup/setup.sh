#!/bin/bash
################################################################################
# setup.sh: Assuming a clean system: setup standard packages and install
#           config scripts stored here
#
# Author: Martyn Gigg
################################################################################
DEBUG=1

# where are we
setup_dir=$( cd "$( dirname "$0" )" && pwd )

# common.sh functions
source $setup_dir/common.sh

# are we on a system we understand - basically a Debian-like system at the moment
if [ -n "$(which dpkg)" ]; then
  echo "Unable to find dpkg. Is this a Debian-like distro?"
  exit 1
fi

# remove unwanted directories in HOME
remove_existing_directories $HOME/Music $HOME/Public $HOME/Templates $HOME/Videos

# main setup
bash $setup_dir/install-packages-apt.sh
bash $setup_dir/install-dotfiles.sh
bash $setup_dir/install-powerline-symbols.sh
bash $setup_dir/install-solarized-dircolors.sh
bash $setup_dir/install-custom-terminal-theme.sh
bash $setup_dir/enable-user-services.sh
bash $setup_dir/change-default-shell.sh
