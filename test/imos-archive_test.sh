run() {
  local tmporary_directory=''
  func::tmpfile temporary_directory
  mkdir -p "${temporary_directory}"
  # pushd "${temporary_directory}" >'/dev/null'
  local output_file=''
  func::tmpfile output_file
  imos-archive --output="${output_file}" "$@"
  if [ "${#run_options[*]}" -ne 0 ]; then
    "${output_file}" "${run_options[@]}"
  else
    "${output_file}"
  fi
  # popd >'/dev/null'
}

test::imos-archive() {
  local run_options=()
  local sample_command="$(dirname "${BASH_SOURCE}")/imos-archive.sh"
  # pushd "$(dirname "${BASH_SOURCE}")"
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
