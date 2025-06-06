# Function to install tools on macOS
# Install CMake on macOS
install_tools_mac() {
    echo "Installing tools..."
    xcode-select --install
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install git cmake ninja
    echo "Installed Git, CMake, and Ninja."
    echo "All tools installed successfully. Install Vulkan SDK from https://vulkan.lunarg.com/sdk/home."
}

# Install CMake on Windows
install_tools_windows() {
    echo "Installing tools..."
    winget install --id Git.Git -e --source winget
    winget install -e --id Kitware.CMake
    winget install -e --id Kitware.Ninja
    echo "Installed Git, CMake, and Ninja."
    echo "All tools installed successfully."
}

# Install CMake on Linux
install_tools_linux() {
    echo "Installing tools..."
    sudo apt update
    sudo apt upgrade -y
    sudo apt install git cmake ninja-build -y
    echo "Installed Git, CMake, and Ninja."
    echo "All tools installed successfully."
}

# Detect operating system and install tools
detect_os_and_install_tools() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        install_tools_mac
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        install_tools_linux
    elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
        install_tools_windows
    else
        echo "Unsupported operating system: $OSTYPE"
        exit 1
    fi
}

# Main function to run the script
main() {
    #Check Vulkan SDK installation
    if ! command -v vulkaninfo &> /dev/null; then
        echo "Vulkan SDK is not installed. Please install it from https://vulkan.lunarg.com/sdk/home."
        exit 1
    fi
    # Start tool installation
    echo "Starting tool installation..."
    detect_os_and_install_tools
    echo "Tool installation completed."

    chmod +x build.sh
    echo "Setup complete. You can now run the build script using './build.sh'."
}

# Run the main function
main