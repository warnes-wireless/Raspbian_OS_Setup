# !/bin/bash
#
# Copyright 2017 The MathWorks, Inc.
#
#  Customize the default Raspberry Pi Raspbian Jessie Lite image to be compatible with MATHWORKS tools
#  Run the following shell script as a sudoer.
#  The default usename is assumed to be pi. If your username is different, change it accorsingle in the following command
username="pi"
echo -e "\nCustomizing Raspbian Bullseye...\n"

# Update the package repository.
echo -e "\n1. Update package repository...\n"
sudo apt-get -y update

# Upgrade the repository to point to the latest locations
echo -e "\n2. Upgrade any out of date packages to latest...\n"
sudo apt-get -y upgrade

# Install all the required packages. Following are the required packages
# 1. libsdl1.2-dev
# 2. alsa-utils
# 3. espeak
# 4. i2c-tools
# 5. libi2c-dev
# 6. ssmtp
# 7. ntpdate
# 8. git-core
# 9. v4l-utils
# 10. cmake
# 11. sense-hat
# 12. libsox-dev
# 13. libcurl4-openssl-dev
# 14. paho-mqtt
# 15. pigpio
# 16. nanomsg
# 17. collad 
# 18. Robot OS
# 19. Userland
echo -e "\n3. Installing required software packages...\n"
sudo apt-get -y install libsdl1.2-dev alsa-utils espeak i2c-tools \
         libi2c-dev ssmtp ntpdate git-core v4l-utils cmake sense-hat \
         sox libsox-fmt-all libsox-dev libcurl4-openssl-dev \
         libpaho-mqtt1.3 libpaho-mqtt-dev \
         pigpio libnanomsg5 libnanomsg-dev nanomsg-utils \
         libboost-filesystem-dev libxml2-dev libcollada-dom-dev \
         ros-base ros-base-dev \
         libraspberrypi-bin libraspberrypi-dev


# Clean-up the installation
echo -e "\n4. Remove un-needed packages...\n"
sudo apt-get -y autoremove

# Install rpi-serial-console package
echo -e "\n5. Install serial console package...\n"
sudo wget https://raw.github.com/lurch/rpi-serial-console/master/rpi-serial-console -O /usr/bin/rpi-serial-console
sudo chmod +x /usr/bin/rpi-serial-console

# Install WiringPi
echo -e "\n6. Install WiringPi\n"
cd /tmp
wget https://project-downloads.drogon.net/wiringpi-latest.deb
sudo dpkg -i wiringpi-latest.deb

# Build ROS user workspace. This step creates devel and build directories under the ~/catkin_ws.
echo -e "\n7. Build ROS user workspace\n"
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
catkin_init_workspace
cd ~/catkin_ws/
catkin_make

echo -e "\nCustomization Complete...\n"
