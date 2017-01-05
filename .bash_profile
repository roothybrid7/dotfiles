#!/bin/bash

system_type=$(uname -s)

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_LIB_HOME="$HOME/.local/lib"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Tools
export INPUTRC="$XDG_CONFIG_HOME/bash/inputrc"
# Use Apple Terminal
if [ "$system_type" != "Darwin" ]; then
  export HISTFILE="$XDG_DATA_HOME/bash/history"
  export HISTSIZE=100000
  export HISTFILESIZE=100000
fi
export PAGER='lv -c'
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME/httpie"

# XXXenv
export GOPATH="$HOME/.go"
export PYENV_ROOT="$HOME/.pyenv"
export RBENV_ROOT="$HOME/.rbenv"

export PATH=/usr/local/sbin:$PYENV_ROOT/shims:$RBENV_ROOT/bin:$PATH:$GOPATH/bin

# Python user site packages
if [[ "$system_type" = "Darwin" ]]; then
  py_ver=$(/usr/bin/python -V 2>&1 >/dev/null | sed -e 's/Python *//g' | awk -F'.' '{OFS=".";print $1,$2}')
  py_ver=$(echo -n $py_ver)
  export PATH=$HOME/Library/Python/$py_ver/bin:$PATH
else
  export PATH=$HOME/.local/bin:$PATH
fi

# Use a dotfile in $HOME directory for regacy tools
[[ -f "$HOME/.bashrc" ]] && . "$HOME/.bashrc"

[[ -f "$XDG_CONFIG_HOME/bash/env" ]] && . "$XDG_CONFIG_HOME/bash/env"

[[ -s "/Users/roothy/.gvm/scripts/gvm" ]] && source "/Users/roothy/.gvm/scripts/gvm"
