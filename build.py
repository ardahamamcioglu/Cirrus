import os
import sys
import subprocess

def main():
    # Get the current working directory
    current_dir = os.getcwd()
    
    # Define the path to the 'build' directory
    build_dir = os.path.join(current_dir, 'build')
    
    # Check if the 'build' directory exists, create it if not
    if not os.path.exists(build_dir):
        os.makedirs(build_dir)
        print(f"Created directory: {build_dir}")
    else:
        print(f"Using existing directory: {build_dir}")
    
    # Change to the 'build' directory
    os.chdir(build_dir)
    
    # Run the CMake command
    subprocess.run(['cmake', '..'], check=True)
    
    # Run the make command
    subprocess.run(['make'], check=True)
    print("Build completed successfully.")
    
if __name__ == "__main__":
    main()