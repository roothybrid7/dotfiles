#!/bin/bash

shopt -s expand_aliases

[ ! -d "$XDG_DATA_HOME/bash" ] && mkdir -p "$XDG_DATA_HOME/bash"

# Load bash completions
load_bash_completions() {
  for f in $@
  do
    source $f
  done
}

brew_prefix=$(brew --prefix)

[ -f "$brew_prefix/etc/bash_completion" ] && . "$brew_prefix/etc/bash_completion"
[[ -f "$XDG_LIB_HOME/bash/gpip.sh" ]] && . "$XDG_LIB_HOME/bash/gpip.sh"
[[ -f "$XDG_LIB_HOME/bash/ln_yadm_encrypt.sh" ]] && . "$XDG_LIB_HOME/bash/ln_yadm_encrypt.sh"

which pip >/dev/null 2>&1 && eval "$(pip completion --bash)"
which pyenv >/dev/null && eval "$(pyenv init -)"
which rbenv >/dev/null && eval "$(rbenv init -)"
which nodenv >/dev/null && eval "$(nodenv init -)"
which swiftenv >/dev/null && eval "$(swiftenv init -)"

# virtualenv for python
which virtualenvwrapper.sh >/dev/null && {
  export WORKON_HOME=$XDG_DATA_HOME/virtualenvs
  . virtualenvwrapper.sh
}
export PIP_REQUIRE_VIRTUALENV=true

PS1='\[\e[35m\]\h\[\e[00m\]:\[\e[1;36m\]\W\[\e[00m\] \u\[\e[1;32m\]$(__git_ps1)\[\e[00m\] \[\e[4;33m\]\t\[\e[00m\]\n\$ '

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh
