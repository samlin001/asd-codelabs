# This is aphone AVD build configuration for ASD codelabs.
# Based on android/build/make/target/product/sdk_phone_x86_64.mk

#
# Image partition configurations
#
QEMU_USE_SYSTEM_EXT_PARTITIONS := true
PRODUCT_USE_DYNAMIC_PARTITIONS := true

#
# All components inherited here go to system image
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/mainline_system.mk)

# Enable mainline checking for excat this product name
ifeq (aphone,$(TARGET_PRODUCT))
PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := relaxed
endif

#
# All components inherited here go to system_ext image
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/handheld_system_ext.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/telephony_system_ext.mk)

#
# All components inherited here go to product image
#
$(call inherit-product, device/asd/aphone/aphone_product.mk)

#
# All components inherited here go to vendor image
#
$(call inherit-product-if-exists, device/generic/goldfish/x86_64-vendor.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulator_vendor.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/board/generic_x86_64/device.mk)

# Define the host tools and libs that are parts of the SDK.
-include sdk/build/product_sdk.mk
-include development/build/product_sdk.mk

# Overrides
PRODUCT_BRAND := ASD
PRODUCT_NAME := aphone
PRODUCT_DEVICE := generic_x86_64
PRODUCT_MODEL := ASD Phone1
PRODUCT_MANUFACTURER := asd

ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
# Disable AVB verification for userdebug and eng builds
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 2
endif
