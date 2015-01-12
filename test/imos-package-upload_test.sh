source "$(dirname "${BASH_SOURCE}")"/../imos-package-upload || exit 1

curl() {
  LOG INFO "Args: $*"
  local ARGS_silent=0 ARGS_fail=0 ARGS_head=0
  eval "${IMOSH_PARSE_ARGUMENTS}"

  if [ "$#" -eq 1 ]; then
    ASSERT_EQ 1 "${ARGS_fail}"
    ASSERT_EQ 1 "${ARGS_head}"
    if [ "${1}" = "http://${FLAGS_bucket}/foobar" ]; then
      cat << 'EOM'
HTTP/1.1 200 OK
Date: Wed, 07 Jan 2015 16:25:55 GMT
Last-Modified: Fri, 25 Jul 2014 04:32:39 GMT
ETag: "foobar"
Content-Type: application/octet-stream
Content-Length: 897
Server: AmazonS3

EOM
    else
      return 22
    fi
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

imos-aws-credentials() {
  LOG INFO 'Mocking: imos-aws-credentials'
}

imos-aws() {
  sub::println "$@" >>"${TMPDIR}/imos-aws"
}

# override
create_working_directory() {
  LOG INFO "Mocking: create_working_directory $*"
  if [ "$#" -eq 1 ]; then
    func::let "${1}" "${WORKING_DIRECTORY}"
    if [ -d "${WORKING_DIRECTORY}" ]; then
      rm -R "${WORKING_DIRECTORY}"
    fi
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

run() {
  true >"${TMPDIR}/imos-aws"
  main "$@"
  cat "${TMPDIR}/imos-aws" | \
      stream::str_replace "${WORKING_DIRECTORY}" 'WORKING_DIRECTORY'
}

test::imos-package-upload::rfc2date() {
  EXPECT_EQ '2014-01-08' "$(rfc2date 'Sun, 08 Jan 2014 10:11:12 GMT')"
}

test::imos-package-upload::mdate() {
  EXPECT_EQ '2014-07-25' "$(mdate foobar)"
  EXPECT_EQ '' "$(mdate foofoo)"
}

test::imos-package-upload() {
  local target="${TMPDIR}/target"
  local WORKING_DIRECTORY="${TMPDIR}/WORKING_DIRECTORY"
  touch "${target}"
  EXPECT_EQ "$(
      echo s3api put-object \
          --bucket package.imoz.jp \
          --key ephemeral/d41d8cd98f00b204e9800998ecf8427e \
          --content-md5 1B2M2Y8AsgTpgAmY7PhCfg== \
          --body WORKING_DIRECTORY/d41d8cd98f00b204e9800998ecf8427e
      echo s3api put-object \
          --bucket package.imoz.jp \
          --key ephemeral/227bc609651f929e367c3b2b79e09d5b \
          --content-md5 InvGCWUfkp42fDsreeCdWw== \
          --body WORKING_DIRECTORY/227bc609651f929e367c3b2b79e09d5b)" \
    "$(run "${target}")"
  seq 100 >"${target}"
  EXPECT_EQ "$(
      echo s3api put-object \
          --bucket package.imoz.jp \
          --key ephemeral/d632eba71107bf7bc3ec423eab256d78 \
          --content-md5 1jLrpxEHv3vD7EI+qyVteA== \
          --body WORKING_DIRECTORY/d632eba71107bf7bc3ec423eab256d78
      echo s3api put-object \
          --bucket package.imoz.jp \
          --key ephemeral/6fe45f263f52b46265af688d4e26a3d6 \
          --content-md5 b+RfJj9StGJlr2iNTiaj1g== \
          --body WORKING_DIRECTORY/6fe45f263f52b46265af688d4e26a3d6)" \
    "$(run "${target}")"
  EXPECT_EQ 'd632eba71107bf7bc3ec423eab256d78' \
      "$(cat "${WORKING_DIRECTORY}/d632eba71107bf7bc3ec423eab256d78" | \
         stream::md5)"
  EXPECT_EQ '6fe45f263f52b46265af688d4e26a3d6' \
      "$(cat "${WORKING_DIRECTORY}/6fe45f263f52b46265af688d4e26a3d6" | \
         stream::md5)"
  EXPECT_EQ 'd632eba71107bf7bc3ec423eab256d78' \
      "$(cat "${WORKING_DIRECTORY}/6fe45f263f52b46265af688d4e26a3d6")"
  FLAGS_fragment_size=100
  EXPECT_EQ "$(
      echo s3api put-object \
          --bucket package.imoz.jp \
          --key ephemeral/c4095b9c7c0a5d8dc6472ecb3fb7395e \
          --content-md5 xAlbnHwKXY3GRy7LP7c5Xg== \
          --body WORKING_DIRECTORY/c4095b9c7c0a5d8dc6472ecb3fb7395e
      echo s3api put-object \
          --bucket package.imoz.jp \
          --key ephemeral/b8465f50d9579a17a918285548090783 \
          --content-md5 uEZfUNlXmhepGChVSAkHgw== \
          --body WORKING_DIRECTORY/b8465f50d9579a17a918285548090783
      echo s3api put-object \
          --bucket package.imoz.jp \
          --key ephemeral/bcab5aa38bd1777c2cdbc1b79cee353f \
          --content-md5 vKtao4vRd3ws28G3nO41Pw== \
          --body WORKING_DIRECTORY/bcab5aa38bd1777c2cdbc1b79cee353f
      echo s3api put-object \
          --bucket package.imoz.jp \
          --key ephemeral/0982e972bf2e287852c958582b0e4364 \
          --content-md5 CYLpcr8uKHhSyVhYKw5DZA== \
          --body WORKING_DIRECTORY/0982e972bf2e287852c958582b0e4364)" \
    "$(run "${target}")"
  EXPECT_EQ 'd632eba71107bf7bc3ec423eab256d78' \
      "$({
              cat "${WORKING_DIRECTORY}/c4095b9c7c0a5d8dc6472ecb3fb7395e"
              cat "${WORKING_DIRECTORY}/b8465f50d9579a17a918285548090783"
              cat "${WORKING_DIRECTORY}/bcab5aa38bd1777c2cdbc1b79cee353f"
         } | \
         stream::md5)"
  EXPECT_EQ "$(
      echo c4095b9c7c0a5d8dc6472ecb3fb7395e
      echo b8465f50d9579a17a918285548090783
      echo bcab5aa38bd1777c2cdbc1b79cee353f)" \
      "$(cat "${WORKING_DIRECTORY}/0982e972bf2e287852c958582b0e4364")"
}
