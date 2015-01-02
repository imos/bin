#!/bin/bash

source "$(dirname "${BASH_SOURCE}")"/../imos-variables || exit 1

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
  echo 'Psyduck'
}

mkdir -p "${TMPDIR}/scutil"
scutil() {
  if [ "${#}" -eq 3 ]; then
    CHECK [ "${1}" = '--set' ]
    sub::println "${3}" > "${TMPDIR}/scutil/${2}"
  else
    LOG FATAL "Wrong number of arguments: ${#}"
  fi
}

source "$(dirname "${BASH_SOURCE}")"/../imos-start || exit 1
