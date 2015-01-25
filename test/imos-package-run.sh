source "$(dirname "${BASH_SOURCE}")"/../imos-package || exit 1

imos-package::download() {
  LOG INFO "imos-package::download $*"
  if [ "$#" -eq 1 ]; then
    CHECK [ "${1}" = '0123456789abcdef0123456789abcdef' ]
    CHECK [ "${FLAGS_command}" != '' ]
    CHECK [ "${FLAGS_output}" != '' ]
    sub::println "${FLAGS_command}" >"${FLAGS_output}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

eval "${IMOSH_INIT}"
CHECK [ "$#" -eq 0 ]
imos-package::run 0123456789abcdef0123456789abcdef "$@"
