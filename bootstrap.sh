#!/bin/bash
#
# Basic script to clone this repository to $HOME/.repos/configs
#

function info {
  echo "--" $*
}

function exit_if_command_not_available {
  if [ -z $(which $1) ]; then
    echo "Installation requires the $1 command to be available"
    exit 1
  fi
}

exit_if_command_not_available git
exit_if_command_not_available curl

# fix home
if [ $(whoami) = "root" ]; then
  home="/root"
else
  home=$HOME
fi

# clone the repository
local_repos_dir=$home/.repos
repo_name=configs
local_clone_dir=$home/.repos/$repo_name
remote_repo="https://martyngigg@github.com/martyngigg/configs.git"

info "home is" $home
info "configs folder is" $local_clone_dir

[ -d $local_repos_dir ] || mkdir $local_repos_dir

if [ ! -d $local_clone_dir ]; then
  info "trying clone from remote '$remote_repo' into '$local_clone_dir'"
  git clone --recursive $remote_repo $local_clone_dir
  if [ $? -ne 0 ]; then
    info "cloning from remote failed. unable to continue"
    exit 1
  fi
else
  info "local clone exists at '$local_clone_dir'. updating from origin master"
  cd $local_clone_dir
  git pull origin master
  if [ $? -ne 0 ]; then
    info "error updating local copy in '$local_clone_dir'"
    info "continuing with current state"
  fi
fi

info "done!"
