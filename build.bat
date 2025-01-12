@echo off
REM ==============================================================================
REM Build Script for Vulkan Renderer
REM ==============================================================================
REM This script handles the build process for the Vulkan Renderer project.
REM It includes options for cleaning the build directory and specifying the build type.
REM ==============================================================================

setlocal

REM Set build directory and default build type
set "BUILD_DIR=build"
if "%BUILD_TYPE%"=="" set "BUILD_TYPE=Debug"

REM Clean build directory if requested
if /i "%CLEAN_BUILD%"=="true" (
    echo Cleaning build directory...
    rmdir /s /q "%BUILD_DIR%" 2>nul
    if errorlevel 1 (
        echo Warning: Build directory could not be fully cleaned. Continuing...
    )
    mkdir "%BUILD_DIR%"
)

REM Ensure the build directory exists
if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"

REM Navigate to the build directory
pushd "%BUILD_DIR%"

REM Step 1: Install dependencies using Conan
echo Installing dependencies with Conan...
conan install .. --output-folder=. --build=missing --settings=build_type=%BUILD_TYPE%
if errorlevel 1 (
    echo Error: Conan dependency installation failed. Aborting.
    popd
    exit /b 1
)

REM Step 2: Configure the project with CMake
echo Configuring project with CMake...
cmake .. ^
    -DCMAKE_BUILD_TYPE=%BUILD_TYPE% ^
    -G "Visual Studio 17 2022" ^
    -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake
if errorlevel 1 (
    echo Error: CMake configuration failed. Aborting.
    popd
    exit /b 1
)

REM Step 3: Build the project
echo Building project with CMake...
cmake --build .
if errorlevel 1 (
    echo Error: Build process failed. Aborting.
    popd
    exit /b 1
)

REM Return to the original directory
popd

echo Build process completed successfully.
endlocal
