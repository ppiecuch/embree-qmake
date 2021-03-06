include("embree_config.pri")

EMBREE_AUTOGEN_CONFIG = config.h hash.h rtcore_version.h
for(f, EMBREE_AUTOGEN_CONFIG) {
    src = $$PWD/auto-gen/embree/$$f
    dest = $$EMBREE_ROOT/kernels/$$f
    _src = $$cat($$src, blob)
    _dest = $$cat($$dest, blob)
    !equals(_src, $$_dest) {
        message("*** Copy config file: $$f")
        system("$$QMAKE_COPY \"$$src\" \"$$dest\"")
    }
}

# Compilers
# TODO: check more compilers
QMAKE_CXX_NAME = $$basename(QMAKE_CXX)
equals(QMAKE_CXX_NAME, clang++) {
    message("*** clang++ detected")
	FLAGS_SSE2 = "-msse2"
	FLAGS_SSE3 = "-msse3"
	FLAGS_SSSE3 = "-mssse3"
	FLAGS_SSE41 = "-msse4.1"
	FLAGS_SSE42 = "-msse4.2"
	FLAGS_AVX = "-mavx"
	FLAGS_AVX2 = "-mf16c -mavx2 -mfma -mlzcnt -mbmi -mbmi2"
	FLAGS_AVX512KNL = "-march=knl"
	FLAGS_AVX512SKX = "-march=skx"
	QMAKE_CXXFLAGS += -fno-strict-aliasing -Wno-unused-variable -Wno-unused-parameter -Wno-narrowing -Wno-deprecated-register
}

# ISA configuration

SSE2 = 0
SSE42 = 1
AVX = 2
AVX2 = 3
AVX512KNL = 4
AVX512SKX = 5

FLAGS_LOWEST = ""
ISA_LOWEST_AVX = $$AVX

macx {
	XEON_ISA = "AVX2"
    ISA_LOWEST = $$SSE42
    FLAGS_LOWEST = $$FLAGS_SSE42 # Qt's default c++ flags forces minimum sse41
} else {
	!equals(QMAKE_CXX_NAME, icc) {
		XEON_ISA = "AVX2"
	} else {
		XEON_ISA = "AVX512SKX"
	}
}

equals(XEON_ISA, "SSE2"): ISA = 1
equals(XEON_ISA, "SSE3"): ISA = 2
equals(XEON_ISA, "SSSE3"): ISA = 3
equals(XEON_ISA, "SSE4.1"): ISA = 4
equals(XEON_ISA, "SSE4.2"): ISA = 5
equals(XEON_ISA, "AVX"): ISA = 6
equals(XEON_ISA, "AVX-I"): ISA = 7
equals(XEON_ISA, "AVX2"): ISA = 8
equals(XEON_ISA, "AVX512KNL"): ISA = 9
equals(XEON_ISA, "AVX512SKX"): ISA = 10

greaterThan(ISA, 0) {
    CONFIG += target_sse2
	ISPC_TARGETS = "sse2"
	isEmpty(FLAGS_LOWEST) {
        ISA_LOWEST = $$SSE2
        FLAGS_LOWEST = $$FLAGS_SSE2
	}
}
greaterThan(ISA, 1) {
	CONFIG += target_sse3
}
greaterThan(ISA, 2) {
	CONFIG += target_ssse3
}
greaterThan(ISA, 3) {
	CONFIG += target_sse41
}
greaterThan(ISA, 4) {
    CONFIG += target_sse42
	ISPC_TARGETS += "sse4"
	isEmpty(FLAGS_LOWEST) {
        ISA_LOWEST = $$SSE42
        FLAGS_LOWEST = $$FLAGS_SSE42
    }

}
greaterThan(ISA, 5) {
    CONFIG += target_avx
	ISPC_TARGETS += "avx"
	isEmpty(FLAGS_LOWEST) {
        ISA_LOWEST = $$AVX
        ISA_LOWEST_AVX = $$AVX
        FLAGS_LOWEST = $$FLAGS_AVX
    }
}
greaterThan(ISA, 7) {
	CONFIG += target_avx2
	ISPC_TARGETS += "avx2"
	isEmpty(FLAGS_LOWEST) {
        ISA_LOWEST = $$AVX2
        ISA_LOWEST_AVX = $$AVX2
        FLAGS_LOWEST = $$FLAGS_AVX2
    }
}
greaterThan(ISA, 8) {
	CONFIG += target_avx512knl
	ISPC_TARGETS += "avx512knl-i32x16"
	isEmpty(FLAGS_LOWEST) {
        ISA_LOWEST = $$AVX512KNL
        ISA_LOWEST_AVX = $$AVX512KNL
        FLAGS_LOWEST = $$FLAGS_AVX512KNL
    }
}
greaterThan(ISA, 9) {
	CONFIG += target_avx512skx
	ISPC_TARGETS += "avx512skx-i32x16"
	isEmpty(FLAGS_LOWEST) {
        ISA_LOWEST = $$AVX512SKX
        ISA_LOWEST_AVX = $$AVX512SKX
        FLAGS_LOWEST = $$FLAGS_AVX512SKX
    }
}

message("*** ISA configuration:")
message("    ISPC_TARGETS = $$ISPC_TARGETS")
message("    ISA_LOWEST_AVX = $$ISA_LOWEST_AVX")
message("    FLAGS_LOWEST = $$FLAGS_LOWEST")

QMAKE_CXXFLAGS += $$FLAGS_LOWEST

# Files definitions

OBJECTS_EXT = $$QMAKE_EXT_OBJ

INCLUDEPATH += \
	$$PWD/auto-gen/compat \
	$$PWD/auto-gen/embree \
	$$ISPC_DIR \
	$$EMBREE_ROOT/include

INCLUDEPATH_ISPC += \
	$$EMBREE_ROOT/include

HEADERS += \
	$$EMBREE_ROOT/common/algorithms/parallel_for.h \
	$$EMBREE_ROOT/common/algorithms/parallel_for_for.h \
	$$EMBREE_ROOT/common/algorithms/parallel_for_for_prefix_sum.h \
	$$EMBREE_ROOT/common/algorithms/parallel_partition.h \
	$$EMBREE_ROOT/common/algorithms/parallel_prefix_sum.h \
	$$EMBREE_ROOT/common/algorithms/parallel_reduce.h \
	$$EMBREE_ROOT/common/algorithms/parallel_map.h \
	$$EMBREE_ROOT/common/algorithms/parallel_partition.h \
	$$EMBREE_ROOT/common/algorithms/parallel_set.h \
	$$EMBREE_ROOT/common/algorithms/parallel_sort.h \
	\
	$$EMBREE_ROOT/kernels/common/accel.h \
	$$EMBREE_ROOT/kernels/common/accelinstance.h \
	$$EMBREE_ROOT/kernels/common/acceln.h \
	$$EMBREE_ROOT/kernels/common/accelset.h \
	$$EMBREE_ROOT/kernels/common/alloc.h \
	$$EMBREE_ROOT/kernels/common/buffer.h \
	$$EMBREE_ROOT/kernels/common/builder.h \
	$$EMBREE_ROOT/kernels/common/context.h \
	$$EMBREE_ROOT/kernels/common/default.h \
	$$EMBREE_ROOT/kernels/common/device.h \
	$$EMBREE_ROOT/kernels/common/geometry.h \
	$$EMBREE_ROOT/kernels/common/hit.h \
	$$EMBREE_ROOT/kernels/common/isa.h \
	$$EMBREE_ROOT/kernels/common/primref.h \
	$$EMBREE_ROOT/kernels/common/profile.h \
	$$EMBREE_ROOT/kernels/common/ray.h \
	$$EMBREE_ROOT/kernels/common/rtcore.h \
	$$EMBREE_ROOT/kernels/common/scene.h \
	$$EMBREE_ROOT/kernels/common/scene_curves.h \
	$$EMBREE_ROOT/kernels/common/scene_points.h \
	$$EMBREE_ROOT/kernels/common/scene_grid_mesh.h \
	$$EMBREE_ROOT/kernels/common/scene_instance.h \
	$$EMBREE_ROOT/kernels/common/scene_line_segments.h \
	$$EMBREE_ROOT/kernels/common/scene_quad_mesh.h \
	$$EMBREE_ROOT/kernels/common/scene_subdiv_mesh.h \
	$$EMBREE_ROOT/kernels/common/scene_triangle_mesh.h \
	$$EMBREE_ROOT/kernels/common/scene_user_geometry.h \
	$$EMBREE_ROOT/kernels/common/stack_item.h \
	$$EMBREE_ROOT/kernels/common/stat.h \
	$$EMBREE_ROOT/kernels/common/state.h \
	$$EMBREE_ROOT/kernels/common/vector.h \
	\
	$$EMBREE_ROOT/kernels/subdiv/bezier_curve.h \
	$$EMBREE_ROOT/kernels/subdiv/bezier_patch.h \
	$$EMBREE_ROOT/kernels/subdiv/bilinear_patch.h \
	$$EMBREE_ROOT/kernels/subdiv/bspline_patch.h \
	$$EMBREE_ROOT/kernels/subdiv/catmullclark_coefficients.h \
	$$EMBREE_ROOT/kernels/subdiv/catmullclark_patch.h \
	$$EMBREE_ROOT/kernels/subdiv/catmullclark_ring.h \
	$$EMBREE_ROOT/kernels/subdiv/feature_adaptive_eval.h \
	$$EMBREE_ROOT/kernels/subdiv/feature_adaptive_eval_grid.h \
	$$EMBREE_ROOT/kernels/subdiv/feature_adaptive_eval_simd.h \
	$$EMBREE_ROOT/kernels/subdiv/gregory_patch.h \
	$$EMBREE_ROOT/kernels/subdiv/gregory_patch_dense.h \
	$$EMBREE_ROOT/kernels/subdiv/gridrange.h \
	$$EMBREE_ROOT/kernels/subdiv/half_edge.h \
	$$EMBREE_ROOT/kernels/subdiv/patch.h \
	$$EMBREE_ROOT/kernels/subdiv/patch_eval.h \
	$$EMBREE_ROOT/kernels/subdiv/patch_eval_grid.h \
	$$EMBREE_ROOT/kernels/subdiv/patch_eval_simd.h \
	$$EMBREE_ROOT/kernels/subdiv/subdivpatch1base.h \
	$$EMBREE_ROOT/kernels/subdiv/tessellation.h \
	$$EMBREE_ROOT/kernels/subdiv/tessellation_cache.h \
	\
	$$EMBREE_ROOT/kernels/builders/bvh_builder_hair.h \
	$$EMBREE_ROOT/kernels/builders/bvh_builder_morton.h \
	$$EMBREE_ROOT/kernels/builders/bvh_builder_sah.h \
	$$EMBREE_ROOT/kernels/builders/heuristic_binning.h \
	$$EMBREE_ROOT/kernels/builders/heuristic_binning_array_aligned.h \
	$$EMBREE_ROOT/kernels/builders/heuristic_binning_array_unaligned.h \
	$$EMBREE_ROOT/kernels/builders/heuristic_binning.h \
	$$EMBREE_ROOT/kernels/builders/heuristic_spatial.h \
	$$EMBREE_ROOT/kernels/builders/heuristic_spatial_array.h \
	$$EMBREE_ROOT/kernels/builders/heuristic_strand_array.h \
	$$EMBREE_ROOT/kernels/builders/priminfo.h \
	$$EMBREE_ROOT/kernels/builders/primrefgen.h \
	$$EMBREE_ROOT/kernels/builders/splitter.h \
	\
	$$EMBREE_ROOT/kernels/bvh/bvh.h \
	$$EMBREE_ROOT/kernels/bvh/bvh4_factory.h \
	$$EMBREE_ROOT/kernels/bvh/bvh8_factory.h \
	$$EMBREE_ROOT/kernels/bvh/bvh_builder.h \
	$$EMBREE_ROOT/kernels/bvh/bvh_builder_twolevel.h \
	$$EMBREE_ROOT/kernels/bvh/bvh_intersector1.h \
	$$EMBREE_ROOT/kernels/bvh/bvh_intersector_hybrid.h \
	$$EMBREE_ROOT/kernels/bvh/bvh_intersector_stream.h \
	$$EMBREE_ROOT/kernels/bvh/bvh_intersector_stream_filters.h \
	$$EMBREE_ROOT/kernels/bvh/bvh_refit.h \
	$$EMBREE_ROOT/kernels/bvh/bvh_rotate.h \
	$$EMBREE_ROOT/kernels/bvh/bvh_statistics.h \
	$$EMBREE_ROOT/kernels/bvh/bvh_traverser1.h \
	\
	$$EMBREE_ROOT/kernels/geometry/curve_intersector_distance.h \
	$$EMBREE_ROOT/kernels/geometry/curve_intersector_oriented.h \
	$$EMBREE_ROOT/kernels/geometry/curve_intersector_precalculations.h \
	$$EMBREE_ROOT/kernels/geometry/curve_intersector_ribbon.h \
	$$EMBREE_ROOT/kernels/geometry/curve_intersector_sweep.h \
	$$EMBREE_ROOT/kernels/geometry/curve_intersector_virtual.h \
	$$EMBREE_ROOT/kernels/geometry/curve_intersector.h \
	$$EMBREE_ROOT/kernels/geometry/curveNi_intersector.h \
	$$EMBREE_ROOT/kernels/geometry/curveNi_mb_intersector.h \
	$$EMBREE_ROOT/kernels/geometry/curveNi_mb.h \
	$$EMBREE_ROOT/kernels/geometry/curveNi.h \
	$$EMBREE_ROOT/kernels/geometry/curveNv_intersector.h \
	$$EMBREE_ROOT/kernels/geometry/curveNv.h \
	$$EMBREE_ROOT/kernels/geometry/cylinder.h \
	$$EMBREE_ROOT/kernels/geometry/filter.h \
	$$EMBREE_ROOT/kernels/geometry/grid_soa.h \
	$$EMBREE_ROOT/kernels/geometry/grid_soa_intersector1.h \
	$$EMBREE_ROOT/kernels/geometry/instance_intersector.h \
	$$EMBREE_ROOT/kernels/geometry/intersector_epilog.h \
	$$EMBREE_ROOT/kernels/geometry/intersector_iterators.h \
	$$EMBREE_ROOT/kernels/geometry/line_intersector.h \
	$$EMBREE_ROOT/kernels/geometry/linei.h \
	$$EMBREE_ROOT/kernels/geometry/linei_intersector.h \
	$$EMBREE_ROOT/kernels/geometry/object.h \
	$$EMBREE_ROOT/kernels/geometry/object_intersector.h \
	$$EMBREE_ROOT/kernels/geometry/plane.h \
	$$EMBREE_ROOT/kernels/geometry/primitive.h \
	$$EMBREE_ROOT/kernels/geometry/quad_intersector_moeller.h \
	$$EMBREE_ROOT/kernels/geometry/quad_intersector_pluecker.h \
	$$EMBREE_ROOT/kernels/geometry/quadi.h \
	$$EMBREE_ROOT/kernels/geometry/quadv.h \
	$$EMBREE_ROOT/kernels/geometry/quadv_intersector.h \
	$$EMBREE_ROOT/kernels/geometry/subdivpatch1_intersector.h \
	$$EMBREE_ROOT/kernels/geometry/subdivpatch1.h \
	$$EMBREE_ROOT/kernels/geometry/triangle.h \
	$$EMBREE_ROOT/kernels/geometry/triangle_intersector.h \
	$$EMBREE_ROOT/kernels/geometry/triangle_intersector_moeller.h \
	$$EMBREE_ROOT/kernels/geometry/triangle_intersector_pluecker.h \
	$$EMBREE_ROOT/kernels/geometry/trianglei.h \
	$$EMBREE_ROOT/kernels/geometry/trianglev.h \
	$$EMBREE_ROOT/kernels/geometry/trianglev_mb.h

RC_FILES += \
	$$EMBREE_ROOT/kernels/embree.rc

EMBREE_LIBRARY_FILES += \ 
	$$EMBREE_ROOT/common/algorithms/parallel_for.cpp \
	$$EMBREE_ROOT/common/algorithms/parallel_reduce.cpp \
	$$EMBREE_ROOT/common/algorithms/parallel_prefix_sum.cpp \
	$$EMBREE_ROOT/common/algorithms/parallel_for_for.cpp \
	$$EMBREE_ROOT/common/algorithms/parallel_for_for_prefix_sum.cpp \
	$$EMBREE_ROOT/common/algorithms/parallel_sort.cpp \
	$$EMBREE_ROOT/common/algorithms/parallel_set.cpp \
	$$EMBREE_ROOT/common/algorithms/parallel_map.cpp \
	$$EMBREE_ROOT/common/algorithms/parallel_partition.cpp \
	\
	$$EMBREE_ROOT/kernels/common/device.cpp \
	$$EMBREE_ROOT/kernels/common/stat.cpp \
	$$EMBREE_ROOT/kernels/common/acceln.cpp \
	$$EMBREE_ROOT/kernels/common/accelset.cpp \
	$$EMBREE_ROOT/kernels/common/state.cpp \
	$$EMBREE_ROOT/kernels/common/rtcore.cpp \
	$$EMBREE_ROOT/kernels/common/rtcore_builder.cpp \
	$$EMBREE_ROOT/kernels/common/scene.cpp \
	$$EMBREE_ROOT/kernels/common/alloc.cpp \
	$$EMBREE_ROOT/kernels/common/geometry.cpp \
	$$EMBREE_ROOT/kernels/common/scene_curves.cpp \
	$$EMBREE_ROOT/kernels/common/scene_points.cpp \
	$$EMBREE_ROOT/kernels/common/scene_grid_mesh.cpp \
	$$EMBREE_ROOT/kernels/common/scene_user_geometry.cpp \
	$$EMBREE_ROOT/kernels/common/scene_instance.cpp \
	$$EMBREE_ROOT/kernels/common/scene_triangle_mesh.cpp \
	$$EMBREE_ROOT/kernels/common/scene_quad_mesh.cpp \
	$$EMBREE_ROOT/kernels/common/scene_line_segments.cpp \
	\
    $$EMBREE_ROOT/kernels/subdiv/bezier_curve.cpp \
    $$EMBREE_ROOT/kernels/subdiv/bspline_curve.cpp \
    \
	$$EMBREE_ROOT/kernels/geometry/primitive4.cpp \
	\
	$$EMBREE_ROOT/kernels/builders/primrefgen.cpp \
	\
	$$EMBREE_ROOT/kernels/bvh/bvh.cpp \
	$$EMBREE_ROOT/kernels/bvh/bvh_statistics.cpp \
	$$EMBREE_ROOT/kernels/bvh/bvh4_factory.cpp \
	$$EMBREE_ROOT/kernels/bvh/bvh8_factory.cpp \
	$$EMBREE_ROOT/kernels/bvh/bvh_rotate.cpp \
	$$EMBREE_ROOT/kernels/bvh/bvh_refit.cpp \
	$$EMBREE_ROOT/kernels/bvh/bvh_builder.cpp \
	$$EMBREE_ROOT/kernels/bvh/bvh_builder_hair.cpp \
	$$EMBREE_ROOT/kernels/bvh/bvh_builder_hair_mb.cpp \
	$$EMBREE_ROOT/kernels/bvh/bvh_builder_morton.cpp \
	$$EMBREE_ROOT/kernels/bvh/bvh_builder_sah.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_sah_spatial.cpp \
	$$EMBREE_ROOT/kernels/bvh/bvh_builder_sah_mb.cpp \
	$$EMBREE_ROOT/kernels/bvh/bvh_builder_twolevel.cpp

embree_geom_subdiv: EMBREE_LIBRARY_FILES += \
    $$EMBREE_ROOT/kernels/common/scene_subdiv_mesh.cpp \
    $$EMBREE_ROOT/kernels/subdiv/tessellation_cache.cpp \
    $$EMBREE_ROOT/kernels/subdiv/subdivpatch1base.cpp \
    $$EMBREE_ROOT/kernels/subdiv/catmullclark_coefficients.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_subdiv.cpp

embree_tasking_ppl: EMBREE_LIBRARY_FILES += \
    $$EMBREE_ROOT/common/tasking/taskschedulerppl.cpp
else:embree_tasking_tbb: EMBREE_LIBRARY_FILES += \
    $$EMBREE_ROOT/common/tasking/taskschedulertbb.cpp
else: EMBREE_LIBRARY_FILES += \ # embree_tasking_internal
	$$EMBREE_ROOT/common/tasking/taskschedulerinternal.cpp

defineReplace(uniqueid) {
    f=$$eval($$1)
    p=$$2
    fn=$$basename(f)
    components = $$split(fn, ".")
    return ($$first(components)$$p)
}

UID_LINE = "$${LITERAL_HASH}undef MODULE_ID"

EMBREE_LIBRARY_FILES_SSE42 += \
    $$EMBREE_ROOT/kernels/geometry/instance_intersector.cpp \
    $$EMBREE_ROOT/kernels/geometry/curve_intersector_virtual.cpp \
    \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector1_bvh4.cpp

embree_ray_packets: EMBREE_LIBRARY_FILES_SSE42 += \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_hybrid4_bvh4.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_stream_bvh4.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_stream_filters.cpp

embree_geom_subdiv: EMBREE_LIBRARY_FILES_SSE42 += \
    $$EMBREE_ROOT/kernels/common/scene_subdiv_mesh.cpp \
    $$EMBREE_ROOT/kernels/geometry/grid_soa.cpp \
    $$EMBREE_ROOT/kernels/subdiv/subdivpatch1base_eval.cpp

target_sse42:!isEmpty(EMBREE_LIBRARY_FILES_SSE42) {
    message("*** Enabling target SSE42")
    DEFINES += EMBREE_TARGET_SSE42
    # make unity build
    UNITY_BUILD_FILE_SSE42 = $$SRC_DIR/target-sse42-unity.cpp
    INC_FILE = "// target_sse42"
    for(f, EMBREE_LIBRARY_FILES_SSE42) {
        UID = $$uniqueid(f, "_sse42")
        INC_FILE += $$UID_LINE
        INC_FILE += "$${LITERAL_HASH}define MODULE_ID $$UID"
        INC_FILE += "$${LITERAL_HASH}include \"$$f\""
    }
    # get new content
    write_file($$SRC_DIR/.tmp, INC_FILE)
    _tmp = $$cat($$SRC_DIR/.tmp, blob)
    # compare new content with current file
    _content = $$cat($$UNITY_BUILD_FILE_SSE42, blob)
    !equals(_tmp, $$_content) {
        message("*** File changed")
        write_file($$UNITY_BUILD_FILE_SSE42, INC_FILE)
    }
    # build sub-object target
    sse42_target.name = Unity build file ${QMAKE_FILE_IN} for SSE42
    sse42_target.input = UNITY_BUILD_FILE_SSE42
    sse42_target.output = $${OBJECTS_DIR}/${QMAKE_FILE_IN_BASE}$${OBJECTS_EXT}
    sse42_target.commands = $(CXX) $(CXXFLAGS) $(INCPATH) -UEMBREE_LOWEST_ISA $${FLAGS_SSE42} -c -o ${QMAKE_FILE_OUT} ${QMAKE_FILE_IN}
    sse42_target.CONFIG +=
    sse42_target.variable_out = OBJECTS
    sse42_target.depends = $${EMBREE_LIBRARY_FILES_SSE42}
    QMAKE_EXTRA_COMPILERS += sse42_target
}

EMBREE_LIBRARY_FILES_AVX += \
    $$EMBREE_ROOT/kernels/geometry/instance_intersector.cpp \
    $$EMBREE_ROOT/kernels/geometry/curve_intersector_virtual.cpp \
    \
    $$EMBREE_ROOT/kernels/common/scene_user_geometry.cpp \
    $$EMBREE_ROOT/kernels/common/scene_instance.cpp \
    $$EMBREE_ROOT/kernels/common/scene_triangle_mesh.cpp \
    $$EMBREE_ROOT/kernels/common/scene_quad_mesh.cpp \
    $$EMBREE_ROOT/kernels/common/scene_curves.cpp \
    $$EMBREE_ROOT/kernels/common/scene_line_segments.cpp \
    $$EMBREE_ROOT/kernels/common/scene_grid_mesh.cpp \
    $$EMBREE_ROOT/kernels/common/scene_points.cpp \
    \
    $$EMBREE_ROOT/kernels/builders/primrefgen.cpp \
    \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_hair.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_hair_mb.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_morton.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_sah.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_sah_mb.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_sah_spatial.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_twolevel.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector1_bvh4.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector1_bvh8.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_refit.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_rotate.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_statistics.cpp

equals(ISA_LOWEST_AVX, $$AVX): EMBREE_LIBRARY_FILES_AVX += \
	$$EMBREE_ROOT/kernels/geometry/primitive8.cpp

embree_ray_packets: EMBREE_LIBRARY_FILES_AVX += \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_hybrid4_bvh4.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_stream_bvh4.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_stream_filters.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_hybrid4_bvh8.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_hybrid8_bvh4.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_hybrid8_bvh8.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_stream_bvh8.cpp

embree_geom_subdiv: EMBREE_LIBRARY_FILES_AVX += \
  $$EMBREE_ROOT/kernels/common/scene_subdiv_mesh.cpp \
  $$EMBREE_ROOT/kernels/geometry/grid_soa.cpp \
  $$EMBREE_ROOT/kernels/bvh/bvh_builder_subdiv.cpp \
  $$EMBREE_ROOT/kernels/subdiv/subdivpatch1base_eval.cpp

