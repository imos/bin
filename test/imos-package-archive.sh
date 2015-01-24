echo "# of args: $#"
if [ "$#" -ne 0 ]; then
  for argument in "$@"; do
    echo "${argument}"
  done
fi
