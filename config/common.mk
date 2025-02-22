PRODUCT_BRAND ?= GuunOS

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0
endif

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/guun/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/guun/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/guun/prebuilt/common/bin/50-cm.sh:system/addon.d/50-cm.sh \
    vendor/guun/prebuilt/common/bin/blacklist:system/addon.d/blacklist

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/guun/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/guun/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# init.d support
PRODUCT_COPY_FILES += \
    vendor/guun/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/guun/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/guun/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# CM-specific init file
PRODUCT_COPY_FILES += \
    vendor/guun/prebuilt/common/etc/init.local.rc:root/init.cm.rc

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/guun/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is Guun!
PRODUCT_COPY_FILES += \
    vendor/guun/config/permissions/com.cyanogenmod.android.xml:system/etc/permissions/com.cyanogenmod.android.xml

# Include Guun audio files
include vendor/guun/config/cm_audio.mk

ifneq ($(TARGET_DISABLE_CMSDK), true)
# CMSDK
include vendor/guun/config/cmsdk_common.mk
endif

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/guun/config/twrp.mk
endif

TARGET_BOOTANIMATION_480P := $(shell \
   if [ $(TARGET_SCREEN_WIDTH) -le 720 ]; then \
     echo 'true'; \
   else \
     echo ''; \
   fi )

 # Bootanimation
 ifeq ($(TARGET_BOOTANIMATION_480P),true)
 PRODUCT_COPY_FILES += \
     vendor/guun/bootanimation/bootanimation-480p.zip:system/media/bootanimation.zip
 else
 PRODUCT_COPY_FILES += \
     vendor/guun/bootanimation/bootanimation.zip:system/media/bootanimation.zip
 endif

# Required CM packages

PRODUCT_COPY_FILES += \
        vendor/guun/prebuilt/common/fonts/NotoColorEmoji.ttf:system/fonts/NotoColorEmoji.ttf \
		vendor/guun/prebuilt/common/fonts/DroidSansFallback.ttf:system/fonts/DroidSansFallback.ttf \
		vendor/guun/prebuilt/common/fonts/Roboto-Black.ttf:system/fonts/Roboto-Black.ttf \
		vendor/guun/prebuilt/common/fonts/Roboto-BlackItalic.ttf:system/fonts/Roboto-BlackItalic.ttf \
		vendor/guun/prebuilt/common/fonts/Roboto-Bold.ttf:system/fonts/Roboto-Bold.ttf \
		vendor/guun/prebuilt/common/fonts/Roboto-BoldItalic.ttf:system/fonts/Roboto-BoldItalic.ttf \
		vendor/guun/prebuilt/common/fonts/RobotoCondensed-Bold.ttf:system/fonts/RobotoCondensed-Bold.ttf \
		vendor/guun/prebuilt/common/fonts/RobotoCondensed-BoldItalic.ttf:system/fonts/RobotoCondensed-BoldItalic.ttf \
		vendor/guun/prebuilt/common/fonts/RobotoCondensed-Italic.ttf:system/fonts/RobotoCondensed-Italic.ttf \
		vendor/guun/prebuilt/common/fonts/RobotoCondensed-Light.ttf:system/fonts/RobotoCondensed-Light.ttf \
		vendor/guun/prebuilt/common/fonts/RobotoCondensed-LightItalic.ttf:system/fonts/RobotoCondensed-LightItalic.ttf \
		vendor/guun/prebuilt/common/fonts/RobotoCondensed-Regular.ttf:system/fonts/RobotoCondensed-Regular.ttf \
		vendor/guun/prebuilt/common/fonts/Roboto-Italic.ttf:system/fonts/Roboto-Italic.ttf \
		vendor/guun/prebuilt/common/fonts/Roboto-Light.ttf:system/fonts/Roboto-Light.ttf \
		vendor/guun/prebuilt/common/fonts/Roboto-LightItalic.ttf:system/fonts/Roboto-LightItalic.ttf \
		vendor/guun/prebuilt/common/fonts/Roboto-Medium.ttf:system/fonts/Roboto-Medium.ttf \
		vendor/guun/prebuilt/common/fonts/Roboto-MediumItalic.ttf:system/fonts/Roboto-MediumItalic.ttf \
		vendor/guun/prebuilt/common/fonts/Roboto-Regular.ttf:system/fonts/Roboto-Regular.ttf \
		vendor/guun/prebuilt/common/fonts/Roboto-Thin.ttf:system/fonts/Roboto-Thin.ttf \
		vendor/guun/prebuilt/common/fonts/Roboto-ThinItalic.ttf:system/fonts/Roboto-ThinItalic.ttf
