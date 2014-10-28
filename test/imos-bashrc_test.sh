test::imos-bashrc() {
  PS1='$'
  POKEMON='Pikachu'
  source "$(dirname "${BASH_SOURCE}")/../imos-bashrc"
  eval "echo \"${PS1}\"" > '/dev/null'
}
