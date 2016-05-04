LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := samples

LOCAL_SRC_FILES := $(call all-java-files-under, src)

#LOCAL_SDK_VERSION := current
LOCAL_PACKAGE_NAME := DTVPlayer
LOCAL_STATIC_JAVA_LIBRARIES := tvmiddleware
LOCAL_JNI_SHARED_LIBRARIES := libam_adp libam_mw libjnitvmboxdevice libjnitvdatabase libjnitvdbcheck libjnitvscanner libjnitvsubtitle libjnitvepgscanner libzvbi libjnitvupdater

ifeq (1,$(strip $(shell expr $(PLATFORM_SDK_VERSION) \>= 22)))
LOCAL_JNI_SHARED_LIBRARIES += libam_sysfs
endif

LOCAL_PROGUARD_ENABLED := disabled

LOCAL_CERTIFICATE := platform

$(LOCAL_PATH)/AndroidManifest.xml: $(LOCAL_PATH)/AndroidManifest.xml.in
	SDK_VERSION=$(PLATFORM_SDK_VERSION) LOCAL_PATH=$(dir $@) $(dir $@)/makeversion.sh $< $@

.PHONY: $(LOCAL_PATH)/AndroidManifest.xml

include $(BUILD_PACKAGE)

###################################################

include $(call all-makefiles-under,$(LOCAL_PATH))