target_avx:!isEmpty(EMBREE_LIBRARY_FILES_AVX) {
    message("*** Enabling target AVX")
    DEFINES += EMBREE_TARGET_AVX
    # make unity build
    UNITY_BUILD_FILE_AVX = $$SRC_DIR/target-avx-unity.cpp
    INC_FILE = "// target_avx"
    for(f, EMBREE_LIBRARY_FILES_AVX) {
        UID = $$uniqueid(f, "_avx")
        INC_FILE += $$UID_LINE
        INC_FILE += "$${LITERAL_HASH}define MODULE_ID $$UID"
        INC_FILE += "$${LITERAL_HASH}include \"$$f\""
    }
    # get new content
    write_file($$SRC_DIR/.tmp, INC_FILE)
    _tmp = $$cat($$SRC_DIR/.tmp, blob)
    # compare new content with current file
    _content = $$cat($$UNITY_BUILD_FILE_AVX, blob)
    !equals(_tmp, $$_content) {
        message("*** File changed")
        write_file($$UNITY_BUILD_FILE_AVX, INC_FILE)
    }
    # build sub-object target
    avx_target.name = Unity build file ${QMAKE_FILE_IN} for AVX
    avx_target.input = UNITY_BUILD_FILE_AVX
    avx_target.output = $${OBJECTS_DIR}/${QMAKE_FILE_IN_BASE}$${OBJECTS_EXT}
    avx_target.commands = $(CXX) $(CXXFLAGS) $(INCPATH) -UEMBREE_LOWEST_ISA $${FLAGS_AVX} -c -o ${QMAKE_FILE_OUT} ${QMAKE_FILE_IN}
    avx_target.CONFIG +=
    avx_target.variable_out = OBJECTS
    avx_target.depends = $${EMBREE_LIBRARY_FILES_AVX}
    QMAKE_EXTRA_COMPILERS += avx_target
}

EMBREE_LIBRARY_FILES_AVX2 += \
    $$EMBREE_ROOT/kernels/common/scene_user_geometry.cpp \
    $$EMBREE_ROOT/kernels/common/scene_instance.cpp \
    $$EMBREE_ROOT/kernels/common/scene_triangle_mesh.cpp \
    $$EMBREE_ROOT/kernels/common/scene_quad_mesh.cpp \
    $$EMBREE_ROOT/kernels/common/scene_curves.cpp \
    $$EMBREE_ROOT/kernels/common/scene_line_segments.cpp \
    $$EMBREE_ROOT/kernels/common/scene_grid_mesh.cpp \
    $$EMBREE_ROOT/kernels/common/scene_points.cpp \
    \
    $$EMBREE_ROOT/kernels/geometry/instance_intersector.cpp \
    $$EMBREE_ROOT/kernels/geometry/curve_intersector_virtual.cpp \
    \
    $$EMBREE_ROOT/kernels/builders/primrefgen.cpp \
    \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_hair.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_hair_mb.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_morton.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_sah.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_sah_mb.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_sah_spatial.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_twolevel.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_refit.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_rotate.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector1_bvh4.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector1_bvh8.cpp \
#    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_stream_filters.cpp

equals(ISA_LOWEST_AVX, $$AVX2): EMBREE_LIBRARY_FILES_AVX2 += \
	$$EMBREE_ROOT/kernels/geometry/primitive8.cpp

embree_geom_subdiv: EMBREE_LIBRARY_FILES_AVX2 += \
    $$EMBREE_ROOT/kernels/common/scene_subdiv_mesh.cpp \
    $$EMBREE_ROOT/kernels/geometry/grid_soa.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_subdiv.cpp \
    $$EMBREE_ROOT/kernels/subdiv/subdivpatch1base_eval.cpp

embree_ray_packets: EMBREE_LIBRARY_FILES_AVX2 += \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_hybrid4_bvh4.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_stream_bvh4.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_hybrid4_bvh8.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_hybrid8_bvh4.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_hybrid8_bvh8.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_stream_bvh8.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_stream_filters.cpp

target_avx2:!isEmpty(EMBREE_LIBRARY_FILES_AVX2): {
    message("*** Enabling target AVX2")
    DEFINES += EMBREE_TARGET_AVX2
    # make unity build
    UNITY_BUILD_FILE_AVX2 = $$SRC_DIR/target-avx2-unity.cpp
    INC_FILE = "// target_avx2"
    for(f, EMBREE_LIBRARY_FILES_AVX2) {
        UID = $$uniqueid(f, "_avx2")
        INC_FILE += $$UID_LINE
        INC_FILE += "$${LITERAL_HASH}define MODULE_ID $$UID"
        INC_FILE += "$${LITERAL_HASH}include \"$$f\""
    }
    # get new content
    write_file($$SRC_DIR/.tmp, INC_FILE)
    _tmp = $$cat($$SRC_DIR/.tmp, blob)
    # compare new content with current file
    _content = $$cat($$UNITY_BUILD_FILE_AVX2, blob)
    !equals(_tmp, $$_content) {
        message("*** File changed")
        write_file($$UNITY_BUILD_FILE_AVX2, INC_FILE)
    }
    # build sub-object target
    avx2_target.name = Unity build file ${QMAKE_FILE_IN} for AVX2
    avx2_target.input = UNITY_BUILD_FILE_AVX2
    avx2_target.output = $${OBJECTS_DIR}/${QMAKE_FILE_IN_BASE}$${OBJECTS_EXT}
    avx2_target.commands = $(CXX) $(CXXFLAGS) $(INCPATH) -UEMBREE_LOWEST_ISA $${FLAGS_AVX2} -c -o ${QMAKE_FILE_OUT} ${QMAKE_FILE_IN}
    avx2_target.CONFIG +=
    avx2_target.variable_out = OBJECTS
    avx2_target.depends = $${EMBREE_LIBRARY_FILES_AVX2}
    QMAKE_EXTRA_COMPILERS += avx2_target
}

EMBREE_LIBRARY_FILES_AVX512KNL += \
    $$EMBREE_ROOT/kernels/builders/primrefgen.cpp \
    \
    $$EMBREE_ROOT/kernels/common/scene_user_geometry.cpp \
    $$EMBREE_ROOT/kernels/common/scene_instance.cpp \
    $$EMBREE_ROOT/kernels/common/scene_triangle_mesh.cpp \
    $$EMBREE_ROOT/kernels/common/scene_quad_mesh.cpp \
    $$EMBREE_ROOT/kernels/common/scene_curves.cpp \
    $$EMBREE_ROOT/kernels/common/scene_line_segments.cpp \
    $$EMBREE_ROOT/kernels/common/scene_grid_mesh.cpp \
    $$EMBREE_ROOT/kernels/common/scene_points.cpp \
    \
    $$EMBREE_ROOT/kernels/geometry/instance_intersector.cpp \
    \
    $$EMBREE_ROOT/kernels/bvh/bvh_refit.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_rotate.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector1_bvh4.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector1_bvh8.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_sah.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_twolevel.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_instancing.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_morton.cpp

embree_geom_subdiv: EMBREE_LIBRARY_FILES_AVX512KNL += \
    $$EMBREE_ROOT/kernels/geometry/grid_soa.cpp \
    $$EMBREE_ROOT/kernels/subdiv/subdivpatch1base_eval.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_subdiv.cpp

embree_ray_packets: EMBREE_LIBRARY_FILES_AVX512KNL += \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_hybrid4_bvh4.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_stream_bvh4.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_hybrid8_bvh4.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_hybrid4_bvh8.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_hybrid8_bvh8.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_hybrid16_bvh4.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_hybrid16_bvh8.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_stream_bvh8.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_stream_filters.cpp

target_avx512knl:!isEmpty(EMBREE_LIBRARY_FILES_AVX512KNL) {
    message("*** Enabling target AVX512KNL")
    DEFINES += EMBREE_TARGET_AVX512KNL
    # make unity build
    UNITY_BUILD_FILE_AVX512KNL = $$SRC_DIR/target-avx512knl-unity.cpp
    INC_FILE = "// target_avx512knl"
    for(f, EMBREE_LIBRARY_FILES_AVX512KNL) {
        UID = $$uniqueid(f, "_avx512")
        INC_FILE += $$UID_LINE
        INC_FILE += "$${LITERAL_HASH}define MODULE_ID $$UID"
        INC_FILE += "$${LITERAL_HASH}include \"$$f\""
    }
    # get new content
    write_file($$SRC_DIR/.tmp, INC_FILE)
    _tmp = $$cat($$SRC_DIR/.tmp, blob)
    # compare new content with current file
    _content = $$cat($$UNITY_BUILD_FILE_AVX512KNL, blob)
    !equals(_tmp, $$_content) {
        message("*** File changed")
        write_file($$UNITY_BUILD_FILE_AVX512KNL, INC_FILE)
    }
    # build sub-object target
    avx512knl_target.name = Unity build file ${QMAKE_FILE_IN} for AVX512KNL
    avx512knl_target.input = UNITY_BUILD_FILE_AVX512KNL
    avx512knl_target.output = $${OBJECTS_DIR}/${QMAKE_FILE_IN_BASE}$${OBJECTS_EXT}
    avx512knl_target.commands = $(CXX) $(CXXFLAGS) $(INCPATH) -UEMBREE_LOWEST_ISA $${FLAGS_AVX512KNL} -c -o ${QMAKE_FILE_OUT} ${QMAKE_FILE_IN}
    avx512knl_target.CONFIG +=
    avx512knl_target.variable_out = OBJECTS
    avx512knl_target.depends = $${EMBREE_LIBRARY_FILES_AVX512KNL}
    QMAKE_EXTRA_COMPILERS += avx512knl_target
}

EMBREE_LIBRARY_FILES_AVX512SKX += \
    $$EMBREE_ROOT/kernels/builders/primrefgen.cpp \
    \
    $$EMBREE_ROOT/kernels/common/scene_user_geometry.cpp \
    $$EMBREE_ROOT/kernels/common/scene_instance.cpp \
    $$EMBREE_ROOT/kernels/common/scene_triangle_mesh.cpp \
    $$EMBREE_ROOT/kernels/common/scene_quad_mesh.cpp \
    $$EMBREE_ROOT/kernels/common/scene_curves.cpp \
    $$EMBREE_ROOT/kernels/common/scene_line_segments.cpp \
    $$EMBREE_ROOT/kernels/common/scene_grid_mesh.cpp \
    $$EMBREE_ROOT/kernels/common/scene_points.cpp \
    \
    $$EMBREE_ROOT/kernels/geometry/instance_intersector.cpp \
    \
    $$EMBREE_ROOT/kernels/bvh/bvh_refit.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_sah.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_twolevel.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_instancing.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_morton.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_rotate.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector1_bvh4.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector1_bvh8.cpp

embree_geom_subdiv: EMBREE_LIBRARY_FILES_AVX512SKX += \
    $$EMBREE_ROOT/kernels/geometry/grid_soa.cpp \
    $$EMBREE_ROOT/kernels/subdiv/subdivpatch1base_eval.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder_subdiv.cpp

embree_ray_packets: EMBREE_LIBRARY_FILES_AVX512SKX += \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_stream_bvh4.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_hybrid4_bvh4.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_hybrid8_bvh4.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_hybrid4_bvh8.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_hybrid8_bvh8.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_hybrid16_bvh4.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_hybrid16_bvh8.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_stream_bvh8.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_stream_filters.cpp

target_avx512skx:!isEmpty(EMBREE_LIBRARY_FILES_AVX512SKX) {
    message("*** Enabling target AVX512SKX")
    DEFINES += EMBREE_TARGET_AVX512SKX
    # make unity build
    UNITY_BUILD_FILE_AVX512SKX = $$SRC_DIR/target-avx512skx-unity.cpp
    INC_FILE = "// target_avx512skx"
    for(f, EMBREE_LIBRARY_FILES_AVX512SKX) {
        UID = $$uniqueid(f, "_avx512")
        INC_FILE += $$UID_LINE
        INC_FILE += "$${LITERAL_HASH}define MODULE_ID $$UID"
        INC_FILE += "$${LITERAL_HASH}include \"$$f\""
    }
    # get new content
    write_file($$SRC_DIR/.tmp, INC_FILE)
    _tmp = $$cat($$SRC_DIR/.tmp, blob)
    # compare new content with current file
    _content = $$cat($$UNITY_BUILD_FILE_AVX512SKX, blob)
    !equals(_tmp, $$_content) {
        message("*** File changed")
        write_file($$UNITY_BUILD_FILE_AVX512SKX, INC_FILE)
    }
    # build sub-object target
    avx512skx_target.name = Unity build file ${QMAKE_FILE_IN} for AVX512SKX
    avx512skx_target.input = UNITY_BUILD_FILE_AVX512SKX
    avx512skx_target.output = $${OBJECTS_DIR}/${QMAKE_FILE_IN_BASE}$${OBJECTS_EXT}
    avx512skx_target.commands = $(CXX) $(CXXFLAGS) $(INCPATH) -UEMBREE_LOWEST_ISA $${FLAGS_AVX512KNL} -c -o ${QMAKE_FILE_OUT} ${QMAKE_FILE_IN}
    avx512skx_target.CONFIG +=
    avx512skx_target.variable_out = OBJECTS
    avx512skx_target.depends = $${EMBREE_LIBRARY_FILES_AVX512SKX}
    QMAKE_EXTRA_COMPILERS += avx512skx_target
}

SOURCES += $$EMBREE_LIBRARY_FILES


# common libs:
# > lexers
# > math
# > simd
# > sys
# > tasking

