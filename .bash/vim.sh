#!/bin/bash

# In order for NERDTree to recognize the plugin, it has to be in its
# nerdtree_plugin folder. But we want the script under source control!
# Solution? Symlink it in if it doesn't already exist.
# Also, exclude it from nerdtree's repo so it doesn't appear dirty
if [ -d ~/.dotfiles/.vim/bundle/nerdtree/nerdtree_plugin ] && \
   [ -e ~/.dotfiles/myscripts/yank_path.vim ] && \
   [ ! -L ~/.dotfiles/.vim/bundle/nerdtree/nerdtree_plugin/yank_path.vim ]
then
  ln -s ~/.dotfiles/myscripts/yank_path.vim \
        ~/.dotfiles/.vim/bundle/nerdtree/nerdtree_plugin/yank_path.vim
  echo 'nerdtree_plugin/yank_path.vim' >> \
       ~/.dotfiles/.vim/bundle/nerdtree/.git/info/exclude
fi

# neovim version of the above
if [ -d ~/.local/share/nvim/lazy/nerdtree/nerdtree_plugin ] && \
   [ -e ~/.dotfiles/myscripts/yank_path.vim ] && \
   [ ! -L ~/.local/share/nvim/lazy/nerdtree/nerdtree_plugin/yank_path.vim ]
then
  ln -s ~/.dotfiles/myscripts/yank_path.vim \
        ~/.local/share/nvim/lazy/nerdtree/nerdtree_plugin/yank_path.vim
  echo 'nerdtree_plugin/yank_path.vim' >> \
       ~/.local/share/nvim/lazy/nerdtree/.git/info/exclude
fi

# Ensure that editorconfig can work
if [ -d ~/.dotfiles/.vim/bundle/editorconfig-vim ]; then
  if [ ! -L ~/.dotfiles/.vim/plugin/editorconfig.vim ]; then
    ln -s ~/.dotfiles/.vim/bundle/editorconfig-vim/plugin/editorconfig.vim \
          ~/.dotfiles/.vim/plugin/editorconfig.vim
  fi
  if [ ! -L ~/.dotfiles/.vim/plugin/editorconfig.py ]; then
    ln -s ~/.dotfiles/.vim/bundle/editorconfig-vim/plugin/editorconfig.py \
          ~/.dotfiles/.vim/plugin/editorconfig.py
  fi
  if [ ! -L ~/.dotfiles/.vim/autoload/editorconfig.vim ]; then
    ln -s ~/.dotfiles/.vim/bundle/editorconfig-vim/autoload/editorconfig.vim \
          ~/.dotfiles/.vim/autoload/editorconfig.vim
  fi
fi

# Ensure that NeoVim knows about coc-settings
if [ -f ~/.dotfiles/.vim/coc-settings.json ] \
    && [ ! -L ~/.config/nvim/coc-settings.json ]; then
  ln -s ~/.dotfiles/.vim/coc-settings.json \
        ~/.config/nvim/coc-settings.json
fi

# Make sure that NeoVim can use solarized
if [ -f ~/.dotfiles/.vim/colors/solarized.vim ]; then
  if [ ! -L ~/.config/nvim/pack/local/start/solarized/colors/solarized.vim ]; then
    ln -s ~/.dotfiles/.vim/colors/solarized.vim \
          ~/.config/nvim/pack/local/start/solarized/colors/solarized.vim
  fi
  if [ ! -L ~/.config/nvim/pack/local/start/solarized/plugin/solarized.vim ]; then
    ln -s ~/.dotfiles/.vim/colors/solarized.vim \
          ~/.config/nvim/pack/local/start/solarized/plugin/solarized.vim
  fi
fi

# Ensure that NeoVim shares plugins with Vim
if [ -f ~/.dotfiles/.vim/bundle/editorconfig-vim/plugin/editorconfig.vim ] \
    && [ ! -L ~/.config/nvim/plugin/editorconfig.vim ]; then
  ln -s ~/.dotfiles/.vim/bundle/editorconfig-vim/plugin/editorconfig.vim \
        ~/.config/nvim/plugin/editorconfig.vim
fi

if [ -f ~/.dotfiles/.vim/plugin/ajgitcommitmsg.vim ] \
    && [ ! -L ~/.config/nvim/plugin/ajgitcommitmsg.vim ]; then
  ln -s ~/.dotfiles/.vim/plugin/ajgitcommitmsg.vim \
        ~/.config/nvim/plugin/ajgitcommitmsg.vim
fi

if [ -f ~/.dotfiles/.vim/plugin/delete-non-window-buffers.vim ] \
    && [ ! -L ~/.config/nvim/plugin/delete-non-window-buffers.vim ]; then
  ln -s ~/.dotfiles/.vim/plugin/delete-non-window-buffers.vim \
        ~/.config/nvim/plugin/delete-non-window-buffers.vim
fi

if [ -f ~/.dotfiles/.vim/plugin/grep-operator.vim ] \
    && [ ! -L ~/.config/nvim/plugin/grep-operator.vim ]; then
  ln -s ~/.dotfiles/.vim/plugin/grep-operator.vim \
        ~/.config/nvim/plugin/grep-operator.vim
fi
