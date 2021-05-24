build() {
  setup
  SECONDS=0
  m -j16
  echo "took ${SECONDS} s to build"
}

setup(){
  . build/envsetup.sh
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