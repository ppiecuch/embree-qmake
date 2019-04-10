EMBREE_VER = 3.5.1
EMBREE_ROOT = $$PWD/../embree/$$EMBREE_VER
ISPC_VER=1.9.2
ITT_ROOT = $$PWD/../deps/IntelSEAPI/ittnotify

DEFINES += EMBREE_STATIC_LIB EMBREE_LOWEST_ISA

CONFIG(debug, debug|release): CONFIG += embree_stat_counters
CONFIG -= embree_ray_masks      # Enables ray mask support.
CONFIG += embree_ray_packets    # Enabled support for ray packets.
CONFIG += embree_backface_culling # Enables backface culling
CONFIG += embree_filter_function  # Enables filter functions
CONFIG += embree_geom_triangle  # Enables support for triangle geometries.
CONFIG += embree_geom_quad      # Enables support for quad geometries.
CONFIG += embree_geom_curve     # Enables support for curve geometries

CONFIG += embree_geom_lines     # Enables support for line geometries.
CONFIG += embree_geom_hair      # Enables support for hair geometries.
CONFIG += embree_geom_subdiv    # Enables support for subdiv geometries.
CONFIG += embree_geom_user      # Enables support for user geometries.
CONFIG += embree_geom_instance  # Enables support for instances
CONFIG += embree_geom_grid      # Enables support for grid geometries
CONFIG += embree_geom_point     # Enables support for point geometries

CONFIG -= embree_native_curve_bspline # Specifies the spline basis.
CONFIG -= embree_itt            # Enable instrumentation with the ITT API.
CONFIG += embree_tasking_tbb    # Tasking type: embree_tasking_tbb|embree_tasking_ppl|embree_tasking_internal

embree_itt {
    exits($$ITT_ROOT) {
        DEFINES += RTCORE_ITT
        INCLUDEPATH += $$ITT_ROOT/include
    } else {
        message("*** ITT not found at: '$$ITT_ROOT' - feature will be disabled")
    }
}

embree_stat_counters: DEFINES += EMBREE_STAT_COUNTERS
embree_ray_masks: DEFINES += EMBREE_RAY_MASK
embree_ray_packets: DEFINES += EMBREE_RAY_PACKETS
embree_backface_culling: DEFINES += EMBREE_BACKFACE_CULLING
embree_filter_function: DEFINES += EMBREE_FILTER_FUNCTION
embree_geom_triangles: DEFINES += EMBREE_GEOMETRY_TRIANGLE
embree_geom_quads: DEFINES += EMBREE_GEOMETRY_QUAD
embree_geom_curve: DEFINES += EMBREE_GEOMETRY_CURVE
embree_geom_lines: DEFINES += EMBREE_GEOMETRY_LINE
embree_geom_hair: DEFINES += EMBREE_GEOMETRY_HAIR
embree_geom_subdiv: DEFINES += EMBREE_GEOMETRY_SUBDIVISION
embree_geom_user: DEFINES += EMBREE_GEOMETRY_USER
embree_geom_instances: DEFINES += EMBREE_GEOMETRY_INSTANCE
embree_geom_grid: DEFINES += EMBREE_GEOMETRY_GRID
embree_geom_point: DEFINES += EMBREE_GEOMETRY_POINT
embree_native_curve_bspline: DEFINES += EMBREE_NATIVE_CURVE_BSPLINE
