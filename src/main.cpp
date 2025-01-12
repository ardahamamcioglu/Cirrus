//#define GLFW_INCLUDE_NONE
#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>

#define GLM_FORCE_RADIANS
#define GLM_FORCE_DEPTH_ZERO_TO_ONE
#include <glm/vec4.hpp>
#include <glm/mat4x4.hpp>

#include <iostream>
#include <stdlib.h>
#include <stddef.h>
#include <stdio.h>
 
static void error_callback(int error, const char* description)
{
    fprintf(stderr, "Error: %s\n", description);
}

int main(void)
{
    glfwSetErrorCallback(error_callback);
 
    if (!glfwInit())
    {
        exit(EXIT_FAILURE);
    }
    
    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
    GLFWwindow* window = glfwCreateWindow(800, 600, "Cirrus Window", nullptr, nullptr);
    
    if (!window)
    {
        glfwTerminate();
        exit(EXIT_FAILURE);
    }

    uint32_t extensionCount = 0;
    vkEnumerateInstanceExtensionProperties(nullptr, &extensionCount, nullptr);

    std::cout << extensionCount << "extensions supported\n";

    glm::mat4 matrix;
    glm::vec4 vec;
    auto test = matrix*vec;

    /*
    VkSurfaceKHR surface;

    VkResult err = glfwCreateWindowSurface(instance, window, NULL, &surface);
    if (err)
    {
        Print("Window surface creation failed.");
    }
    */

    glfwMakeContextCurrent(window);
    glfwSwapInterval(1);

    while (!glfwWindowShouldClose(window))
    {
        glfwPollEvents();
    }
    
    //vkDestroySurfaceKHR();
    glfwDestroyWindow(window);
 
    glfwTerminate();
    exit(EXIT_SUCCESS);
}