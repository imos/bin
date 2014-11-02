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
  EXPECT_EQ '-f %g:%u' "${options}"

  options="$(run --format=%G:%U /file)"
  EXPECT_EQ '-f %Sg:%Su' "${options}"
}

test::imos-stat::linux() {
  export UNAME=Linux
  local options=''

  options="$(run --format=%g:%u /file)"
  EXPECT_EQ '--format %g:%u' "${options}"

  options="$(run --format=%G:%U /file)"
  EXPECT_EQ '--format %G:%U' "${options}"
}
