run() {
  bash "$(dirname "${BASH_SOURCE}")"/../imos-crypt \
      --password=PASSW0RD \
      --alsologtostderr="${FLAGS_alsologtostderr}" \
      --logtostderr="${FLAGS_logtostderr}" \
      "$@"
}

test::imos-crypt() {
  func::print 'foobar' > "${TMPDIR}/input"
  run --encrypt "${TMPDIR}/input" "${TMPDIR}/encrypted"
  EXPECT_NE 'foobar' \
            "$(cat "${TMPDIR}/encrypted")"
  run --decrypt "${TMPDIR}/encrypted" "${TMPDIR}/decrypted"
  EXPECT_EQ 'foobar' \
            "$(cat "${TMPDIR}/decrypted")"
}
