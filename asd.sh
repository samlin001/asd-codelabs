#!/bin/bash

readme() {
echo '''
Utility scripts for Android System Development, e.g.
./asd.sh setupVm
./asd.sh studio
./asd.sh buildSdkPhone
./asd.sh buildAPhone
./asd.sh runAvd
./asd.sh avdInfo
'''
}

setupVm() {
  echo "Check if kvm is enabled for the VM. If not, follow Enabling nested virtualization for VM instances"
  ls -l /dev/kvm
  echo "Add yourself to the kvm grols up"
  sudo adduser ${USER} kvm
  echo "Ensure the kvm group can access to kvm"
  sudo chmod 660 /dev/kvm
  grep kvm /etc/group
  echo "Make ${USER} as the owner for /ws"
  sudo chown -R ${USER}:${USER} /ws

  echo "link ${HOME}/Android to /ws/Android to use preloaded SDK"
  ln -s /ws/Android ${HOME}/Android
}

studio() {
  /ws/android-studio/bin/studio.sh &
}

build() {
  SECONDS=0
  m -j16
  echo "took ${SECONDS} sec. to build"
}

buildSdkPhone() {
  . build/envsetup.sh && lunch sdk_phone_x86_64-userdebug
  build
}

buildAPhone() {
  . build/envsetup.sh && lunch aphone-userdebug
  build
}

runAvd() {
  emulator -no-snapshot -memory 4096 -qemu -smp 6 &
}

avdInfo()
{
  echo "Check key device info"
  adb shell getprop | grep ro.build.fingerprint
  adb shell getprop | grep abi
  adb shell ls -l /product/media
  adb shell ls -l /product/app
  adb shell pm list features
  adb shell cat /proc/meminfo
  adb shell cat /proc/cpuinfo
}

if [[ -z $1 ]]; then
    readme
else
    echo "Running: $@"
    $@
fi
