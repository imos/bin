run() {
  bash "$(dirname "${BASH_SOURCE}")"/imos-pokemon.sh \
      --nocache \
      --pokemon_error_level=FATAL \
      --alsologtostderr="${FLAGS_alsologtostderr}" \
      --logtostderr="${FLAGS_logtostderr}" \
      "$@"
}

test::imos-pokemon() {
  # Test only when Darwin-specific commands exist.
  if [ "${UNAME}" = 'Darwin' ]; then
    EXPECT_EQ 'Moltres' "$(UNAME=Darwin run)"
    EXPECT_EQ '146' "$(UNAME=Darwin run --id)"
  fi

  EXPECT_EQ 'Dunsparce' "$(UNAME=Linux run)"
  EXPECT_EQ '206' "$(UNAME=Linux run --id)"

  echo 'Pikachu' > "${TMPDIR}/POKEMON_NAME"
  EXPECT_EQ 'Pikachu' "$(
      UNAME=Darwin run --cache --cache_file="${TMPDIR}/POKEMON_NAME")"
}
