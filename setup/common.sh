#!/bin/sh

if [ -z "$DEBUG" ]; then
  DEBUG=0
fi

# fix home for root
if [ $(whoami) = "root" ]; then
  home="/root"
else
  home=$HOME
fi

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


# Remove a directory if it exists
# @param $1 target
function remove_existing_directory() {
  local target=$1
  shift 1
  if [ -d $target ]; then
    rm -rf $target
  fi
}

# Remove a directory if it exists
# @param $1..$n directories to remove
function remove_existing_directories() {
  local target=$1
  shift 1
  info "removing directories $*"
  for direc in $*; do
     remove_existing_directory $direc
  done
}

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
      info "  linking $source -> $target"
      link_asset $target $source
    fi
  done
}
