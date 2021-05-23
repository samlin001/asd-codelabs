# Create Your Own AVD On The Cloud
In this code lab, you will learn how to create a new AVD target and change its
boot animation.

## Android Build Anatomy
![Android Build Layers](res/Android_Build_Layers.png)
1. [Understanding build layers](https://source.android.com/setup/develop/new-device#build-layers)
2. [Build parameters & fingerprint](https://source.android.com/compatibility/android-cdd#3_2_2_build_parameters)
3. [Pixel 5 build make files](https://cs.android.com/android/platform/superproject/+/master:device/google/redfin/)
4. [Nexus & Pixel factory images](https://developers.google.com/android/images#redfin)

## Create Your Own AVD
1. Create your company & device folders: ${ANDROID_BUILD_TOP}/asd/aphone
2. Create AndroidProduct.mk file for Android Build System to know your build target.
3. Create aphone.mk file to configure your build target.
4. Create aphone.sh development utility scripts to make your life a bit easier.
5. Build aphone product graph.

```
export ANDROID_BUILD_TOP="${HOME}/ws/android"
mkdir -p ${ANDROID_BUILD_TOP}/asd/aphone
cp -r ${HOME}/ws/asd-codelab/codelab3/res/asd ${ANDROID_BUILD_TOP}/asd
```

### Extra Credits
1. What are the [Android device storage partitions](https://source.android.com/devices/bootloader/partitions)?
2. What are the [Android images](https://source.android.com/devices/bootloader/images)?

## Change The Boot Animation
Most device makers will add their own boot animation for their brands. You can
make your own too as:

1. Understand how [Android bootanimation](https://android.googlesource.com/platform/frameworks/base/+/master/cmds/bootanimation/FORMAT.md)
is built.

2. Add aphone specific bootanimation.zip, e.g.
```
mkdir -p $ANDROID_BUILD_TOP/device/asd/aphone/bootanimations
echo copy a car boot animzation as an example
cp $ANDROID_BUILD_TOP/packages/services/Car/car_product/bootanimations/bootanimation-832.zip $ANDROID_BUILD_TOP/device/asd/aphone/bootanimations/bootanimation-832.zip
```

3. Add it to the makefile, $ANDROID_BUILD_TOP/device/asd/aphone/aphone.mk, e.g.
```
# Boot animation
PRODUCT_COPY_FILES += \
    device/asd/aphone/bootanimations/bootanimation-832.zip:system/media/bootanimation.zip
```

4. Build & Run as usual to check the result.

## Add A Preload App
1. Download an prebuilt APK from: https://github.com/android/compose-samples/releases/tag/v1.0.0-beta07
2.
https://github.com/android/compose-samples/releases

## References
1. You can build for Smarter Cars too: [Android Virtual Device as a Development Platform] (https://source.android.com/devices/automotive/start/avd?hl=en)
