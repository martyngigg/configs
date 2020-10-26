#!/bin/sh
# Install custom fonts

# Source URLs
powerline_symbols_url=https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
inconsolata_url=https://github.com/powerline/fonts/raw/master/Inconsolata-g/Inconsolata-g%20for%20Powerline.otf

# Destination directories
fonts_home_path=$HOME/Library/Fonts

if [ ! -f $fonts_home_path/PowerlineSymbols.otf ]; then
  test -d $fonts_home_path || mkdir $fonts_home_path
  curl --silent --show-error --location -o $fonts_home_path/PowerlineSymbols.otf $powerline_symbols_url
  curl --silent --show-error --location -o "$fonts_home_path/Inconsolata-g for Powerline.otf" https://github.com/powerline/fonts/raw/master/Inconsolata-g/Inconsolata-g%20for%20Powerline.otf
fi
