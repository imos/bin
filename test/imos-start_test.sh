run() {
  bash "$(dirname "${BASH_SOURCE}")"/imos-start.sh \
      --alsologtostderr="${FLAGS_alsologtostderr}" \
      --logtostderr="${FLAGS_logtostderr}" \
      "$@"
}

test::imos-start::darwin() {
  export IMOS_ROOT="${TMPDIR}/root"
  mkdir -p "${IMOS_ROOT}/Users/Guest/Pictures/test"
  mkdir -p "${IMOS_ROOT}/Users/foo/Pictures/test"
  UNAME=Darwin run
  EXPECT_TRUE [ ! -L "${IMOS_ROOT}/Users/Guest/Pictures" ]
  EXPECT_EQ "${IMOS_ROOT}/storage/home/foo/Pictures" \
            "$(readlink "${IMOS_ROOT}/Users/foo/Pictures")"
}
