ROOT = $$PWD/../ospray
EMBREE_QT = $$PWD/embree.pri

DEFINES += ENABLE_STATIC_LIB

OSPRAY_TILE_SIZE = 64               # Tile size
OSPRAY_PIXELS_PER_JOB = 64          # Must be multiple of largest vector width *and* <= OSPRAY_TILE_SIZE
CONFIG += exp_new_bb_volume_kernels # Experimental new block/bricked volume layout


INCLUDEPATH += \
  $$PWD/auto-gen/ospray \
  $$ROOT/ospray/include \
  $$ROOT/ospray \
  $$ROOT/components \
  $$ROOT/apps \
  $$ROOT/apps/common \
  $$ROOT

INCLUDEPATH_ISPC += \
  $$PWD/auto-gen/ospray \
  $$ROOT/ospray/include \
  $$ROOT/ospray \
  $$ROOT

OSPRAY_TARGET = "intel64"

ISPC_SOURCES += \
  $$ROOT/ospray/math/Distribution1D.ispc \
  $$ROOT/ospray/math/Distribution2D.ispc \
  $$ROOT/ospray/math/box.ispc \
  \
  $$ROOT/ospray/common/Model.ispc \
  $$ROOT/ospray/common/OSPCommon.ispc \
  \
  $$ROOT/ospray/fb/FrameBuffer.ispc \
  $$ROOT/ospray/fb/LocalFB.ispc \
  \
  $$ROOT/ospray/camera/Camera.ispc \
  $$ROOT/ospray/camera/PerspectiveCamera.ispc \
  $$ROOT/ospray/camera/OrthographicCamera.ispc \
  $$ROOT/ospray/camera/PanoramicCamera.ispc \
  \
  $$ROOT/ospray/volume/BlockBrickedVolume.ispc \
  $$ROOT/ospray/volume/GhostBlockBrickedVolume.ispc \
  $$ROOT/ospray/volume/GridAccelerator.ispc \
  $$ROOT/ospray/volume/SharedStructuredVolume.ispc \
  $$ROOT/ospray/volume/StructuredVolume.ispc \
  $$ROOT/ospray/volume/Volume.ispc \
  \
  $$ROOT/ospray/transferFunction/LinearTransferFunction.ispc \
  $$ROOT/ospray/transferFunction/TransferFunction.ispc \
  \
  $$ROOT/ospray/geometry/TriangleMesh.ispc \
  $$ROOT/ospray/geometry/StreamLines.ispc \
  $$ROOT/ospray/geometry/Instance.ispc \
  $$ROOT/ospray/geometry/Cylinders.ispc \
  $$ROOT/ospray/geometry/Slices.ispc \
  $$ROOT/ospray/geometry/Isosurfaces.ispc \
  \
  $$ROOT/ospray/lights/Light.ispc \
  $$ROOT/ospray/lights/AmbientLight.ispc \
  $$ROOT/ospray/lights/DirectionalLight.ispc \
  $$ROOT/ospray/lights/PointLight.ispc \
  \
  $$ROOT/ospray/geometry/Spheres.ispc \
  $$ROOT/ospray/geometry/Geometry.ispc \
  \
  $$ROOT/ospray/lights/SpotLight.ispc \
  $$ROOT/ospray/lights/QuadLight.ispc \
  $$ROOT/ospray/lights/HDRILight.ispc \
  \
  $$ROOT/ospray/texture/Texture2D.ispc \
  \
  $$ROOT/ospray/render/Renderer.ispc \
  $$ROOT/ospray/render/util.ispc \
  $$ROOT/ospray/render/raycast/RaycastRenderer.ispc \
  $$ROOT/ospray/render/simpleAO/SimpleAO.ispc \
  $$ROOT/ospray/render/simpleAO/SimpleAOMaterial.ispc \
  $$ROOT/ospray/render/scivis/SciVisRenderer.ispc \
  $$ROOT/ospray/render/scivis/SciVisMaterial.ispc \
  $$ROOT/ospray/render/pathtracer/PathTracer.ispc \
  $$ROOT/ospray/render/pathtracer/GeometryLight.ispc \
  $$ROOT/ospray/render/pathtracer/materials/Material.ispc \
  $$ROOT/ospray/render/pathtracer/materials/OBJ.ispc \
  $$ROOT/ospray/render/pathtracer/materials/Velvet.ispc \
  $$ROOT/ospray/render/pathtracer/materials/Metal.ispc \
  $$ROOT/ospray/render/pathtracer/materials/ThinGlass.ispc \
  $$ROOT/ospray/render/pathtracer/materials/Glass.ispc \
  $$ROOT/ospray/render/pathtracer/materials/MetallicPaint.ispc \
  $$ROOT/ospray/render/pathtracer/materials/Plastic.ispc \
  $$ROOT/ospray/render/pathtracer/materials/Matte.ispc \
  $$ROOT/ospray/render/pathtracer/materials/Mix.ispc

