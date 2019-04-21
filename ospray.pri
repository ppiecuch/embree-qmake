include("ospray_config.pri")

EMBREE_QT = $$PWD/embree.pri

ISPC_SOURCES += \
  $$OSPRAY_ROOT/ospray/math/Distribution1D.ispc \
  $$OSPRAY_ROOT/ospray/math/Distribution2D.ispc \
  $$OSPRAY_ROOT/ospray/math/box.ispc \
  $$OSPRAY_ROOT/ospray/math/sobol.ispc \
  $$OSPRAY_ROOT/ospray/math/spectrum.ispc \
  \
  $$OSPRAY_ROOT/ospray/common/Model.ispc \
  $$OSPRAY_ROOT/ospray/common/OSPCommon.ispc \
  \
  $$OSPRAY_ROOT/ospray/fb/FrameBuffer.ispc \
  $$OSPRAY_ROOT/ospray/fb/LocalFB.ispc \
  \
  $$OSPRAY_ROOT/ospray/camera/Camera.ispc \
  $$OSPRAY_ROOT/ospray/camera/PerspectiveCamera.ispc \
  $$OSPRAY_ROOT/ospray/camera/OrthographicCamera.ispc \
  $$OSPRAY_ROOT/ospray/camera/PanoramicCamera.ispc \
  \
  $$OSPRAY_ROOT/ospray/volume/Volume.ispc \
  $$OSPRAY_ROOT/ospray/volume/structured/GridAccelerator.ispc \
  $$OSPRAY_ROOT/ospray/volume/structured/StructuredVolume.ispc \
  $$OSPRAY_ROOT/ospray/volume/structured/bricked/BlockBrickedVolume.ispc \
  $$OSPRAY_ROOT/ospray/volume/structured/bricked/GhostBlockBrickedVolume.ispc \
  $$OSPRAY_ROOT/ospray/volume/structured/shared/SharedStructuredVolume.ispc \
  $$OSPRAY_ROOT/ospray/volume/unstructured/MinMaxBVH2.ispc \
  $$OSPRAY_ROOT/ospray/volume/unstructured/UnstructuredVolume.ispc \
  $$OSPRAY_ROOT/ospray/volume/amr/AMRVolume.ispc \
  $$OSPRAY_ROOT/ospray/volume/amr/CellRef.ispc \
  $$OSPRAY_ROOT/ospray/volume/amr/DualCell.ispc \
  $$OSPRAY_ROOT/ospray/volume/amr/method_current.ispc \
  $$OSPRAY_ROOT/ospray/volume/amr/method_finest.ispc \
  $$OSPRAY_ROOT/ospray/volume/amr/method_octant.ispc \
  \
  $$OSPRAY_ROOT/ospray/transferFunction/LinearTransferFunction.ispc \
  $$OSPRAY_ROOT/ospray/transferFunction/TransferFunction.ispc \
  \
  $$OSPRAY_ROOT/ospray/geometry/QuadMesh.ispc \
  $$OSPRAY_ROOT/ospray/geometry/TriangleMesh.ispc \
  $$OSPRAY_ROOT/ospray/geometry/StreamLines.ispc \
  $$OSPRAY_ROOT/ospray/geometry/Instance.ispc \
  $$OSPRAY_ROOT/ospray/geometry/Cylinders.ispc \
  $$OSPRAY_ROOT/ospray/geometry/Slices.ispc \
  $$OSPRAY_ROOT/ospray/geometry/Isosurfaces.ispc \
  \
  $$OSPRAY_ROOT/ospray/lights/Light.ispc \
  $$OSPRAY_ROOT/ospray/lights/AmbientLight.ispc \
  $$OSPRAY_ROOT/ospray/lights/DirectionalLight.ispc \
  $$OSPRAY_ROOT/ospray/lights/PointLight.ispc \
  \
  $$OSPRAY_ROOT/ospray/geometry/Spheres.ispc \
  $$OSPRAY_ROOT/ospray/geometry/Geometry.ispc \
  \
  $$OSPRAY_ROOT/ospray/lights/SpotLight.ispc \
  $$OSPRAY_ROOT/ospray/lights/QuadLight.ispc \
  $$OSPRAY_ROOT/ospray/lights/HDRILight.ispc \
  \
  $$OSPRAY_ROOT/ospray/texture/Texture2D.ispc \
  $$OSPRAY_ROOT/ospray/texture/TextureVolume.ispc \
  \
  $$OSPRAY_ROOT/ospray/render/Renderer.ispc \
  $$OSPRAY_ROOT/ospray/render/util.ispc \
  $$OSPRAY_ROOT/ospray/render/raycast/RaycastRenderer.ispc \
  $$OSPRAY_ROOT/ospray/render/simpleAO/SimpleAO.ispc \
  $$OSPRAY_ROOT/ospray/render/simpleAO/SimpleAOMaterial.ispc \
  $$OSPRAY_ROOT/ospray/render/scivis/SciVisRenderer.ispc \
  $$OSPRAY_ROOT/ospray/render/scivis/SciVisMaterial.ispc \
  $$OSPRAY_ROOT/ospray/render/scivis/lightAlpha.ispc \
  $$OSPRAY_ROOT/ospray/render/scivis/surfaceShading.ispc \
  $$OSPRAY_ROOT/ospray/render/scivis/volumeIntegration.ispc \
  $$OSPRAY_ROOT/ospray/render/pathtracer/PathTracer.ispc \
  $$OSPRAY_ROOT/ospray/render/pathtracer/GeometryLight.ispc \
  $$OSPRAY_ROOT/ospray/render/pathtracer/bsdfs/MicrofacetAlbedoTables.ispc \
  $$OSPRAY_ROOT/ospray/render/pathtracer/materials/Alloy.ispc \
  $$OSPRAY_ROOT/ospray/render/pathtracer/materials/CarPaint.ispc \
  $$OSPRAY_ROOT/ospray/render/pathtracer/materials/Glass.ispc \
  $$OSPRAY_ROOT/ospray/render/pathtracer/materials/Luminous.ispc \
  $$OSPRAY_ROOT/ospray/render/pathtracer/materials/Material.ispc \
  $$OSPRAY_ROOT/ospray/render/pathtracer/materials/Metal.ispc \
  $$OSPRAY_ROOT/ospray/render/pathtracer/materials/MetallicPaint.ispc \
  $$OSPRAY_ROOT/ospray/render/pathtracer/materials/Mix.ispc \
  $$OSPRAY_ROOT/ospray/render/pathtracer/materials/OBJ.ispc \
  $$OSPRAY_ROOT/ospray/render/pathtracer/materials/Plastic.ispc \
  $$OSPRAY_ROOT/ospray/render/pathtracer/materials/Principled.ispc \
  $$OSPRAY_ROOT/ospray/render/pathtracer/materials/ThinGlass.ispc \
  $$OSPRAY_ROOT/ospray/render/pathtracer/materials/Velvet.ispc

