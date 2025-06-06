#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define build directory
BUILD_DIR="build"

# Create build directory if it doesn't exist
if [ ! -d "$BUILD_DIR" ]; then
    mkdir "$BUILD_DIR"
fi

# Navigate to the build directory
cd "$BUILD_DIR"

# Run CMake to configure the project with Ninja as the generator
cmake -G "Ninja" ..

# Build the project using Ninja
ninja

# Navigate back to the root directory
cd ..

# Notify the user
echo "Build completed successfully."