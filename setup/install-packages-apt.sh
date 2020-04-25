#!/bin/bash

setup_dir=$(cd $(dirname "$0") && pwd)
. $setup_dir/common.sh

info updating package lists
sudo apt-get -y update

info upgrading current packages
sudo apt-get -y dist-upgrade

info removing old packages
sudo apt-get -y autoremove

info installing packages
sudo apt-get -y install \
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

info adding $(whoami) to docker group - log out for changes to take effect
sudo usermod -aG docker $(whoami)
