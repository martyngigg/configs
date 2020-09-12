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

# are we on a system we understand - basically a Debian-like system at the moment
if [ -z "$(which dpkg)" ]; then
  echo "Unable to find dpkg. Is this a Debian-like distro?"
  exit 1
fi

# main
install_d_dir=$this_dir/install.d
for install_file in `ls $install_d_dir/*.sh | sort -V`; do
  exit_on_failure bash $install_file
done
