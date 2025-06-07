#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define build directory
BUILD_DIR="build"

# Check for clean build flag
if [[ "$1" == "clean" ]]; then
    echo "Performing a clean build..."
    rm -rf "$BUILD_DIR"
fi

# Create build directory if it doesn't exist
if [ ! -d "$BUILD_DIR" ]; then
    mkdir "$BUILD_DIR"
fi

# Navigate to the build directory
cd "$BUILD_DIR"

# Run CMake to configure the project with Ninja as the generator
cmake -G "Ninja" .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

# Build the project using Ninja
ninja

# Navigate back to the root directory
cd ..

# Notify the user
echo "Build completed successfully."