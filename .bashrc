#!/bin/bash

brew_prefix=$(brew --prefix)

shopt -s expand_aliases

[ ! -d "$XDG_DATA_HOME/bash" ] && mkdir -p "$XDG_DATA_HOME/bash"

# Load bash completions
compl_files="$brew_prefix/etc/bash_completion.d/*"
for f in $compl_files
do
  . $f
done

[[ -f "$XDG_LIB_HOME/bash/gpip.sh" ]] && . "$XDG_LIB_HOME/bash/gpip.sh"

which pip >/dev/null 2>&1 && eval "$(pip completion --bash)"
which pyenv >/dev/null && eval "$(pyenv init -)"
which rbenv >/dev/null && eval "$(rbenv init -)"

# virtualenv for python
which virtualenvwrapper.sh >/dev/null && {
  export WORKON_HOME=$XDG_DATA_HOME/virtualenvs
  . virtualenvwrapper.sh
}
export PIP_REQUIRE_VIRTUALENV=true

PS1='\[\e[35m\]\h\[\e[00m\]:\[\e[1;36m\]\W\[\e[00m\] \u\[\e[1;32m\]$(__git_ps1)\[\e[00m\] \[\e[4;33m\]\t\[\e[00m\]\n\$ '
