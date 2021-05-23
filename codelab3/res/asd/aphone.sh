#!/bin/bash

readme() {
echo '''
Utility scripts for aphone development under android/, e.g.
$ device/asd/aphone.sh build
'''
}

setup() {
  . build/envsetup.sh && lunch aphone-userdebug
}

build() {
  setup
  SECONDS=0
  m -j8
  echo "took ${SECONDS} s to build"
}

main() {
  readme
}

if [[ -z $1 ]]; then
    main
else
    echo "Running: $@"
    $@
fi
