#!/bin/sh
# Enable powerline if dbus is running

# utilities
source scripts/common.sh

# exit if dbus not running
if [ -z "$(ps -e | grep dbus-daemon)" ]; then
  info dbus daemon not running. Skipping powerline-daemon startup
  exit 0
fi

# utilities
source scripts/common.sh

info "Enabling powerline daemon"
systemctl --user enable powerline-daemon
systemctl --user start powerline-daemon
