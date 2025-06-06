cmake_minimum_required(VERSION 3.24)
project(cirrus)

include(FetchContent)

# Fetch GLFW
FetchContent_Declare(
    glfw
    GIT_REPOSITORY https://github.com/glfw/glfw.git
    GIT_TAG        3.3.8 # Use the latest stable version
)
FetchContent_MakeAvailable(glfw)

#Fetch GLM
FetchContent_Declare(
    glm
    GIT_REPOSITORY https://github.com/g-truc/glm.git
    GIT_TAG        0.9.9.8 # Use the latest stable version
)
FetchContent_MakeAvailable(glm)

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
  target_compile_definitions(cirrus PUBLIC "LINUX_OS")
endif()
if(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
  target_compile_definitions(cirrus PUBLIC "MACOS_OS")
endif()
if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
  target_compile_definitions(cirrus PUBLIC "WINDOWS_OS")
endif()

# Define the path to the enigine directory
set(CIRRUS_DIR "${CMAKE_SOURCE_DIR}/..")

# Append Vulkan SDK Dir to Cmake
list(APPEND CMAKE_PREFIX_PATH "$ENV{VULKAN_SDK}")

# Find libraries
find_package(glfw REQUIRED)
find_package(Vulkan REQUIRED)

# Add all .cpp files in the src directory and its subdirectories
file(GLOB_RECURSE CPP_SOURCES src/*.cpp)

# Add all .h files in the src directory and its subdirectories
file(GLOB_RECURSE HEADER_FILES src/*.h)

# Create the library target
add_executable(${PROJECT_NAME} src/main.cpp ${CPP_SOURCES} ${HEADER_FILES})

# Include enigine headers
target_include_directories(${PROJECT_NAME} PRIVATE ${ENIGINE_DIR}/src)
target_include_directories(${PROJECT_NAME} PRIVATE $ENV{VULKAN_SDK})
target_include_directories(${PROJECT_NAME} PRIVATE ${glm_SOURCE_DIR})

# Link libraries to the target
target_link_libraries(${PROJECT_NAME} PRIVATE glfw)
target_link_libraries(${PROJECT_NAME} PRIVATE Vulkan::Vulkan)