TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle

include("config.pri")
include("ospray.pri")

SOURCES += $$OSPRAY_ROOT/tutorials/ospTutorial.cpp
HEADERS +=
