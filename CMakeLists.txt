cmake_minimum_required(VERSION 3.50)
project(cirrus)

include(FetchContent)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Fetch GLFW
FetchContent_Declare(
    glfw
    GIT_REPOSITORY https://github.com/glfw/glfw.git
    GIT_TAG        3.4
)
FetchContent_MakeAvailable(glfw)

#Fetch GLM
FetchContent_Declare(
    glm
    GIT_REPOSITORY https://github.com/g-truc/glm.git
	  GIT_TAG 	     1.0.1
)
FetchContent_MakeAvailable(glm)

#Fetch imGUI
FetchContent_Declare(
    imgui
    GIT_REPOSITORY https://github.com/ocornut/imgui.git
    GIT_TAG        v1.91.9b-docking
)
FetchContent_MakeAvailable(imgui)

#Fetch AngelScript
# FetchContent_Declare(
#     angelscript
#     URL https://www.angelcode.com/angelscript/sdk/files/angelscript_2.37.0.zip
# )

FetchContent_MakeAvailable(glfw)
FetchContent_MakeAvailable(glm)
#FetchContent_MakeAvailable(angelscript)

# Define the path to the enigine directory
set(CIRRUS_DIR "${CMAKE_SOURCE_DIR}/..")

# Append Vulkan SDK Dir to Cmake
list(APPEND CMAKE_PREFIX_PATH "$ENV{VULKAN_SDK}")

# Find libraries
find_package(Vulkan REQUIRED)

# Add all .cpp files in the src directory and its subdirectories
file(GLOB_RECURSE CPP_SOURCES src/*.cpp)

# Add all .h files in the src directory and its subdirectories
file(GLOB_RECURSE HEADER_FILES src/*.h)

# Create the library target
add_executable(${PROJECT_NAME} src/main.cpp ${CPP_SOURCES} ${HEADER_FILES})

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
  target_compile_definitions(${PROJECT_NAME} PUBLIC "LINUX_OS")
endif()
if(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
  target_compile_definitions(${PROJECT_NAME} PUBLIC "MACOS_OS")
endif()
if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
  target_compile_definitions(${PROJECT_NAME} PUBLIC "WINDOWS_OS")
endif()

#add_subdirectory(${angelscript_SOURCE_DIR}/angelscript/projects/cmake ${CMAKE_BINARY_DIR}/angelscript)

# Include enigine headers
target_include_directories(${PROJECT_NAME} PRIVATE ${ENIGINE_DIR}/src)
target_include_directories(${PROJECT_NAME} PRIVATE $ENV{VULKAN_SDK})
target_include_directories(${PROJECT_NAME} PRIVATE ${glm_SOURCE_DIR})
target_include_directories(${PROJECT_NAME} PRIVATE ${imgui_SOURCE_DIR})

#target_include_directories(${PROJECT_NAME} PRIVATE ${angelscript_SOURCE_DIR}/angelscript/include)

# Add Dear ImGui source files
file(GLOB IMGUI_SOURCES
    ${imgui_SOURCE_DIR}/imgui.cpp
    ${imgui_SOURCE_DIR}/imgui_draw.cpp
    ${imgui_SOURCE_DIR}/imgui_tables.cpp
    ${imgui_SOURCE_DIR}/imgui_widgets.cpp
    ${imgui_SOURCE_DIR}/backends/imgui_impl_glfw.cpp
    ${imgui_SOURCE_DIR}/backends/imgui_impl_vulkan.cpp
)


# Add Dear ImGui sources to the target
target_sources(${PROJECT_NAME} PRIVATE ${IMGUI_SOURCES})

# Link GLFW and Vulkan (already done in your CMakeLists.txt)
target_link_libraries(${PROJECT_NAME} PRIVATE glfw)
target_link_libraries(${PROJECT_NAME} PRIVATE Vulkan::Vulkan)
#target_link_libraries(${PROJECT_NAME} PRIVATE angelscript)
