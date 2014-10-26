run() {
  bash "$(dirname "${BASH_SOURCE}")"/imos-pokemon.sh \
      --nocache \
      --pokemon_error_level=FATAL \
      --alsologtostderr="${FLAGS_alsologtostderr}" \
      --logtostderr="${FLAGS_logtostderr}" \
      "$@"
}

test::imos-pokemon() {
  EXPECT_EQ 'Moltres' "$(UNAME=Darwin run)"
  EXPECT_EQ '146' "$(UNAME=Darwin run --id)"

  EXPECT_EQ 'Dunsparce' "$(UNAME=Linux run)"
  EXPECT_EQ '206' "$(UNAME=Linux run --id)"
}
