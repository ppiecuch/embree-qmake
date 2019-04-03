TBB = tbb-2019_U2
TBB_ROOT = $$PWD/../deps/$$TBB

exists($$TBB_ROOT) {
	message("*** Found TBB instalation at $$TBB_ROOT")
	TASKING_TBB = "ON"
	DEFINES += TASKING_TBB
} else {
	error("*** Cannot find TBB instalation at $$TBB_ROOT")
	TASKING_INTERNAL = "ON"
	DEFINES += TASKING_INTERNAL
}

INCLUDEPATH += $$PWD/auto-gen/tbb $$TBB_ROOT/include $$TBB_ROOT/src $$TBB_ROOT/src/rml/include
TBB_SRC_ROOT = $$TBB_ROOT/src

DEFINES += __TBB_BUILD=1 __TBBMALLOC_BUILD=1

CONFIG(debug, debug|release): DEFINES += TBB_USE_DEBUG
c++11: DEFINES += _TBB_CPP0X

macx: {
    DEFINES += USE_PTHREAD
    QMAKE_CXXFLAGS += -Wno-non-virtual-dtor -Wno-dangling-else
}

VER_FILE = auto-gen/tbb/version_string.ver
L = "/* generated version info string */"
L += "$${LITERAL_HASH}define __TBB_VERSION_STRINGS(N) \\"
L += "$${LITERAL_HASH}N\": BUILD_HOST\t\t$$QMAKE_HOST.name\" ENDL \\"
L += "$${LITERAL_HASH}N\": BUILD_OS\t\t$$QMAKE_HOST.os\" ENDL \\"
L += "$${LITERAL_HASH}N\": BUILD_KERNEL\t$$QMAKE_HOST.version_string\" ENDL \\"
L += "$${LITERAL_HASH}N\": BUILD_CLANG\tn/a\" ENDL \\"
L += "$${LITERAL_HASH}N\": BUILD_XCODE\tn/a\" ENDL \\"
L += "$${LITERAL_HASH}N\": BUILD_COMPILER\tn/a\" ENDL \\"
L += "$${LITERAL_HASH}N\": BUILD_TARGET\t$$QMAKESPEC\" ENDL \\"
L += "$${LITERAL_HASH}N\": BUILD_COMMAND\tn/a\" ENDL \\"
L += " "
L += "$${LITERAL_HASH}define __TBB_DATETIME \"$$_DATE_\""
write_file($$VER_FILE, L)

tbb_stddef = $$TBB_ROOT/include/tbb/tbb_stddef.h
exists($$tbb_stddef) {
    message("*** Fixing tbb_stddef.h")
    _tbb_stddef = $$cat($$tbb_stddef, blob)
    _tbb_stddef = $$replace(_tbb_stddef, ": rml::internal::assertion_failure", ": ::rml::internal::assertion_failure")
    write_file($$tbb_stddef, _tbb_stddef)
}

TBB = \
    $$TBB_SRC_ROOT/rml/client/rml_tbb.cpp \
    \
    $$TBB_SRC_ROOT/tbb/concurrent_hash_map.cpp \
    $$TBB_SRC_ROOT/tbb/concurrent_queue.cpp \
    $$TBB_SRC_ROOT/tbb/concurrent_vector.cpp \
    $$TBB_SRC_ROOT/tbb/dynamic_link.cpp \
    $$TBB_SRC_ROOT/tbb/itt_notify.cpp \
    $$TBB_SRC_ROOT/tbb/cache_aligned_allocator.cpp \
    $$TBB_SRC_ROOT/tbb/pipeline.cpp \
    $$TBB_SRC_ROOT/tbb/queuing_mutex.cpp \
    $$TBB_SRC_ROOT/tbb/queuing_rw_mutex.cpp \
    $$TBB_SRC_ROOT/tbb/reader_writer_lock.cpp \
    $$TBB_SRC_ROOT/tbb/spin_rw_mutex.cpp \
    $$TBB_SRC_ROOT/tbb/x86_rtm_rw_mutex.cpp \
    $$TBB_SRC_ROOT/tbb/spin_mutex.cpp \
    $$TBB_SRC_ROOT/tbb/critical_section.cpp \
    $$TBB_SRC_ROOT/tbb/mutex.cpp \
    $$TBB_SRC_ROOT/tbb/recursive_mutex.cpp \
    $$TBB_SRC_ROOT/tbb/condition_variable.cpp \
    $$TBB_SRC_ROOT/tbb/tbb_thread.cpp \
    $$TBB_SRC_ROOT/tbb/concurrent_monitor.cpp \
    $$TBB_SRC_ROOT/tbb/semaphore.cpp \
    $$TBB_SRC_ROOT/tbb/private_server.cpp \
    $$TBB_SRC_ROOT/tbb/tbb_misc.cpp \
    $$TBB_SRC_ROOT/tbb/tbb_misc_ex.cpp \
    $$TBB_SRC_ROOT/tbb/task.cpp \
    $$TBB_SRC_ROOT/tbb/task_group_context.cpp \
    $$TBB_SRC_ROOT/tbb/governor.cpp \
    $$TBB_SRC_ROOT/tbb/market.cpp \
    $$TBB_SRC_ROOT/tbb/arena.cpp \
    $$TBB_SRC_ROOT/tbb/scheduler.cpp \
    $$TBB_SRC_ROOT/tbb/observer_proxy.cpp \
    $$TBB_SRC_ROOT/tbb/tbb_statistics.cpp \
    $$TBB_SRC_ROOT/tbb/tbb_main.cpp

TBB_MALLOC = \
    $$TBB_SRC_ROOT/tbbmalloc/backend.cpp \
    $$TBB_SRC_ROOT/tbbmalloc/large_objects.cpp \
    $$TBB_SRC_ROOT/tbbmalloc/backref.cpp  \
    $$TBB_SRC_ROOT/tbbmalloc/tbbmalloc.cpp \
    $$TBB_SRC_ROOT/tbbmalloc/frontend.cpp \
    $$TBB_SRC_ROOT/tbbmalloc/proxy.cpp \
    $$TBB_SRC_ROOT/tbbmalloc/tbb_function_replacement.cpp

TBB_PROXY = \
    $$TBB_SRC_ROOT/tbbproxy/tbbproxy.cpp
win {
    TBB_ASM_IN = $$TBB_SRC_ROOT/tbbproxy/tbbproxy-windows.asm
    TBB_ASM_OUT = tbbproxy-asm.asm
}
# preprocess asm file
asm_tbbproxy.name = Preprocess asm file ${QMAKE_FILE_IN}
asm_tbbproxy.input = TBB_ASM
asm_tbbproxy.output = tbbproxy-asm.asm
asm_tbbproxy.depends = ${QMAKE_FILE_IN}
asm_tbbproxy.commands = ${QMAKE_CXX} -E -P ${QMAKE_FILE_IN} > $$TBB_ASM_OUT
asm_tbbproxy.CONFIG += target_predeps no_link
asm_tbbproxy.variable_out = GENERATED_SOURCES
QMAKE_EXTRA_COMPILERS += asm_tbbproxy

SOURCES += \
    $$TBB $$TBB_MALLOC $$TBB_PROXY
