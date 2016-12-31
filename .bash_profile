#!/bin/bash

if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

[[ -s "/Users/roothy/.gvm/scripts/gvm" ]] && source "/Users/roothy/.gvm/scripts/gvm"
