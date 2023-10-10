#!/bin/bash
# Install common packages with brew

# standard formulae
brew install \
  bat \
  ccache \
  git \
  htop \
  limactl \
  mosh \
  ripgrep \
  the_silver_searcher \
  watch

# cask installs
brew cask install \
  virtualbox \
  iterm2 \
  visual-studio-code