RC_FILES += \
  $$ROOT/ospray/common/ospray.rc

HEADERS += \
  $$ROOT/ospray/include/ospray/ospray.h \
  $$ROOT/ospray/include/ospray/OSPDataType.h \
  $$ROOT/ospray/include/ospray/OSPTexture.h \
  \
  $$ROOT/ospray/geometry/Geometry.h \
  $$ROOT/ospray/geometry/Geometry.ih \
  $$ROOT/ospray/geometry/TriangleMesh.h \
  $$ROOT/ospray/geometry/TriangleMesh.ih \
  $$ROOT/ospray/geometry/StreamLines.h \
  $$ROOT/ospray/geometry/Instance.h \
  $$ROOT/ospray/geometry/Instance.ih \
  $$ROOT/ospray/geometry/Spheres.h \
  $$ROOT/ospray/geometry/Cylinders.h \
  $$ROOT/ospray/geometry/Slices.h \
  $$ROOT/ospray/geometry/Isosurfaces.h \
  \
  $$ROOT/ospray/common/ISPC_KNL_Backend.h \
  \
  $$ROOT/components/ospcommon/tasking/async.h \
  $$ROOT/components/ospcommon/tasking/parallel_for.h \
  $$ROOT/components/ospcommon/tasking/tasking_system_handle.h \
  $$ROOT/components/ospcommon/tasking/TaskingTypeTraits.h \
  $$ROOT/components/ospcommon/tasking/TaskSys.h \
  \
  $$ROOT/ospray/render/pathtracer/PathTracer.h \
  $$ROOT/ospray/render/pathtracer/PathTracer.ih \
  $$ROOT/ospray/render/pathtracer/bsdfs/BSDF.ih \
  $$ROOT/ospray/render/pathtracer/bsdfs/Conductor.ih \
  $$ROOT/ospray/render/pathtracer/bsdfs/Dielectric.ih \
  $$ROOT/ospray/render/pathtracer/bsdfs/DielectricLayer.ih \
  $$ROOT/ospray/render/pathtracer/bsdfs/GGXDistribution.ih \
  $$ROOT/ospray/render/pathtracer/bsdfs/Lambert.ih \
  $$ROOT/ospray/render/pathtracer/bsdfs/MicrofacetConductor.ih \
  $$ROOT/ospray/render/pathtracer/bsdfs/MicrofacetDielectricLayer.ih \
  $$ROOT/ospray/render/pathtracer/bsdfs/Minneart.ih \
  $$ROOT/ospray/render/pathtracer/bsdfs/MultiBSDF.ih \
  $$ROOT/ospray/render/pathtracer/bsdfs/Optics.ih \
  $$ROOT/ospray/render/pathtracer/bsdfs/PowerCosineDistribution.ih \
  $$ROOT/ospray/render/pathtracer/bsdfs/Reflection.ih \
  $$ROOT/ospray/render/pathtracer/bsdfs/Scale.ih \
  $$ROOT/ospray/render/pathtracer/bsdfs/ShadingContext.ih \
  $$ROOT/ospray/render/pathtracer/bsdfs/Specular.ih \
  $$ROOT/ospray/render/pathtracer/bsdfs/ThinDielectric.ih \
  $$ROOT/ospray/render/pathtracer/bsdfs/Transmission.ih \
  $$ROOT/ospray/render/pathtracer/bsdfs/Velvety.ih \
  \
  $$ROOT/ospray/api/Device.h \
  $$ROOT/ospray/api/LocalDevice.h \
  \
  $$ROOT/ospray/fb/Tile.h \
  \
  $$ROOT/ospray/static_plugins_instance.h

  
