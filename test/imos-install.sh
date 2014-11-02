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

launchctl() {
  case "${1}" in
    list)
      echo $'PID\tStatus\tLabel'
      echo $'17\t0\tcom.apple.syslogd'
      echo $'17\t0\tjp.imoz.foo'
      ;;
    load)
      CHECK [ -f "${2}" ]
      ;;
    *)
      LOG FATAL "Unknown launchctl command: ${1}";;
  esac
}

source "$(dirname "${BASH_SOURCE}")"/../imos-install || exit 1
