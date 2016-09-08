THEOS_DEVICE_IP = 192.168.1.11

ARCHS = armv7 armv7s arm64

THEOS_BUILD_DIR = Packages

include theos/makefiles/common.mk

TWEAK_NAME = CustomDia
CustomDia_FILES = CustomDia.x
CustomDia_FRAMEWORKS = Foundation UIKit CoreGraphics AudioToolBox
CustomDia_PRIVATE_FRAMEWORKS = AppSupport BulletinBoard
CustomDia_LIBRARIES = substrate 

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
SUBPROJECTS += customdia
include $(THEOS_MAKE_PATH)/aggregate.mk
