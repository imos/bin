run() {
  local tmporary_directory=''
  func::tmpfile temporary_directory
  mkdir -p "${tmporary_directory}"
  cd "${temporary_directory}"
  local output_file=''
  func::tmpfile output_file
  ../imos-archive --output="${output_file}" "$@"
  "${output_file}"
}

test::imos-archive() {
  pushd "$(dirname "${BASH_SOURCE}")"
  EXPECT_EQ 'foo bar' "$(run --command='echo foo bar')"
  EXPECT_EQ 'foo bar' "$(run --command='echo foo bar' --file_size=1000000)"
  EXPECT_DEATH "$(run --command='echo foo bar' --file_size=1000)"
  EXPECT_EQ 'This is imos-archive.' "$(run --command='./imos-archive.sh')"
}
