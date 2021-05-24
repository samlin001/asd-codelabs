# Build An Android Virtual Device On The Cloud
In this clode lab, you will learn how to build an Android Virtual Device(AVD),
sdk_phone_x86_64 on the cloud.

## Android Build Process In A Nutshell
![Android Build Process](res/Android%20Build%20Process.png)

## Android Source Code
Glancing through following pointers will give you a sense of Android codebase &
development universe.
- To navigate the codebase: [Android Code Search](https://cs.android.com/)
- The code & revision management: [Android Software Management](https://source.android.com/setup/start/codelines)
- The Android & Pixel SW releases: [Codenames, Tags, and Build Numbers](https://source.android.com/setup/start/build-numbers)
- [Source Control Workflow](https://source.android.com/setup/create/coding-tasks)


### Download Android Source Code
1. Pick an branch from [AOSP branch list](https://android.googlesource.com/platform/manifest/+refs).
2. Read [Downloading the Source](https://source.android.com/setup/build/downloading) to know more details.
3. For a quickstart to download android11-qpr2-release:

```
mkdir -p $HOME/ws/android
cd $HOME/ws/android
repo init -u https://android.googlesource.com/platform/manifest -b android11-qpr2-release
repo sync -j16
```

## Build sdk_phone_x86_64 AVD
1. Read [Building Android](https://source.android.com/setup/build/building) to know more details.

2. A quickstart to build sdk_phon_x86_64 AVD.
```
echo "Set android folder"
export ANDROID_BUILD_TOP="${HOME}/ws/android"
cd ${ANDROID_BUILD_TOP}

echo "Set up Android build environment"
source build/envsetup.sh

echo "Select a target"
lunch sdk_phone_x86_64-userdebug

echo "Build the target"
m -j16

echo "Run it"
emulator &
```

## Poke the AVD
- [Use command line](https://developer.android.com/studio/run/emulator-commandline)
- Control it with [the Extened Control](https://developer.android.com/studio/run/emulator#extended)
- [install an app](https://developer.android.com/studio/run/emulator-commandline#apps)


## References
### Use Android Studio & Android Emulator
1. Launch browser inside your computer instace and go to [android studio download page](https://developer.android.com/studio)
2. Download and install android studio
3. Follow instructions over at [create and manage virtal devices](https://developer.android.com/studio/run/managing-avds#createavd)
4. Launch Android Studio [Update your tools with the SDK Manager](https://developer.android.com/studio/intro/update#sdk-manager)


## Make it run
There are two ways of running the build, by [Emulating an Android device](https://source.android.com/setup/build/building#emulate-an-android-device)
