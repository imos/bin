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

test::rfc2date() {
  EXPECT_EQ '2014-01-08' "$(rfc2date 'Sun, 08 Jan 2014 10:11:12 GMT')"
}

test::mdate() {
  EXPECT_EQ '2014-07-25' "$(mdate foobar)"
  EXPECT_EQ '' "$(mdate foofoo)"
}
