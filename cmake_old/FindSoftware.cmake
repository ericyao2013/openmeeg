macro(find type arg)
    set(guard "USE_SYSTEM_${arg}")
    if (${guard})
        unset(${arg}_DIR)
    endif()

    if (FIND_DEBUG_MODE)
        set(CMAKE_FIND_DEBUG_MODE 1)
        message("[[Looking for ${type}: ${arg}]]")
    endif()   

    if ("${type}" STREQUAL "package")
        find_package(${arg} ${ARGN})
    elseif ("${type}" STREQUAL "library")
        find_library(${arg} ${arg} ${ARGN})
    else()
        message(SEND_ERROR "Unknown type ${type}")
    endif()
endmacro()