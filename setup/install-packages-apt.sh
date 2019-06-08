#!/bin/bash

setup_dir=$(cd $(dirname "$0") && pwd)
. $setup_dir/common.sh

info updating package lists
sudo apt-get -y update

info upgrading current packages
sudo apt-get -y upgrade

info removing old packages
sudo apt-get -y autoremove

info installing base packages
sudo apt-get -y install \
  build-essential \
  cmake \
  cppcheck \
  curl \
  dconf-cli \
  devscripts \
  doxygen \
  emacs24 \
  emacs-goodies-el \
  evince \
  fakeroot \
  firefox \
  fonts-inconsolata \
  fonts-powerline \
  gdebi-core \
  htop \
  python3-ipython \
  openssh-client \
  openssh-server \
  powerline \
  screen \
  tmux \
  silversearcher-ag \
  xsel \
  zsh

info adding docker-ce repo
# allow apt to use a repository over HTTPS:
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# At time of writing there is no stable package for Ubuntu 19.04
info add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   test"
sudo apt-get -y update

info installing docker
sudo apt-get -y install \
  docker-ce \
  docker-ce-cli \
  containerd.io \
