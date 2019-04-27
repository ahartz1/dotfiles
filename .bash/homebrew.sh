if [ "$(which brew)" ]; then

  # Set architecture flags
  export ARCHFLAGS="-arch x86_64"

  # Ensure user-installed binaries take precedence
  if [ ! $_PATH_SET ]; then
    export PATH="/usr/local/sbin:$PATH"
  fi

  # Homebrew autocompletion
  if [ -z "$ZSH" ] && [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
  fi

fi