PRODUCT_PACKAGES += \
    BluetoothExt \
    CMAudioService \
    CMParts \
    Development \
    Profiles \
    WeatherManagerService

# Optional CM packages
PRODUCT_PACKAGES += \
    libemoji \
    LiveWallpapersPicker \
    PhotoTable \
    Terminal

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Custom Guun packages
PRODUCT_PACKAGES += \
    AudioFX \
    CMSettingsProvider \
    ExactCalculator \
    Jelly \
    LockClock \
    ThemeInterfacer \
    GoogleContacts \
    Mixplorer \
    Evie \
    Phonograph \
    Vanced \
    Dialer \
    Recorder \
    WallpaperPicker \
    WeatherProvider

# Dialer Jar
PRODUCT_PACKAGES += \
		com.google.android.dialer.support \

# Dialer Permissions
PRODUCT_COPY_FILES += \
		vendor/guun/prebuilt/etc/permissions/com.google.android.dialer.support.xml:system/etc/permissions/com.google.android.dialer.support.xml \
		vendor/guun/prebuilt/etc/sysconfig/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# Required keyboard packages
PRODUCT_PACKAGES += \
    LatinIME

#Dex2oat
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.boot-dex2oat-threads=8 \
    dalvik.vm.dex2oat-threads=6 \
    dalvik.vm.image-dex2oat-threads=8

# Exchange support
PRODUCT_PACKAGES += \
    Exchange2

# Extra tools in CM
PRODUCT_PACKAGES += \
    7z \
    bash \
    bzip2 \
    curl \
    fsck.ntfs \
    gdbserver \
    htop \
    lib7z \
    libsepol \
    micro_bench \
    mke2fs \
    mkfs.ntfs \
    mount.ntfs \
    oprofiled \
    pigz \
    powertop \
    sqlite3 \
    strace \
    tune2fs \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Custom off-mode charger
ifneq ($(WITH_CM_CHARGER),false)
PRODUCT_PACKAGES += \
    charger_res_images \
    cm_charger_res_images \
    font_log.png \
    libhealthd.cm
endif

# ExFAT support
WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Storage manager
PRODUCT_PROPERTY_OVERRIDES += \
    ro.storage_manager.enabled=true

# Telephony
PRODUCT_PACKAGES += \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    procmem \
    procrank

# Conditionally build in su
ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su
endif
endif

DEVICE_PACKAGE_OVERLAYS += vendor/guun/overlay/common

PRODUCT_VERSION_MAJOR = 1
PRODUCT_VERSION_MINOR = 69
ifndef GUUN_BUILDTYPE
    GUUN_BUILDTYPE := UNOFFICIAL
endif

ifeq ($(GUUN_OFFICIAL), true)
   CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)
   LIST = $(shell curl -s https://raw.githubusercontent.com/guunos/vendor_guun/guunaugat/guun.official)
   FOUND_DEVICE =  $(filter $(CURRENT_DEVICE), $(LIST))
    ifeq ($(FOUND_DEVICE),$(CURRENT_DEVICE))
      IS_OFFICIAL=true
      GUUN_BUILDTYPE := OFFICIAL

      PRODUCT_PACKAGES += \
      #PsychoOTA

    endif

    ifneq ($(IS_OFFICIAL), true)
       GUUN_BUILDTYPE := UNOFFICIAL
       $(error Device is not official "$(FOUND)")
    endif

    PRODUCT_PROPERTY_OVERRIDES += \
        persist.ota.romname=$(TARGET_PRODUCT) \
        persist.ota.version=$(shell date +%Y%m%d) \
        persist.ota.manifest=https://raw.githubusercontent.com/PsychoOS/OTA/Psycho-N/$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3).xml
endif

GUUN_POSTFIX := $(shell date +"%Y%m%d-%H%M")

GUUN_VERSION := GuunOS-v$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(GUUN_POSTFIX)-$(GUUN_BUILD)GUUNICIAL

PRODUCT_PROPERTY_OVERRIDES += \
	ro.guun.version=$(GUUN_VERSION) \
	ro.modversion=$(GUUN_VERSION) \
	guun.build.type=$(GUUN_BUILDTYPE) \
	ro.guun.build.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
	guun.ota.version= $(shell date +%Y%m%d) \
	ro.substratum.verified=true \
	ro.opa.eligible_device=true

GUUN_DISPLAY_VERSION := $(GUUN_VERSION)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.guun.display.version=$(GUUN_DISPLAY_VERSION)

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/guun/config/partner_gms.mk
-include vendor/cyngn/product.mk

$(call prepend-product-if-exists, vendor/extra/product.mk)