RC_FILES += \
  $$OSPRAY_ROOT/ospray/common/ospray.rc

HEADERS += \
  $$OSPRAY_ROOT/ospray/include/ospray/ospray.h \
  $$OSPRAY_ROOT/ospray/include/ospray/OSPDataType.h \
  $$OSPRAY_ROOT/ospray/include/ospray/OSPTexture.h \
  \
  $$OSPRAY_ROOT/ospray/common/Util.h \
  \
  $$OSPRAY_ROOT/ospray/geometry/Geometry.h \
  $$OSPRAY_ROOT/ospray/geometry/Geometry.ih \
  $$OSPRAY_ROOT/ospray/geometry/QuadMesh.h \
  $$OSPRAY_ROOT/ospray/geometry/QuadMesh.ih \
  $$OSPRAY_ROOT/ospray/geometry/TriangleMesh.h \
  $$OSPRAY_ROOT/ospray/geometry/TriangleMesh.ih \
  $$OSPRAY_ROOT/ospray/geometry/StreamLines.h \
  $$OSPRAY_ROOT/ospray/geometry/Instance.h \
  $$OSPRAY_ROOT/ospray/geometry/Instance.ih \
  $$OSPRAY_ROOT/ospray/geometry/Spheres.h \
  $$OSPRAY_ROOT/ospray/geometry/Cylinders.h \
  $$OSPRAY_ROOT/ospray/geometry/Slices.h \
  $$OSPRAY_ROOT/ospray/geometry/Isosurfaces.h \
  \
  $$OSPRAY_ROOT/ospray/texture/Texture.h \
  $$OSPRAY_ROOT/ospray/texture/Texture2D.h \
  $$OSPRAY_ROOT/ospray/texture/Texture2D.ih \
  $$OSPRAY_ROOT/ospray/texture/TextureParam.ih \
  $$OSPRAY_ROOT/ospray/texture/TextureVolume.h \
  \
  $$OSPRAY_ROOT/ospray/volume/Volume.h \
  \
  $$OSPRAY_ROOT/components/ospcommon/tasking/async.h \
  $$OSPRAY_ROOT/components/ospcommon/tasking/parallel_for.h \
  $$OSPRAY_ROOT/components/ospcommon/tasking/tasking_system_handle.h \
  $$OSPRAY_ROOT/components/ospcommon/tasking/detail/TaskSys.h \
  $$OSPRAY_ROOT/components/ospcommon/utility/demangle.h \
  $$OSPRAY_ROOT/components/ospcommon/utility/PseudoURL.h \
  $$OSPRAY_ROOT/components/ospcommon/utility/ParameterizedObject.h \
  $$OSPRAY_ROOT/components/ospcommon/utility/TimeStamp.h \
  $$OSPRAY_ROOT/components/ospcommon/xml/XML.h \
  \
  $$OSPRAY_ROOT/ospray/render/pathtracer/PathTracer.h \
  $$OSPRAY_ROOT/ospray/render/pathtracer/PathTracer.ih \
  $$OSPRAY_ROOT/ospray/render/pathtracer/bsdfs/BSDF.ih \
  $$OSPRAY_ROOT/ospray/render/pathtracer/bsdfs/Conductor.ih \
  $$OSPRAY_ROOT/ospray/render/pathtracer/bsdfs/Dielectric.ih \
  $$OSPRAY_ROOT/ospray/render/pathtracer/bsdfs/DielectricLayer.ih \
  $$OSPRAY_ROOT/ospray/render/pathtracer/bsdfs/GGXDistribution.ih \
  $$OSPRAY_ROOT/ospray/render/pathtracer/bsdfs/Lambert.ih \
  $$OSPRAY_ROOT/ospray/render/pathtracer/bsdfs/MicrofacetConductor.ih \
  $$OSPRAY_ROOT/ospray/render/pathtracer/bsdfs/MicrofacetAlbedoTables.ih \
  $$OSPRAY_ROOT/ospray/render/pathtracer/bsdfs/MicrofacetDielectricLayer.ih \
  $$OSPRAY_ROOT/ospray/render/pathtracer/bsdfs/Minneart.ih \
  $$OSPRAY_ROOT/ospray/render/pathtracer/bsdfs/MultiBSDF.ih \
  $$OSPRAY_ROOT/ospray/render/pathtracer/bsdfs/Optics.ih \
  $$OSPRAY_ROOT/ospray/render/pathtracer/bsdfs/PowerCosineDistribution.ih \
  $$OSPRAY_ROOT/ospray/render/pathtracer/bsdfs/Reflection.ih \
  $$OSPRAY_ROOT/ospray/render/pathtracer/bsdfs/Scale.ih \
  $$OSPRAY_ROOT/ospray/render/pathtracer/bsdfs/ShadingContext.ih \
  $$OSPRAY_ROOT/ospray/render/pathtracer/bsdfs/Specular.ih \
  $$OSPRAY_ROOT/ospray/render/pathtracer/bsdfs/ThinDielectric.ih \
  $$OSPRAY_ROOT/ospray/render/pathtracer/bsdfs/Transmission.ih \
  $$OSPRAY_ROOT/ospray/render/pathtracer/bsdfs/Velvety.ih \
  \
  $$OSPRAY_ROOT/ospray/api/Device.h \
  $$OSPRAY_ROOT/ospray/api/ISPCDevice.h \
  \
  $$OSPRAY_ROOT/ospray/fb/Tile.h

  
OSPRAY_SOURCES += \
  $$OSPRAY_ROOT/ospray/ispc_tasksys.cpp \
  \
  $$OSPRAY_ROOT/ospray/fb/FrameBuffer.cpp \
  $$OSPRAY_ROOT/ospray/fb/LocalFB.cpp \
  $$OSPRAY_ROOT/ospray/fb/PixelOp.cpp \
  $$OSPRAY_ROOT/ospray/fb/TileError.cpp \
  \
  $$OSPRAY_ROOT/ospray/camera/Camera.cpp \
  $$OSPRAY_ROOT/ospray/camera/PerspectiveCamera.cpp \
  $$OSPRAY_ROOT/ospray/camera/OrthographicCamera.cpp \
  $$OSPRAY_ROOT/ospray/camera/PanoramicCamera.cpp \
  \
  $$OSPRAY_ROOT/ospray/volume/structured/StructuredVolume.cpp \
  $$OSPRAY_ROOT/ospray/volume/structured/bricked/BlockBrickedVolume.cpp \
  $$OSPRAY_ROOT/ospray/volume/structured/bricked/GhostBlockBrickedVolume.cpp \
  $$OSPRAY_ROOT/ospray/volume/structured/shared/SharedStructuredVolume.cpp \
  $$OSPRAY_ROOT/ospray/volume/unstructured/MinMaxBVH2.cpp \
  $$OSPRAY_ROOT/ospray/volume/unstructured/UnstructuredVolume.cpp \
  $$OSPRAY_ROOT/ospray/volume/amr/AMRAccel.cpp \
  $$OSPRAY_ROOT/ospray/volume/amr/AMRData.cpp \
  $$OSPRAY_ROOT/ospray/volume/amr/AMRVolume.cpp \
  $$OSPRAY_ROOT/ospray/volume/Volume.cpp \
  \
  $$OSPRAY_ROOT/ospray/transferFunction/LinearTransferFunction.cpp \
  $$OSPRAY_ROOT/ospray/transferFunction/TransferFunction.cpp \
  \
  $$OSPRAY_ROOT/ospray/geometry/Geometry.cpp \
  $$OSPRAY_ROOT/ospray/geometry/QuadMesh.cpp \
  $$OSPRAY_ROOT/ospray/geometry/TriangleMesh.cpp \
  $$OSPRAY_ROOT/ospray/geometry/StreamLines.cpp \
  $$OSPRAY_ROOT/ospray/geometry/Instance.cpp \
  $$OSPRAY_ROOT/ospray/geometry/Spheres.cpp \
  $$OSPRAY_ROOT/ospray/geometry/Cylinders.cpp \
  $$OSPRAY_ROOT/ospray/geometry/Slices.cpp \
  $$OSPRAY_ROOT/ospray/geometry/Isosurfaces.cpp \
  \
  $$OSPRAY_ROOT/ospray/lights/Light.cpp \
  $$OSPRAY_ROOT/ospray/lights/AmbientLight.cpp \
  $$OSPRAY_ROOT/ospray/lights/DirectionalLight.cpp \
  $$OSPRAY_ROOT/ospray/lights/PointLight.cpp \
  $$OSPRAY_ROOT/ospray/lights/SpotLight.cpp \
  $$OSPRAY_ROOT/ospray/lights/QuadLight.cpp \
  $$OSPRAY_ROOT/ospray/lights/HDRILight.cpp \
  \
  $$OSPRAY_ROOT/ospray/texture/Texture.cpp \
  $$OSPRAY_ROOT/ospray/texture/Texture2D.cpp \
  $$OSPRAY_ROOT/ospray/texture/TextureVolume.cpp \
  \
  $$OSPRAY_ROOT/ospray/render/LoadBalancer.cpp \
  $$OSPRAY_ROOT/ospray/render/Renderer.cpp \
  $$OSPRAY_ROOT/ospray/render/raycast/RaycastRenderer.cpp \
  $$OSPRAY_ROOT/ospray/render/simpleAO/SimpleAO.cpp \
  $$OSPRAY_ROOT/ospray/render/simpleAO/SimpleAOMaterial.cpp \
  $$OSPRAY_ROOT/ospray/render/scivis/SciVisRenderer.cpp \
  $$OSPRAY_ROOT/ospray/render/scivis/SciVisMaterial.cpp \
  \
  $$OSPRAY_ROOT/ospray/render/pathtracer/PathTracer.cpp \
  $$OSPRAY_ROOT/ospray/render/pathtracer/materials/OBJ.cpp \
  $$OSPRAY_ROOT/ospray/render/pathtracer/materials/Velvet.cpp \
  $$OSPRAY_ROOT/ospray/render/pathtracer/materials/Metal.cpp \
  $$OSPRAY_ROOT/ospray/render/pathtracer/materials/ThinGlass.cpp \
  $$OSPRAY_ROOT/ospray/render/pathtracer/materials/Glass.cpp \
  $$OSPRAY_ROOT/ospray/render/pathtracer/materials/MetallicPaint.cpp \
  $$OSPRAY_ROOT/ospray/render/pathtracer/materials/Plastic.cpp \
  $$OSPRAY_ROOT/ospray/render/pathtracer/materials/Mix.cpp \
  \
  $$OSPRAY_ROOT/ospray/api/API.cpp \
  $$OSPRAY_ROOT/ospray/api/Device.cpp \
  $$OSPRAY_ROOT/ospray/api/ISPCDevice.cpp \

message("*** Building ospray sources")
UNITY_BUILD_FILE_OSP = $$SRC_DIR/osp-unity.cpp
INC_FILE = "// ospray sources"
for(f, OSPRAY_SOURCES) {
    INC_FILE += "$${LITERAL_HASH}include \"$$f\""
}
# get new content
write_file($$SRC_DIR/.tmp, INC_FILE)
_tmp = $$cat($$SRC_DIR/.tmp, blob)
# compare new content with current file
_content = $$cat($$UNITY_BUILD_FILE_OSP, blob)
!equals(_tmp, $$_content) {
    message("*** File changed")
    write_file($$UNITY_BUILD_FILE_OSP, INC_FILE)
}
SOURCES += $$UNITY_BUILD_FILE_OSP

COMMON_OSP_SOURCES = \
  $$OSPRAY_ROOT/ospray/common/OSPCommon.cpp \
  $$OSPRAY_ROOT/ospray/common/Managed.cpp \
  $$OSPRAY_ROOT/ospray/common/ObjectHandle.cpp \
  $$OSPRAY_ROOT/ospray/common/Data.cpp \
  $$OSPRAY_ROOT/ospray/common/Model.cpp \
  $$OSPRAY_ROOT/ospray/common/Material.cpp \
  \
  $$OSPRAY_ROOT/components/ospcommon/FileName.cpp \
  $$OSPRAY_ROOT/components/ospcommon/common.cpp \
  $$OSPRAY_ROOT/components/ospcommon/library.cpp \
  $$OSPRAY_ROOT/components/ospcommon/sysinfo.cpp \
  $$OSPRAY_ROOT/components/ospcommon/thread.cpp \
  $$OSPRAY_ROOT/components/ospcommon/vec.cpp \
  $$OSPRAY_ROOT/components/ospcommon/memory/malloc.cpp \
  $$OSPRAY_ROOT/components/ospcommon/tasking/detail/tasking_system_handle.cpp \
  $$OSPRAY_ROOT/components/ospcommon/tasking/detail/TaskSys.cpp \
  $$OSPRAY_ROOT/components/ospcommon/utility/demangle.cpp \
  $$OSPRAY_ROOT/components/ospcommon/utility/PseudoURL.cpp \
  $$OSPRAY_ROOT/components/ospcommon/utility/ParameterizedObject.cpp \
  $$OSPRAY_ROOT/components/ospcommon/utility/TimeStamp.cpp \
  $$OSPRAY_ROOT/components/ospcommon/xml/XML.cpp

