# Function to install tools on macOS
install_tools_mac() {
    echo "Installing tools..."

    xcode-select --install
    echo "Installed Xcode command line tools."
    
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Installed Homebrew."

    brew install python
    echo "Installed Python."

    pip3 install -r requirements.txt
    echo "Installed required Python packages."

    echo "All tools installed successfully. Install Vulkan SDK from https://vulkan.lunarg.com/sdk/home."
}

# Function to install tools on Windows
install_tools_windows() {
    echo "Installing tools..."

    winget install --id=Python.Python.3 -e
    echo "Installed Python."

    pip3 install -r requirements.txt
    echo "Installed required Python packages."

    echo "All tools installed successfully."
}

# Function to install tools on Linux
install_tools_linux() {
    echo "Installing tools..."

    sudo apt update
    sudo apt upgrade
    
    sudo apt install python3 python3-pip -y
    echo "Installed Python."

    pip3 install -r requirements.txt
    echo "Installed required Python packages."

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
fi

#Build
python3 build.py
if [ $? -ne 0 ]; then
    echo "Build failed. Please check the error messages above."
    exit 1
else
    echo "Build completed successfully."
fi