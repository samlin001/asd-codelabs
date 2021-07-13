# Build and Debug Android CTS
You will learn how to build & debug CTS in this code lab. Android Open-Source Project (AOSP) uses Compatibility Test Suite(CTS) to validate if a device can run Android apps properly. Because anyone can enhance & extend Android sources to build better devices for their target users, CTS is the tool to ensure the changes do not add technical debt to the Android app ecosystem.

## 1. Build & Run
- Build CTS under the Android source directory, e.g.:
```
cd /ws/android && . build/envsetup.sh && lunch sdk_phone_x86_64-userdebug && make cts -j16
```
- Run a CTS module: SignatureTest#testSignature
```
cts-tradefed run cts -m CtsCurrentApiSignatureTestCases -t android.signature.cts.api.SignatureTest#testSignature
```

## 2. Debug a CTS test case with Android Studio
Debugging Android can be difficult & time-consuming. For example, a typically debug cycle is hypothesizing, adding logs, building, testing & repeat. Android Studio provides a better GUI & tools to make it easier for app developers. Here is an example using Android Studio to debug a CTS test case.

1. Set breakpoints
2. Run command
3. Step through and debug


## 3. Detailed case study: CtsDeviceInfo.apk
CtsDeviceInfo.apk is not a test
1. Make apk debugable
   - If
2. build CTS
3. Open APK with Android studio
4. Install APK
 ```
 adb install -g /ws/android/out/host/linux-x86/cts/android-cts/testcases/CtsDeviceInfo.apk
 ```
5. Start app and wait for debugger

## 4. Extra Credits
```
adb shell am instrument -e debug true  -w -r --no-isolated-storage   -e newRunListenerMode true -e timeout_msec 300000 com.android.compatibility.common.deviceinfo/androidx.test.runner.AndroidJUnitRunner
```
6. Setup breakpoints in Android Studio
  - In Android studio, click on the line of code that you want the application to stop at
7. Attach debugger to Android Process
  - Top right bug icon, click and select the running app
8. Start debug
  - Execute the app, and wait for the break
9. Check call stack and step through
