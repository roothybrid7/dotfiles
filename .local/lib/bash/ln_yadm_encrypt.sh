#!/bin/bash

ln_yadm_encrypt() {
  system_type=$(uname -s)
  os_matcher="*##${system_type}"
  echo $os_matcher

  for path in $(cat $HOME/.yadm/encrypt)
  do
    case "$path" in
      $os_matcher )
        src="${HOME}/${path}"
        dest="${src%##${system_type}}"
        echo "Linking ${src} to ${dest}"
        ln -nfs ${src} ${dest} ;;
    esac
  done
}
