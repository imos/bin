IMOSH_TESTING=1
source "$(dirname "${BASH_SOURCE}")"/../imos-package || exit 1

curl() {
  LOG INFO "Args: $*"
  local ARGS_silent=0 ARGS_fail=0 ARGS_output=0
  eval "${IMOSH_PARSE_ARGUMENTS}"

  if [ "$#" -eq 2 ]; then
    ASSERT_EQ 1 "${ARGS_fail}"
    ASSERT_EQ 1 "${ARGS_output}"
    case "${2}" in
      'https://s3-ap-northeast-1.amazonaws.com/imos-package/ephemeral/b026324c6904b2a9cb4b88d6d61c81d1')
        sub::println '1' >"${1}";;
      'https://s3-ap-northeast-1.amazonaws.com/imos-package/ephemeral/26ab0db90d72e28ad0ba1e22ee510510')
        sub::println '2' >"${1}";;
      'https://s3-ap-northeast-1.amazonaws.com/imos-package/ephemeral/6d7fce9fee471194aa8b5b6e47267f03')
        sub::println '3' >"${1}";;
      'https://s3-ap-northeast-1.amazonaws.com/imos-package/ephemeral/9518ab157cbf0ecdee5048934bfb878a')
        {
          sub::println 'b026324c6904b2a9cb4b88d6d61c81d1'
          sub::println '26ab0db90d72e28ad0ba1e22ee510510'
          sub::println '6d7fce9fee471194aa8b5b6e47267f03'
        } >"${1}";;
      *)
        return 22;;
    esac
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

run() {
  imos-package::download "$@"
}

test::imos-package::download() {
  FLAGS_fragments_directory="${TMPDIR}/fragments"
  FLAGS_output="${TMPDIR}/output"

  run '9518ab157cbf0ecdee5048934bfb878a'
  EXPECT_EQ "$(sub::println '1'; sub::println '2'; sub::println '3')" \
            "$(cat "${FLAGS_output}")"
}
