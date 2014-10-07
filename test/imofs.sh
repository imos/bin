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

service() {
  LOG INFO "Command: service $*"
  if [ "$#" -eq 2 ]; then
    local service="$1"
    local command="$2"
    case "${command}" in
      status)
        if ! func::isset "SERVICE_${service}"; then
          LOG ERROR "Unrecognized service: ${service}"
          return 1
        fi
        if (( SERVICE_${service} )); then
          return 0
        fi
        return 2
        ;;
      start)
        func::let "SERVICE_${service}" 1
        ;;
      stop)
        func::let "SERVICE_${service}" 0
        ;;
    esac
  else
    LOG FATAL "Wrong number of arguments: $#"
  fi
}

SERVICE_mysqld=1

rsync() {
  CHECK --message='mysqld must be turned off during rsync.' \
      [ "${SERVICE_mysqld}" -eq 0 ]
  command -p rsync "$@"
}

source "$(dirname "${BASH_SOURCE}")"/../imofs || exit 1

CHECK --message='mysqld is not restored.' [ "${SERVICE_mysqld}" -eq 1 ]
