run() {
  bash "$(dirname "${BASH_SOURCE}")"/imos-start.sh "$@"
}

test::imos-start::darwin() {
  export IMOS_ROOT="${TMPDIR}/root"
  mkdir -p "${IMOS_ROOT}/Users/Guest/Pictures/test"
  mkdir -p "${IMOS_ROOT}/Users/foo/Pictures/test"
  mkdir -p "${IMOS_ROOT}/usr/imos/config"
  sub::print 'PASSW0RD' > "${IMOS_ROOT}/usr/imos/config/installed-password"
  UNAME=Darwin run
  EXPECT_TRUE [ ! -L "${IMOS_ROOT}/Users/Guest/Pictures" ]
  EXPECT_EQ "${IMOS_ROOT}/Volumes/Arceus/Users/foo/Pictures" \
            "$(readlink "${IMOS_ROOT}/Users/foo/Pictures")"
  EXPECT_EQ 'hoge' "$(cat "${IMOS_ROOT}/foo/bar")"
}
