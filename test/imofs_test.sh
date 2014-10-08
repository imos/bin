run() {
  bash "$(dirname "${BASH_SOURCE}")"/imofs.sh \
      --target_directory="${TARGET}" \
      --backup_directory="${BACKUP}" \
      --source_directory="${SOURCE}" \
      --alsologtostderr="${FLAGS_alsologtostderr}" \
      --logtostderr="${FLAGS_logtostderr}" \
      "$@"
}

test::imofs() {
  local TARGET="${TMPDIR}/imofs"
  local BACKUP="${TMPDIR}/imofs/backup"
  local SOURCE="${TMPDIR}/imofs/repository"

  mkdir -p "${TARGET}/etc"
  echo 'aaa' > "${TARGET}/etc/aaa"
  echo 'bbb' > "${TARGET}/etc/bbb"
  echo 'ccc' > "${TARGET}/etc/ccc"

  run backup

  EXPECT_EQ 'aaa' "$(cat "${BACKUP}/etc/aaa")"
  EXPECT_EQ 'bbb' "$(cat "${BACKUP}/etc/bbb")"
  EXPECT_EQ 'ccc' "$(cat "${BACKUP}/etc/ccc")"
  EXPECT_EQ 'mysqld' "$(cat "${BACKUP}/imofs/services")"

  echo 'BBBBB' > "${TARGET}/etc/bbb"
  rm "${TARGET}/etc/ccc"

  run restore

  EXPECT_EQ 'aaa' "$(cat "${TARGET}/etc/aaa")"
  EXPECT_EQ 'bbb' "$(cat "${TARGET}/etc/bbb")"
  EXPECT_EQ 'ccc' "$(cat "${TARGET}/etc/ccc")"

  echo 'BBBBB' > "${TARGET}/etc/bbb"
  rm "${TARGET}/etc/ccc"

  run backup

  EXPECT_EQ 'aaa' "$(cat "${BACKUP}/etc/aaa")"
  EXPECT_EQ 'BBBBB' "$(cat "${BACKUP}/etc/bbb")"
  EXPECT_FALSE [ -f "${BACKUP}/etc/ccc" ]
  EXPECT_EQ 'mysqld' "$(cat "${BACKUP}/imofs/services")"

  mkdir -p "${SOURCE}/etc"
  echo 'AAAAA' > "${SOURCE}/etc/aaa"
  { echo '#!/bin/bash'; echo 'touch etc/foo'; } > "${SOURCE}/deploy"

  run deploy

  EXPECT_EQ 'AAAAA' "$(cat "${TARGET}/etc/aaa")"
  EXPECT_EQ 'BBBBB' "$(cat "${TARGET}/etc/bbb")"
  EXPECT_FALSE [ -f "${TARGET}/etc/ccc" ]
  EXPECT_TRUE [ -f "${TARGET}/etc/foo" ]
}
