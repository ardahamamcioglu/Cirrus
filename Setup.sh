# Function to install tools on macOS
install_tools_mac() {
    echo "Installing tools..."

    xcode-select --install
    echo "Installed Xcode command line tools."
    
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Installed Homebrew."

    brew install python
    echo "Installed Python."

    pip install conan
    echo "Installed Conan."

    echo "All tools installed successfully. Install Vulkan SDK from https://vulkan.lunarg.com/sdk/home."
}

# Function to install tools on Windows
install_tools_windows() {
    echo "Installing tools..."

    winget install --id=Python.Python.3 -e
    echo "Installed Python."

    winget install --id=KhronosGroup.VulkanSDK -e
    echo "Installed Vulkan SDK."
    
    pip install conan -y
    echo "Installed Conan."

    echo "All tools installed successfully."
}

# Function to install tools on Linux
install_tools_linux() {
    echo "Installing tools..."

    sudo apt update
    sudo apt upgrade -y
    
    sudo apt install python3 python3-pip -y
    echo "Installed Python."
    
    sudo apt install vulkan-sdk -y
    echo "Installed Vulkan SDK."

    pip install conan -y
    echo "Installed Conan."

    echo "All tools installed successfully."
}   

# Detect operating system and install tools
if [[ "$OSTYPE" == "darwin"* ]]; then
    install_tools_mac
elif [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "cygwin"* || "$OSTYPE" == "win32" ]]; then
    install_tools_windows
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    install_tools_linux
else
    echo "Unsupported operating system. Exiting."
    exit 1
fi