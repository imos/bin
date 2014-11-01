#!/bin/bash

source "$(dirname "${BASH_SOURCE}")"/../imosh || exit 1

whoami() {
  LOG INFO "Command: whoami $*"
  if [ "$#" -eq 0 ]; then
    echo root
  else
    LOG FATAL "Wrong number of arguments: $#"
  fi
}

imos-pokemon() {
  LOG INFO "Command: imos-pokemon $*"
  echo 'Pikachu'
}

source "$(dirname "${BASH_SOURCE}")"/../imos-install || exit 1
