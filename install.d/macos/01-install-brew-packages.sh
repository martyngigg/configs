#!/bin/bash
# Install common packages with brew

# standard formulae
brew install \
  bat \
  fish \
  git \
  htop \
  jq \
  limactl \
  mkcert \
  mosh \
  parquet-cli \
  pwgen \
  nvm \
  ripgrep \
  uv \
  watch \
  yq

# cask installs
brew install --cask \
  visual-studio-code \
  zed
