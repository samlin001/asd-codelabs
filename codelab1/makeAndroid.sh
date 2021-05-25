build() {
  SECONDS=0
  m -j16
  echo "took ${SECONDS} s to build"
}

main() {
  build
}

if [[ -z $1 ]]; then
    main
else
    echo "Running: $@"
    $@
fi
