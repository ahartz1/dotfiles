if command -v pyenv 2>&1 >/dev/null ; then
  export PYENV_ROOT="$HOME"/.pyenv
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init - zsh)"
fi
