@echo off
setlocal

set "BUILD_DIR=build"
if "%BUILD_TYPE%"=="" set "BUILD_TYPE=Debug"

if /i "%CLEAN_BUILD%"=="true" (
  echo "Cleaning build directory..."
  rmdir /s /q "%BUILD_DIR%"
  mkdir "%BUILD_DIR%"
)

if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"

pushd "%BUILD_DIR%"

echo "Running Conan to install dependencies..."
conan install .. --output-folder=. --build=missing --settings=build_type=%BUILD_TYPE%
if errorlevel 1 (
  echo "Conan install failed. Aborting."
  exit /b 1
)

echo "Configuring project with CMake using Clang..."
cmake .. -DCMAKE_BUILD_TYPE=%BUILD_TYPE% -G "Visual Studio 17 2022" -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake
if errorlevel 1 (
  echo "CMake configuration failed. Aborting."
  exit /b 1
)

echo "Building project..."
cmake --build .
if errorlevel 1 (
  echo "Build failed. Aborting."
  exit /b 1
)

popd

endlocal
