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

function info() {
  echo "--" $*
}

function debug() {
  [ $DEBUG -eq 1 ] && echo "  " $*
}

function exit_if_command_not_available {
  if [ -z $(which $1) ]; then
    echo "Installation requires the $1 command to be available"
    exit 1
  fi
}

# Link a source to a target, backing up the original if it is not a link
# @param $1 target The link name
# @param $2 source the source for the link
function link_asset() {
  local link_cmd="ln -s"
  local target=$1
  local source=$2
  if [ -L $target ]; then
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
    asset=$(basename $asset)
    source=$source_dir/$asset
    target=$target_dir/$asset
    if [[ ! -e $(readlink $target) ]]; then
      info "  linking $source -> $target"
      link_asset $target $source
    fi
  done
}

# Install all specified templates into the target directory, substituting
# values from the current environment where necessary
# @param $1 target directory for final file
# @param $2 source directory
# @param $3..$n list of files and directories to link
install_templates() {
  local target_dir=$1
  local source_dir=$2
  shift 2
  info "installing templates from $source_dir -> $target_dir"
  for template in $*; do
    template=$(basename $template)
    source=$source_dir/$template
    target=$target_dir/${template/.template/}
    if [[ ! -e $target ]]; then
      info "  installing $source -> $target"
    else
      info "  re-installing $source -> $target"
    fi
    install_template $target $source
  done
}

# Install a template to a target, backing up the original if one exists
# @param $1 target The link name
# @param $2 source the source for the link
install_template() {
  local target=$1
  local source=$2
  if [ -f $target ]; then
    debug mv $target{,.bak}
    mv $target{,.bak}
  fi
  debug envsubst < $source > $target
  envsubst < $source > $target
}
