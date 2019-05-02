#!/bin/bash

# In order for NERDTree to recognize the plugin, it has to be in its
# nerdtree_plugin folder. But we want the script under source control!
# Solution? Symlink it in if it doesn't already exist.
if [ -d ~/.dotfiles/.vim/bundle/nerdtree/nerdtree_plugin ] && \
   [ -e ~/.dotfiles/myscripts/yank_path.vim ] && \
   [ ! -e ~/.dotfiles/.vim/bundle/nerdtree/nerdtree_plugin/yank_path.vim ]
then
  ln -s ~/.dotfiles/myscripts/yank_path.vim \
        ~/.dotfiles/.vim/bundle/nerdtree/nerdtree_plugin/yank_path.vim
fi

# Ensure that editorconfig can work
if [ -d ~/.dotfiles/.vim/bundle/editorconfig-vim ]; then
  if [ ! -e ~/.dotfiles/.vim/plugin/editorconfig.vim ]; then
    ln -s ~/.dotfiles/.vim/bundle/editorconfig-vim/plugin/editorconfig.vim \
          ~/.dotfiles/.vim/plugin/editorconfig.vim
  fi
  if [ ! -e ~/.dotfiles/.vim/plugin/editorconfig.py ]; then
    ln -s ~/.dotfiles/.vim/bundle/editorconfig-vim/plugin/editorconfig.py \
          ~/.dotfiles/.vim/plugin/editorconfig.py
  fi
  if [ ! -e ~/.dotfiles/.vim/autoload/editorconfig.vim ]; then
    ln -s ~/.dotfiles/.vim/bundle/editorconfig-vim/autoload/editorconfig.vim \
          ~/.dotfiles/.vim/autoload/editorconfig.vim
  fi
fi
