run() {
  bash "$(dirname "${BASH_SOURCE}")"/imos-install.sh "$@"
}

test::imos-install::darwin() {
  export IMOS_ROOT="${TMPDIR}/root"
  mkdir -p "${IMOS_ROOT}"
  mkdir -p "${IMOS_ROOT}/Volumes/Arceus"
  mkdir -p "${IMOS_ROOT}/Users/Guest/Desktop/test"
  mkdir -p "${IMOS_ROOT}/Users/foo/Desktop/test"
  touch "${IMOS_ROOT}/Users/foo/Desktop/.localized"
  mkdir -p "${IMOS_ROOT}/Users/foo/Library/Caches/test"
  mkdir -p "${IMOS_ROOT}/Users/bar"
  mkdir -p "${IMOS_ROOT}/Library/Caches/test"
  mkdir -p "${IMOS_ROOT}/var/vm"
  mkdir -p "${IMOS_ROOT}/Library/LaunchDaemons"
  UNAME=Darwin run
  EXPECT_EQ "${IMOS_ROOT}/Volumes/Arceus" \
            "$(readlink "${IMOS_ROOT}/storage")"
  EXPECT_EQ "${IMOS_ROOT}/storage/Users/foo/Desktop" \
            "$(readlink "${IMOS_ROOT}/Users/foo/Desktop")"
  EXPECT_TRUE [ -d "${IMOS_ROOT}/Users/foo/Desktop/test" ]
  EXPECT_TRUE [ -f "${IMOS_ROOT}/Users/foo/Desktop/.localized" ]
  EXPECT_EQ "${IMOS_ROOT}/storage/Users/foo/Downloads" \
            "$(readlink "${IMOS_ROOT}/Users/foo/Downloads")"
  EXPECT_EQ "${IMOS_ROOT}/storage/cache/Users/foo/Library/Caches" \
            "$(readlink "${IMOS_ROOT}/Users/foo/Library/Caches")"
  EXPECT_EQ "${IMOS_ROOT}/storage/Users/foo/.bash_history" \
            "$(readlink "${IMOS_ROOT}/Users/foo/.bash_history")"
  EXPECT_EQ "${IMOS_ROOT}/storage/cache/Library/Caches" \
            "$(readlink "${IMOS_ROOT}/Library/Caches")"
  # EXPECT_EQ "${IMOS_ROOT}/storage/cache/var/vm" \
  #           "$(readlink "${IMOS_ROOT}/var/vm")"
  EXPECT_TRUE \
      [ -f "${IMOS_ROOT}/Library/LaunchDaemons/jp.imoz.imos-start.plist" ]
}
