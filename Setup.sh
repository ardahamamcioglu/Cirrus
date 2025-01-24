#!/bin/bash

# Function to check if brew is installed
check_brew() {
    if command -v brew &> /dev/null; then
        echo "Homebrew is already installed."
    else
        echo "Homebrew is not installed. Installing now..."
        install_brew
    fi
}

# Function to install Homebrew
install_brew() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
        echo "Failed to install Homebrew. Please check your internet connection or try manually."
        exit 1
    }
    echo "Homebrew installation complete."
}

# Run the check
check_brew