HEADERS += \
	$$EMBREE_ROOT/common/lexers/parsestream.h \
	$$EMBREE_ROOT/common/lexers/stream.h \
	$$EMBREE_ROOT/common/lexers/streamfilters.h \
	$$EMBREE_ROOT/common/lexers/stringstream.h \
	$$EMBREE_ROOT/common/lexers/tokenstream.h \
	$$EMBREE_ROOT/common/math/affinespace.h \
	$$EMBREE_ROOT/common/math/bbox.h \
	$$EMBREE_ROOT/common/math/col3.h \
	$$EMBREE_ROOT/common/math/col4.h \
	$$EMBREE_ROOT/common/math/color.h \
	$$EMBREE_ROOT/common/math/constants.h \
	$$EMBREE_ROOT/common/math/linearspace2.h \
	$$EMBREE_ROOT/common/math/linearspace3.h \
	$$EMBREE_ROOT/common/math/math.h \
	$$EMBREE_ROOT/common/math/obbox.h \
	$$EMBREE_ROOT/common/math/quaternion.h \
	$$EMBREE_ROOT/common/math/vec2.h \
	$$EMBREE_ROOT/common/math/vec3.h \
	$$EMBREE_ROOT/common/math/vec3ba.h \
	$$EMBREE_ROOT/common/math/vec3fa.h \
	$$EMBREE_ROOT/common/math/vec3ia.h \
	$$EMBREE_ROOT/common/math/vec4.h \
	$$EMBREE_ROOT/common/simd/avx.h \
	$$EMBREE_ROOT/common/simd/avx512.h \
	$$EMBREE_ROOT/common/simd/simd.h \
	$$EMBREE_ROOT/common/simd/sse.h \
	$$EMBREE_ROOT/common/simd/varying.h \
	$$EMBREE_ROOT/common/simd/vboold4_avx.h \
	$$EMBREE_ROOT/common/simd/vboold8_avx512.h \
	$$EMBREE_ROOT/common/simd/vboolf16_avx512.h \
	$$EMBREE_ROOT/common/simd/vboolf4_sse2.h \
	$$EMBREE_ROOT/common/simd/vboolf8_avx.h \
	$$EMBREE_ROOT/common/simd/vdouble4_avx.h \
	$$EMBREE_ROOT/common/simd/vdouble8_avx512.h \
	$$EMBREE_ROOT/common/simd/vfloat16_avx512.h \
	$$EMBREE_ROOT/common/simd/vfloat4_sse2.h \
	$$EMBREE_ROOT/common/simd/vfloat8_avx.h \
	$$EMBREE_ROOT/common/simd/vint16_avx512.h \
	$$EMBREE_ROOT/common/simd/vint4_sse2.h \
	$$EMBREE_ROOT/common/simd/vint8_avx.h \
	$$EMBREE_ROOT/common/simd/vint8_avx2.h \
	$$EMBREE_ROOT/common/simd/vllong4_avx2.h \
	$$EMBREE_ROOT/common/simd/vllong8_avx512.h \
	$$EMBREE_ROOT/common/simd/vuint16_avx512.h \
	$$EMBREE_ROOT/common/sys/alloc.h \
	$$EMBREE_ROOT/common/sys/array.h \
	$$EMBREE_ROOT/common/sys/atomic.h \
	$$EMBREE_ROOT/common/sys/barrier.h \
	$$EMBREE_ROOT/common/sys/condition.h \
	$$EMBREE_ROOT/common/sys/filename.h \
	$$EMBREE_ROOT/common/sys/intrinsics.h \
	$$EMBREE_ROOT/common/sys/library.h \
	$$EMBREE_ROOT/common/sys/mutex.h \
	$$EMBREE_ROOT/common/sys/platform.h \
	$$EMBREE_ROOT/common/sys/ref.h \
	$$EMBREE_ROOT/common/sys/regression.h \
	$$EMBREE_ROOT/common/sys/string.h \
	$$EMBREE_ROOT/common/sys/sysinfo.h \
	$$EMBREE_ROOT/common/sys/thread.h \
	$$EMBREE_ROOT/common/sys/vector.h \
	$$EMBREE_ROOT/common/tasking/taskscheduler.h \
	$$EMBREE_ROOT/common/tasking/taskschedulerinternal.h \
	$$EMBREE_ROOT/common/tasking/taskschedulertbb.h

SOURCES += \
	$$EMBREE_ROOT/common/math/constants.cpp \
	$$EMBREE_ROOT/common/lexers/stringstream.cpp \
	$$EMBREE_ROOT/common/lexers/tokenstream.cpp \
	$$EMBREE_ROOT/common/simd/sse.cpp \
	$$EMBREE_ROOT/common/sys/alloc.cpp \
	$$EMBREE_ROOT/common/sys/barrier.cpp \
	$$EMBREE_ROOT/common/sys/condition.cpp \
	$$EMBREE_ROOT/common/sys/filename.cpp \
	$$EMBREE_ROOT/common/sys/library.cpp \
	$$EMBREE_ROOT/common/sys/mutex.cpp \
	$$EMBREE_ROOT/common/sys/regression.cpp \
	$$EMBREE_ROOT/common/sys/string.cpp \
	$$EMBREE_ROOT/common/sys/sysinfo.cpp \
	$$EMBREE_ROOT/common/sys/thread.cpp

MARK = $${LITERAL_HASH}$${LITERAL_HASH}$${LITERAL_HASH}

# check for duplicates:
_dups_file = $$OBJECTS_DIR/_dups1.cpp
_line = "/* Auto-generated duplicates */"
write_file($$_dups_file, _line)
_unique = []
for(f, SOURCES) {
    contains(_unique, $$basename(f)) {
        message("$$MARK Duplicate filename found: $$basename(f)")
        _line = "$${LITERAL_HASH}include \"$$f\""
        write_file($$_dups_file, _line, append)
        SOURCES -= $$f
    } else: _unique += $$basename(f)
}

SOURCES += $$_dups_file


# Intel SMPD compiler (ISPC)

macx: ISPC_EXECUTABLE = $$PWD/../deps/ispc/ispc-v$${ISPC_VER}-osx
linux: ISPC_EXECUTABLE = $$PWD/../deps/ispc/ispc-v$${ISPC_VER}-linux

!exists($$ISPC_EXECUTABLE) {
	error("*** Cannot find ispc executable (v$${ISPC_VER})")
}

EMBREE_ISPC_ADDRESSING = 32
isEmpty(ISPC_DIR): error("*** ISPC_DIR is not set.")
!exists($$ISPC_DIR): $$system($$QMAKE_MKDIR $$ISPC_DIR)
ISPC_TARGET_ARGS = $$join( ISPC_TARGETS, "," )
win32 {
	ISPC_TARGET_EXT = ".obj"
} else {
	ISPC_TARGET_EXT = ".o"
}
win32|CONFIG(release, debug|release) {
	ISPC_OPT_FLAGS = "-O3"
} else {
	ISPC_OPT_FLAGS = "-O2 -g"
}
win32 {
	ISPC_ADDITIONAL_ARGS = "--dllexport"
} else {
	ISPC_ADDITIONAL_ARGS = "--pic"
}

