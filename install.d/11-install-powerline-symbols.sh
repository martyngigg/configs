#!/bin/sh
# Install powerline fonts

# Source URLs
powerline_symbols_url=https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
powerline_symbols_conf_url=https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf

# Destination directories
fonts_home_path=$HOME/.fonts
fonts_conf_home_path=$HOME/.fonts.conf.d

if [ ! -f $fonts_home_path/PowerlineSymbols.otf ]; then
  test -d $fonts_home_path || mkdir $fonts_home_path
  curl --silent --show-error --location -o $fonts_home_path/PowerlineSymbols.otf $powerline_symbols_url
  fc-cache -vf $fonts_home_path
  test -d $fonts_conf_home_path || mkdir $fonts_conf_home_path
  curl --silent --show-error --location -o $fonts_conf_home_path/10-powerline-symbols.conf $powerline_symbols_conf_url
fi
