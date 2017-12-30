#!/bin/sh

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