HEADERS += \
  $$OSPRAY_ROOT/components/ospcommon/library.h

message("*** Building common-ospray sources")
UNITY_BUILD_FILE_COMMON_OSP = $$SRC_DIR/common-osp-unity.cpp
INC_FILE = "// common-ospray sources"
for(f, COMMON_OSP_SOURCES) {
    INC_FILE += "$${LITERAL_HASH}include \"$$f\""
}
# get new content
write_file($$SRC_DIR/.tmp, INC_FILE)
_tmp = $$cat($$SRC_DIR/.tmp, blob)
# compare new content with current file
_content = $$cat($$UNITY_BUILD_FILE_COMMON_OSP, blob)
!equals(_tmp, $$_content) {
    message("*** File changed")
    write_file($$UNITY_BUILD_FILE_COMMON_OSP, INC_FILE)
}
SOURCES += $$UNITY_BUILD_FILE_COMMON_OSP

# embree.pri should be included as last component:

exists($$EMBREE_QT) {
	message("*** Using embree from $$EMBREE_QT")
	include($$EMBREE_QT)
} else {
	error("*** embree-qt not found")
}

APP_COMMON_OSP_SOURCES += \
  $$OSPRAY_ROOT/apps/common/tfn_lib/jsoncpp.cpp \
  $$OSPRAY_ROOT/apps/common/tfn_lib/tfn_lib.cpp \
  \
  $$OSPRAY_ROOT/apps/common/ospray_testing/ospray_testing.cpp \
  $$OSPRAY_ROOT/apps/common/ospray_testing/geometry/RandomSpheres.cpp \
  $$OSPRAY_ROOT/apps/common/ospray_testing/geometry/SubdivisionCube.cpp \
  $$OSPRAY_ROOT/apps/common/ospray_testing/lights/AmbientOnly.cpp \
  $$OSPRAY_ROOT/apps/common/ospray_testing/lights/AmbientAndDirectional.cpp \
  $$OSPRAY_ROOT/apps/common/ospray_testing/transferFunction/Grayscale.cpp \
  $$OSPRAY_ROOT/apps/common/ospray_testing/transferFunction/Jet.cpp \
  $$OSPRAY_ROOT/apps/common/ospray_testing/transferFunction/RGB.cpp \
  $$OSPRAY_ROOT/apps/common/ospray_testing/transferFunction/TransferFunction.cpp \
  $$OSPRAY_ROOT/apps/common/ospray_testing/volume/GravitySpheresVolume.cpp \
  $$OSPRAY_ROOT/apps/common/ospray_testing/volume/SimpleStructuredVolume.cpp \
  $$OSPRAY_ROOT/apps/common/ospray_testing/volume/SimpleUnstructuredVolume.cpp \
  \
  $$OSPRAY_ROOT/apps/exampleViewer/common/imgui/imgui.cpp \
  $$OSPRAY_ROOT/apps/exampleViewer/common/imgui/imgui_draw.cpp \
  $$OSPRAY_ROOT/apps/exampleViewer/widgets/imgui_impl_qt_gl2.cpp

