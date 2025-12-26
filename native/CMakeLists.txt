cmake_minimum_required(VERSION 3.15)
project(MaryNativeModules)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_subdirectory(filesystem)
add_subdirectory(image-processor)
add_subdirectory(video-transcoder)
add_subdirectory(crypto-accelerator)
