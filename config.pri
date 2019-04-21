CONFIG += debug

CONFIG(c++11): C11 = -c11
CONFIG(debug, debug|release): DBG = dbg
else: DBG = rel

DESTDIR = $$OUT_PWD/build-$$[QMAKE_SPEC]$$C11
SUBDIR = $${TEMPLATE}$${TARGET}.$${DBG}
OBJECTS_DIR = $$OUT_PWD/build-$$[QMAKE_SPEC]$$C11/$$SUBDIR/obj
MOC_DIR = $$OUT_PWD/build-$$[QMAKE_SPEC]$$C11/$$SUBDIR/ui
UI_DIR = $$OUT_PWD/build-$$[QMAKE_SPEC]$$C11/$$SUBDIR/ui
RCC_DIR = $$OUT_PWD/build-$$[QMAKE_SPEC]$$C11/$$SUBDIR/ui
SRC_DIR = $$OUT_PWD/build-$$[QMAKE_SPEC]$$C11/$$SUBDIR/src
!exists($$SRC_DIR): mkpath($$SRC_DIR)
ISPC_DIR = $$OUT_PWD/build-$$[QMAKE_SPEC]$$C11/$$SUBDIR/ispc
!exists($$ISPC_DIR): mkpath($$ISPC_DIR)

LIBS += -L$$DESTDIR
