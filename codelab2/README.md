# Build An Android Virtual Device On The Cloud
In this clode lab, you will learn how to get the Android source code, build it, and run the built product on GCP. 

However, downloading and building android will take around 4~6 hours total, due to the time limit, the following part up untill [Make it run](https://github.com/Alwin-Lin/gcpSetup/blob/master/README.md#make-it-run)
is only for demonstration.

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

## Build a phone
   
## Building an android virtual device
1. Launch browser inside your computer instace and go to [android studio download page](https://developer.android.com/studio)
2. Download and install android studio
3. Follow instructions over at [create and manage virtal devices](https://developer.android.com/studio/run/managing-avds#createavd)


## Make it run
There are two ways of running the build, by [Emulating an Android device](https://source.android.com/setup/build/building#emulate-an-android-device) or [Flashing a device](https://source.android.com/setup/build/running#flashing-a-device)

Here we will run with the emulator
```
emulator
```