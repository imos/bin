run() {
  local output_file=''
  func::tmpfile output_file
  "$(dirname "${BASH_SOURCE}")/../imos-package" archive \
      --output "${output_file}" --logtostderr "$@"
  if [ "${#run_options[*]}" -ne 0 ]; then
    "${output_file}" "${run_options[@]}"
  else
    "${output_file}"
  fi
}

test::imos-package::archive() {
  local run_options=()
  local sample_command="$(dirname "${BASH_SOURCE}")/imos-package-archive.sh"
  EXPECT_EQ 'foo bar' "$(run --command='echo foo bar')"
  EXPECT_EQ 'foo bar' "$(run --command='echo foo bar' --file_size=1000000)"
  EXPECT_DEATH "$(run --command='echo foo bar' --file_size=1000)"
  EXPECT_EQ '# of args: 0' "$(run --command="${sample_command}")"
  run_options=('foo bar')
  EXPECT_EQ $'# of args: 1\nfoo bar' "$(run --command="${sample_command}")"
  run_options=('foo' 'bar')
  EXPECT_EQ $'# of args: 2\nfoo\nbar' "$(run --command="${sample_command}")"
  EXPECT_EQ $'# of args: 0' "$(
      run --command="${sample_command}" --noextra_arguments)"
}
