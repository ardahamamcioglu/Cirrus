#!/bin/bash

# ==============================================================================
# Build Script for Vulkan Renderer
# ==============================================================================
# This script handles the build process for the Vulkan Renderer project.
# It includes options for cleaning the build directory and specifying the build type.
# ==============================================================================

# Set build directory and default build type
BUILD_DIR="build"
BUILD_TYPE="${BUILD_TYPE:-Debug}"

# Function to clean the build directory
clean_build_directory() {
    if [[ "$CLEAN_BUILD" == "true" ]]; then
        echo "Cleaning build directory..."
        rm -rf "$BUILD_DIR"
        if [[ $? -ne 0 ]]; then
            echo "Warning: Build directory could not be fully cleaned. Continuing..."
        fi
    fi
    mkdir -p "$BUILD_DIR"
}

# Function to install dependencies using Conan
install_dependencies() {
    echo "Installing dependencies with Conan..."
    conan install .. --output-folder=. --build=missing --settings=build_type="$BUILD_TYPE"
    if [[ $? -ne 0 ]]; then
        echo "Error: Conan dependency installation failed. Aborting."
        exit 1
    fi
}

# Function to configure the project with CMake
configure_project() {
    echo "Configuring project with CMake..."
    cmake .. \
        -DCMAKE_BUILD_TYPE="$BUILD_TYPE" \
        -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake
    if [[ $? -ne 0 ]]; then
        echo "Error: CMake configuration failed. Aborting."
        exit 1
    fi
}

# Function to build the project with CMake
build_project() {
    echo "Building project with CMake..."
    cmake --build .
    if [[ $? -ne 0 ]]; then
        echo "Error: Build process failed. Aborting."
        exit 1
    fi
}

# Main script logic
main() {
    # Clean build directory if requested
    clean_build_directory

    # Navigate to the build directory
    pushd "$BUILD_DIR" > /dev/null

    # Step 1: Install dependencies using Conan
    install_dependencies

    # Step 2: Configure the project with CMake
    configure_project

    # Step 3: Build the project
    build_project

    # Return to the original directory
    popd > /dev/null

    echo "Build process completed successfully."
}

# Run the main function
main