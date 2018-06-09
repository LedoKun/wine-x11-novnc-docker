#!/bin/bash

# Exit when any command fails
set -e

# Packages
BUILD_PACKAGES="git"
DEPEN_PACKAGES="cabextract \
  fluxbox \
  mono-complete \
  net-tools \
  python-numpy \
  unzip \
  wget \
  x11vnc \
  xdotool \
  gxmessage \
  xvfb \
  ttf-mscorefonts-installer"
WINE_PACKAGES="winehq-stable \
  wine-mono \
  wine-gecko"

# Enable i386
dpkg --add-architecture i386

# Install base packages
apt-get update
apt-get dist-upgrade -y
apt-get install -y \
  ${DEPEN_PACKAGES} \
  ${BUILD_PACKAGES}

# Add Wine repo
wget -nc https://dl.winehq.org/wine-builds/Release.key
apt-key add Release.key
apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/

# Install base packages
apt-get update
apt-get dist-upgrade -y
apt-get install -y \
  ${WINE_PACKAGES}

# Install WineTricks
wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod +x winetricks
mv winetricks /usr/local/bin

# Install Corefonts
/usr/local/bin/winetricks --unattended corefonts

# Install noVNC
mkdir -p /root/novnc/
git clone git://github.com/kanaka/noVNC /root/novnc/
git clone git://github.com/novnc/websockify /root/novnc/utils/websockify/
cp /root/novnc/vnc.html /root/novnc/index.html

# Cleanup
apt-get autoremove --purge -y ${BUILD_PACKAGES}
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
rm -rf /install.sh /Release.key

# Create Runit services
chmod a+x /etc/service/ -R
