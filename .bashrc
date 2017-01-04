#!/bin/bash

brew_prefix=$(brew --prefix)

shopt -s expand_aliases

[ ! -d "$XDG_DATA_HOME/bash" ] && mkdir -p "$XDG_DATA_HOME/bash"
[[ -f /Applications/SourceTree.app/Contents/Resources/stree  ]] && [[ ! -f /usr/local/bin/stree ]] && ln -s /Applications/SourceTree.app/Contents/Resources/stree /usr/local/bin/stree

# Load bash completions
compl_files="$brew_prefix/etc/bash_completion.d/*"
for f in $compl_files
do
  . $f
done

PS1='\[\e[35m\]\h\[\e[00m\]:\[\e[1;36m\]\W\[\e[00m\] \u\[\e[1;32m\]$(__git_ps1)\[\e[00m\] \[\e[4;33m\]\t\[\e[00m\]\n\$ '

which pyenv >/dev/null && eval "$(pyenv init -)"
which rbenv >/dev/null && eval "$(rbenv init -)"
