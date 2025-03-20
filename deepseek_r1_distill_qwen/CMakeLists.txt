cmake_minimum_required(VERSION 3.10)
project(model)

set(CMAKE_CXX_STANDARD 17)
set(PLATFORM_TYPE "soc" CACHE STRING "Platform type: pcie or soc")
message(STATUS "Compiling for platform: ${PLATFORM_TYPE}")

include_directories(${PROJECT_SOURCE_DIR}/../support/include)

if (PLATFORM_TYPE STREQUAL "soc")
    add_definitions(-DSOC_TARGET)
    link_directories(${PROJECT_SOURCE_DIR}/../support/lib_soc)
    message("SoC mode, starting......")
else()
    add_definitions(-DPCIE_TARGET)
    link_directories(${PROJECT_SOURCE_DIR}/../support/lib_pcie)
    message("PCIE mode, starting......")
endif()

# OpenCV configuration
if (${TYPE} STREQUAL "image" OR ${TYPE} STREQUAL "video")
    find_package(OpenCV REQUIRED)
    include_directories(${OpenCV_INCLUDE_DIRS})
    link_directories(${OpenCV_LIBRARY_DIRS})
    message(STATUS "OpenCV version: ${OpenCV_VERSION}")
    set(OPENCV_LIBS opencv_core opencv_imgcodecs opencv_videoio)
else()
    set(OPENCV_LIBS "")
endif()

add_definitions(-DDEBUG --std=c++17 -fPIC -Wall)

set(CMAKE_BUILD_TYPE "Debug")

find_package(pybind11 REQUIRED CONFIG)

file(GLOB CPP_FILES ${PROJECT_SOURCE_DIR}/*.cpp)

pybind11_add_module(chat ${CPP_FILES})
target_link_libraries(chat PUBLIC bmrt bmlib ${OPENCV_LIBS})
install(TARGETS chat DESTINATION python)
