#!/bin/bash
# Install common packages with brew

# standard formulae
brew install \
  bat \
  ccache \
  git \
  htop \
  jq \
  limactl \
  mosh \
  parquet-cli \
  pwgen \
  nvm \
  ripgrep \
  the_silver_searcher \
  uv \
  watch \
  yq

# cask installs
brew cask install \
  virtualbox \
  iterm2 \
  visual-studio-code
