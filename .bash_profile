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
export EDITOR=vim

# XXXenv
export GOPATH="$HOME/.go"
export PYENV_ROOT="$HOME/.pyenv"
export RBENV_ROOT="$HOME/.rbenv"
export NODENV_ROOT="$HOME/.nodenv"
export SWIFTENV_ROOT="$HOME/.swiftenv"
export GOENVGOROOT="$XDG_LIB_HOME/.goenvs"
export GOENVTARGET="$XDG_BIN_HOME"
export GOENVHOME="$XDG_DATA_HOME/workspace"
export ANDROID_HOME="$HOME/Library/Android"
export ANDROID_SDK_ROOT="$ANDROID_HOME/sdk"
export ANDROID_SDK="$ANDROID_SDK_ROOT"

export PATH=/usr/local/sbin:$XDG_BIN_HOME:$PYENV_ROOT/shims:$RBENV_ROOT/shims:$NODENV_ROOT/shims:$SWIFTENV_ROOT/bin:$PATH:$GOPATH/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/tools:$PATH

# Python user site packages
if [[ "$system_type" == "Darwin" ]]; then
  py_ver=$(/usr/bin/python -V 2>&1 >/dev/null | sed -e 's/Python *//g' | awk -F'.' '{OFS=".";print $1,$2}')
  py_ver=$(echo -n $py_ver)
  export PATH=$HOME/Library/Python/$py_ver/bin:$PATH
else
  export PATH=$HOME/.local/bin:$PATH
fi

export IRBRC="$XDG_CONFIG_HOME/ruby/irbrc"

[[ -f "$XDG_DATA_HOME/ansible/.provisioning_vault_pass.txt" ]] && export ANSIBLE_VAULT_PASSWORD_FILE=$XDG_DATA_HOME/ansible/.provisioning_vault_pass.txt

[[ -f "$XDG_CONFIG_HOME/bash/profile.local" ]] && . "$XDG_CONFIG_HOME/bash/profile.local"

# Use a dotfile in $HOME directory for regacy tools
[[ -f "$HOME/.bashrc" ]] && . "$HOME/.bashrc"

[[ -f "$XDG_CONFIG_HOME/bash/env" ]] && . "$XDG_CONFIG_HOME/bash/env"
export PATH="/usr/local/opt/libxml2/bin:$PATH"
