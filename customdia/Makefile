ARCHS = armv7 armv7s arm64

TARGET = iphone:clang:latest:7.0

THEOS_BUILD_DIR = Packages

include theos/makefiles/common.mk

BUNDLE_NAME = customdia
customdia_CFLAGS = -fno-objc-arc
customdia_FILES = customdiaListController.m CreditsListController.m
customdia_INSTALL_PATH = /Library/PreferenceBundles
customdia_FRAMEWORKS = Foundation UIKit
customdia_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/customdia.plist$(ECHO_END)
