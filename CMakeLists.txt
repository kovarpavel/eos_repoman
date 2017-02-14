# project name
project (repoman)

# the oldest stable cmake version we support
cmake_minimum_required (VERSION 2.6)

# tell cmake where its modules can be found in our project directory
list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/src)

# where we install data directory (if we have any)
set (DATADIR "${CMAKE_INSTALL_PREFIX}/share")

# what to call that directory where we install data too
set (PKGDATADIR "${DATADIR}/hello-again")

set (EXEC_NAME "repoman")
set (RELEASE_NAME "A hello world.")
set (VERSION "0.1")
set (VERSION_INFO "whats up world")

add_definitions (-DI_KNOW_THE_PACKAGEKIT_GLIB2_API_IS_SUBJECT_TO_CHANGE)

find_package(PkgConfig)
pkg_check_modules(DEPS REQUIRED gtk+-3.0 packagekit-glib2)

add_definitions(${DEPS_CFLAGS})
link_libraries(${DEPS_LIBRARIES})
link_directories(${DEPS_LIBRARY_DIRS})

# make sure we have vala
find_package(Vala REQUIRED)
# make sure we use vala
include(ValaVersion)
# make sure it's the desired version of vala
ensure_vala_version("0.16" MINIMUM)

# files we want to compile
include(ValaPrecompile)
vala_precompile(VALA_C ${EXEC_NAME}
    src/Repoman.vala
    src/Source.vala
    src/Repolist.vala

# tell what libraries to use when compiling
PACKAGES
    gtk+-3.0
    packagekit-glib2
)
# tell cmake what to call the executable we just made
add_executable(${EXEC_NAME} ${VALA_C})

# install the binaries we just made
install (TARGETS ${EXEC_NAME} RUNTIME DESTINATION bin)

# install our .desktop file so the Applications menu will see it
#install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/hello.desktop DESTINATION ${DATADIR}/applications/)
