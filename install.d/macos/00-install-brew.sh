#!/bin/bash
# Installs Homebrew package manager

# common functions
source scripts/common.sh

# exit if it's already installed
if [ "$(which brew)" != "" ]; then
  info brew already installed
  exit 0
fi


if [ $(id -u) -ne 0 ]; then
  if [ -z "$(which sudo)" ]; then
    info script requires root access but sudo command not found
    exit 1
  fi
  if sudo ls > /dev/null 2>&1; then
    info script requires raised privileges, sudo password will be requested.
  else
    info "sudo check failed. Have you raised Privileges?"
    exit 1
  fi
fi

bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
