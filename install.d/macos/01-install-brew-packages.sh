#!/bin/bash
# Install common packages with brew

# standard formulae
brew install \
  bat \
  ccache \
  git \
  htop \
  mosh \
  the_silver_searcher

# cask installs
brew cask install \
  iterm2 \
  visual-studio-code
