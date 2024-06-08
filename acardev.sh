#!/bin/bash
readme() {
echo '''
# 1. append these to ~/.bashrc
if [ -f ~/asd-codelabs/acardev/acardev.sh ]; then
    . ~/asd-codelabs/acardev/acardev.sh
fi

# 2. just run ~/asd-codelabs/acardev/acardev.sh [function]
e.g.
  acardev cdScar
'''
}

# AAOS DevFlow Setup
export ASDK_ROOT=${HOME}/Android/Sdk
export BUILDTOOL_DIRS=($(ls ${ASDK_ROOT}/build-tools))
export BUILDTOOL_DIR_NAME=${BUILDTOOL_DIRS}[-1]
export BUILDTOOL_DIR=${ASDK_ROOT}/build-tools/${BUILDTOOL_DIR_NAME}

#add SDK & Tool path
PATH=$PATH:${ASDK_ROOT}/platform-tools:${ASDK_ROOT}/build-tools:${BUILDTOOL_DIR}:${ASDK_ROOT}/emulator

setupGit() {
  git config --global user.name yourName
  git config --global user.email yourMailAddress@gmail.com
}

setupKvm() {
  sudo usermod -aG kvm ${USER}
  sudo usermod -aG cvdnetwork ${USER}
  sudo usermod -aG render ${USER}
  # this will reset & run .bashrc again
  exec sudo su - ${USER}
}

setup4Dev() {
  sed '0,/.*nameserver.*/s/.*nameserver*/nameserver 8.8.8.8\n&/' /etc/resolv.conf | sudo tee /etc/resolv.conf
  sudo apt install rsync
}

echo '$ cdScar cdTcar or cdUcar to a car repo'
cdUcar() {
  cdCar ucar
}

cdTcar() {
  cdCar tcar
}

cdScar() {
  cdCar scar
}

cdCar() {
  if [ -d ${HOME}/ws/$1 ]; then
    mkdir -p ${HOME}/ws/$1
    echo 'remember to get the code, e.g. $ checkoutScar and $ sync'
  fi
  cd ${HOME}/ws/$1
}

echo '$ lunchCf to set the target to cuttlefish AVD'
lunchCf() {
  time . build/envsetup.sh
  time lunch aosp_cf_x86_64_auto-userdebug
}

echo '$ lunchEmu to set the target to Android Emulator AVD'
lunchEmu() {
  time . build/envsetup.sh
  time lunch sdk_car_x86_64-userdebug
}

echo '$ mCar to build the target'
mCar() {
  time m -j60 2>&1 > "build-$(date +"%Y%m%d-%I%M%S").log"
  df -h
}

echo '$ checkoutScar checkoutTcar checkoutUcar to checkout a car codebase'
checkoutUcar() {
  echo 'Need to setup an account with access to the partner repo'
  time repo init --partial-clone --partial-clone-exclude=platform/frameworks/base --clone-filter=blob:limit=10M -u https://partner-android.googlesource.com/platform/vendor/pdk/generic/fs/manifest -b u-car-fs-release
}
checkoutTcar() {
  time repo init --partial-clone -u https://android.googlesource.com/platform/manifest -b android13-qpr1-release
}
checkoutScar() {
  time repo init --partial-clone -u https://android.googlesource.com/platform/manifest -b android12L-release
}

echo '$ sync to download the code'
sync() {
  df -h
  time repo sync -c -j 60
  df -h
}

echo '$ getChrome & $ installChrome if needed'

getChrome() {
  cd ~/Downloads
  sudo apt-get install libxss1 libappindicator1 libindicator7
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
}

installChrome() {
  sudo apt install ~/Downloads/google-chrome*.deb
}

echo '$ installAsfp & $ setupAsfp if needed'
installAsfp() {
  if test -f ${HOME}/Downloads/asfp.deb; then
    sudo apt install ${HOME}/Downloads/asfp.deb
  else
    echo 'Download ${HOME}/Downloads/asfp.deb first'
    open https://developer.android.com/studio/platform
  fi
}

setupAsfp() {
echo 'before:'
cat /home/user/.config/Google/AndroidStudioForPlatformCanaryPreview2024.1/studio64.vmoptions
echo
echo '''# custom Android Studio VM options, see https://developer.android.com/studio/intro/studio-config.html
-Xmx25000m
-Didea.max.intellisense.filesize=10000
''' > /home/user/.config/Google/AndroidStudioForPlatformCanaryPreview2024.1/studio64.vmoptions
echo 'after:'
cat /home/user/.config/Google/AndroidStudioForPlatformCanaryPreview2024.1/studio64.vmoptions
}

checkDevEnv() {
  echo 'checkDevEvn'
  echo 'how many cpu cores for emulator'
  egrep -c '(vmx|svm)' /proc/cpuinfo
  echo
  groups
  echo '$ setupKvm, if no kvm in the groups'
  echo
  ping -c 1 www.google.com
  echo '$ setup4Dev to connect to Internet, etc.'
  echo
  echo '$ cdScar to get started'
}

checkDevEnv

if [[ -z $1 ]]; then
  readme
else
  echo "Running: $@"
  $@
fi
