# Dotfiles

## Overview

This repo contains dotfiles for a development environment setup, including Vim and tmux configurations. It includes a utility ([dfm](https://github.com/justone/dfm)) to help with managing and updating your dotfiles.

## Using this repo

### If you just want to use the dotfiles...

```bash
$ cd ~
$ git clone https://github.com/ahartz1/dotfiles.git .dotfiles
$ ./.dotfiles/bin/dfm install  # Creates symlinks to install files. Shell restart required.
```

### If you want to make changes...

First, fork this repo.

Then, add your dotfiles:

```bash
$ cd ~
$ git clone git@github.com:username/dotfiles.git .dotfiles
$ cd .dotfiles
$  # edit files
$  # edit files
$ git push origin master
```

Finally, to install your dotfiles onto a new system:

```bash
$ cd ~
$ git clone git@github.com:username/dotfiles.git .dotfiles
$ ./.dotfiles/bin/dfm install  # Creates symlinks to install files. Shell restart required.
```

## Full documentation

For more information, check out the [wiki](http://github.com/justone/dotfiles/wiki).

You can also run

```bash
~/.dotfiles/bin/dfm --help
```

## Resources for Vim

 * To get Vim running properly, you must have first installed my dotfiles (or at least the Vim-related files) and run the dfm install command. (On first install, shell restart is required.)

```bash
$ ~/.dotfiles/bin/dfm install
```

 * You also must be running Vim 7.4.x or greater to allow the `2nd user vimrc` location to be set by default (to `~/.vim/vimrc`). On OS&nbsp;X / macOS, this can be done with homebrew:

```bash
$ brew install vim
```
 * For vim-airline to correctly display symbols in the lower status bar, you will need to install a patched font. There are many choices in powerline's [fonts folder](https://github.com/powerline/fonts). However, I prefer Menlo (which is the default font in Atom and isn't in powerline's folder), so I used the patched version [here](https://gist.github.com/sjl/1627888). Navigate to the font in Finder, double click on it, and install it.
 * Once installed, you must change your Terminal or iTerm2 profile font settings to use it.
 * For the Solarized theme to work best in iTerm2, download the [iTerm2 color settings](https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized) and load them in iTerm2 (in OS&nbsp;X / macOS, just double-click the itermcolors file). Note that once it is loaded, you must then select it in your Profile's 'Colors' tab.
 * Plugins are managed with [vim-plug](https://github.com/junegunn/vim-plug); launch Vim and type `:PlugInstall` to install the plugins.
 * For ALE to perform syntax checks, install the following (using [npm](http://npmjs.com)):
   * JavaScript, JSX, React: `eslint`, `babel-eslint`, and `eslint-plugin-react`
   * Sass: `sass-lint`
   * HTML: `htmlhint`

```bash
$ sudo npm install -g eslint babel-eslint eslint-plugin-react sass-lint htmlhint
```

* An important tip for making both Vim and tmux possible to use easily: remap your caps lock key to control.

## Resources for tmux

 * For tmux to work as configured in these dotfiles, you will need to install `tmux` and, if you are on OS&nbsp;X / macOS, also `reattach-to-user-namespace` (only use `--with-wrap-pbcopy-and-pbpaste` flag for macOS).

```bash
$ brew install tmux reattach-to-user-namespace --with-wrap-pbcopy-and-pbpaste
```
 * Then, you'll need to install the tmux plugin manager.

```bash
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

 * I have configured the tmux prefix to be `Ctrl+s`. The first time you fire up tmux, use prefix + `I` to install the plugins. This will enable the session saving. If you activate session saving in Vim using `:Obsession`, the tmux restoration process will reopen Vim using the Session.vim present in the working directory, if it exists.

## Configuring italics in iTerm2

These dotfiles include support of italics in iTerm2, but you will need to adjust iTerm2's settings to get it working.

 * For the Profile in question, go to the 'Text' tab and select the 'Use different font for non-ASCII text'; select your powerline font for this. For the normal Font, select a standard mono-spaced font that has support of italics (e.g., Menlo).
 * Next, in that same Profile's 'Terminal' tab, modify the 'Report Terminal Type' field to be `xterm-256color-italic` (note you can just type into this box, it is not purely a dropdown).