OSPRAY_SOURCES += \
  $$ROOT/ospray/fb/FrameBuffer.cpp \
  $$ROOT/ospray/fb/LocalFB.cpp \
  $$ROOT/ospray/fb/PixelOp.cpp \
  \
  $$ROOT/ospray/camera/Camera.cpp \
  $$ROOT/ospray/camera/PerspectiveCamera.cpp \
  $$ROOT/ospray/camera/OrthographicCamera.cpp \
  $$ROOT/ospray/camera/PanoramicCamera.cpp \
  \
  $$ROOT/ospray/volume/BlockBrickedVolume.cpp \
  $$ROOT/ospray/volume/GhostBlockBrickedVolume.cpp \
  \
  $$ROOT/ospray/volume/SharedStructuredVolume.cpp \
  $$ROOT/ospray/volume/StructuredVolume.cpp \
  $$ROOT/ospray/volume/Volume.cpp \
  \
  $$ROOT/ospray/transferFunction/LinearTransferFunction.cpp \
  $$ROOT/ospray/transferFunction/TransferFunction.cpp \
  \
  $$ROOT/ospray/geometry/Geometry.cpp \
  $$ROOT/ospray/geometry/TriangleMesh.cpp \
  $$ROOT/ospray/geometry/StreamLines.cpp \
  $$ROOT/ospray/geometry/Instance.cpp \
  $$ROOT/ospray/geometry/Spheres.cpp \
  $$ROOT/ospray/geometry/Cylinders.cpp \
  $$ROOT/ospray/geometry/Slices.cpp \
  $$ROOT/ospray/geometry/Isosurfaces.cpp \
  \
  $$ROOT/ospray/lights/Light.cpp \
  $$ROOT/ospray/lights/AmbientLight.cpp \
  $$ROOT/ospray/lights/DirectionalLight.cpp \
  $$ROOT/ospray/lights/PointLight.cpp \
  $$ROOT/ospray/lights/SpotLight.cpp \
  $$ROOT/ospray/lights/QuadLight.cpp \
  $$ROOT/ospray/lights/HDRILight.cpp \
  \
  $$ROOT/ospray/texture/Texture2D.cpp \
  \
  $$ROOT/ospray/render/LoadBalancer.cpp \
  $$ROOT/ospray/render/Renderer.cpp \
  $$ROOT/ospray/render/raycast/RaycastRenderer.cpp \
  $$ROOT/ospray/render/simpleAO/SimpleAO.cpp \
  $$ROOT/ospray/render/simpleAO/SimpleAOMaterial.cpp \
  $$ROOT/ospray/render/scivis/SciVisRenderer.cpp \
  $$ROOT/ospray/render/scivis/SciVisMaterial.cpp \
  \
  $$ROOT/ospray/render/pathtracer/PathTracer.cpp \
  $$ROOT/ospray/render/pathtracer/materials/OBJ.cpp \
  $$ROOT/ospray/render/pathtracer/materials/Velvet.cpp \
  $$ROOT/ospray/render/pathtracer/materials/Metal.cpp \
  $$ROOT/ospray/render/pathtracer/materials/ThinGlass.cpp \
  $$ROOT/ospray/render/pathtracer/materials/Glass.cpp \
  $$ROOT/ospray/render/pathtracer/materials/MetallicPaint.cpp \
  $$ROOT/ospray/render/pathtracer/materials/Plastic.cpp \
  $$ROOT/ospray/render/pathtracer/materials/Matte.cpp \
  $$ROOT/ospray/render/pathtracer/materials/Mix.cpp \
  \
  $$ROOT/ospray/api/API.cpp \
  $$ROOT/ospray/api/Device.cpp \
  $$ROOT/ospray/api/LocalDevice.cpp \
  \
  $$ROOT/ospray/static_plugins_instance.cpp

message("*** Building ospray sources")
UNITY_BUILD_FILE_OSP = $$SRC_DIR/osp-unity.cpp
write_file($$UNITY_BUILD_FILE_OSP)
for(f, OSPRAY_SOURCES) {
    INC_FILE = "$${LITERAL_HASH}include \"$$f\""
    write_file($$UNITY_BUILD_FILE_OSP, INC_FILE, append)
}
SOURCES += $$UNITY_BUILD_FILE_OSP

