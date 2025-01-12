@echo off
REM ==============================================================================
REM Setup Script for Vulkan Renderer Environment
REM ==============================================================================
REM This script installs all necessary dependencies using winget.
REM Run this script before building the project.
REM ==============================================================================

echo Setting up the environment for Vulkan Renderer...

REM Install Conan for package management
echo Installing Conan...
winget install --id JFrog.Conan --exact --silent
if %ERRORLEVEL% neq 0 (
    echo Error: Failed to install Conan.
    exit /b 1
)

REM Install Vulkan SDK
echo Installing Vulkan SDK...
winget install --id KhronosGroup.VulkanSDK --exact --silent
if %ERRORLEVEL% neq 0 (
    echo Error: Failed to install Vulkan SDK.
    exit /b 1
)

REM Install CMake
echo Installing CMake...
winget install --id Kitware.CMake --exact --silent
if %ERRORLEVEL% neq 0 (
    echo Error: Failed to install CMake.
    exit /b 1
)

echo Environment setup complete. All required tools have been installed.

REM Optional: Prompt to add VulkanSDK to PATH
echo Ensure Vulkan SDK is added to your PATH environment variable.
echo You can verify by running 'echo %%VULKAN_SDK%%' in a new command prompt.

exit /b 0
