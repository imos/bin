test::imos-bashrc() {
  PS1='$' POKEMON='Pikachu' UNAME='Darwin' \
      "$(dirname "${BASH_SOURCE}")"/imos-bashrc.sh
  PS1='$' POKEMON='Pikachu' UNAME='Linux' \
      "$(dirname "${BASH_SOURCE}")"/imos-bashrc.sh
  PS1='$' POKEMON='Pikachu' UNAME='Unknown' \
      "$(dirname "${BASH_SOURCE}")"/imos-bashrc.sh
}
