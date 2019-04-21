TEMPLATE = app
CONFIG += console with_app_source
CONFIG -= app_bundle

include("config.pri")
include("ospray.pri")

INCLUDEPATH +=

SOURCES += \
    $$OSPRAY_ROOT/tutorials/ospTutorialSpheres.cpp \
    $$OSPRAY_ROOT/tutorials/ArcballCamera.cpp \
    $$OSPRAY_ROOT/tutorials/QtOSPRayWindow.cpp
HEADERS += \
    $$OSPRAY_ROOT/tutorials/ArcballCamera.h \
    $$OSPRAY_ROOT/tutorials/QtOSPRayWindow.h
