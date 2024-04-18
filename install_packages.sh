#!/bin/bash

WORK_DIR="surface_gps_test"

# Udpate apt
sudo apt update && sudo apt upgrade -y

# Install sensor packages
git clone -b dev_4.0.6 --recursive https://github.com/stereolabs/zed-ros2-wrapper.git
git clone -b humble https://github.com/ros-drivers/ros2_ouster_drivers.git
git clone -b ros2 https://github.com/ros-drivers/nmea_navsat_driver.git
git clone https://github.com/CLOBOT-Co-Ltd/myahrs_ros2_driver.git
git clone https://github.com/mint-lab/mint_cart_ros.git
git clone https://github.com/mint-lab/surface_gps.git

# Fix myahrs_ros2_driver.cpp
cd myahrs_ros2_driver/myahrs_ros2_driver/src
sed -i 's/this->declare_parameter(\("[a-z_]*"\))/this->declare_parameter(\1, 0.0)/g' ./myahrs_ros2_driver.cpp

# Install ROS Packages Dependencies
cd ../../../../../ # ros woskspace
source /root/.bashrc
source ./install/local_setup.bash
rosdep update
rosdep install --from-path src --ignore-src -r -y
colcon build

sudo apt update && apt upgrade -y
sudo apt install ros-$ROS_DISTRO-rviz-imu-plugin

source /root/.bashrc
source ./install/local_setup.bash