contains(QT_ARCH, i386) {
	ISPC_ARCHITECTURE = "x86"
} else {
	ISPC_ARCHITECTURE = "x86-64"
}

ISPC_INCLUDE_DIR_PARMS = $$join( INCLUDEPATH_ISPC, " -I ", " -I " )

message("*** ISPC executable: $$ISPC_EXECUTABLE")
message("*** ISPC architecture: $$ISPC_ARCHITECTURE")
message("*** ISPC targets: $$ISPC_TARGET_ARGS")

ispc_compile.name = Building ISPC object ${QMAKE_FILE_IN}
ispc_compile.input = ISPC_SOURCES
ispc_compile.output = $$ISPC_DIR/${QMAKE_FILE_BASE}.dev$${ISPC_TARGET_EXT}
ispc_compile.commands = \
      $$ISPC_EXECUTABLE \
      -I $$PWD \
      $$ISPC_INCLUDE_DIR_PARMS \
      --arch=$$ISPC_ARCHITECTURE \
      --addressing=$$EMBREE_ISPC_ADDRESSING \
      $$ISPC_OPT_FLAGS \
      --target=$$ISPC_TARGET_ARGS \
      --woff \
      --opt=fast-math \
      $$ISPC_ADDITIONAL_ARGS \
      -h $$ISPC_DIR/${QMAKE_FILE_BASE}_ispc.h \
      -MMM  $$ISPC_DIR/${QMAKE_FILE_BASE}.dev.idep \
      -o $$ISPC_DIR/${QMAKE_FILE_BASE}.dev$${ISPC_TARGET_EXT} \
      ${QMAKE_FILE_IN}
macx {
    FIX_OSX_MIN = $(HOME)/Private/Projekty/0.shared/common-dev-tools/bin/patch_lc_version_min_osx.py
    exists($$FIX_OSX_MIN) {
        ispc_compile.commands += ;$$FIX_OSX_MIN $$ISPC_DIR/${QMAKE_FILE_BASE}.dev$${ISPC_TARGET_EXT}
        for(ispc_target, ISPC_TARGETS) {
            ispc_compile.commands += ;$$FIX_OSX_MIN $$ISPC_DIR/${QMAKE_FILE_BASE}.dev_$${ispc_target}$${ISPC_TARGET_EXT}
        }
    } else {
        message("*** Not fixing mac-version-min field.")
    }
}
ispc_compile.CONFIG +=
ispc_compile.variable_out = OBJECTS
QMAKE_EXTRA_COMPILERS += ispc_compile
# empty targets for additional target objects:
for(ispc_target, ISPC_TARGETS) {
	eval(ispc_compile_$${ispc_target}.name = Building ISPC object \${QMAKE_FILE_IN} ($$ispc_target))
	eval(ispc_compile_$${ispc_target}.input = ISPC_SOURCES)
	eval(ispc_compile_$${ispc_target}.output = $$ISPC_DIR/${QMAKE_FILE_BASE}.dev_$${ispc_target}$${ISPC_TARGET_EXT})
	eval(ispc_compile_$${ispc_target}.commands = $$escape_expand(\\n)) # empty command
	eval(ispc_compile_$${ispc_target}.CONFIG +=)
	eval(ispc_compile_$${ispc_target}.variable_out = OBJECTS)
    QMAKE_EXTRA_COMPILERS += ispc_compile_$${ispc_target}
}

include("$$PWD/tbb.pri")

# check for final duplicates:
_dups_file = $$OBJECTS_DIR/_dups2.cpp
_line = "/* Auto-generated duplicates */"
write_file($$_dups_file, _line)
_unique = []
for(f, SOURCES) {
    contains(_unique, $$basename(f)) {
        message("$$MARK Duplicate filename found: $$basename(f)")
        _line = "$${LITERAL_HASH}include \"$$f\""
        write_file($$_dups_file, _line, append)
        SOURCES -= $$f
    } else: _unique += $$basename(f)
}

SOURCES += $$_dups_file

# patch duplicate defines:
_fix = \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_stream_filters.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_stream.cpp
for(f, _fix) {
    _inc = $${f}.inc
    !exists($$_inc) {
        _base = $$basename(f)
        _guard = $$replace(_base, "\.", _)
        message("Fixing duplicate define: $$_base")
        _line  = "$${LITERAL_HASH}ifndef $$_guard"
        _line += "$${LITERAL_HASH}define $$_guard"
        _line += "$${LITERAL_HASH}define MAX_RAYS_PER_OCTANT U_NAME(MAX_RAYS_PER_OCTANT)"
        _line += "$${LITERAL_HASH}include \"$$_inc\""
        _line += "$${LITERAL_HASH}undef MAX_RAYS_PER_OCTANT"
        _line += "$${LITERAL_HASH}endif"
        system("$$QMAKE_COPY \"$$f\" \"$$_inc\"")
        write_file($$f, _line)
    }
}

# add once guarde for included headers and sources:
_fix = \
    $$EMBREE_ROOT/kernels/bvh/bvh_builder.h \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector1.cpp \
    $$EMBREE_ROOT/kernels/bvh/bvh_intersector_hybrid.cpp
for(f, _fix) {
    _inc = $${f}.inc
    !exists($$_inc) {
        message("Fixing pragma once: $$basename(f)")
        _line  = "$${LITERAL_HASH}pragma once"
        _line += "$${LITERAL_HASH}include \"$$_inc\""
        system("$$QMAKE_COPY \"$$f\" \"$$_inc\"")
        write_file($$f, _line)
    }
}

# fix EMBREE_LOWEST_ISA conditions
_fix = \
    $$EMBREE_ROOT/kernels/common/scene_subdiv_mesh.cpp
for(f, _fix) {
    _content = $$cat($$f, blob)
    _match = $$find(_content, "// EMBREE_LOWEST_ISA")
    isEmpty(_match) {
        message("Fixing EMBREE_LOWEST_ISA: $$basename(f)")
        _content = $$replace(_content, "$${LITERAL_HASH}endif\n", "$${LITERAL_HASH}else // EMBREE_LOWEST_ISA")
        _content = $$replace(_content, "\n\\}\n", "")
        _content += "$${LITERAL_HASH}endif // EMBREE_LOWEST_ISA"
        _content += "}"
        write_file($$f, _content)
    }
}
