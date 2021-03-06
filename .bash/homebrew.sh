if [ $(which brew 2> /dev/null) ]; then

  # Set architecture flags
  export ARCHFLAGS="-arch x86_64"

  # Ensure user-installed binaries take precedence
  export PATH="/usr/local/sbin:$PATH"

  # Homebrew autocompletion (`brew install bash-completion`)
  if [ -z "$ZSH" ] && [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
  fi

fi