COMMON_OSP_SOURCES = \
  $$ROOT/ospray/common/OSPCommon.cpp \
  $$ROOT/ospray/common/Managed.cpp \
  $$ROOT/ospray/common/ObjectHandle.cpp \
  $$ROOT/ospray/common/Data.cpp \
  $$ROOT/ospray/common/Model.cpp \
  $$ROOT/ospray/common/Material.cpp \
  \
  $$ROOT/components/ospcommon/FileName.cpp \
  $$ROOT/components/ospcommon/common.cpp \
  $$ROOT/components/ospcommon/library.cpp \
  $$ROOT/components/ospcommon/malloc.cpp \
  $$ROOT/components/ospcommon/sysinfo.cpp \
  $$ROOT/components/ospcommon/thread.cpp \
  $$ROOT/components/ospcommon/vec.cpp \
  $$ROOT/components/ospcommon/tasking/tasking_system_handle.cpp \
  $$ROOT/components/ospcommon/tasking/TaskSys.cpp

message("*** Building common-ospray sources")
UNITY_BUILD_FILE_COMMON_OSP = $$SRC_DIR/common-osp-unity.cpp
write_file($$UNITY_BUILD_FILE_COMMON_OSP)
for(f, COMMON_OSP_SOURCES) {
    INC_FILE = "$${LITERAL_HASH}include \"$$f\""
    write_file($$UNITY_BUILD_FILE_COMMON_OSP, INC_FILE, append)
}
SOURCES += $$UNITY_BUILD_FILE_COMMON_OSP

# embree.pri should be included as last component:

exists($$EMBREE_QT) {
	message("*** Using embree from $$EMBREE_QT")
	include($$EMBREE_QT)
} else {
	error("*** embree-qt not found")
}

APP_COMMON_OSP_SOURCES = \
  \
  $$ROOT/apps/common/ospapp/OSPApp.cpp \
  \
  $$ROOT/apps/common/sg/importer/importAMRChombo.cpp \
  $$ROOT/apps/common/sg/importer/importOBJ.cpp \
  $$ROOT/apps/common/sg/importer/importOSP.cpp \
  $$ROOT/apps/common/sg/importer/importOSPSG.cpp \
  $$ROOT/apps/common/sg/importer/importOSX.cpp \
  $$ROOT/apps/common/sg/importer/importPLY.cpp \
  $$ROOT/apps/common/sg/importer/importOSX.cpp \
  $$ROOT/apps/common/sg/importer/importRIVL.cpp \
  $$ROOT/apps/common/sg/importer/importUnstructuredVolume.cpp \
  $$ROOT/apps/common/sg/importer/importX3D.cpp \
  $$ROOT/apps/common/sg/importer/importXYZ.cpp \
  $$ROOT/apps/common/sg/importer/Importer.cpp \
  \
  $$ROOT/apps/common/sg/3rdParty/ply.cpp \
  $$ROOT/apps/common/sg/camera/OrthographicCamera.cpp \
  $$ROOT/apps/common/sg/camera/PanoramicCamera.cpp \
  $$ROOT/apps/common/sg/camera/PerspectiveCamera.cpp \
  \
  $$ROOT/apps/common/tfn_lib/jsoncpp.cpp \
  $$ROOT/apps/common/tfn_lib/tfn_lib.cpp

HEADERS += \
  $$ROOT/apps/common/importer/Importer.h \
  $$ROOT/apps/common/miniSG/miniSG.h \
  $$ROOT/apps/common/tfn_lib/tfn_lib.h \
  $$ROOT/apps/common/script/OSPRayScriptHandler.h \
  $$ROOT/apps/common/commandline/CommandLineExport.h \
  $$ROOT/apps/common/commandline/CommandLineParser.h \
  $$ROOT/apps/common/commandline/SceneParser/SceneParser.h \
  $$ROOT/apps/common/commandline/Utility.h \
  $$ROOT/apps/common/xml/XML.h

message("*** Building app-common-ospray sources")
UNITY_BUILD_FILE_APP_COMMON_OSP = $$SRC_DIR/app-common-osp-unity.cpp
write_file($$UNITY_BUILD_FILE_APP_COMMON_OSP)
for(f, APP_COMMON_OSP_SOURCES) {
    INC_FILE = "$${LITERAL_HASH}include \"$$f\""
    write_file($$UNITY_BUILD_FILE_APP_COMMON_OSP, INC_FILE, append)
}
SOURCES += $$UNITY_BUILD_FILE_APP_COMMON_OSP
