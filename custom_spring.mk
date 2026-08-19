#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common PixelOS stuff.
$(call inherit-product, vendor/custom/config/common_full_phone.mk)
TARGET_SCREEN_WIDTH := 1080

# Inherit from spring device
$(call inherit-product, device/xiaomi/spring/device.mk)

# Device identifiers
PRODUCT_DEVICE := spring
PRODUCT_NAME := custom_spring
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := 25057RN09G
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="spring_global-user 16 BP2A.250605.031.A3 16OS3.1.260731.200512599.QCPEGL.S release-keys" \
    BuildFingerprint=Xiaomi/spring_global/spring:16/BP2A.250605.031.A3/16OS3.1.260731.200512599.QCPEGL.S:user/release-keys \
    DeviceName=spring \
    DeviceProduct=spring_global

# GMS
PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
