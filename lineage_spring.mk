#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from spring device
$(call inherit-product, device/xiaomi/spring/device.mk)

# Device identifiers
PRODUCT_DEVICE := spring
PRODUCT_NAME := lineage_spring
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := 25057RN09G
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="spring_global-user 15 AQ3A.250226.002/OS2.0.210.0.VOUMIXM release-keys" \
    BuildFingerprint=Redmi/spring_global/spring:15/AQ3A.250226.002/OS2.0.210.0.VOUMIXM:user/release-keys \
    DeviceName=spring_global \
    DeviceProduct=spring

# GMS
PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
