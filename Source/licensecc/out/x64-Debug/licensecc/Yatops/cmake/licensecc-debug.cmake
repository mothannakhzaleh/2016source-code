#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "licensecc::licensecc_static" for configuration "Debug"
set_property(TARGET licensecc::licensecc_static APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(licensecc::licensecc_static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/licensecc/Yatops/licensecc_static.lib"
  )

list(APPEND _cmake_import_check_targets licensecc::licensecc_static )
list(APPEND _cmake_import_check_files_for_licensecc::licensecc_static "${_IMPORT_PREFIX}/licensecc/Yatops/licensecc_static.lib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
