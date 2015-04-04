#!/bin/bash
################################################################################
# setup.sh: Assuming a clean system: setup standard packages and install
#           config scripts stored here
#
#   curl -Ls https://github.com/martyngigg/configs/raw/master/setup/setup.sh | bash
#
# Author: Martyn Gigg
################################################################################

# ------------------------------------------------------------------------------
# Check script requirements
# ------------------------------------------------------------------------------
DEBUG=1

function exit_if_command_available {
  if [ -z $(which $1) ]; then
    echo "Installation requires the $1 command to be available"
    exit 1
  fi
}

function info() {
  echo "--" $*
}

function debug() {
  [ $DEBUG -eq 1 ] && echo "  " $*
}

exit_if_command_available git
exit_if_command_available curl

# Fix home for root
if [ $(whoami) = "root" ]; then
  home="/root"
else
  home=$HOME
fi

# ------------------------------------------------------------------------------
# Clone or update repository
# ------------------------------------------------------------------------------
local_repos_dir=$home/.repos
repo_name=configs
local_clone_dir=$home/.repos/$repo_name

remote_rw="git@github.com:martyngigg/configs.git"
remote_ro="https://github.com/martyngigg/configs.git"
tarball_url="https://www.github.com/martyngigg/configs/tarball/master"

info "home is" $home
info "configs folder is" $local_clone_dir

[ -d $local_repos_dir ] || mkdir $local_repos_dir

if [ ! -d $local_clone_dir ]; then
  info "trying clone from read-write remote '$remote_rw' into '$local_clone_dir'"
  git clone $remote_rw $local_clone_dir
  if [ $? -ne 0 ]; then
    info "cloning from read-write remote failed, are your ssh keys set up? trying again on read-only remote '$remote_ro'"
    git clone $remote_ro $local_clone_dir
    if [ $? -ne 0 ]; then
      info "cloning from read-only remote failed. unable to continue"
      exit 1
    fi
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

# ------------------------------------------------------------------------------
# install or update links
# ------------------------------------------------------------------------------
#
# Link all specified assets to the given directory
# @param $1 target directory for link
# @param $2 source directory
# @param $3..$n list of files and directories to link
function link_assets() {
  _link_cmd="ln -s"
  _target_dir=$1
  shift 1
  _source_dir=$1
  shift 1
  info "updating linked assets from $_source_dir -> $_target_dir"
  for asset in $*; do
    _source=$_source_dir/$asset
    _target=$_target_dir/$asset
    if [ ! -L $_target ]; then
      debug mv $_target{,.bak}
      mv $_target{,.bak}
      debug $_link_cmd $_source $_target
      $_link_cmd $_source $_target
    fi
  done
}

ignored="setup.sh|README.md|.gitignore|setup|.git"
source_dir=$local_clone_dir/dotfiles
assets=$(ls -A1 $source_dir | egrep -v ignored | xargs)
link_assets $home $source_dir $assets
