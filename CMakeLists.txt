cmake_minimum_required(VERSION 3.24)
project(cirrus)

# Find libraries
find_package(glfw3 REQUIRED)
find_package(glew REQUIRED)
find_package(glm REQUIRED)

# Add all .cpp files in the src directory and its subdirectories
file(GLOB_RECURSE CPP_SOURCES src/*.cpp)

# Add all .h files in the src directory and its subdirectories
file(GLOB_RECURSE HEADER_FILES src/*.h)

# Create the library target
add_executable(cirrus src/main.cpp)

# Link libraries to the target
target_link_libraries(cirrus glfw)
target_link_libraries(cirrus GLEW::GLEW)
target_link_libraries(cirrus glm::glm)