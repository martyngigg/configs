#!/bin/bash

# common functions
source scripts/common.sh

function run_with_sudo() {
  sudo $*
}

if [ $(id -u) -ne 0 ]; then
  if [ -z "$(which sudo)" ]; then
    info script requires root access but sudo command not found
    exit 1
  fi
  info script requires root privileges, sudo password will be requested
fi

info updating package lists
run_with_sudo apt-get -y update

info upgrading current packages
run_with_sudo apt-get -y dist-upgrade

info removing old packages
run_with_sudo apt-get -y autoremove

info installing packages
run_with_sudo apt-get -y install \
  apt-transport-https \
  ca-certificates \
  curl \
  dconf-cli \
  docker.io \
  emacs \
  emacs-goodies-el \
  evince \
  fakeroot \
  firefox \
  fonts-inconsolata \
  fonts-powerline \
  gdebi-core \
  gnupg-agent \
  htop \
  mosh \
  openssh-client \
  powerline \
  screen \
  tmux \
  silversearcher-ag \
  software-properties-common \
  xsel \
  zsh

if [ $(id -u) -neq 0 ]; then
  info adding $(whoami) to docker group - log out for changes to take effect
  run_with_sudo usermod -aG docker $(whoami)

  info removing run_with_sudo credential cache
  sudo -K
fi

