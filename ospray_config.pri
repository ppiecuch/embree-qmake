OSPRAY_ROOT = $$PWD/../ospray

OSPRAY_TILE_SIZE = 64               # Tile size
OSPRAY_PIXELS_PER_JOB = 64          # Must be multiple of largest vector width *and* <= OSPRAY_TILE_SIZE
CONFIG += exp_new_bb_volume_kernels # Experimental new block/bricked volume layout
# CONFIG += with_app_source         # Common apps source code

DEFINES += OSPRAY_ENABLE_STATIC_LIB
exp_new_bb_volume_kernels: DEFINES += EXP_NEW_BB_VOLUME_KERNELS

INCLUDEPATH += \
  $$PWD/auto-gen/ospray \
  \
  $$OSPRAY_ROOT/ospray \
  $$OSPRAY_ROOT/ospray/common \
  $$OSPRAY_ROOT/ospray/include \
  $$OSPRAY_ROOT/components \
  $$OSPRAY_ROOT/apps \
  $$OSPRAY_ROOT/apps/common \
  $$OSPRAY_ROOT/apps/common/sg \
  $$OSPRAY_ROOT

INCLUDEPATH_ISPC += \
  $$PWD/auto-gen/ospray \
  \
  $$OSPRAY_ROOT/ospray \
  $$OSPRAY_ROOT/ospray/include \
  $$OSPRAY_ROOT/ospray/common \
  $$OSPRAY_ROOT

OSPRAY_TARGET = "intel64"
