#!/bin/bash
# install.sh: Assuming a clean system: setup standard packages and install
#           config scripts stored here
DEBUG=1

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
