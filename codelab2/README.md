# Build An Android Virtual Device On The Cloud
In this clode lab, you will learn where to get the Android source code, how to build and run the built product on GCP. 

Downloading and building android will take around 4~6 hours

## Android CS

 - Downliad source with repo
 ```
 mkdir -p $HOME/ws/android
 cd $HOME/ws/android
 repo init -u https://android.googlesource.com/platform/manifest
 repo sync
 ```
## Build Process
1. Run setup script
  ```
  source build/envsetup.sh
  ```
2. Selecting a target   
  ```
  lunch 16
  ```
3. Build the target
   ```
   m -j
   ```

## Build a phone with Android Studio
1. Launch browser inside your computer instace and go to [android studio download page](https://developer.android.com/studio)
2. Download and install android studio
3. Follow instructions over at [create and manage virtal devices](https://developer.android.com/studio/run/managing-avds#createavd)
4. Launch Android Studio [Update your tools with the SDK Manager](https://developer.android.com/studio/intro/update#sdk-manager)


## Make it run
There are two ways of running the build, by [Emulating an Android device](https://source.android.com/setup/build/building#emulate-an-android-device) or [Flashing a device](https://source.android.com/setup/build/running#flashing-a-device)

Here we will run with the emulator
```
emulator
```
