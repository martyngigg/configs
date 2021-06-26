#!/bin/bash
# install.sh: Assuming a clean system: setup standard packages and install
#           config scripts stored here
DEBUG=1

# script must be run as subshell and not sourced
(return 0 2>/dev/null) && SOURCED=1 || SOURCED=0
if [ "$SOURCED" == "1"  ]; then
  echo "Script must be run with subshell and not sourced with '.'"
  return 1
fi

# put us in this directory
pushd $(dirname $0)

# utilities
source scripts/common.sh

# functions
function exit_on_failure {
  debug $*
  $*
  if [ $? -ne 0 ]; then
    echo -e "\nExecuting '$*' failed."
    exit $?
  fi
}

# where are we
this_dir=$( cd "$( dirname "$0" )" && pwd )

# are we on a system we understand
source scripts/systeminfo.sh

# main
if [ $ON_DEBIAN = true ]; then
  install_d_dir=$this_dir/install.d/debian
else
  install_d_dir=$this_dir/install.d/macos
fi
for install_file in `ls $install_d_dir/*.sh | sort -V`; do
  exit_on_failure bash $install_file
done
