#!/bin/bash

readme() {
echo '''
Utility scripts for Android System Development, e.g.
/ws/asd-codelabs/asd.sh setupVm
. /ws/asd-codelabs/asd.sh setEnv
asd.sh studio
asd.sh sync
asd.sh buildSdkPhone
asd.sh buildAPhone
asd.sh runAvd
asd.sh avdInfo
'''
}

setupVm() {
  SECONDS=0
  echo "Set up a new VM"
  echo "Check if kvm is enabled for the VM. If not, follow Enabling nested virtualization for VM instances"
  ls -l /dev/kvm
  echo "Add yourself to the kvm grols up"
  sudo adduser ${USER} kvm
  echo "Ensure the kvm group can access to kvm"
  sudo chmod 660 /dev/kvm
  grep kvm /etc/group

  echo "link ${HOME}/Android to /ws/Android to use preloaded SDK"
  ln -s /ws/Android ${HOME}/Android
  echo 'alias lunchSdkPhone=". build/envsetup.sh && lunch sdk_phone_x86_64-userdebug"' >> ~/.bashrc
  echo 'alias lunchAPhone=". build/envsetup.sh && lunch aphone-userdebug"' >> ~/.bashrc
  echo 'alias studio="/ws/android-studio/bin/studio.sh &"' >> ~/.bashrc
  echo 'export PATH=$PATH:/ws/bin:/ws/asd-codelabs' >> ~/.bashrc

  echo "Update to the latest asd-codelabs"
  cd /ws/asd-codelabs && git pull
  echo "setupVm took ${SECONDS} s."
}

setEnv() {
  echo "Set up development environment for each terminal."
  if [[ -z ${ANDROID_BUILD_TOP} ]]; then
    export ANDROID_BUILD_TOP="/ws/android"
  fi
  echo "ANDROID_BUILD_TOP=${ANDROID_BUILD_TOP}"

  if [[ -z ${ANDROID_SDK_ROOT} ]]; then
    export ANDROID_SDK_ROOT="${HOME}/Android/Sdk"
  fi
  echo "ANDROID_SDK_ROOT=${ANDROID_SDK_ROOT}"

  cd "${ANDROID_BUILD_TOP}"
}

sync() {
  SECONDS=0
  cd "${ANDROID_BUILD_TOP}"
  repo sync -j16
  echo "took ${SECONDS} sec. to sync."
}

build() {
  SECONDS=0
  m -j16
  echo "took ${SECONDS} sec. to build."
}

buildSdkPhone() {
  cd "${ANDROID_BUILD_TOP}"
  . build/envsetup.sh && lunch sdk_phone_x86_64-userdebug
  build
}

buildAPhone() {
  cd "${ANDROID_BUILD_TOP}"
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
