#!/bin/sh

FILES=".bash_aliases .bashrc_mgigg .emacs"

for f in ${FILES}; do
   name="."$(echo $f | cut -c4-)
   echo "Restoring $name"
   cp $f ~/$name
done

# patch .bashrc
echo
echo "Patching '.bashrc' to import '.bashrc_mgigg'"
SRC=`cat personalise-bashrc`
echo "${SRC}" >> ~/.bashrc # quotes enure newlines are kept
