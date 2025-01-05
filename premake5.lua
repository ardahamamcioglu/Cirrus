workspace "cirrus"
   configurations { "Debug", "Release" }
   location "build"

project "cirrus"
   kind "ConsoleApp"
   language "C++"
   cppdialect "C++17"

   -- Set the target and object directories
   targetdir "bin/%{cfg.buildcfg}"
   objdir "bin-int/%{cfg.buildcfg}"

   -- Add all .cpp and .h files in the src directory and subdirectories
   files { "src/**.cpp", "src/**.h" }

   -- Include directories (these are automatically set by the find_package equivalent in Premake)
   includedirs { "/path/to/glfw/include", "/path/to/glew/include", "/path/to/glm/include" }

   -- Link libraries
   links { "glfw", "glew", "glm" }

   -- Specify library directories (replace with actual paths)
   libdirs { "/path/to/glfw/lib", "/path/to/glew/lib", "/path/to/glm/lib" }

   -- Define Debug and Release configurations
   filter "configurations:Debug"
      defines { "DEBUG" }
      symbols "On"

   filter "configurations:Release"
      defines { "NDEBUG" }
      optimize "On"
