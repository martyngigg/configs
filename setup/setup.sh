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

function exit_if_command_not_available {
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

exit_if_command_not_available git
exit_if_command_not_available curl

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
  git clone --recursive $remote_rw $local_clone_dir
  if [ $? -ne 0 ]; then
    info "cloning from read-write remote failed, are your ssh keys set up? trying again on read-only remote '$remote_ro'"
    git clone --recursive $remote_ro $local_clone_dir
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

# Link a source to a target, backing up the original if it is not a link
# @param $1 target The link name
# @param $2 source the source for the link
function link_asset() {
  local link_cmd="ln -s"
  local target=$1
  local source=$2
  if [ -e $target ]; then
    debug mv $target{,.bak}
    mv $target{,.bak}
  fi
  debug $link_cmd $source $target
  $link_cmd $source $target

}

# Link all specified assets to the given directory
# @param $1 target directory for link
# @param $2 source directory
# @param $3..$n list of files and directories to link
function link_assets() {
  local target_dir=$1
  shift 1
  local source_dir=$1
  shift 1
  info "linking new assets from $source_dir -> $target_dir"
  for asset in $*; do
    source=$source_dir/$asset
    target=$target_dir/$asset
    if [ ! -L $target ]; then
      link_asset $target $source
    fi
  done
}

# ------------------------------------------------------------------------------
# Install powerline fonts
# ------------------------------------------------------------------------------
if [ ! -f $home/.fonts/PowerlineSymbols.otf ]; then
  test -d $home/.fonts || mkdir $home/.fonts
  curl --silent --show-error --location -o $home/.fonts/PowerlineSymbols.otf https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
  fc-cache -vf $home/.fonts/
  test -d $home/.fonts.conf.d || mkdir $home/.fonts.conf.d
  curl --silent --show-error --location -o $home/.fonts.conf.d/10-powerline-symbols.conf https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
fi




# ------------------------------------------------------------------------------
# link dotfiles
# ------------------------------------------------------------------------------
ignored="setup.sh|setup-emacs-cpp.sh|README.md|.gitignore|setup|.git"
source_dir=$local_clone_dir/dotfiles
assets=$(ls -A1 $source_dir | egrep -v ignored | xargs)
link_assets $home $source_dir $assets

# ------------------------------------------------------------------------------
# solarize dircolors
# ------------------------------------------------------------------------------
dircolors_theme=dircolors.256dark
if [ ! -L $home/.dircolors ]; then
  info "installing solarize dircolors"
  link_asset $home/.dircolors $local_clone_dir/thirdparty/dircolors-solarized/$dircolors_theme
else
  info "solarized dircolors is already installed"
fi

# ------------------------------------------------------------------------------
# customize gnome-terminal theme
# ------------------------------------------------------------------------------
info "installing solarized theme for gnome terminal"
$local_clone_dir/thirdparty/gnome-terminal-colors-solarized/install.sh --scheme=dark --profile=Default
info "setting terminal defaults"
gconftool-2 -s /apps/gnome-terminal/profiles/Default/font --type string "Inconsolata Medium 12"
gconftool-2 -s /apps/gnome-terminal/profiles/Default/use_system_font --type boolean false
gconftool-2 -s /apps/gnome-terminal/profiles/Default/use_custom_default_size --type boolean true
gconftool-2 -s /apps/gnome-terminal/profiles/Default/default_size_rows --type int 49
gconftool-2 -s /apps/gnome-terminal/profiles/Default/default_size_columns --type int 102
gconftool-2 -s /apps/gnome-terminal/profiles/Default/silent_bell --type boolean true
gconftool-2 -s /apps/gnome-terminal/profiles/Default/default_show_menubar --type boolean false

# ------------------------------------------------------------------------------
# setup emacs C++ IDE
# ------------------------------------------------------------------------------
#`dirname ${0}`/setup-emacs-cpp.sh
