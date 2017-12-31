#!/bin/sh

setup_dir=$(cd $(dirname "$0") && pwd)
. $setup_dir/common.sh

info "Enabling powerline daemon"
systemctl --user enable powerline-daemon
systemctl --user start powerline-daemon