message("*** Building app-common-ospray sources")
UNITY_BUILD_FILE_APP_COMMON_OSP = $$SRC_DIR/app-common-osp-unity.cpp
INC_FILE = "// app-common-ospray sources"
for(f, APP_COMMON_OSP_SOURCES) {
    INC_FILE += "$${LITERAL_HASH}include \"$$f\""
}
# get new content
write_file($$SRC_DIR/.tmp, INC_FILE)
_tmp = $$cat($$SRC_DIR/.tmp, blob)
# compare new content with current file
_content = $$cat($$UNITY_BUILD_FILE_APP_COMMON_OSP, blob)
!equals(_tmp, $$_content) {
    message("*** File changed")
    write_file($$UNITY_BUILD_FILE_APP_COMMON_OSP, INC_FILE)
}

with_app_source {
  message("*** Including app-common-ospray module")
  SOURCES += $$UNITY_BUILD_FILE_APP_COMMON_OSP
  HEADERS += \
    $$OSPRAY_ROOT/apps/common/ospray_testing/ospray_testing.h \
    \
    $$OSPRAY_ROOT/apps/common/tfn_lib/tfn_lib.h \
    \
    $$OSPRAY_ROOT/apps/exampleViewer/widgets/imgui_impl_qt_gl2.h
  INCLUDEPATH += \
    $$OSPRAY_ROOT/apps/common/ospray_testing \
    \
    $$OSPRAY_ROOT/apps/exampleViewer/common/imgui \
    $$OSPRAY_ROOT/apps/exampleViewer/widgets
}
