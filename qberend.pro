TEMPLATE = app
QT += widgets opengl svg network printsupport concurrent xml
TARGET = qberend

CONFIG += debug

VERSION = 1.0.0

ROOT = $$PWD/../ospray
APP_ROOT = $$PWD/../qberend

AUTOGEN_DIR = "$$OUT_PWD/auto-gen/$$TARGET"
!exists($$AUTOGEN_DIR):$$system($$QMAKE_MKDIR "$$AUTOGEN_DIR")

# build simple build-info header file:
APP_CONF = $$AUTOGEN_DIR/$$TARGET-conf.h
PHONY_IN = .
PHONY_OUT = phony.txt
app_conf_target.name = Building configuration file
app_conf_target.input = PHONY_IN
app_conf_target.output = $$PHONY_OUT
APP_CONF_CMD = echo \"*** Building $$APP_CONF file\";
APP_CONF_CMD += echo \"$${LITERAL_HASH}define APP_VERSION \\\"$$VERSION\\\"\" > $$APP_CONF; echo \"$${LITERAL_HASH}define APP_BUILD_TIME \\\"`date`\\\"\" >> $$APP_CONF;
app_conf_target.commands = $$APP_CONF_CMD
app_conf_target.CONFIG += target_predeps no_link
app_conf_target.variable_out = HEADERS
QMAKE_EXTRA_COMPILERS += app_conf_target

include(config.pri)

isEmpty(LDR_LIB):exists(/Volumes/Xta/Library/ldraw/library.zip):LDR_LIB = /Volumes/Xta/Library/ldraw/library.zip
isEmpty(LDR_LIB):exists($$_PRO_FILE_PWD_/library.bin):LDR_LIB = $$_PRO_FILE_PWD_/library.bin
isEmpty(LDR_LIB):exists($$OUT_PWD/library.bin):LDR_LIB = $$OUT_PWD/library.bin
isEmpty(LDR_LIB):exists($$PWD/library.bin):LDR_LIB = $$PWD/library.bin

macx {
    exists($$LDR_LIB) {
        message("*** Bricks library from $$LDR_LIB")
        APP_RES = $$OUT_PWD/$$DESTDIR/$${TARGET}.app/Contents/Resources/
        copydata.commands = $(MKDIR) \"$$APP_RES\"; $(COPY_DIR) \"$$LDR_LIB\" \"$$APP_RES\"
        first.depends = $(first) copydata
        QMAKE_EXTRA_TARGETS += first copydata
    }
}

ICON = assets/OSPRay.icns
RESOURCES += $$APP_ROOT/qberend.qrc

INCLUDEPATH += \
    auto-gen \
    $$APP_ROOT $$APP_ROOT/ext \
    $$ROOT/ospray/include $$ROOT/apps $$ROOT/apps/common $$ROOT/components $$ROOT/apps/qtViewer

include("$$APP_ROOT/ext/libldr/libldr.pri")

