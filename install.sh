#!/bin/sh

# Exit when any command fails
set -e

BUILD_PACKAGE='git'

# Configure user nobody to match unRAID's settings
usermod -u 99 nobody
usermod -g 100 nobody
usermod -d /config nobody
chown -R nobody:users /home

# Install base packages
apt update
apt install -y \
  wget \
  xvfb \
  x11vnc \
  xdotool \
  supervisor \
  python-numpy \
  net-tools \
  ${BUILD_PACKAGE}

# Add Wine repo
wget -nc https://dl.winehq.org/wine-builds/Release.key
apt-key add Release.key
apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/

# Install Wine
dpkg --add-architecture i386
apt update
apt dist-upgrade -y
apt install -y --install-recommends \
  winehq-stable

# Install noVNC
mkdir -p /root/novnc/
git clone git://github.com/kanaka/noVNC /root/novnc/
git clone git://github.com/novnc/websockify /root/novnc/utils/websockify/

# Cleanup
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
rm /install.sh
