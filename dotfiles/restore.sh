#!/bin/sh

FILES=".bash_aliases .bashrc_mgigg .emacs .gitconfig"

for f in ${FILES}; do
   echo "Restoring $f"
   cp $f ~/$f
done

# patch .bashrc
echo
echo "Patching '.bashrc' to import '.bashrc_mgigg'"
SRC=`cat personalise-bashrc`
echo "${SRC}" >> ~/.bashrc # quotes enure newlines are kept
