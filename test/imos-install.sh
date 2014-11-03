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

imos-crypt() {
  LOG INFO "Command: imos-crypt $*"
}

LAUNCHCTL_DIRECTORY="${TMPDIR}/launchctl"
mkdir -p "${LAUNCHCTL_DIRECTORY}"
echo $'PID\tStatus\tLabel' > "${LAUNCHCTL_DIRECTORY}/HEADER"
echo $'17\t0\tcom.apple.syslogd' > "${LAUNCHCTL_DIRECTORY}/com.apple.syslogd"
echo $'-\t0\tjp.imoz.foo' > "${LAUNCHCTL_DIRECTORY}/jp.imoz.foo"
launchctl() {
  case "${1}" in
    list)
      cat "${LAUNCHCTL_DIRECTORY}"/*
      ;;
    load)
      CHECK [ -f "${2}" ]
      ;;
    remove)
      CHECK [ -f "${LAUNCHCTL_DIRECTORY}/${2}" ]
      rm "${LAUNCHCTL_DIRECTORY}/${2}"
      ;;
    *)
      LOG FATAL "Unknown launchctl command: ${1}";;
  esac
}

source "$(dirname "${BASH_SOURCE}")"/../imos-install || exit 1
