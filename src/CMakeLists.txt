cmake_minimum_required(VERSION 2.8)
project( xcompile-opencv-demo )

# OpenCV example
find_package(OpenCV REQUIRED PATHS "/opt/opencv-static")
add_executable( opencv-test opencv-test.cpp )
target_link_libraries( opencv-test ${OpenCV_LIBS} "-static")

# UDP Example with winsock
find_library(WS2_32_LIBRARY ws2_32)
add_executable( udp-test udp-test.cpp )
target_link_libraries( udp-test ${WS2_32_LIBRARY} "-static")
