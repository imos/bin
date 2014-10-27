run() {
  SSH_TTY= "$(dirname "${BASH_SOURCE}")"/../imos-passgen
}

test::imos-passgen() {
  EXPECT_EQ 'zKIQMRw8' "$(echo $'foo\nbar' | run)"
  EXPECT_EQ 'J7GedYjG' "$(echo $'hoge\npiyo' | run)"
}
