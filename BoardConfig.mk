# Copyright (C) 2014 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# inherit from common msm8974
-include device/samsung/msm8974-common/BoardConfigCommon.mk

LOCAL_PATH := device/samsung/ks01lte

TARGET_SPECIFIC_HEADER_PATH := $(LOCAL_PATH)/include

TARGET_OTA_ASSERT_DEVICE := ks01lte,ks01ltexx,GT-I9506

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := MSM8974

# Build with Clang by default
USE_CLANG_PLATFORM_BUILD := true

# Kernel
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_CMDLINE := console=null androidboot.hardware=qcom androidboot.selinux=permissive user_debug=31 msm_rtb.filter=0x3F androidboot.bootdevice=msm_sdcc.1
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_SEPARATED_DT := true
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x02000000 --tags_offset 0x01e00000
TARGET_KERNEL_CONFIG := cm_msm8974_sec_defconfig
TARGET_KERNEL_VARIANT_CONFIG := cm_msm8974_sec_ks01eur_defconfig
TARGET_KERNEL_SELINUX_CONFIG := cm_selinux_defconfig
TARGET_KERNEL_SOURCE := kernel/samsung/ks01lte


# Audio
BOARD_HAVE_NEW_QCOM_CSDCLIENT := true
USE_CUSTOM_AUDIO_POLICY := 1

# Bluetooth
BOARD_BLUEDROID_VENDOR_CONF := $(LOCAL_PATH)/bluetooth/vnd_ks01lte.txt
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(LOCAL_PATH)/bluetooth
BOARD_BLUETOOTH_USES_HCIATTACH_PROPERTY := false
BOARD_HAVE_BLUETOOTH_BCM := true

# ANT+
BOARD_ANT_WIRELESS_DEVICE := "vfs-prerelease"

# Camera
TARGET_USE_COMPAT_GRALLOC_ALIGN := true
TARGET_PROVIDES_CAMERA_HAL := true
COMMON_GLOBAL_CFLAGS += -DCAMERA_VENDOR_L_COMPAT

# CMHW
BOARD_HARDWARE_CLASS += device/samsung/ks01lte/cmhw
BOARD_HARDWARE_CLASS += hardware/samsung/cmhw

# RIL
BOARD_RIL_CLASS := ../../../device/samsung/ks01lte/ril

# Graphics
TARGET_HAVE_NEW_GRALLOC := true

# Lights
TARGET_PROVIDES_LIBLIGHT := true

# NFC
BOARD_NFC_HAL_SUFFIX := msm8974

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE := 20971520
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 20971520
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2390753280
BOARD_USERDATAIMAGE_PARTITION_SIZE := 12528352256 # 12528368640 - 16384

# Power HAL
TARGET_POWERHAL_VARIANT := qcom
TARGET_POWERHAL_SET_INTERACTIVE_EXT := $(LOCAL_PATH)/power/power_ext.c

#TARGET_RECOVERY := twrp
# Recovery
ifneq ($(TARGET_RECOVERY),twrp)
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/rootdir/etc/fstab.qcom
endif
BOARD_USE_CUSTOM_RECOVERY_FONT := \"roboto_23x41.h\"
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_HAS_NO_MISC_PARTITION := true
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_RECOVERY_SWIPE := true
BOARD_USES_MMCUTILS := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
# TWRP Recovery
ifeq ($(TARGET_RECOVERY),twrp)
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.secure=0 \
    ro.adb.secure=0 \
    ro.allow.mock.location=1 \
    ro.debuggable=1 \
    persist.sys.usb.config=adb
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/rootdir/etc/fstab.twrp
DEVICE_RESOLUTION := 1080x1920
BOARD_HAS_NO_REAL_SDCARD := true
RECOVERY_SDCARD_ON_DATA := true
RECOVERY_GRAPHICS_USE_LINELENGTH := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_THEME := portrait_hdpi
TW_BRIGHTNESS_PATH := "/sys/devices/mdp.0/qcom\x2cmdss_fb_primary.182/leds/lcd-backlight/brightness"
TW_MAX_BRIGHTNESS := 255
TW_NO_REBOOT_BOOTLOADER := true
TW_HAS_DOWNLOAD_MODE := true
TW_NO_EXFAT_FUSE := false
TW_NO_EXFAT := false
TW_INCLUDE_FB2PNG := true
TW_TARGET_USES_QCOM_BSP := true
TW_INTERNAL_STORAGE_PATH := "/data/media/0"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"
TW_INCLUDE_CRYPTO := true
#TW_INCLUDE_CRYPTO_SAMSUNG := true
#TW_CRYPTO_FS_TYPE := "ext4"
#TW_CRYPTO_REAL_BLKDEV := "/dev/block/mmcblk0p25"
#TW_CRYPTO_MNT_POINT := "/data"
#TW_CRYPTO_FS_OPTIONS := "nosuid,nodev,noatime,noauto_da_alloc,discard,journal_async_commit,errors=panic"
#TW_CRYPTO_FS_FLAGS := "0x00000406"
#TW_CRYPTO_KEY_LOC := "footer"
endif

# SELinux
-include device/qcom/sepolicy/sepolicy.mk
BOARD_SEPOLICY_DIRS += device/samsung/ks01lte/sepolicy

# Wifi
BOARD_HAVE_SAMSUNG_WIFI := true
BOARD_WLAN_DEVICE := bcmdhd
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WPA_SUPPLICANT_VERSION := VER_0_8_X
WIFI_BAND := 802_11_ABG
WIFI_DRIVER_MODULE_ARG      := "firmware_path=/system/etc/wifi/bcmdhd_sta.bin nvram_path=/system/etc/wifi/nvram_net.txt"
WIFI_DRIVER_MODULE_AP_ARG   := "firmware_path=/system/etc/wifi/bcmdhd_apsta.bin nvram_path=/system/etc/wifi/nvram_net.txt"
WIFI_DRIVER_FW_PATH_PARAM   := "/sys/module/dhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA     := "/system/etc/wifi/bcmdhd_sta.bin"
WIFI_DRIVER_FW_PATH_AP      := "/system/etc/wifi/bcmdhd_apsta.bin"

# inherit from the proprietary version
-include vendor/samsung/ks01lte/BoardConfigVendor.mk
