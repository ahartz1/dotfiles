if [ $(which brew) ]; then

  # Set architecture flags
  export ARCHFLAGS="-arch x86_64"

  # Ensure user-installed binaries take precedence
  export PATH="/usr/local/sbin:$PATH"

  # Homebrew autocompletion
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
  fi

fi
