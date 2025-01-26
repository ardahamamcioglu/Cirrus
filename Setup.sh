#!/bin/bash

# Function to install Xcode Command Line Tools on macOS
install_xcode_tools() {
    echo "Checking for Xcode Command Line Tools..."
    if ! xcode-select -p &>/dev/null; then
        echo "Xcode Command Line Tools are not installed. Installing now..."
        xcode-select --install
        echo "Please complete the installation, then re-run this script."
        exit 1
    else
        echo "Xcode Command Line Tools are already installed."
    fi
}

# Function to install tools on macOS
install_tools_mac() {
    echo "Installing tools on macOS..."

    install_xcode_tools
    
    # Check if Homebrew is installed
    if command -v brew &> /dev/null; then
        echo "Homebrew is already installed."
    else
        echo "Homebrew is not installed. Installing now..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
            echo "Failed to install Homebrew. Please check your internet connection or try manually."
            exit 1
        }
        echo "Homebrew installation complete."
    fi

    # Install MoltenVK
    echo "Installing MoltenVK..."
    brew install molten-vk || {
        echo "Failed to install MoltenVK. Please check your Homebrew installation or try manually."
        exit 1
    }

    # Install Conan
    echo "Installing Conan..."
    brew install conan || {
        echo "Failed to install Conan. Please check your Homebrew installation or try manually."
        exit 1
    }

    echo "All tools installed successfully on macOS."
}

# Function to install tools on Windows
install_tools_windows() {
    echo "Installing tools on Windows..."

    # Check if winget is available
    if ! command -v winget &> /dev/null; then
        echo "winget is not available. Please install it manually or update Windows to include it."
        exit 1
    fi

    # Install Vulkan SDK (MoltenVK is not applicable for Windows)
    echo "Installing Vulkan SDK..."
    winget install --id LunarG.VulkanSDK -e --silent || {
        echo "Failed to install Vulkan SDK. Please check your winget installation or try manually."
        exit 1
    }

    # Install Conan
    echo "Installing Conan..."
    winget install --id Conan.Conan -e --silent || {
        echo "Failed to install Conan. Please check your winget installation or try manually."
        exit 1
    }

    echo "All tools installed successfully on Windows."
}

# Detect operating system and install tools
if [[ "$OSTYPE" == "darwin"* ]]; then
    install_tools_mac
elif [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "cygwin"* || "$OSTYPE" == "win32" ]]; then
    install_tools_windows
else
    echo "Unsupported operating system. Exiting."
    exit 1
fi