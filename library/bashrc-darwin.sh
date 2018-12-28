edit() {
  if [ "${#}" -ne 0 ]; then
    open -a 'Visual Studio Code' "${@}"
  else
    LOG ERROR 'Wrong number of arguments.'
  fi
}