APP_SOURCES += \
  # qt helper widgets
  $$ROOT/apps/qtViewer/widgets/lightManipulator/QLightManipulator.cpp \
  $$ROOT/apps/qtViewer/widgets/transferFunction/QTransferFunctionEditor.cpp \
  $$ROOT/apps/qtViewer/widgets/affineSpaceManipulator/HelperGeometry.cpp \
  $$ROOT/apps/qtViewer/widgets/affineSpaceManipulator/QAffineSpaceManipulator.cpp \
  \
  $$APP_ROOT/widgets/qlogwidgets.cpp \
  $$APP_ROOT/widgets/extrawidgets.cpp \
  \
  # scene graph nodes
  $$ROOT/apps/common/sg/SceneGraph.cpp \
  $$ROOT/apps/common/sg/Renderer.cpp \
  $$ROOT/apps/common/sg/3rdParty/ply.cpp \
  $$ROOT/apps/common/sg/transferFunction/TransferFunction.cpp \
  $$ROOT/apps/common/sg/geometry/Spheres.cpp \
  $$ROOT/apps/common/sg/geometry/TriangleMesh.cpp \
  $$ROOT/apps/common/sg/camera/PerspectiveCamera.cpp \
  $$ROOT/apps/common/sg/common/Common.cpp \
  $$ROOT/apps/common/sg/common/FrameBuffer.cpp \
  $$ROOT/apps/common/sg/common/Node.cpp \
  $$ROOT/apps/common/sg/common/Integrator.cpp \
  $$ROOT/apps/common/sg/common/Serialization.cpp \
  $$ROOT/apps/common/sg/common/Texture2D.cpp \
  $$ROOT/apps/common/sg/common/Transform.cpp \
  $$ROOT/apps/common/sg/common/Material.cpp \
  $$ROOT/apps/common/sg/common/World.cpp \
  $$ROOT/apps/common/sg/volume/Volume.cpp \
  $$ROOT/apps/common/sg/module/Module.cpp \
  $$ROOT/apps/common/sg/importer/Importer.cpp \
  $$ROOT/apps/common/sg/importer/ImportOSP.cpp \
  $$ROOT/apps/common/sg/importer/ImportOBJ.cpp \
  $$ROOT/apps/common/sg/importer/ImportPLY.cpp \
  $$ROOT/apps/common/sg/importer/ImportRIVL.cpp

HEADERS += \
  $$APP_ROOT/ModelViewer.h \
  $$APP_ROOT/widgets/qlogwidgets.h \
  $$APP_ROOT/widgets/extrawidgets.h \
  $$APP_ROOT/widgets/activeLabel/activelabel.h \
  $$ROOT/apps/qtViewer/widgets/affineSpaceManipulator/QAffineSpaceManipulator.h \
  $$ROOT/apps/qtViewer/widgets/transferFunction/QTransferFunctionEditor.h \
  $$ROOT/apps/qtViewer/widgets/lightManipulator/QLightManipulator.h \
  \
  $$ROOT/components/ospcommon/AffineSpace.h \
  $$ROOT/components/ospcommon/box.h \
  $$ROOT/components/ospcommon/constants.h \
  $$ROOT/components/ospcommon/intrinsics.h \
  $$ROOT/components/ospcommon/LinearSpace.h \
  $$ROOT/components/ospcommon/math.h \
  $$ROOT/components/ospcommon/malloc.h \
  $$ROOT/components/ospcommon/platform.h \
  $$ROOT/components/ospcommon/thread.h \
  $$ROOT/components/ospcommon/Quaternion.h \
  $$ROOT/components/ospcommon/RefCount.h \
  $$ROOT/components/ospcommon/vec.h

UNITY_BUILD_FILE = $$SRC_DIR/$${TARGET}-unity.cpp
write_file($$UNITY_BUILD_FILE)
for(f, APP_SOURCES) {
  INC_FILE = "$${LITERAL_HASH}include \"$$f\""
  write_file($$UNITY_BUILD_FILE, INC_FILE, append)
}

SOURCES += \
  $$UNITY_BUILD_FILE \
  \
  $$APP_ROOT/main.cpp \
  \
  # modelviewer proper
  $$APP_ROOT/ModelViewer.cpp \
  $$APP_ROOT/FPSCounter.cpp \
  $$APP_ROOT/sg/importLDraw.cpp

macx {
    exists("/opt/local/lib/libz.a"):LIBS += /opt/local/lib/libz.a
    else: LIBS += -lz
} else: LIBS += -lz

include("ospray.pri")

exists($$(HOME)/Private/Projekty/_applicationSupport): APP_RT_ROOT = $$(HOME)/Private/Projekty/_applicationSupport
else:exists($$(HOME)/Private/Projekty/0.rt/_applicationSupport): APP_RT_ROOT = $$(HOME)/Private/Projekty/0.rt/_applicationSupport
else:error("(qberend) Missing common runtime path!")

include($$APP_RT_ROOT/Qt/QtnProperty/QtnProperty.pri)
include($$APP_RT_ROOT/Qt/QtnProperty/PEG.pri)

PEG_SOURCES += ../qberend/qberend.pef
