#!/bin/bash

# Update and init submodules
git submodule update --init

# Iterate over the list of setup files we want to alias from our dotfile
# distribution
for file in vimrc vim tmux.conf gitconfig; do
   # Check to see if the file already has a symlink. If it does, we won't touch
   # it.
   if [ ! -h ~/.${file} ]; then
      # If the file exists, ask the user if they'd like us to move it to
      # FILENAME_old. If we don't move it, ln won't overwrite it, it'll just
      # fail.
      if [ -e ~/.${file} ]; then
         read -p "Move existing $file to ${file}_old? y[n] " -n 1
         echo
         if [[ $REPLY =~ ^[Yy]$ ]]; then
            mv ~/.${file} ~/.${file}_old
         fi
      fi
      # Add the appropriate symlink
      echo "Symlinking ~/dotfiles/${file} to ~/.${file}"
      ln -s ~/dotfiles/${file} ~/.${file}
   fi
done

# Softlink zsh customizations to $ZSH_CUSTOM dir.
ln -s ~/dotfiles/custom.sh ~/.oh-my-bash/custom/brolfe-personal.sh
ln -s "$HOME/.vimrc" "$HOME/.ideavimrc"
