#!/bin/sh

# Exit when any command fails
set -e

BUILD_PACKAGES="git"
DEPEN_PACKAGES="net-tools \
  python-numpy \
  supervisor \
  wget \
  x11vnc \
  xdotool \
  xvfb"

# Configure user nobody to match unRAID's settings
usermod -u 99 nobody
usermod -g 100 nobody
usermod -d /config nobody
chown -R nobody:users /home

# Install base packages
apt-get update
apt-get install -y \
  ${DEPEN_PACKAGES} \
  ${BUILD_PACKAGES}

# Add Wine repo
wget -nc https://dl.winehq.org/wine-builds/Release.key
apt-key add Release.key
apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/

# Install Wine
dpkg --add-architecture i386
apt-get update
apt-get dist-upgrade -y
apt-get install -y --install-recommends \
  winehq-stable

# Install noVNC
mkdir -p /root/novnc/
git clone git://github.com/kanaka/noVNC /root/novnc/
git clone git://github.com/novnc/websockify /root/novnc/utils/websockify/

# Cleanup
apt-get autoremove --purge -y ${BUILD_PACKAGES}
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
rm -rf /install.sh /Release.key
