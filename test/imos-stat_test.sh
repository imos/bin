run() {
  bash "$(dirname "${BASH_SOURCE}")"/imos-stat.sh \
      --use_native_uname=false \
      --alsologtostderr="${FLAGS_alsologtostderr}" \
      --logtostderr="${FLAGS_logtostderr}" \
      "$@"
}

test::imos-stat::darwin() {
  export UNAME=Darwin
  local options=''

  options="$(run --format=%g:%u /file)"
  EXPECT_EQ '-f %g:%u /file' "${options}"

  options="$(run --format=%G:%U /file)"
  EXPECT_EQ '-f %Sg:%Su /file' "${options}"
}

test::imos-stat::linux() {
  export UNAME=Linux
  local options=''

  options="$(run --format=%g:%u /file)"
  EXPECT_EQ '--format %g:%u /file' "${options}"

  options="$(run --format=%G:%U /file)"
  EXPECT_EQ '--format %G:%U /file' "${options}"
}

test::imos-stat() {
  EXPECT_EQ '2312' "$(
      "$(dirname "${BASH_SOURCE}")/../imos-stat" \
          --format=%s "$(dirname "${BASH_SOURCE}")/../imos-stat")"
}
