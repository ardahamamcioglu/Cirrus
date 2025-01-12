cmake_minimum_required(VERSION 3.24)
project(cirrus)

# Define the path to the enigine directory
set(CIRRUS_DIR "${CMAKE_SOURCE_DIR}/..")

# Find libraries
find_package(glfw3 REQUIRED)
find_package(glm REQUIRED)

# Add all .cpp files in the src directory and its subdirectories
file(GLOB_RECURSE CPP_SOURCES src/*.cpp)

# Add all .h files in the src directory and its subdirectories
file(GLOB_RECURSE HEADER_FILES src/*.h)

# Create the library target
add_executable(${PROJECT_NAME} src/main.cpp ${CPP_SOURCES} ${HEADER_FILES})

# Include enigine headers
target_include_directories(${PROJECT_NAME} PRIVATE ${ENIGINE_DIR}/src)

# Link libraries to the target
target_link_libraries(${PROJECT_NAME} PRIVATE glfw)
target_link_libraries(${PROJECT_NAME} PRIVATE glm::glm)