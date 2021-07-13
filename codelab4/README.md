# Build and debug CTS
## Build CTS
The following line locates and builds CTS
```
cd /ws/android && . build/envsetup.sh && lunch sdk_phone_x86_64-userdebug && make cts -j8
```
Run CTS SignatureTest#testSignature
```
cts-tradefed run cts -m CtsCurrentApiSignatureTestCases -t android.signature.cts.api.SignatureTest#testSignature
```
## Debug a CTS test case
1. Set breakpoints
2. Run command
3. Step through and debug
## Special case sutdy: CtsDeviceInfo.apk
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
