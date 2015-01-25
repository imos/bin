run() {
  "$(dirname "${BASH_SOURCE}")/imos-package-run.sh" "$@" &
  wait "$!" || echo "Exit status: $?"
}

test::imos-package::run() {
  EXPECT_EQ 'foo bar' "$(run --command='echo foo bar')"
  EXPECT_EQ 'Exit status: 134' "$(run --command='kill -SIGABRT $$')"
  EXPECT_EQ 'Exit status: 137' "$(run --command='kill -SIGKILL $$')"
}
