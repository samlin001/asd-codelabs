#!/bin/bash

readme() {
echo '''
Utility scripts for aphone development under android/, e.g.
$ device/asd/aphone.sh build
$ device/asd/aphone.sh info
'''
}

setup() {
  . build/envsetup.sh && lunch aphone-userdebug
}

build() {
  setup
  SECONDS=0
  m -j16
  echo "took ${SECONDS} s to build"
}

info() {
  echo "Check key device info"
  adb shell getprop | grep ro.build.fingerprint
  adb shell getprop | grep abi
  adb shell ls -l /product/media
  adb shell ls -l /product/app
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
